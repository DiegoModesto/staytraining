# Prompt de design — animações de execução dos exercícios (StayTraining)

Cole o conteúdo da seção **"PROMPT"** abaixo no Claude (recurso de design / artifacts) para gerar as
animações de demonstração dos exercícios. As seções seguintes (design system, registros, exemplo,
critérios) fazem parte do prompt — envie tudo junto.

> **Por que HTML/animação e não GIF direto:** o Claude design gera páginas HTML self-contained
> (SVG/CSS/Canvas). A saída é uma página com uma animação em **loop** por exercício, no estilo do app.
> A partir dela você **grava/exporta cada GIF** (ex.: screen recording da área da figura → conversor
> para GIF, ou captura de tela em loop). Alternativamente, use a animação SVG/Lottie diretamente.

---

## PROMPT

Você é designer de motion/ilustração. Gere uma **página HTML única, self-contained** (todo CSS/JS
inline, sem assets externos, sem CDNs) com **uma animação de demonstração por exercício** do app de
treinos **StayTraining**. Cada animação mostra a **execução correta** do movimento, em **loop suave**
(2–4 s), vista de **perfil**, com um boneco/manequim estilizado minimalista e o equipamento quando
houver.

### Objetivo
Servir de referência visual de execução para o aluno e como base para exportar GIFs (≈480–720px,
sem áudio, loop) que serão anexados como mídia de cada exercício.

### Formato e layout
- Uma **grade de cards**, um card por exercício, agrupados por **modalidade** (Musculação, Funcional,
  Boxe, Aeróbico).
- Cada card: a **animação** (quadrada, ~1:1), o **nome** do exercício, o **músculo-alvo** e a
  **prescrição padrão**. Botão para **pausar/reproduzir** e respeito a `prefers-reduced-motion`
  (mostrar quadro estático quando reduzido).
- Responsivo (1 coluna no celular, grade em telas largas); a página não rola horizontalmente.
- Cada card tem um **id/slug** estável (ex.: `agachamento-livre`) para facilitar a captura.

### Estilo (design system "VOLT")
Use exatamente estes tokens (o app já usa este tema):
- **Accent volt:** claro `#A6D400`, escuro `#C7F536`; texto de contraste sobre o volt: `#0C0E12`.
- **Secundária** `#FF5A3C` · **terciária** `#4EA8FF` · sucesso `#2FD37A` · alerta `#FFB020` · erro `#FF4757`.
- **Fundo** claro `#F4F5F1` / superfície `#FFFFFF`; **escuro** fundo `#0C0E12` / superfície `#14171D`.
- **Texto** `#131720` (claro) / `#F2F5F7` (escuro); linhas `#E4E7E0` / `#2A313C`; **raio 12px**.
- **Tipografia:** display **Archivo** (títulos/labels, peso 700–800), corpo **Hanken Grotesk**.
- **Cor por modalidade** (borda/realce do card): Musculação `#4EA8FF`, Funcional `#2FD37A`,
  Boxe `#FF4757`, Aeróbico `#FFB020`.
- Tema **claro/escuro** (respeitar `prefers-color-scheme`). Boneco em silhueta neutra; o
  equipamento (barra, halter, corda, saco) e a trajetória do movimento realçados no accent volt.

### Técnica
- SVG animado (via CSS `@keyframes`/SMIL) ou Canvas; **loop infinito**, easing suave, sem “teleporte”
  entre o fim e o início.
- Nada de imagens externas, fontes por URL ou scripts de CDN — inline tudo (fontes podem ser
  fallback do sistema se necessário).
- Movimento correto e seguro: amplitude realista, coluna neutra, sem exageros.

### Exercícios (nome · modalidade · músculo · prescrição · **quadros-chave do movimento**)
Anime cada um pelos quadros-chave (posição inicial → final → retorno):

**Musculação**
1. **Supino reto** · peito · 4×10 · 90s — deitado no banco; barra desce até a linha do peito → empurra até estender os cotovelos.
2. **Crucifixo** · peito · 3×12 · 60s — halteres acima do peito, cotovelos levemente fletidos; abre em arco até a linha do peito → fecha.
3. **Desenvolvimento militar** · ombro · 4×10 · 90s — barra na altura dos ombros → empurra acima da cabeça até estender → desce.
4. **Elevação lateral** · ombro · 3×15 · 45s — halteres ao lado do corpo → eleva lateralmente até a altura dos ombros → desce.
5. **Levantamento terra** · posterior de coxa · 4×8 · 120s — barra no chão, coluna neutra → sobe estendendo quadril e joelhos (barra rente às pernas) → desce.
6. **Puxada frente** · costas · 4×10 · 90s — na polia alta, pegada aberta → puxa a barra até o peito aproximando as escápulas → sobe.
7. **Remada curvada** · costas · 4×10 · 90s — tronco inclinado, coluna neutra → puxa a barra ao abdômen → estende.
8. **Rosca direta** · bíceps · 3×12 · 60s — barra na frente das coxas → flexiona os cotovelos elevando sem balançar → desce.
9. **Tríceps corda** · tríceps · 3×12 · 60s — polia alta, cotovelos junto ao corpo → estende os antebraços abrindo a corda → retorna.
10. **Agachamento livre** · quadríceps · 4×10 · 120s — barra no trapézio → desce até coxas paralelas, tronco firme → sobe.

**Funcional**
11. **Afundo** · quadríceps · 3×12 · 60s — passo à frente → desce o quadril (joelho ~90°) → empurra de volta; alterna pernas.
12. **Burpee** · corpo inteiro · 3×12 · 45s — agacha → apoia as mãos e joga os pés para trás (prancha) → volta os pés → salto com braços acima.
13. **Prancha** · abdômen · 3× · 60s (isometria) — apoio em antebraços e pés, corpo em linha reta; loop curto de sustentação com leve respiração.

**Boxe**
14. **Jab e direto (sombra)** · corpo inteiro · 5× · 60s — guarda alta → jab (braço da frente) → direto (braço de trás) com rotação do quadril → guarda.
15. **Saco pesado** · corpo inteiro · 5× · 60s — sequência jab-direto no saco, transferindo peso e girando o quadril; saco balança levemente.

**Aeróbico**
16. **Polichinelo** · corpo inteiro · 5× · 30s — pés juntos e braços ao lado → salta abrindo pernas e elevando os braços → volta.
17. **Pular corda** · corpo inteiro · 5× · 30s — saltos baixos e contínuos girando a corda pelos punhos, aterrissando na ponta dos pés.

### Nomenclatura de saída (para exportar/guardar)
Use estes slugs (kebab-case) por card e nos GIFs exportados:
`supino-reto`, `crucifixo`, `desenvolvimento-militar`, `elevacao-lateral`, `levantamento-terra`,
`puxada-frente`, `remada-curvada`, `rosca-direta`, `triceps-corda`, `agachamento-livre`, `afundo`,
`burpee`, `prancha`, `jab-e-direto`, `saco-pesado`, `polichinelo`, `pular-corda`.

### Critérios de aceite
- [ ] 17 animações, agrupadas por modalidade, cada uma em loop suave e sem “corte” visível.
- [ ] Estilo VOLT (cores/tipografia/raio), com realce da cor da modalidade e do equipamento em volt.
- [ ] Tema claro/escuro via `prefers-color-scheme`; `prefers-reduced-motion` mostra quadro estático.
- [ ] Página self-contained (sem assets/fontes/scripts externos) e responsiva (sem scroll horizontal).
- [ ] Nome, músculo-alvo e prescrição visíveis em cada card; slug estável por card.
- [ ] Movimento anatomicamente plausível e seguro (amplitude realista, coluna neutra).

---

## Referências no repositório
- Execução detalhada de cada exercício: `artifacts/todo/treinos.md`.
- Biblioteca/modelos de treino: `artifacts/training/exercicios.md`, `artifacts/training/modelos.md`.
- Tema/tokens no código: `backend/src/EntryPoints/Web.Blazor/Theme/StayTrainingTheme.cs` e
  `mobile/lib/core/theme/app_theme.dart`.

## Exemplos de referência visual (links)

> Use para conferir como o movimento é executado antes de animar. ⚠️ São **referências** — cheque a
> licença de cada fonte antes de reutilizar qualquer arquivo.

**Fontes abertas/candidatas:** [Free Exercise DB (domínio público)](https://yuhonas.github.io/free-exercise-db/) ·
[exercises-dataset (GIFs)](https://github.com/hasaneyldrm/exercises-dataset) ·
[ExerciseDB API](https://github.com/ExerciseDB/exercisedb-api) ·
[MuscleWiki](https://musclewiki.com) · [Pixabay GIFs](https://pixabay.com/gifs/) ·
[LottieFiles](https://lottiefiles.com/free-animations/exercise)

**Busca por exercício** (termo EN → imagens/GIF):

| Exercício | Referência |
|---|---|
| Supino reto | [barbell bench press](https://www.google.com/search?tbm=isch&q=barbell+bench+press+gif) |
| Crucifixo | [dumbbell chest fly](https://www.google.com/search?tbm=isch&q=dumbbell+chest+fly+gif) |
| Desenvolvimento militar | [military press](https://www.google.com/search?tbm=isch&q=military+press+gif) |
| Elevação lateral | [lateral raise](https://www.google.com/search?tbm=isch&q=dumbbell+lateral+raise+gif) |
| Levantamento terra | [barbell deadlift](https://www.google.com/search?tbm=isch&q=barbell+deadlift+gif) |
| Puxada frente | [lat pulldown](https://www.google.com/search?tbm=isch&q=lat+pulldown+gif) |
| Remada curvada | [bent-over row](https://www.google.com/search?tbm=isch&q=barbell+bent+over+row+gif) |
| Rosca direta | [barbell curl](https://www.google.com/search?tbm=isch&q=barbell+biceps+curl+gif) |
| Tríceps corda | [triceps rope pushdown](https://www.google.com/search?tbm=isch&q=triceps+rope+pushdown+gif) |
| Agachamento livre | [barbell squat](https://www.google.com/search?tbm=isch&q=barbell+squat+gif) |
| Afundo | [dumbbell lunge](https://www.google.com/search?tbm=isch&q=dumbbell+lunge+gif) |
| Burpee | [burpee](https://www.google.com/search?tbm=isch&q=burpee+gif) |
| Prancha | [plank](https://www.google.com/search?tbm=isch&q=plank+exercise+gif) |
| Jab e direto (sombra) | [boxing jab cross](https://www.google.com/search?tbm=isch&q=boxing+jab+cross+gif) |
| Saco pesado | [heavy bag boxing](https://www.google.com/search?tbm=isch&q=heavy+bag+boxing+gif) |
| Polichinelo | [jumping jacks](https://www.google.com/search?tbm=isch&q=jumping+jacks+gif) |
| Pular corda | [jump rope](https://www.google.com/search?tbm=isch&q=jump+rope+gif) |

## Depois de gerar
1. Abra o artifact, valide as 17 animações.
2. Exporte cada card como GIF (screen recording da área da figura → conversor GIF, ~480–720px, loop)
   ou use o SVG/Lottie diretamente.
3. Anexe como mídia do exercício pelo backoffice (upload já existente) — o app exibe GIF/vídeo/imagem.
