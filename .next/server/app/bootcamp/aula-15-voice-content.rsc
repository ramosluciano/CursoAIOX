2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","188","static/chunks/app/bootcamp/%5Blesson%5D/page-3b4cd11983f1559e.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T4f3f,# Aula 15 — Voice Analysis e Geração de Conteúdo

<!-- metadata
module: 4
lesson: 15
title: "Voice Analysis e Geração de Conteúdo"
duration: 4-5 horas
agents: "squad agents (Voice Analyst, Quiz Crafter, Content Writer, Editor)"
project: Squad LinkedIn Monitoragindo
phase: Desenvolvimento (Fase 2)
prerequisites: Aula 14 concluída (squad arquitetado com 6 agentes + 4 workflows)
-->

---

> **Módulo 4** · Squad LinkedIn Monitoragindo
> **Duração**: 4-5 horas
> **Agentes praticados**: Squad agents — Voice Analyst, Quiz Crafter, Content Writer, Editor
> **Projeto**: Squad LinkedIn Monitoragindo

---

## 🏆 Vitória desta aula

Voice Profile gerado a partir de posts reais do LinkedIn, e 3 peças de conteúdo produzidas COM a voz autêntica: 1 Zabbix Quiz da Semana, 1 artigo técnico sobre o tema do quiz, e 1 post IA na Sexta. Conteúdo que alguém lê e pensa "isso é do Luciano", não "isso é de IA".

**Critério binário**: `docs/voice-profile.md` gerado + 3 peças de conteúdo em `output/` que passam no checklist de autenticidade de voz.

---

## Conceito

### Voice Profiling: o que separa conteúdo genérico de conteúdo autêntico

Qualquer LLM gera texto sobre Zabbix. O problema é que o texto sai genérico — tom neutro, vocabulário corporativo, estrutura padronizada. Qualquer pessoa com acesso à mesma ferramenta produz o mesmo resultado. Isso não constrói audiência no LinkedIn. O que constrói é **voz**.

Voz é o conjunto de padrões que tornam um autor reconhecível: tom (direto, bem-humorado, técnico-mas-acessível), vocabulário (expressões recorrentes, nível de formalidade), estrutura (como abre um post, como fecha, como transiciona), e marcas pessoais (emojis específicos, hashtags recorrentes, tipo de hook no primeiro parágrafo).

O Voice Analyst é o agente do squad que extrai esses padrões de posts históricos reais e os consolida em um **Voice Profile** — um documento que todos os outros agentes do squad referenciam ao gerar conteúdo. O Content Writer não escreve "um post sobre Zabbix"; ele escreve "um post sobre Zabbix no estilo que o Voice Profile define".

### Knowledge base personalizada: agentes que sabem do assunto

O Quiz Crafter não gera perguntas genéricas — ele acessa a documentação oficial do Zabbix como knowledge base e produz perguntas técnicas precisas. O Content Writer não inventa informações — ele referencia conceitos reais da documentação e os traduz para linguagem acessível.

Isso é diferente de tudo que fizemos até agora. No RockQuiz, os agentes AIOX (analyst, pm, architect, dev) trabalhavam com contexto do projeto. Aqui, os agentes do **squad** trabalham com contexto de **domínio** (Zabbix) e de **pessoa** (sua voz). A knowledge base não é código-fonte — é documentação técnica e histórico de comunicação.

### O princípio aplicado

Você vai alimentar o Voice Analyst com seus posts reais e avaliar se o Voice Profile captura sua voz de verdade. Vai avaliar se o conteúdo gerado **soa como você** — não se é tecnicamente correto (isso é pré-requisito), mas se alguém da sua audiência leria e reconheceria como seu. **Não vai ditar** o tom, as expressões ou a estrutura — o Voice Analyst extrai. Você valida.

---

## Contexto

Na Aula 14, o squad foi arquitetado: 6 agentes definidos, 4 workflows por vertente, templates e checklists. Agora os agentes entram em ação. Esta aula exercita 4 dos 6 agentes em sequência: Voice Analyst → Quiz Crafter → Content Writer → Editor. Os 2 restantes (Trend Scout e Publisher) entram nas aulas 16-18.

O workflow é uma **cadeia**: o Voice Profile alimenta todos os agentes de conteúdo. Se o Voice Profile for ruim, todo conteúdo sai genérico. Por isso o Passo 1 é o mais importante — e merece a maior parte do tempo de avaliação.

---

## Prática

### Passo 1 — Voice Analyst: extraindo sua voz

Primeiro, prepare o material de input — seus posts reais do LinkedIn:

```bash
cd ~/aiox-bootcamp/linkedin-squad
mkdir -p input/posts

# Copie 10-20 posts seus do LinkedIn para arquivos individuais
# Idealmente posts de diferentes vertentes:
# - Posts sobre Zabbix (técnicos)
# - Posts sobre IA (IA na Sexta)
# - Posts de reflexão (mentalidade/liderança)
# - Posts com quiz (Zabbix Quiz da Semana)
#
# Formato: um arquivo .md por post
# input/posts/post-01-zabbix-api.md
# input/posts/post-02-ia-na-sexta.md
# etc.
```

> **Importante**: Use posts REAIS. O Voice Profile é tão bom quanto o material de input. Posts fabricados para teste vão gerar um perfil genérico — exatamente o oposto do objetivo. Se tiver menos de 10 posts, use o que tiver. Qualidade importa mais que quantidade.

Agora execute o Voice Analyst:

```bash
claude
```

```
Estou trabalhando no Squad LinkedIn Monitoragindo. 
Leia o config.yaml do squad e ative o workflow do 
Voice Analyst.

Voice Analyst, analise os posts em input/posts/ e 
extraia meu perfil de comunicação.

Para cada dimensão, identifique padrões concretos — 
com exemplos extraídos dos posts reais:

1. TOM: como me posiciono? (autoritativo, casual, 
   didático, provocativo?) Varia por vertente?
2. VOCABULÁRIO: expressões recorrentes, gírias técnicas 
   que uso, nível de formalidade. Quais palavras são 
   "minhas"?
3. ESTRUTURA: como abro posts? (pergunta, afirmação 
   forte, história?) Como fecho? (CTA, reflexão, 
   pergunta aberta?) Qual o tamanho médio?
4. HOOKS: como capturo atenção no primeiro parágrafo? 
   Que padrões de hook se repetem?
5. FORMATAÇÃO: uso emojis? Quais? Uso bullet points? 
   Parágrafos curtos ou longos? Hashtags recorrentes?
6. DIFERENÇAS POR VERTENTE: o tom muda quando falo 
   de Zabbix vs quando falo de IA vs quando falo de 
   mentalidade? Como muda?

Gere o Voice Profile completo em docs/voice-profile.md.
```

**O que esperar**: O Voice Analyst deve produzir um documento que não é uma lista genérica de "tom: profissional, linguagem: técnica". Deve ter **exemplos concretos extraídos dos posts**. Algo como:

- "Abertura típica: pergunta retórica que desafia um mito. Ex: 'Você acha que monitorar é só olhar dashboard?'"
- "Fechamento recorrente: convite para comentar com experiência pessoal. Ex: 'E você, como resolve isso no seu ambiente?'"
- "Expressões-assinatura: 'bora automatizar', 'o bicho pega quando...', 'na real'"
- "Tom Zabbix: didático-autoritativo (ensina, mas com propriedade de quem faz há 15 anos)"
- "Tom IA: curioso-experimental (compartilha descobertas, não prescreve)"

**Como avaliar**:

> **Checklist de avaliação do Voice Profile**
> - [ ] Tem exemplos reais dos posts (não padrões inventados)?
> - [ ] Cobre as 6 dimensões (tom, vocabulário, estrutura, hooks, formatação, vertentes)?
> - [ ] Diferencia padrões entre vertentes? (Zabbix ≠ IA ≠ mentalidade)
> - [ ] Você se reconhece? (leu e pensou "é, é assim que eu escrevo")
> - [ ] Identifica padrões que você não tinha consciência?
> - [ ] É específico o suficiente para outro agente gerar conteúdo "na sua voz"?

O teste definitivo é pessoal: **você se reconhece no perfil?** Se o Voice Profile descreve alguém genérico, falhou. Se descreve algo que você lê e pensa "é, isso sou eu — inclusive isso aqui que eu não tinha notado", funcionou.

Se o perfil estiver genérico:

```
Voice Analyst, o perfil diz que meu tom é "profissional 
e técnico". Isso descreve qualquer pessoa de TI. Olhe 
os posts de novo — eu uso humor? Sou direto ou rodeio? 
Uso analogias do cotidiano? Falo em primeira pessoa ou 
uso "a gente"? Preciso de padrões ESPECÍFICOS com exemplos 
dos meus posts, não descrições genéricas.
```

Se faltar diferenciação por vertente:

```
Voice Analyst, o perfil trata todos os posts como se 
tivessem o mesmo tom. Mas quando falo de Zabbix, sou 
mais didático e técnico. Quando falo de IA, sou mais 
exploratório. Quando falo de mentalidade, sou mais 
reflexivo e pessoal. Separe os padrões por vertente — 
o Content Writer precisa dessa diferença.
```

Se você não se reconhecer:

```
Voice Analyst, o perfil diz que eu "evito opiniões fortes". 
Leia o post-07 e o post-12 — eu tomo posição clara e 
defendo com argumentos. Revise essa análise com base 
nos posts reais, não em suposição.
```

> **🏆 Checkpoint 1**: Voice Profile que você se reconhece — com exemplos reais e diferenciação por vertente.

---

### Passo 2 — Quiz Crafter: Zabbix Quiz da Semana

Com o Voice Profile pronto, o primeiro agente de conteúdo entra:

```
Quiz Crafter, gere o Zabbix Quiz da Semana.

Consulte a documentação oficial do Zabbix como knowledge 
base para escolher o tema. O quiz segue o formato da 
vertente "Zabbix Quiz" definida no config.yaml do squad.

Requisitos:
1. Pergunta técnica sobre um conceito real do Zabbix
2. 4 alternativas (1 correta, 3 plausíveis — não 
   alternativas absurdas)
3. Explicação detalhada da resposta correta
4. Nível de dificuldade adequado para a audiência 
   (profissionais de TI, não iniciantes absolutos)
5. Use o Voice Profile para o tom da pergunta e da 
   explicação — deve soar como EU perguntando e explicando

Salve em output/quiz-da-semana.md
```

**O que esperar**: Uma pergunta técnica precisa, com alternativas que exigem conhecimento real (não "qual a cor do logo do Zabbix?"), e explicação que usa seu tom de voz.

**Como avaliar**:

> **Checklist de avaliação do Quiz**
> - [ ] A pergunta é tecnicamente correta? (confira na documentação)
> - [ ] As alternativas são plausíveis? (alguém com conhecimento parcial erraria)
> - [ ] A alternativa correta é inequivocamente correta?
> - [ ] A explicação ensina algo (não apenas "a resposta é B")?
> - [ ] O tom soa como você? (compare com seus quizzes anteriores reais)
> - [ ] O nível é adequado para a audiência?

Se a pergunta for trivial:

```
Quiz Crafter, "Qual porta padrão do Zabbix Server?" é 
muito básico para minha audiência. Preciso de perguntas 
que façam o profissional pensar — sobre comportamento de 
triggers, lógica de discovery, nuances de templates. 
O tipo de pergunta que gera discussão nos comentários.
```

Se as alternativas forem óbvias:

```
Quiz Crafter, as alternativas B, C e D são claramente 
erradas para qualquer pessoa que já abriu o Zabbix. 
Boas alternativas são conceitos que existem mas não se 
aplicam ao contexto da pergunta — confundem quem sabe 
um pouco mas não domina o tema.
```

Se o tom não bater com o Voice Profile:

```
Quiz Crafter, a pergunta está em tom formal acadêmico. 
O Voice Profile mostra que meus quizzes abrem com uma 
situação prática ("Imagine que seu trigger disparou mas 
o problema já foi resolvido...") e depois fazem a pergunta. 
Reescreva seguindo o padrão do Voice Profile.
```

> **🏆 Checkpoint 2**: Quiz tecnicamente correto + tom autêntico.

---

### Passo 3 — Content Writer: artigo técnico do quiz

O artigo técnico expande o tema do quiz — é o conteúdo que vai junto ou logo após a publicação da resposta:

```
Content Writer, escreva o artigo técnico que acompanha 
o Zabbix Quiz da Semana que o Quiz Crafter acabou de gerar.

O artigo deve:
1. Explicar o conceito por trás da pergunta do quiz 
   em profundidade
2. Incluir contexto prático — quando esse conceito 
   importa no dia a dia de monitoramento
3. Se possível, incluir um exemplo de configuração 
   ou cenário real
4. Usar o Voice Profile como guia de tom e estrutura
5. Seguir o template da vertente "Artigo Técnico" 
   definido no squad

Referência: docs/voice-profile.md para a voz, 
output/quiz-da-semana.md para o tema.

Salve em output/artigo-tecnico.md
```

**Como avaliar**:

> **Checklist de avaliação do artigo**
> - [ ] Expande o tema do quiz (não repete a mesma informação)?
> - [ ] Tem profundidade técnica real (não superficial)?
> - [ ] Inclui cenário prático ou exemplo de configuração?
> - [ ] O tom corresponde ao Voice Profile para vertente técnica?
> - [ ] A estrutura segue o padrão dos seus artigos reais? (hook, contexto, conteúdo, fechamento)
> - [ ] O tamanho é adequado para LinkedIn? (não é um whitepaper)

Se o artigo for genérico:

```
Content Writer, o artigo explica o conceito de forma 
enciclopédica — parece documentação traduzida. Meus 
artigos técnicos no LinkedIn começam com um problema 
real ("Semana passada, num cliente, aconteceu X...") 
e depois explicam o conceito como solução. O Voice 
Profile tem esse padrão documentado. Reescreva.
```

Se faltar profundidade:

```
Content Writer, o artigo ficou superficial — qualquer 
busca no Google retorna a mesma informação. Minha 
audiência são profissionais que JÁ usam Zabbix. 
Preciso de nuances que só quem tem experiência prática 
sabe: armadilhas, configurações não óbvias, interações 
entre funcionalidades.
```

> **🏆 Checkpoint 3**: Artigo técnico com profundidade + voz autêntica.

---

### Passo 4 — Content Writer: post IA na Sexta

Vertente diferente, tom diferente. O Voice Profile deve guiar a mudança:

```
Content Writer, agora escreva o post da vertente "IA na 
Sexta" — a coluna semanal sobre IA aplicada.

O post deve:
1. Apresentar uma ferramenta, técnica ou descoberta de IA 
   da semana que seja relevante para profissionais de TI
2. Explicar de forma prática — o que faz, como usar, 
   quando faz sentido
3. Incluir opinião pessoal (o Voice Profile mostra que 
   nessa vertente eu sou mais experimental e opinativo)
4. Fechar com provocação ou convite para o leitor testar

ATENÇÃO: o tom dessa vertente é DIFERENTE do artigo 
técnico. O Voice Profile documenta que meus posts de IA 
são mais exploratórios e menos prescritivos. Siga essa 
diferenciação.

Salve em output/ia-na-sexta.md
```

**Como avaliar**:

> **Checklist de avaliação do post IA na Sexta**
> - [ ] O tema é relevante e atual? (não algo de 2 anos atrás)
> - [ ] A explicação é prática? (o leitor sabe como usar depois de ler)
> - [ ] Tem opinião pessoal? (não apenas facts — tem posicionamento)
> - [ ] O tom é diferente do artigo técnico? (mais leve, exploratório)
> - [ ] O Voice Profile foi respeitado para esta vertente?
> - [ ] O fechamento convida engajamento?

Se o tom for idêntico ao artigo técnico:

```
Content Writer, o post IA na Sexta está no mesmo tom do 
artigo de Zabbix — didático e autoritativo. O Voice 
Profile mostra que nessa vertente eu sou mais curioso 
e compartilho descobertas em vez de ensinar. A diferença 
é sutil mas importante: "Descobri essa ferramenta e fiquei 
impressionado" vs "Essa ferramenta é a melhor opção para X". 
Ajuste o tom.
```

> **🏆 Checkpoint 4**: Post IA na Sexta com tom diferenciado + conteúdo relevante.

---

### Passo 5 — Editor: revisão e polimento

O Editor é o último agente antes da publicação — revisa tudo:

```
Editor, revise as 3 peças de conteúdo geradas:
- output/quiz-da-semana.md
- output/artigo-tecnico.md
- output/ia-na-sexta.md

Para cada peça, verifique:
1. PRECISÃO: informação técnica está correta?
2. VOZ: está alinhado com docs/voice-profile.md?
3. LINKEDIN: formatação otimizada para a plataforma 
   (parágrafos curtos, quebras de linha, uso de emojis 
   conforme o perfil)?
4. HOOKS: o primeiro parágrafo captura atenção?
5. CTA: o fechamento convida engajamento?
6. HASHTAGS: relevantes e no padrão do perfil?

Para cada issue encontrada, corrija diretamente no 
conteúdo e indique o que mudou e por quê.
```

**Como avaliar o trabalho do Editor**:

> **Checklist de avaliação da edição**
> - [ ] O Editor fez mudanças substanciais (não apenas pontuação)?
> - [ ] Hooks foram fortalecidos?
> - [ ] Formatação está otimizada para LinkedIn (escaneabilidade)?
> - [ ] Hashtags são relevantes e não genéricas (#technology #innovation)?
> - [ ] As 3 peças mantêm voz consistente (cada uma na sua vertente)?

Se o Editor não mudar nada:

```
Editor, você aprovou as 3 peças sem alteração. Releia 
o Voice Profile e compare com os conteúdos. Os hooks 
estão realmente no padrão dos meus posts? A formatação 
é como eu posto no LinkedIn? Quero que você seja 
CRITICAMENTE construtivo — sempre há algo para melhorar.
```

> **🏆 Checkpoint 5 — VITÓRIA DA AULA**: Voice Profile + 3 peças de conteúdo revisadas e prontas.

---

### Passo 6 — Avaliação final de autenticidade

Este é o checkpoint mais pessoal do curso inteiro. Leia os 3 conteúdos e responda honestamente:

> **Checklist de autenticidade** (avaliação pessoal)
> - [ ] Se eu publicasse o quiz, minha audiência estranharia o tom?
> - [ ] O artigo técnico tem insight que só alguém com 15 anos de Zabbix teria?
> - [ ] O post IA na Sexta soa como algo que eu compartilharia organicamente?
> - [ ] Se alguém lesse os 3 sem saber que foram gerados por IA, pensaria que sou eu?
> - [ ] Há algo que eu NUNCA diria e que está no texto? (red flag de voz genérica)

Se a resposta a qualquer item for "não", identifique o que está errado e peça ajuste ao Content Writer com referência específica ao Voice Profile.

---

### Passo 7 — Commit

```bash
*exit

git add .
git commit -m "feat: voice profile + 3 content pieces (quiz, article, IA na Sexta)

- Voice Profile extracted from real LinkedIn posts
- Zabbix Quiz da Semana: technical question + detailed explanation
- Technical article expanding quiz topic with practical scenarios
- IA na Sexta: weekly AI post with differentiated tone
- Editor review applied to all pieces
- All content aligned with Voice Profile per editorial vertical"
```

---

## Reflexão

### Voice Profile: o ativo mais valioso do squad

Os 3 conteúdos gerados nesta aula são descartáveis — na semana que vem terão novos. O Voice Profile não. Ele é o **ativo permanente** que garante que toda geração futura soa autêntica. Sem ele, cada conteúdo precisaria de ajuste manual de tom. Com ele, o squad produz conteúdo "na sua voz" por padrão.

Isso é diferente de tudo que fizemos antes:

| Projeto | O que os agentes sabem | De onde vem o conhecimento |
|---------|----------------------|--------------------------|
| RockQuiz | Stack técnica, regras de quiz | PRD + Architecture Doc |
| AuctionHunter | Domínio de leilões, formatos de dados | Domain Map + Specs |
| Squad LinkedIn | **Quem você é como comunicador** | Posts reais + Voice Profile |

O Voice Profile é pessoal de uma forma que nenhum outro documento do curso é. É a primeira vez que os agentes trabalham com **identidade**, não apenas com especificação técnica.

### Conteúdo diferenciado por vertente: o teste da voz

Se o quiz, o artigo técnico e o post IA na Sexta tiverem exatamente o mesmo tom, o Voice Profile falhou. O objetivo é que cada vertente tenha personalidade própria **dentro** da sua voz geral:

- **Zabbix Quiz**: didático-provocativo ("será que você sabe...?")
- **Artigo Técnico**: autoritativo-prático ("na semana passada, num cliente...")
- **IA na Sexta**: curioso-experimental ("descobri uma ferramenta que...")
- **Mentalidade** (próximas aulas): reflexivo-pessoal ("algo que aprendi em 25 anos...")

O Voice Profile mapeia essas variações. O Content Writer as aplica. O Editor as verifica. É uma cadeia de qualidade focada em autenticidade.

### O conceito-chave

> **Agentes de squad com knowledge base personalizada (Voice Profile + documentação Zabbix) produzem conteúdo que é simultaneamente tecnicamente preciso e pessoalmente autêntico. O Voice Profile é o que transforma "IA gerando texto sobre Zabbix" em "IA gerando texto como o Luciano escreve sobre Zabbix". Essa diferença é o que constrói audiência.**

### Conexão com a próxima aula

Na Aula 16, o @dev constrói o backend que sustenta o squad: persistência dos posts em banco, integração com a LinkedIn API para publicação e coleta de métricas, e snapshots de engajamento. O squad deixa de ser um gerador de texto e vira um **produto de software** — com dados, automação e feedback loop.

---

> **Anterior**: [Aula 14 — Arquitetura do Squad de Conteúdo](./aula-14-squad-architecture.md)
> **Próxima**: [Aula 16 — Backend de Persistência e Analytics](./aula-16-backend-persistence.md)
5:["lesson","aula-15-voice-content","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["bootcamp",{"children":[["lesson","aula-15-voice-content","d"],{"children":["__PAGE__?{\"lesson\":\"aula-15-voice-content\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["bootcamp",{"children":[["lesson","aula-15-voice-content","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"aula-15-voice-content","module":"bootcamp","lessonIndex":14,"totalLessons":18,"nextLesson":"aula-16-backend-persistence","prevLesson":"aula-14-squad-architecture"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
