# Prompt de design — animações de execução dos exercícios (StayTraining)

Cole a seção **"PROMPT"** no Claude (design / artifacts), **anexando as suas fotos de referência**
(ver *Imagem de exemplo*). A saída é uma página HTML self-contained com uma **animação em loop por
exercício**, no estilo VOLT — da qual você exporta os GIFs ou usa o SVG/Lottie direto.

> **Fonte da verdade dos movimentos:** a execução de **cada** exercício está em
> `artifacts/training/exercicios.md` (catálogo completo por modalidade) e, para os do seed, em
> `artifacts/todo/treinos.md`. O prompt abaixo define **como transformar cada execução em animação**.

---

## PROMPT

Você é designer de motion/ilustração. Gere uma **página HTML única, self-contained** (todo CSS/JS
inline, **sem** assets externos/CDNs/fontes por URL) com **uma animação de demonstração por
exercício** do app **StayTraining**. Cada animação mostra a **execução correta** em **loop suave**,
no estilo do app. Aplique a metodologia abaixo a **todos** os exercícios listados em
`artifacts/training/exercicios.md`, começando pelos 17 do seed (`artifacts/todo/treinos.md`).

### Imagem de exemplo (foto do usuário) — obrigatório usar
Vou **anexar 1+ fotos minhas** como referência de execução. Use-as assim:
- **Modelo do boneco:** baseie o personagem animado nas minhas fotos — proporções, biótipo e
  vestuário aproximados — como uma **silhueta/ilustração estilizada** (não precisa ser fotorrealista;
  pode ser rotoscopia/traço estilizado sobre a pose). Mantenha a mesma identidade visual em todos os
  exercícios.
- **Pose de referência:** quando eu enviar a foto executando um movimento específico, trate-a como o
  **quadro-chave** daquela execução (a "posição correta") e anime as demais fases em torno dela.
- **Camada de referência (opcional):** pode usar a foto como camada semitransparente por baixo do
  traço para calibrar ângulos, mas o resultado final é a ilustração estilizada.
- Se eu enviar poucas fotos, **generalize** o mesmo personagem para os exercícios sem foto,
  mantendo coerência de proporção/vestuário.
- **Boa foto de referência:** corpo inteiro, fundo neutro, roupa de treino, de **perfil** e de
  **frente**; se possível, uma foto no **início** e outra no **fim** do movimento.
- **Privacidade:** as fotos são usadas só como referência visual para gerar as ilustrações.

### Formato e layout
- **Grade de cards**, um por exercício, agrupados por **modalidade** (Musculação, Funcional,
  Calistenia, Aeróbico, Boxe, Muay Thai, Jiu-Jitsu, Natação, Mobilidade).
- Card: **animação** (~1:1), **nome**, **músculo/foco-alvo**, **prescrição**; botão **pausar/reproduzir**;
  respeitar `prefers-reduced-motion` (mostrar quadro estático). Cada card com **slug** kebab-case estável.
- Responsivo (1 coluna no celular; grade em telas largas); sem scroll horizontal.

### Estilo (design system "VOLT")
- **Accent volt:** claro `#A6D400` / escuro `#C7F536`; texto de contraste `#0C0E12`.
- Secundária `#FF5A3C` · terciária `#4EA8FF` · sucesso `#2FD37A` · alerta `#FFB020` · erro `#FF4757`.
- Fundo claro `#F4F5F1` / superfície `#FFFFFF`; escuro fundo `#0C0E12` / superfície `#14171D`.
- Texto `#131720` / `#F2F5F7`; linhas `#E4E7E0` / `#2A313C`; **raio 12px**.
- Tipografia: display **Archivo** (títulos/labels 700–800), corpo **Hanken Grotesk**.
- **Cor por modalidade** (borda/realce): Musculação/Calistenia/Natação `#4EA8FF`, Funcional `#2FD37A`,
  Boxe/Muay Thai/Jiu-Jitsu `#FF4757`, Aeróbico `#FFB020`.
- Tema claro/escuro (`prefers-color-scheme`). Boneco em silhueta; **equipamento e trajetória** do
  movimento realçados no **volt**.

### Técnica
- SVG animado (CSS `@keyframes`/SMIL) ou Canvas; **loop infinito**, easing suave, sem “teleporte”
  entre fim e início (o último quadro liga no primeiro).
- Inline tudo; nada externo. Movimento anatomicamente plausível e seguro (amplitude realista,
  coluna neutra, sem exageros).

---

## Como animar CADA exercício (metodologia)

Para cada exercício, leia a **execução** em `exercicios.md` e converta em **fases (quadros-chave)**.
Regras gerais:
- **2–4 s por ciclo**, loop contínuo. Marque a fase de esforço (concêntrica) em ritmo levemente mais
  rápido que a de retorno (excêntrica).
- **POV de perfil** por padrão (frente quando o movimento é lateral/simétrico — ex.: elevação lateral,
  polichinelo, agachamento sumô).
- Destaque em **volt**: barra/halter/corda/polia/saco/água e a **linha de trajetória** do movimento.
- Mostre **1–2 repetições** por loop. Exercícios isométricos: loop curto com micro-movimento (respiração).
- Indique a **articulação/músculo-alvo** com um leve realce/pulso na região trabalhada.

### Regras por modalidade
- **Musculação / Calistenia (força):** 2 fases — **excêntrica** (descida/alongamento) → **concêntrica**
  (subida/contração) → volta. Ex.: supino desce à linha do peito → empurra até estender. Mostrar o
  implemento e a barra de trajetória; contrair o músculo-alvo no pico.
- **Funcional:** ciclo do movimento completo (ex.: kettlebell swing: quadril recua → estende explosivo
  → peso sobe → desce); enfatizar o **impulso do quadril**/potência.
- **Aeróbico / Cardio:** ciclo rítmico repetitivo (corrida, corda, polichinelo, remo); cadência
  constante, sem pausa entre ciclos; leve “bounce” no eixo vertical.
- **Boxe / Muay Thai (striking):** **guarda → golpe → retorno à guarda** (rotação de quadril no
  golpe; check/defesa quando aplicável). Cada golpe/chute é um ciclo; sequências (combos) encadeiam
  os golpes na ordem do nome. Realçar o membro que golpeia e o alvo.
- **Jiu-Jitsu (drills):** transição de posição em loop (ex.: shrimp: empurra o quadril e volta;
  ponte: eleva e desce). Dois personagens só quando essencial (passagem/raspagem); senão, solo.
- **Natação:** ciclo de **braçada + pernada + respiração** do estilo; mostrar a **linha d’água**, o
  corpo hidrodinâmico e o padrão de braços/pernas do nado. Vista lateral (subaquática/superfície).
- **Mobilidade/Alongamento:** entrar na posição → sustentar (leve respiração) → soltar; amplitude
  suave.

### Exemplos totalmente especificados (padrão a replicar)
**Supino reto (Musculação):** fase 1 (0–40%) barra desce controlada da extensão até tocar a linha do
peito, cotovelos ~45°; fase 2 (40–75%) empurra até estender, peitoral pulsa em volt; fase 3 (75–100%)
segura 1 tempo no topo → reinicia. POV perfil, banco horizontal, barra em volt com linha vertical.

**Agachamento livre (Musculação):** em pé, barra no trapézio → desce (quadril para trás, coxas
paralelas, tronco firme) 0–45% → sobe empurrando o chão 45–85% → topo 85–100%. Perfil; joelhos
acompanham as pontas dos pés.

**Kettlebell swing (Funcional):** quadril recua (hip hinge) → estende explosivo levando o KB à altura
dos ombros → KB desce entre as pernas → repete. Perfil; arco do KB em volt.

**Burpee (Calistenia/Aeróbico):** em pé → agacha e apoia as mãos → pés para trás (prancha) → pés à
frente → salto com braços acima → repete. Perfil; ciclo fluido ~3 s.

**Pular corda (Aeróbico):** saltos baixos contínuos, punhos girando a corda; corda em volt desenha o
arco completo a cada ciclo (~0,6 s por salto, 3–4 saltos no loop).

**1-2 jab-direto (Boxe):** guarda alta → jab (braço da frente estende e recolhe) → direto (braço de
trás com rotação de quadril) → guarda. Realçar o punho que golpeia; ~2,5 s.

**Chute médio (Muay Thai):** guarda → pé de apoio pivota, quadril gira, canela bate na linha das
costelas → recolhe à guarda. Perfil; arco do chute em volt.

**Shrimp / fuga de quadril (Jiu-Jitsu):** deitado, empurra o quadril para trás/lado apoiando pés e
ombros → retorna → repete para o outro lado. Vista superior levemente lateral; solo.

**Nado livre / crawl (Natação):** corpo horizontal na linha d’água; braçada alternada (entrada,
puxada, recuperação) + pernada contínua + respiração lateral a cada 2–3 braçadas. Vista lateral.

### Nomenclatura de saída
Slug kebab-case a partir do nome (sem acentos): `supino-reto`, `agachamento-livre`,
`kettlebell-swing`, `jab-e-direto`, `chute-medio`, `shrimp`, `nado-livre`, etc. Use o mesmo slug no
card e no GIF exportado.

### Critérios de aceite
- [ ] Uma animação por exercício do catálogo (`exercicios.md`), agrupadas por modalidade; loop suave.
- [ ] Personagem baseado nas **fotos de referência** enviadas, coerente entre exercícios.
- [ ] Metodologia por modalidade respeitada (fases corretas; guarda→golpe→guarda; ciclo de nado; etc.).
- [ ] Estilo VOLT (cores/tipografia/raio + cor da modalidade + implemento/trajetória em volt).
- [ ] Tema claro/escuro; `prefers-reduced-motion` estático; página self-contained e responsiva.
- [ ] Nome, foco-alvo e prescrição visíveis; slug estável por card; movimento seguro e plausível.

---

## Exemplos de referência visual (links)

> Para conferir o movimento antes de animar. ⚠️ **Referências** — cheque a licença antes de reutilizar arquivos.

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
| Chute médio (Muay Thai) | [muay thai mid kick](https://www.google.com/search?tbm=isch&q=muay+thai+roundhouse+kick+gif) |
| Nado livre | [freestyle swimming](https://www.google.com/search?tbm=isch&q=freestyle+swimming+technique+gif) |
| Shrimp (Jiu-Jitsu) | [bjj hip escape](https://www.google.com/search?tbm=isch&q=bjj+hip+escape+shrimp+gif) |
| Polichinelo | [jumping jacks](https://www.google.com/search?tbm=isch&q=jumping+jacks+gif) |
| Pular corda | [jump rope](https://www.google.com/search?tbm=isch&q=jump+rope+gif) |

## Referências no repositório
- **Catálogo completo (execução por exercício):** `artifacts/training/exercicios.md`.
- Modelos de treino: `artifacts/training/modelos.md`. Seed p/ GIF: `artifacts/todo/treinos.md`.
- Tema/tokens: `backend/src/EntryPoints/Web.Blazor/Theme/StayTrainingTheme.cs` e
  `mobile/lib/core/theme/app_theme.dart`.

## Depois de gerar
1. Anexe as fotos de referência e valide o personagem/animações.
2. Exporte cada card como GIF (screen recording da figura → conversor, ~480–720px, loop) ou use o
   SVG/Lottie direto.
3. Anexe como mídia do exercício pelo backoffice (upload já existente) — o app exibe GIF/vídeo/imagem.
