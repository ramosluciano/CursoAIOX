# Aula 14 — Arquitetura do Squad de Conteúdo

<!-- metadata
module: 4
lesson: 14
title: "Arquitetura do Squad de Conteúdo"
duration: 4 horas
agents: "@analyst, @architect"
project: Squad LinkedIn Monitoragindo
phase: Planejamento (Fase 1)
prerequisites: Aula 13 concluída (AuctionHunter entregue)
-->

---

> **Módulo 4** · Squad LinkedIn Monitoragindo
> **Duração**: 4 horas
> **Agentes praticados**: `@analyst`, `@architect`
> **Projeto**: Squad LinkedIn Monitoragindo

---

## 🏆 Vitória desta aula

Squad de conteúdo LinkedIn projetado com 6 agentes especializados, 4 workflows distintos (um por vertente editorial), templates de prompt e checklists de qualidade por tipo de conteúdo.

**Critério binário**: `config.yaml` do squad + 4 workflows YAML + definição dos 6 agentes + templates + checklists no projeto.

---

## Conceito

### De agentes individuais a squads: o salto

Nos Módulos 2 e 3, você usou agentes AIOX individuais: @analyst pesquisou, @pm especificou, @dev implementou, @qa revisou. Cada agente trabalhava sozinho, acionado por você. Você era o orquestrador — decidia qual agente chamar, em que ordem, com qual input.

Um squad é diferente. Um squad é um **time de agentes que trabalham em conjunto**, com workflows definidos que determinam a ordem, os inputs/outputs entre agentes, e os pontos de decisão humana. Você não orquestra cada passo — define o workflow e o squad executa.

| Aspecto | Agentes individuais (Módulos 2-3) | Squad (Módulo 4) |
|---------|----------------------------------|-------------------|
| Orquestração | Você decide cada passo | Workflow define a sequência |
| Comunicação | Você passa output de um para outro | Agentes passam output entre si |
| Acionamento | Manual (você chama @agent) | Workflow trigger (comando único) |
| Especialização | Agentes genéricos do AIOX | Agentes customizados para o domínio |
| Consistência | Depende de você lembrar o contexto | Workflow garante contexto entre agentes |

### Squad de conteúdo: não é "ChatGPT que posta"

A tentação com automação de conteúdo é fazer o simples: "IA, escreva um post sobre Zabbix e poste no LinkedIn". O resultado é genérico, sem voz pessoal, sem estratégia editorial, sem consistência entre posts.

O Squad LinkedIn Monitoragindo é diferente em 3 dimensões:

**Voz autêntica**: Um agente especializado analisa seus posts históricos e constrói um Voice Profile — tom, expressões, estrutura preferida, emojis, nível de formalidade. Todos os outros agentes referenciam esse perfil. O conteúdo sai na SUA voz, não na voz genérica de IA.

**Vertentes editoriais**: Não é "conteúdo aleatório". São 4 vertentes com propósitos, formatos e cadências diferentes. Cada vertente tem workflow próprio porque o processo de criação é diferente:

| Vertente | Propósito | Formato | Cadência |
|----------|-----------|---------|----------|
| Zabbix Quiz | Engajamento técnico | Enquete + post resposta | Semanal |
| Artigo Técnico | Autoridade no domínio | Mini-artigo (800-1200 palavras) | Quinzenal |
| IA na Sexta | Relevância em IA/automação | Notícia/dica/ferramenta da semana | Semanal |
| Mentalidade & Liderança | Conexão humana | Reflexão curta sobre carreira/tech | Semanal |

**Feedback loop**: Posts são publicados, métricas são coletadas (likes, comments, saves, impressions), padrões de sucesso são identificados e realimentam a geração. O squad aprende o que funciona.

### O princípio aplicado

Nesta aula você não vai implementar o squad — vai **projetá-lo**. Descrever ao Analyst e ao Architect o que o squad precisa fazer, quem são os agentes, como se comunicam, e quais são os workflows. A implementação vem nas aulas seguintes.

---

## Contexto

O Squad LinkedIn Monitoragindo é o **terceiro projeto** do Bootcamp e o primeiro com squads. Já existe um protótipo semi-funcional no Google AI Studio que será migrado para arquitetura independente na Aula 18 (brownfield). Nesta fase, projetamos o squad para a nova arquitetura — informado pelo protótipo mas não limitado por ele.

A Monitoragindo é sua consultoria. O conteúdo no LinkedIn é canal de aquisição de clientes. O squad não é exercício acadêmico — é ferramenta de negócio. Cada vertente editorial tem propósito estratégico: Zabbix Quiz gera engajamento na comunidade, Artigo Técnico estabelece autoridade, IA na Sexta mostra que você está na fronteira, Mentalidade conecta no nível humano.

---

## Prática

### Passo 1 — Analyst mapeia o domínio de conteúdo LinkedIn

```bash
mkdir -p ~/aiox-bootcamp/linkedin-squad
cd ~/aiox-bootcamp/linkedin-squad
git init
claude
```

```
@analyst

Alex, vou te contextualizar sobre um squad de conteúdo 
para LinkedIn.

NEGÓCIO: Monitoragindo — consultoria de monitoramento, 
automação e IA para infraestrutura de TI. O LinkedIn é 
o canal principal de aquisição de clientes e construção 
de autoridade.

AUDIÊNCIA: Profissionais de TI (infra, DevOps, SRE), 
gestores de tecnologia, e pessoas interessadas em automação 
com IA. Público brasileiro, conteúdo em português.

VERTENTES EDITORIAIS (4 linhas de conteúdo):
1. Zabbix Quiz — enquete técnica semanal + post com resposta 
   detalhada. Engaja a comunidade Zabbix.
2. Artigo Técnico — mini-artigo quinzenal sobre monitoramento, 
   automação ou Zabbix. Estabelece autoridade.
3. IA na Sexta — toda sexta, uma notícia, ferramenta ou dica 
   sobre IA aplicada a TI. Mostra que estou na fronteira.
4. Mentalidade & Liderança — reflexão semanal sobre carreira, 
   liderança técnica ou mindset profissional. Conecta no 
   nível humano.

CONTEXTO: Já existe um protótipo no Google AI Studio que 
gera conteúdo para essas vertentes, mas sem voz consistente, 
sem persistência, sem métricas.

Analise:
1. O domínio de conteúdo técnico no LinkedIn (o que funciona, 
   o que não funciona, padrões de engajamento)
2. Cada vertente: propósito, formato ideal, referências de 
   posts que performam bem nesse estilo
3. Riscos: o que faz conteúdo gerado por IA parecer genérico 
   e como evitar

*research-domain
```

**Como avaliar**:

> **Checklist de avaliação da pesquisa**
> - <input type="checkbox" class="checkbox-input" /> Analisou padrões de conteúdo técnico no LinkedIn? (formato, tamanho, hooks)
> - <input type="checkbox" class="checkbox-input" /> Cada vertente tem análise separada com formato ideal?
> - <input type="checkbox" class="checkbox-input" /> Identificou o que diferencia conteúdo autêntico de conteúdo genérico de IA?
> - <input type="checkbox" class="checkbox-input" /> Mencionou importância de voice/tom pessoal?
> - <input type="checkbox" class="checkbox-input" /> Identificou métricas relevantes por tipo de post? (enquete vs artigo vs reflexão)

Se a análise for genérica sobre "como fazer posts no LinkedIn":

```
Alex, a análise está genérica — vale para qualquer perfil. 
Preciso de análise específica para CONTEÚDO TÉCNICO de 
infraestrutura/DevOps no LinkedIn brasileiro. O que funciona 
nesse nicho? Enquetes técnicas geram mais engajamento que 
artigos longos? Posts pessoais sobre carreira tech performam 
diferente de posts técnicos puros? Foque no nicho.
```

Se não abordar os riscos de conteúdo IA:

```
Alex, a análise não cobre o principal risco: conteúdo 
gerado por IA que parece genérico. O algoritmo do LinkedIn 
penaliza conteúdo percebido como IA. A audiência técnica 
percebe quando um post é genérico. Quais estratégias 
concretas evitam isso? (voice profiling, referências 
pessoais, dados reais, opinião genuína)
```

> **🏆 Checkpoint 1**: Domínio de conteúdo LinkedIn mapeado por vertente.

---

### Passo 2 — Definir os agentes do squad

```
*exit

@architect

Aria, estou projetando um squad de conteúdo para LinkedIn 
com 4 vertentes editoriais. Leia a pesquisa que o Alex 
acabou de produzir.

Preciso que você defina os agentes do squad. Cada agente 
é um especialista com papel único no pipeline de criação 
de conteúdo.

Os agentes que tenho em mente (refine se necessário):

1. VOICE ANALYST — Analisa posts históricos e constrói 
   um Voice Profile (tom, expressões, estrutura, emojis, 
   nível de formalidade)
2. TREND SCOUT — Pesquisa tendências por vertente 
   (novidades Zabbix, notícias IA, temas de liderança tech)
3. QUIZ CRAFTER — Cria perguntas técnicas de Zabbix com 
   alternativas e explicação detalhada
4. CONTENT WRITER — Escreve posts usando o Voice Profile 
   como referência (NÃO genérico)
5. EDITOR — Revisa, otimiza para LinkedIn (hook, formato, 
   hashtags, CTA), garante conformidade com a vertente
6. PUBLISHER — Formata para API do LinkedIn, agenda 
   publicação, prepara primeiro comentário

Para cada agente, defina:
- Responsabilidade (o que faz)
- Input (o que recebe)
- Output (o que produz)
- Knowledge base (que informações precisa acessar)
- Dependências (de quais outros agentes depende)

*create-plan
```

**O que esperar**: O Architect deve definir cada agente como um componente com interface clara. Os agentes formam um pipeline, não uma hierarquia:

```
Trend Scout → Quiz Crafter → Content Writer → Editor → Publisher
                                    ↑
                              Voice Analyst (referência permanente)
```

**Como avaliar**:

> **Checklist de avaliação dos agentes**
> - <input type="checkbox" class="checkbox-input" /> Cada agente tem responsabilidade única (sem sobreposição)?
> - <input type="checkbox" class="checkbox-input" /> Input e output estão claros para cada agente?
> - <input type="checkbox" class="checkbox-input" /> As dependências entre agentes formam um pipeline lógico?
> - <input type="checkbox" class="checkbox-input" /> O Voice Analyst é referenciado por todos os agentes que geram texto?
> - <input type="checkbox" class="checkbox-input" /> O Knowledge base de cada agente está definido? (documentação Zabbix para Quiz Crafter, posts históricos para Voice Analyst, etc.)
> - <input type="checkbox" class="checkbox-input" /> Há 6 agentes (não menos, não mais sem justificativa)?

Se os agentes estiverem acoplados:

```
Aria, o Content Writer e o Editor estão fazendo a mesma 
coisa — ambos "escrevem e revisam". Separe: o Writer cria 
o conteúdo bruto seguindo o Voice Profile, o Editor otimiza 
para LinkedIn (hook na primeira linha, formatação, hashtags, 
CTA). São habilidades diferentes.
```

Se o Voice Analyst estiver isolado:

```
Aria, o Voice Analyst aparece como agente separado mas 
nenhum outro agente lista o Voice Profile como input. 
O Voice Profile é o documento MAIS IMPORTANTE do squad — 
todos os agentes que geram texto (Writer, Editor, Quiz 
Crafter) precisam referenciar. Torne isso explícito nas 
dependências.
```

> **🏆 Checkpoint 2**: 6 agentes definidos com inputs, outputs e dependências.

---

### Passo 3 — Workflows por vertente

Cada vertente tem processo de criação diferente:

```
Aria, agora defina os workflows — um para cada vertente 
editorial. Cada workflow é uma sequência de steps onde 
agentes são acionados em ordem, com outputs fluindo de 
um para o próximo.

VERTENTE 1 — Zabbix Quiz:
Trend Scout pesquisa tema → Quiz Crafter cria pergunta + 
alternativas + explicação → Editor otimiza para formato 
enquete LinkedIn → Publisher formata e agenda

VERTENTE 2 — Artigo Técnico:
Trend Scout pesquisa tema profundo → Content Writer escreve 
mini-artigo → Editor revisa e otimiza → Publisher formata 
e agenda

VERTENTE 3 — IA na Sexta:
Trend Scout pesquisa notícia/ferramenta IA da semana → 
Content Writer escreve post curto com opinião → Editor 
otimiza → Publisher formata e agenda

VERTENTE 4 — Mentalidade & Liderança:
(sem Trend Scout — tema vem de reflexão pessoal) → 
Content Writer escreve reflexão → Editor otimiza → 
Publisher formata e agenda

Para cada workflow, defina:
- Steps na ordem (qual agente, qual ação)
- Input de cada step (output do step anterior)
- Pontos de decisão humana (onde EU reviso antes de 
  continuar)
- Critérios de qualidade por step (como saber se o 
  output está bom)

Escreva os workflows em YAML conforme o formato AIOX.
```

**Como avaliar**:

> **Checklist de avaliação dos workflows**
> - <input type="checkbox" class="checkbox-input" /> São 4 workflows distintos (não um genérico reutilizado)?
> - <input type="checkbox" class="checkbox-input" /> Cada workflow tem steps na ordem correta?
> - <input type="checkbox" class="checkbox-input" /> O Voice Profile é referenciado nos steps de geração de texto?
> - <input type="checkbox" class="checkbox-input" /> Há pontos de decisão humana? (review antes de publicar, no mínimo)
> - <input type="checkbox" class="checkbox-input" /> Mentalidade não usa Trend Scout? (o tema é pessoal, não tendência)
> - <input type="checkbox" class="checkbox-input" /> Zabbix Quiz tem step específico do Quiz Crafter? (não é o Writer genérico)
> - <input type="checkbox" class="checkbox-input" /> Os workflows estão em YAML?

Se todos os workflows forem iguais:

```
Aria, os 4 workflows são praticamente idênticos — mudam 
só o prompt do Writer. Mas os processos são diferentes: 
Zabbix Quiz precisa do Quiz Crafter (agente especializado 
em criar perguntas técnicas), Mentalidade não usa Trend 
Scout, Artigo Técnico precisa de pesquisa mais profunda. 
Diferencie os workflows pela sequência de agentes e pelo 
tipo de processamento.
```

Se faltarem pontos de decisão humana:

```
Aria, nenhum workflow tem ponto de review humano. O squad 
gera e publica automaticamente? Isso é arriscado — um 
post com erro técnico ou tom inadequado pode prejudicar 
a reputação. Inclua pelo menos um ponto de review humano 
antes da publicação, onde eu aprovo ou peço ajuste.
```

> **🏆 Checkpoint 3**: 4 workflows YAML distintos com steps, inputs e decision points.

---

### Passo 4 — Templates e checklists de qualidade

```
Aria, último componente: templates e checklists.

TEMPLATES — cada vertente tem formato diferente:
- Zabbix Quiz: formato de enquete + post de resposta 
  com explicação técnica
- Artigo Técnico: hook → contexto → desenvolvimento → 
  conclusão prática → CTA
- IA na Sexta: gancho de atualidade → o que é → por que 
  importa → como experimentar → opinião pessoal
- Mentalidade: história/situação → reflexão → lição → 
  pergunta para a audiência

Crie templates de prompt para o Content Writer e o Editor, 
um por vertente. O template deve incluir o formato esperado, 
o tom (referenciando o Voice Profile), e exemplos de 
estrutura.

CHECKLISTS DE QUALIDADE — para cada vertente:
- Critérios que o Editor verifica antes de aprovar
- Critérios que EU verifico antes de publicar

Inclua checklist para coisas que IA frequentemente erra: 
tom excessivamente formal, buzzwords genéricos, falta de 
opinião genuína, falta de dados/exemplos concretos.
```

**Como avaliar**:

> **Checklist de avaliação dos templates e checklists**
> - <input type="checkbox" class="checkbox-input" /> Há template por vertente (4 templates)?
> - <input type="checkbox" class="checkbox-input" /> Templates referenciam o Voice Profile?
> - <input type="checkbox" class="checkbox-input" /> Cada template define estrutura específica (não genérica)?
> - <input type="checkbox" class="checkbox-input" /> Checklists incluem critérios anti-IA? (detectar tom genérico)
> - <input type="checkbox" class="checkbox-input" /> Checklists diferenciam o que o Editor verifica vs o que eu verifico?
> - <input type="checkbox" class="checkbox-input" /> Zabbix Quiz tem critério de precisão técnica? (resposta correta, explicação sem erro)

Se os templates forem genéricos:

```
Aria, os templates são "escreva um post sobre [tema] no 
tom do Voice Profile". Isso é genérico demais. O template 
do Zabbix Quiz deve especificar: pergunta com 4 alternativas, 
dificuldade técnica real (não trivial), explicação que ensina 
algo, referência à documentação oficial. O template do IA na 
Sexta deve especificar: gancho de atualidade, link para a 
ferramenta/notícia, opinião pessoal (não neutro). Detalhe.
```

Se os checklists não cobrirem armadilhas de IA:

```
Aria, os checklists verificam gramática e formato mas não 
verificam as armadilhas clássicas de conteúdo gerado por IA: 
"neste artigo vamos explorar", "é fundamental ressaltar", 
"em um mundo cada vez mais conectado". Inclua critérios 
que detectem tom de IA genérica e exijam substituição por 
linguagem autêntica.
```

> **🏆 Checkpoint 4 — VITÓRIA DA AULA**: Squad completo projetado.

---

### Passo 5 — Consolidar e commitar

```
Aria, consolide tudo nos seguintes arquivos:

1. config.yaml — configuração do squad (agentes, roles, 
   knowledge bases)
2. workflows/zabbix-quiz.yaml — workflow da vertente quiz
3. workflows/artigo-tecnico.yaml — workflow de artigos
4. workflows/ia-na-sexta.yaml — workflow IA na Sexta
5. workflows/mentalidade.yaml — workflow Mentalidade
6. templates/ — um template por vertente
7. checklists/ — um checklist por vertente
8. docs/squad-architecture.md — documento de arquitetura 
   do squad (agentes, dependências, pipeline)
```

**Verificar**:

```bash
ls config.yaml workflows/ templates/ checklists/ docs/
```

```bash
*exit

git add .
git commit -m "squad: LinkedIn Monitoragindo architecture

- 6 specialized agents defined (Voice Analyst, Trend Scout,
  Quiz Crafter, Content Writer, Editor, Publisher)
- 4 editorial workflows (Zabbix Quiz, Artigo Técnico,
  IA na Sexta, Mentalidade & Liderança)
- Templates per content type with Voice Profile references
- Quality checklists with anti-AI-generic criteria
- Squad architecture doc with agent dependencies and pipeline"
```

---

## Reflexão

### De "pedir pra IA escrever" a "projetar um sistema de conteúdo"

A maioria das pessoas que usa IA para conteúdo faz isso:

```
"ChatGPT, escreve um post sobre Zabbix pro LinkedIn"
→ Texto genérico, sem voz, sem estratégia, sem consistência
```

O que o Squad LinkedIn faz é fundamentalmente diferente:

```
Voice Analyst constrói perfil de voz
  → Trend Scout pesquisa tema relevante
    → Quiz Crafter/Writer cria com voz autêntica
      → Editor otimiza para LinkedIn
        → Publisher formata e agenda
          → Métricas coletadas → Feedback loop
```

Não é mais rápido. É mais **estratégico**. Cada post é resultado de um pipeline com especialistas, não de um prompt genérico. E ao longo do tempo, o feedback loop identifica o que funciona e realimenta o squad.

### O conceito-chave

> **Um squad não é um agente que faz tudo — é um time onde cada membro tem especialidade e os workflows definem como colaboram. No Squad LinkedIn, o Voice Analyst garante autenticidade, o Trend Scout garante relevância, o Writer garante substância, o Editor garante otimização. Nenhum agente sozinho produz o resultado final.**

### Conexão com a próxima aula

Na Aula 15, o squad sai do papel: o Voice Analyst constrói o Voice Profile analisando seus posts reais do LinkedIn. O Quiz Crafter gera o primeiro Zabbix Quiz. O Content Writer produz o primeiro artigo e o primeiro post IA na Sexta. Você vai ver o squad produzindo conteúdo real — e avaliar se a voz está autêntica.

---

> **Anterior**: Aula 13 — DevOps: Containerização, Scheduling e Retrospectiva
> **Próxima**: Aula 15 — Voice Analysis e Geração de Conteúdo
