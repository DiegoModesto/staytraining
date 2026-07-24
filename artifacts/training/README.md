# Catálogo de treinos — StayTraining

Registros de referência para montar treinos no StayTraining. Servem de base para o professor
cadastrar exercícios/modelos e para produzir mídias (ver também `artifacts/todo/treinos.md`).

## Conteúdo

- **[exercicios.md](exercicios.md)** — biblioteca de exercícios por modalidade, com músculo-alvo e
  descrição de como executar cada um.
- **[modelos.md](modelos.md)** — modelos de treino (combinações prontas de exercícios) por objetivo
  e modalidade, com séries/repetições/descanso sugeridos.
- **[video_prompts.md](video_prompts.md)** — prompts de **image-to-video** por exercício (a partir da
  foto do modelo), com execução passo a passo, loop e câmera/iluminação/4K. Ver também `../../design_prompt.md`.

## Modalidades

| Modalidade | Cor (VOLT) | Base de prescrição |
|---|---|---|
| Musculação | `#4EA8FF` | séries × repetições · descanso |
| Funcional | `#2FD37A` | séries × repetições (ou tempo) · descanso curto |
| Calistenia | `#4EA8FF` | séries × repetições (ou progressões/tempo) |
| Boxe | `#FF4757` | rounds · trabalho/descanso |
| Muay Thai | `#FF4757` | rounds · trabalho/descanso |
| Jiu-Jitsu | `#FF4757` | rounds/drills · tempo |
| Natação | `#4EA8FF` | distância/tempo · séries (tiros) |
| Aeróbico | `#FFB020` | tempo/intervalos (trabalho/descanso × rounds) |

> As modalidades de referência acima cobrem o catálogo em `exercicios.md`. No app, as modalidades
> ativas vêm da tabela `Modalities` (seed/admin) — adicionar Calistenia/Muay Thai/Jiu-Jitsu/Natação
> lá é um passo separado de seed.

> Convenção de prescrição: **séries × repetições · descanso(s)**. Para intervalado/aeróbico:
> **trabalho(s) / descanso(s) × rounds**.
