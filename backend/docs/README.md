# API docs (OpenAPI + ReDoc)

- **`openapi.yaml`** — especificação OpenAPI 3.1 da StayTraining API (v1), com todos os endpoints,
  schemas e exemplos (mocks). É a fonte de verdade; alimente Swagger UI, ReDoc, geradores de client, etc.
- **`redoc.html`** — página ReDoc que renderiza o `openapi.yaml`.

## Visualizar o ReDoc

O `redoc.html` faz `fetch` do `openapi.yaml`, o que o navegador bloqueia via `file://`. Sirva a pasta
por HTTP:

```bash
# a partir da raiz do repo
npx http-server backend/docs -p 8081       # → http://localhost:8081/redoc.html
# ou
python3 -m http.server 8081 --directory backend/docs
```

Alternativas sem servir localmente:
- **Redocly CLI** (gera um HTML estático com o spec embutido, abre direto no `file://`):
  ```bash
  npx @redocly/cli build-docs backend/docs/openapi.yaml -o backend/docs/redoc.static.html
  ```
- **Swagger Editor / editor.swagger.io** — cole o conteúdo do `openapi.yaml`.

## Convenções

- Base: `/api/v1`. Auth: `Authorization: Bearer <token>` (token opaco do Auth.API); tenant via gateway.
- Autorização por permissão — cada operação indica a permissão em **Permissão:** na descrição
  (operações "autenticado" aceitam qualquer token válido).
- Enums serializam como **inteiros** (ex.: `bloodType` 7 = O+, `kind` 2 = YouTube, `platform` 0 = Android).
- Erros seguem `application/problem+json` (RFC 7807).
