# Aula 10 — PM + Architect: Spec Completa Multi-Layer

<!-- metadata
module: 3
lesson: 10
title: "PM + Architect: Spec Completa Multi-Layer"
duration: 4 horas
agents: "@pm, @architect, @qa"
project: AuctionHunter
phase: Planejamento (Fase 1)
prerequisites: Aula 09 concluída (domínio mapeado + failure analysis)
-->

---

> **Módulo 3** · AuctionHunter: Recomeço Estruturado
> **Duração**: 4 horas
> **Agentes praticados**: `@pm`, `@architect`, `@qa`
> **Projeto**: AuctionHunter

---

## 🏆 Vitória desta aula

PRD com requisitos por layer, Architecture Doc com pipeline de fallback, e specs executáveis aprovadas pelo QA após iteração.

**Critério binário**: PRD + Arch Doc + specs no `docs/` que o QA revisou e aprovou.

---

## Conceito

### Spec Pipeline: onde o planejamento vira contrato executável

No RockQuiz, o PM escreveu um PRD e o Architect um Arch Doc — ambos cobriam um sistema coeso. No AuctionHunter, a arquitetura é **multi-layer**: cada camada de scraping é quase um subsistema independente com seus próprios inputs, outputs, modos de falha e estratégias de fallback.

Isso significa que o PRD precisa de requisitos **por layer**, e a arquitetura precisa definir **como as layers se conectam, como uma delega para a outra quando falha, e como os dados convergem para um schema único**.

O Spec Pipeline do ADE (Epic 3) tem 7 etapas:

| Etapa | O que produz |
|-------|-------------|
| 1. Elicitação | Perguntas que refinam o escopo |
| 2. Spec draft | Primeira versão da spec |
| 3. Self-critique | Autor identifica falhas na própria spec |
| 4. QA critique | QA identifica falhas adicionais |
| 5. Iteração | Autor corrige baseado no feedback |
| 6. Aprovação | QA aprova a spec |
| 7. Spec executável | Spec pronta para o Dev implementar |

No RockQuiz, esse ciclo foi implícito. Aqui vamos torná-lo **explícito**: o QA vai criticar as specs e o PM vai iterar até aprovação. Isso é o ADE na prática — não simulado.

### O princípio aplicado

Você vai contextualizar o PM com os documentos do Analyst (brief, domain map, failure analysis). O PM vai transformar esse input em requisitos. O Architect vai propor a arquitetura. Você **não vai ditar** quais FRs escrever, qual stack usar ou como organizar o fallback. Vai avaliar se os outputs cobrem o domínio e endereçam os riscos mapeados.

---

## Contexto

O Analyst (Aula 09) produziu três documentos que agora servem de input: o project brief define o escopo, o domain map identifica as fontes por layer, e o failure analysis lista o que não pode se repetir. O PM e o Architect vão transformar análise em especificação — e cada risco do failure analysis deve virar um requisito ou uma decisão arquitetural.

---

## Prática

### Passo 1 — PM: PRD com requisitos por layer

```bash
cd ~/aiox-bootcamp/auctionhunter
claude
```

```
@pm

Patty, leia os documentos que o Analyst (Alex) produziu:
- docs/project-brief.md (escopo e propósito)
- docs/domain-map.md (fontes de dados por layer)
- docs/failure-analysis.md (o que falhou antes e por quê)

Escreva o PRD do AuctionHunter. Este projeto é diferente do 
RockQuiz porque tem múltiplas layers de scraping, cada uma 
com complexidade e modos de falha diferentes.

Preciso que o PRD tenha:

1. Functional Requirements ORGANIZADOS POR LAYER:
   - Layer 1: PDF Parser (editais públicos)
   - Layer 2: Web Scraper (sites navegáveis)
   - Layer 3: Auth Scraper (sites com login/captcha)
   - Data Normalizer (convergir dados de qualquer layer)
   - API de consulta (endpoints para acessar resultados)

2. Non-Functional Requirements que enderecem CADA RISCO do 
   failure analysis. Se a tentativa anterior falhou porque 
   regex era frágil, preciso de NFR sobre robustez de parsing. 
   Se falhou por falta de fallback, preciso de NFR sobre 
   resiliência.

3. Acceptance Criteria em Gherkin para cada FR — testáveis 
   e sem ambiguidade.

*write-spec
```

**O que esperar**: O PM deve produzir um PRD que reflita a complexidade real do domínio. Cada layer tem FRs específicos porque os desafios técnicos são diferentes: parsear um PDF é diferente de navegar um site, que é diferente de lidar com login + captcha.

**Como avaliar**:

> **Checklist de avaliação do PRD**
> - <input type="checkbox" class="checkbox-input" /> FRs estão organizados por layer (não misturados)?
> - <input type="checkbox" class="checkbox-input" /> Cada FR tem acceptance criteria em Gherkin?
> - <input type="checkbox" class="checkbox-input" /> O Data Normalizer tem FRs próprios (não é apêndice de outra layer)?
> - <input type="checkbox" class="checkbox-input" /> NFRs endereçam os riscos do failure analysis? (robustez, fallback, observabilidade)
> - <input type="checkbox" class="checkbox-input" /> Há FR para o fallback entre layers? (se Layer 1 falha, Layer 2 assume)
> - <input type="checkbox" class="checkbox-input" /> O escopo do brief foi respeitado? (não extrapolou nem reduziu)

Se os FRs estiverem genéricos:

```
Patty, os FRs da Layer 1 dizem "extrair dados de PDF". 
Isso é vago. O domain map do Alex identifica PDFs tabulares, 
PDFs com texto corrido e PDFs escaneados. Cada um precisa de 
FRs diferentes porque a estratégia de extração é diferente. 
Detalhe por tipo de PDF.
```

Se os NFRs não refletirem o failure analysis:

```
Patty, o failure analysis diz que a tentativa anterior falhou 
porque não havia fallback quando a extração falhava — perdia 
100% dos dados. Não vejo NFR sobre resiliência ou fallback 
entre layers. Cada causa raiz do failure analysis deve ter 
um NFR correspondente.
```

Se faltou o Data Normalizer como componente:

```
Patty, o PRD não tem FRs para normalização de dados. 
Cada layer extrai dados em formatos diferentes — placa 
com hífen, sem hífen, com espaço; valores com "R$" ou 
sem; datas em formatos variados. Preciso de uma seção 
de FRs dedicada à normalização que garanta que os dados 
saem em formato unificado independente da fonte.
```

> **🏆 Checkpoint 1**: PRD com FRs por layer + NFRs que endereçam riscos reais.

---

### Passo 2 — Architect: arquitetura multi-layer com fallback

```
*exit

@architect

Aria, leia:
- docs/project-brief.md (escopo)
- docs/domain-map.md (fontes por layer)
- docs/failure-analysis.md (o que falhou)
- docs/prd.md (requisitos que a Patty acabou de escrever)

Projete a arquitetura do AuctionHunter. Este sistema tem 
um desafio central: MÚLTIPLAS FONTES de dados heterogêneas 
que precisam convergir para UM SCHEMA UNIFICADO, com 
fallback quando uma fonte falha.

Preciso que o Architecture Doc cubra:

1. Pipeline de extração: como um edital/URL entra no sistema 
   e sai como dados normalizados no banco
2. Arquitetura de fallback: quando Layer 1 falha, como 
   delega para Layer 2? Como detectar falha? Como reportar?
3. Schema de dados dos veículos (o formato unificado para 
   onde todas as layers convergem)
4. Stack técnica com justificativa
5. Endpoints da API de consulta
6. Diagramas (ao menos um fluxo do pipeline e a estrutura 
   de containers)

O Alex identificou que a tentativa anterior falhou por regex 
frágil, ausência de fallback e falta de schema. A arquitetura 
precisa endereçar cada um desses pontos.

*create-plan
```

**O que esperar**: O Architect deve propor uma arquitetura que trate o pipeline de scraping como uma cadeia de fallback, não como módulos isolados. O schema de dados é crítico — é o contrato que unifica dados de qualquer fonte.

**Como avaliar**:

> **Checklist de avaliação do Architecture Doc**
> - <input type="checkbox" class="checkbox-input" /> O pipeline de extração está desenhado? (entrada → layers → normalização → persistência)
> - <input type="checkbox" class="checkbox-input" /> O fallback entre layers está explícito? (Layer 1 falha → Layer 2 → Layer 3)
> - <input type="checkbox" class="checkbox-input" /> Há critério para "falha"? (o que define que a extração de uma layer falhou?)
> - <input type="checkbox" class="checkbox-input" /> O schema de veículos está definido com tipos e validações?
> - <input type="checkbox" class="checkbox-input" /> A stack é justificada? (por que essa linguagem, esse banco, esse framework?)
> - <input type="checkbox" class="checkbox-input" /> Os endpoints da API estão definidos? (contrato de input/output)
> - <input type="checkbox" class="checkbox-input" /> Há pelo menos um diagrama de fluxo?

Se o fallback for superficial:

```
Aria, o fallback diz "se Layer 1 falhar, tenta Layer 2". 
Mas não define: o que é falha? Zero dados extraídos? 
Menos de 50% dos campos? Dados extraídos mas inválidos? 
E quando Layer 2 também falha — o que acontece? O dado 
é perdido? Vai para fila de revisão manual? Defina o 
fluxo completo incluindo o cenário onde TODAS as layers 
falham.
```

Se o schema estiver ausente:

```
Aria, o Architecture Doc não define o schema de dados do 
veículo. Esse schema é o CONTRATO mais importante do 
sistema — é para onde todas as layers convergem. Preciso 
de: campos obrigatórios vs opcionais, tipos de dados, 
validações (formato de placa, formato de chassi), e como 
lidar com campos faltando (null vs valor default vs 
rejeitar o registro).
```

Se a stack não tiver justificativa:

```
Aria, o doc escolhe FastAPI sem explicar por quê. Na 
tentativa anterior usei Python — devemos manter por 
causa do ecossistema (pdfplumber, Playwright, Scrapy) 
ou há razão para mudar? Justifique a escolha considerando 
as bibliotecas de scraping disponíveis.
```

> **🏆 Checkpoint 2**: Architecture Doc com pipeline, fallback, schema e stack definidos.

---

### Passo 3 — QA critica as specs

Agora o QA entra para **criticar antes de implementar**. Isso é o Spec Pipeline (Epic 3 do ADE) na prática:

```
*exit

@qa

Quinn, leia:
- docs/prd.md (PRD da Patty)
- docs/architecture.md (Architecture Doc da Aria)
- docs/domain-map.md (mapeamento do Alex)
- docs/failure-analysis.md (análise de falha do Alex)

Critique as specs com foco em:

1. COMPLETUDE: os FRs cobrem todos os cenários do domain map? 
   Há fontes mapeadas que não têm FRs?
2. TESTABILIDADE: cada acceptance criteria é realmente testável? 
   Ou tem critérios vagos como "deve ser rápido"?
3. CONSISTÊNCIA: o PRD e o Arch Doc estão alinhados? A stack 
   suporta os requisitos? O schema cobre todos os campos que 
   os FRs mencionam?
4. LIÇÕES APRENDIDAS: cada causa raiz do failure analysis tem 
   pelo menos um FR, NFR ou decisão arquitetural endereçando?
5. EDGE CASES: e quando o PDF tem 500 veículos? E quando dois 
   veículos têm a mesma placa de fontes diferentes? E quando 
   o campo "valor mínimo" está em formato inesperado?

*critique-spec
```

**O que esperar**: O QA deve encontrar gaps. Sempre encontra. Exemplos reais do tipo de coisa que o QA identifica em specs de scraping:

- "FR-L1-03 diz 'extrair dados de PDFs tabulares' mas o domain map identifica 3 tipos de tabela (com header, sem header, com merged cells). Faltam FRs específicos."
- "O Arch Doc define fallback L1→L2 mas o PRD não tem FR para logging de fallback. Se Layer 1 falha silenciosamente, nunca saberemos por quê."
- "O schema define 'placa' como string, mas não especifica validação de formato. Placas brasileiras têm formato antigo (ABC-1234) e Mercosul (ABC1D23). Qual aceitar?"
- "O failure analysis diz que faltava normalização. O PRD tem FRs para normalização, mas o Arch Doc não mostra onde no pipeline a normalização acontece."

**Como avaliar o critique**:

> **Checklist de qualidade do critique**
> - <input type="checkbox" class="checkbox-input" /> O QA encontrou gaps reais (não apenas formatação)?
> - <input type="checkbox" class="checkbox-input" /> Cada issue tem justificativa concreta?
> - <input type="checkbox" class="checkbox-input" /> Referencia os documentos de input (domain map, failure analysis)?
> - <input type="checkbox" class="checkbox-input" /> Identifica inconsistências entre PRD e Arch Doc?
> - <input type="checkbox" class="checkbox-input" /> Cobre edge cases do domínio de leilões?

Se o critique for superficial:

```
Quinn, o critique foca em formatação do PRD. Preciso de 
análise de SUBSTÂNCIA: os FRs cobrem o domínio? O fallback 
da arquitetura é completo? As lições do failure analysis 
foram incorporadas? Qual FR não é testável como está escrito?
```

> **🏆 Checkpoint 3**: Critique do QA com issues substanciais identificadas.

---

### Passo 4 — PM e Architect iteram baseado no critique

```
*exit

@pm

Patty, o QA (Quinn) criticou o PRD. Leia o relatório de 
critique e corrija:
- FRs faltando que o QA identificou
- Acceptance criteria vagos que precisam ser específicos
- Inconsistências com o Architecture Doc

Para cada issue do QA, indique o que mudou no PRD.
```

Depois, o Architect:

```
*exit

@architect

Aria, o QA também criticou o Architecture Doc. Leia o 
relatório e corrija:
- Gaps no pipeline de fallback
- Schema de dados incompleto
- Inconsistências com o PRD atualizado

Para cada issue do QA, indique o que mudou no Arch Doc.
```

**Como acompanhar**:

```
Patty/Aria, o QA reportou N issues. Confirme que cada 
uma foi endereçada. Liste: issue → o que mudou.
```

Se PM ou Architect discordarem de alguma issue:

```
Patty, você diz que o FR para PDFs escaneados "não está 
no escopo". Mas o domain map do Alex inclui PDFs escaneados 
como cenário real. Se não está no escopo, precisa estar 
explicitamente listado no "fora do escopo" do brief. 
Decida: está dentro ou fora? Se fora, documente. Se dentro, 
escreva o FR.
```

---

### Passo 5 — QA aprova

```
*exit

@qa

Quinn, PM e Architect iteraram baseado no seu critique.

Verifique:
1. Cada issue que você reportou foi endereçada?
2. As correções são adequadas (não apenas cosméticas)?
3. PRD e Arch Doc estão consistentes entre si?

*verify-fix

Se todas as issues foram resolvidas, aprove as specs.
Se algo persiste, reporte o que falta.
```

O ciclo repete se necessário. Na prática, 1-2 iterações costumam ser suficientes.

> **🏆 Checkpoint 4**: QA aprovou specs após iteração.

---

### Passo 6 — Specs executáveis por layer

Com PRD e Arch Doc aprovados, gerar as specs que o Dev vai implementar:

```
*exit

@pm

Patty, agora preciso de specs executáveis — uma para cada 
componente que o Dev vai implementar. Baseie-se no PRD 
aprovado e no Architecture Doc.

Gere specs separadas para:
1. Layer 1: PDF Parser
2. Layer 2: Web Scraper
3. Layer 3: Auth Scraper (login + captcha)
4. Data Normalizer
5. API de consulta + persistência

Cada spec deve ser um arquivo em docs/specs/ com:
- Objetivo claro
- FRs correspondentes do PRD (referência)
- Input esperado e output esperado
- Cenários de erro e como tratar
- Acceptance criteria da spec (quando está "pronta"?)

Essas specs vão alimentar o ADE Execution Engine nas 
próximas aulas.

*write-spec
```

**Como verificar**:

```bash
ls docs/specs/
# Deve conter 5 specs
```

> **Checklist de avaliação das specs**
> - <input type="checkbox" class="checkbox-input" /> Há 5 specs separadas (uma por componente)?
> - <input type="checkbox" class="checkbox-input" /> Cada spec referencia os FRs do PRD?
> - <input type="checkbox" class="checkbox-input" /> Input e output estão claros para cada spec?
> - <input type="checkbox" class="checkbox-input" /> Cenários de erro estão documentados?
> - <input type="checkbox" class="checkbox-input" /> As specs são independentes o suficiente para implementar em paralelo?

Se as specs estiverem acopladas:

```
Patty, a spec do Web Scraper assume que o Data Normalizer 
já existe. As specs precisam ser independentes — cada uma 
define seu output em formato intermediário, e o Normalizer 
recebe qualquer um desses formatos. Desacople.
```

> **🏆 Checkpoint 5 — VITÓRIA DA AULA**: PRD + Arch Doc + 5 specs aprovadas no `docs/`.

---

### Passo 7 — Commit

```bash
*exit

git add .
git commit -m "docs: PRD, architecture, and 5 executable specs for AuctionHunter

- PRD with FRs organized by scraping layer + normalizer + API
- Architecture Doc with multi-layer fallback pipeline and vehicle schema
- QA critique cycle completed (specs iterated and approved)
- 5 executable specs: PDF parser, web scraper, auth scraper,
  data normalizer, API + persistence"
```

---

## Reflexão

### O Spec Pipeline muda o jogo

Compare o que aconteceu na primeira tentativa do AuctionHunter com o que esta aula produziu:

| Primeira tentativa | Com AIOX (esta aula) |
|-------------------|----------------------|
| Sem requisitos escritos | PRD com FRs por layer + acceptance criteria |
| Sem schema definido | Schema de veículos no Arch Doc |
| Sem fallback planejado | Pipeline de fallback L1→L2→L3 documentado |
| Sem specs para implementar | 5 specs executáveis independentes |
| Sem review antes de codar | QA criticou e iterou antes de uma linha de código |
| Falha descoberta em runtime | Riscos mapeados e endereçados nos docs |

A diferença não é que agora "vai dar certo" — scrapers vão falhar, PDFs vão surpreender, captchas vão bloquear. A diferença é que agora existe **um plano para quando as coisas falham**. Fallback documentado. Recovery previsto. Schema que aceita dados parciais. Isso é o que faltou antes.

### O conceito-chave

> **O Spec Pipeline (Epic 3 do ADE) existe para garantir que specs são criteriosas antes de virar código. A iteração PM → QA → PM não é burocracia — é a diferença entre implementar sobre specs sólidas e implementar sobre achismos. No AuctionHunter, cada gap encontrado pelo QA nas specs é um bug que nunca vai existir no código.**

### Conexão com a próxima aula

Na Aula 11, o @dev implementa os scrapers — Layer 1 (PDF), Layer 2 (Web) e Layer 3 (Auth). Cada layer usa sua spec como contrato. O ADE Execution Engine (13 steps) entra em ação pela primeira vez de forma metódica, e a Memory Layer começa a acumular insights entre layers. Scrapers vão falhar — e o Recovery System vai ser exercitado de verdade.

---

> **Anterior**: Aula 09 — Analyst: Entendendo o Domínio
> **Próxima**: Aula 11 — Dev: Implementando os Scrapers
