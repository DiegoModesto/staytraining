# Design — Local Telemetry Stack (Grafana LGTM)

**Date:** 2026-06-11
**Status:** Approved (design phase)
**Topic:** Stand up a local observability stack using `grafana/otel-lgtm` and route all telemetry (traces, metrics, logs) from every entrypoint to it.

---

## 1. Goal

Run a single, standalone observability backend locally that receives OpenTelemetry
data from all six .NET entrypoints (Web.API, Web.Blazor, Worker, CronJobs, Auth.API,
Gateway) and renders it in Grafana. The stack used is the official
[`grafana/docker-otel-lgtm`](https://github.com/grafana/docker-otel-lgtm) image, which
bundles an OTel Collector plus Loki (logs), Grafana, Tempo (traces), and
Prometheus/Mimir (metrics) into one container with pre-provisioned datasources.

This replaces the current dead-end state where the OTLP exporter is wired but no
endpoint is configured, and replaces **Seq** as the log backend with **Loki**.

## 2. Current state (verified)

- `src/Infra/Observability/OpenTelemetryExtensions.cs` already exports **traces +
  metrics** via `AddOtlpExporter`, gated on `OpenTelemetry:OtlpEndpoint` /
  `OTEL_EXPORTER_OTLP_ENDPOINT`. No entrypoint in `compose.yaml` sets that variable,
  so telemetry currently goes nowhere.
- All six entrypoints call `AddOpenTelemetryObservability(...)` in their `Program.cs`.
- **Logs** are config-driven via Serilog (`ReadFrom.Configuration`). Each entrypoint's
  `appsettings.json` declares `Serilog.WriteTo` sinks: `Console` + `Seq`
  (`http://seq:5341`). Packages: `Serilog.Sinks.Seq`, `Serilog.Sinks.Console`.
- `compose.yaml` runs a `seq` service (ports `5341`, `8081:80`) with a
  `./.containers/seq` volume.

## 3. Architecture / data flow

```
Entrypoints (.NET): Web.API, Web.Blazor, Worker, CronJobs, Auth.API, Gateway
   ├─ Traces   ─┐
   ├─ Metrics  ─┤  OTLP gRPC :4317
   └─ Logs ─────┘  (Serilog OpenTelemetry sink)
                      │
                      ▼
   grafana/otel-lgtm  (single container)
      OTel Collector → Tempo       (traces)
                     → Prometheus  (metrics)
                     → Loki        (logs)
      Grafana UI :3000  (datasources pre-provisioned)
```

A single `grafana/otel-lgtm` container receives everything over OTLP. The existing
`.AddOtlpExporter` calls (traces + metrics) get a real endpoint; logs gain an OTLP
sink in Serilog. The `seq` service is removed from compose.

## 4. Components / changes

### 4.1 `compose.yaml`

- **Add** service `lgtm`:
  - image `grafana/otel-lgtm:latest`
  - container name `staytraining_lgtm`
  - ports: `3000:3000` (Grafana), `4317:4317` (OTLP gRPC), `4318:4318` (OTLP HTTP)
  - volumes for persistence: `./.containers/lgtm/grafana`, `./.containers/lgtm/prometheus`,
    `./.containers/lgtm/loki` (mounted at the image's data paths — confirm paths against
    the image docs during implementation, default `/data/grafana`, `/data/prometheus`,
    `/loki`)
- **Remove** the `seq` service and its `./.containers/seq` volume reference.
- For each of the **six** entrypoints (`web.api`, `web.blazor`, `worker`, `cronjobs`,
  `auth.api`, `gateway`): add env var `OTEL_EXPORTER_OTLP_ENDPOINT=http://lgtm:4317`
  and add `lgtm` to `depends_on`.

### 4.2 Packages (`Directory.Packages.props`)

- **Add** `Serilog.Sinks.OpenTelemetry` (latest stable compatible with Serilog 4.x).
- **Remove** `Serilog.Sinks.Seq`.
- Update any `.csproj` `PackageReference` entries that name `Serilog.Sinks.Seq`.

### 4.3 Logging config (six `appsettings.json`)

In each entrypoint's `appsettings.json`:
- Replace the `Serilog.Using` entry `Serilog.Sinks.Seq` with `Serilog.Sinks.OpenTelemetry`.
- Replace the `WriteTo` `Seq` sink with an `OpenTelemetry` sink:
  - `Endpoint = http://lgtm:4317`
  - `Protocol = Grpc`
  - `ResourceAttributes` including `service.name` = the service name already passed to
    `AddOpenTelemetryObservability` (so logs correlate with the same service.name as
    traces/metrics).
- Keep the `Console` sink and the existing `Enrich` settings (so `trace_id` / log context
  enrichment carries through for trace↔log correlation).

### 4.4 `OpenTelemetryExtensions.cs`

**No change.** It already reads the endpoint from the env var and exports traces +
metrics. The env var added in compose activates it.

### 4.5 Endpoint decision (logs)

`appsettings.json` is static and the compose run uses `ASPNETCORE_ENVIRONMENT=Development`.
Decision: hardcode `http://lgtm:4317` in `appsettings.json` (the container scenario, which
is the real compose usage). For local `dotnet run` **outside** compose, the developer
overrides to `http://localhost:4317` (documented). The more "purist" env-var-driven sink
endpoint in code is rejected as too invasive (6 edits, breaks the config-driven pattern).

## 5. Verification

1. `docker compose up -d` — confirm the `lgtm` container starts healthy and `seq` is gone.
2. Generate traffic: hit Web.API through the Gateway; let a cron/worker run.
3. Open Grafana at `http://localhost:3000`:
   - **Tempo**: traces present, searchable by `service.name`.
   - **Prometheus**: metrics present (process/runtime/http).
   - **Loki**: logs present, filterable by `service.name`.
4. Confirm trace↔log correlation: an OTLP log line carries the same `trace_id` as the
   span it was emitted within.
5. `dotnet build StayTraining.sln` + `dotnet test StayTraining.sln` pass
   (no `Serilog.Sinks.Seq` reference left behind).

## 6. Docs

- Update `CLAUDE.md`:
  - §4 (commands): replace Seq references; note Grafana at `http://localhost:3000`.
  - §10 (Logging): Serilog sinks are now Console + OTLP→Loki (was Console + Seq).
  - §11.bis (Observability): note the bundled LGTM backend and the OTLP endpoint env var.
- Update `compose.yaml` inline comments and `README.md` where Seq / observability is
  mentioned.

## 7. Out of scope (YAGNI)

- Custom Grafana dashboards / alerting rules (rely on the image's defaults).
- Production-grade deployment of the LGTM stack (this is a local dev convenience).
- OpenTelemetry .NET logging provider (`.WithLogging()`) — Serilog stays the logging
  pipeline; the OTLP sink is the bridge to Loki.
- Custom OTel Collector configuration.
