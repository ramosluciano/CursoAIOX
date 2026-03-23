2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","188","static/chunks/app/bootcamp/%5Blesson%5D/page-3b4cd11983f1559e.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T39ac,# Aula 03 — Analyst + PM: Do Conceito ao PRD

<!-- metadata
module: 2
lesson: 3
title: "Analyst + PM: Do Conceito ao PRD"
duration: 3-4 horas
agents: "@analyst, @pm"
project: RockQuiz
phase: Planejamento (Fase 1)
prerequisites: Módulo 1 concluído
-->

---

> **Módulo 2** · RockQuiz: Pipeline Completo
> **Duração**: 3-4 horas
> **Agentes praticados**: `@analyst`, `@pm`
> **Projeto**: RockQuiz — primeira aplicação real

---

## 🏆 Vitória desta aula

Produzir 3 documentos reais que vão guiar todo o desenvolvimento do RockQuiz: Project Brief, Domain Map e PRD com requisitos testáveis.

**Critério binário**: `docs/project-brief.md` + `docs/domain-map.md` + `docs/prd.md` existem, estão completos e foram validados por você.

---

## Conceito

### O Analyst: pesquisar antes de gastar tempo

O @analyst existe para o trabalho de investigação prévia. Ele pesquisa o domínio, identifica padrões, mapeia entidades e produz um briefing que fundamenta todas as decisões seguintes. Se o Analyst descobre algo que muda a abordagem técnica, isso acontece **antes** de qualquer linha de código — quando mudar de ideia custa zero.

Comandos principais:

| Comando | O que faz | Quando usar |
|---------|-----------|-------------|
| `*research-deps` | Pesquisa tecnologias e dependências | Antes de escolher stack |
| `*extract-patterns` | Identifica padrões do domínio | Antes de modelar dados |

### O PM: transformar ideias em requisitos testáveis

O @pm transforma a pesquisa do Analyst em **requisitos formais**. A diferença entre uma ideia e um requisito é que o requisito é **testável** — tem critérios de aceitação que podem ser verificados. Cada cenário de aceitação se torna um teste automatizado mais tarde.

| Comando | O que faz | Quando usar |
|---------|-----------|-------------|
| `*gather-requirements` | Coleta requisitos com perguntas estruturadas | Início do PRD |
| `*write-spec` | Gera specs executáveis para o ADE | Features complexas |

### O princípio desta aula: descreva a necessidade, não a solução

> **Regra de ouro**: Você diz ao agente O QUÊ precisa e POR QUÊ. O agente decide COMO fazer. Você AVALIA se o resultado está bom e REFINA se necessário.

Na prática: você descreve o RockQuiz em linguagem natural. O Analyst faz perguntas, pesquisa e propõe. Você valida e pede ajustes. Em nenhum momento você dita a estrutura do documento — o agente sabe qual é o formato certo.

---

## Contexto

Vamos aplicar analyst e PM ao **RockQuiz** — um quiz interativo sobre rock. O projeto parece simples mas tem complexidade real que os agentes vão ajudar a descobrir e estruturar. O output desta aula alimenta diretamente o Architect e o SM na próxima aula.

---

## Prática

### Passo 1 — Preparar o ambiente

```bash
cd ~/aiox-bootcamp/rockquiz
claude
```

---

### Passo 2 — Ativar o Analyst e descrever a ideia

Ative o Analyst e descreva o projeto em **linguagem natural**, como descreveria para um colega. Não prescreva formatos, tecnologias ou estruturas — deixe o agente processar e perguntar:

```
@analyst

Ana, quero criar uma aplicação web chamada RockQuiz. É um quiz 
interativo sobre conhecimentos de rock — história, bandas, álbuns, 
curiosidades, letras e instrumentos.

A ideia é que o jogador acesse o site, escolha um nickname, selecione 
um modo de jogo e responda perguntas de múltipla escolha. Cada resposta 
tem feedback visual imediato mostrando se acertou ou errou, com uma 
explicação do porquê. A pontuação deve considerar a dificuldade da 
pergunta, a velocidade da resposta e a sequência de acertos consecutivos. 
No final, o jogador vê sua posição em um ranking público.

Quero 3 modos de jogo: um modo tranquilo com 20 perguntas, um modo 
contra o relógio e um modo hardcore onde o primeiro erro elimina.

Antes de criar qualquer documento, me faça suas perguntas. Quero 
entender o que você precisa saber para pesquisar bem esse projeto.
```

**O que vai acontecer**: O Analyst vai fazer perguntas de aprofundamento — isso é o **human-in-the-loop**. Responda com honestidade. Se não sabe algo, diga "não defini ainda — o que você sugere?". Exemplos de temas que o Analyst pode perguntar:

- Público-alvo e nível de conhecimento
- Monetização ou gratuito
- Volume esperado de jogadores
- Perguntas pré-cadastradas ou geradas por IA
- Escopo da v1 (o que NÃO faz parte)

> **Dica pedagógica**: Note como o processo é diferente de "gere um app de quiz". O Analyst te força a tomar decisões que teriam que ser tomadas de qualquer jeito — mas ANTES de codificar.

---

### Passo 3 — Pesquisa de dependências

Após responder as perguntas, peça ao Analyst para pesquisar o domínio técnico. **Descreva a necessidade, não a solução**:

```
Ana, agora que entende o projeto, pesquise o que precisamos saber 
antes de começar a construir:

*research-deps

Preciso entender:
- Existe alguma biblioteca pronta para quiz engines ou é melhor 
  construir do zero?
- Como outros apps de quiz (Kahoot, Sporcle) implementam pontuação?
- Qual a melhor forma de armazenar ranking em tempo real?
- A stack que você recomenda para esse tipo de aplicação
```

**Como avaliar o output**: O Analyst deve retornar uma análise com **recomendações justificadas**, não apenas uma lista de tecnologias. Se ele apenas listar nomes sem explicar trade-offs, peça mais:

```
Ana, você recomendou Redis para ranking mas não explicou por quê. 
Quais alternativas existem e por que Redis é melhor para esse caso?
```

---

### Passo 4 — Extração de padrões do domínio

```
*extract-patterns

Ana, mapeie as entidades e relações do RockQuiz. Quero entender 
a estrutura de dados antes de qualquer decisão técnica:

- Quais são as entidades principais?
- Como elas se relacionam?
- Quais regras de negócio existem entre elas?
- Há alguma complexidade que não é óbvia à primeira vista?

Salve o resultado em docs/domain-map.md
```

**Como avaliar o output**: Abra `docs/domain-map.md` e verifique:

> **Checklist de validação do Domain Map**
> - [ ] As entidades principais estão listadas (jogador, categoria, pergunta, jogo, ranking)?
> - [ ] As relações estão claras (1:N, N:M)?
> - [ ] As regras de negócio estão documentadas (ex: "perguntas não repetem no mesmo jogo")?
> - [ ] Há algo que falta? Pense: "o que o Architect vai precisar saber para projetar o banco?"

Se algo estiver faltando, peça:

```
Ana, o domain map não menciona como funciona o streak 
(sequência de acertos). Isso é uma regra de negócio 
importante — adicione ao documento.
```

> **🏆 Checkpoint 1**: `docs/domain-map.md` criado com entidades, relações e regras.

---

### Passo 5 — Gerar o Project Brief

```
Ana, com base em tudo que discutimos — minhas respostas, a pesquisa 
de dependências e o domain map — gere o Project Brief completo 
do RockQuiz.

Inclua tudo que você considera essencial para que alguém que nunca 
ouviu falar do projeto entenda: o que é, por que existe, para quem 
é, o que faz, o que NÃO faz, e como saber se deu certo.

Salve em docs/project-brief.md
```

Note que **não prescrevemos as seções do documento**. O Analyst sabe qual é a estrutura de um bom brief — faz parte do seu treinamento no AIOX. Se o resultado estiver fraco em algum aspecto, refinamos:

**Avalie o Brief gerado:**

> **Checklist de validação do Brief**
> - [ ] A visão está clara? Alguém que nunca ouviu falar do projeto entenderia em 2 parágrafos?
> - [ ] O público-alvo está definido (não apenas "qualquer pessoa")?
> - [ ] As funcionalidades-chave estão listadas com prioridade?
> - [ ] As restrições estão explícitas (o que NÃO está no escopo)?
> - [ ] Os critérios de sucesso são mensuráveis (não apenas "funcionar")?

Se algo faltar, peça especificamente:

```
Ana, o brief não define o que está FORA do escopo. Isso é 
importante para evitar scope creep. Adicione uma seção de 
restrições: o que o RockQuiz NÃO faz na v1.
```

> **🏆 Checkpoint 2**: `docs/project-brief.md` completo e validado.

---

### Passo 6 — Transição para o PM

O PM vai ler os documentos do Analyst e transformar em requisitos formais. Novamente: **descreva a necessidade, deixe o agente decidir o formato**:

```
*exit

@pm

Pete, a Ana (Analyst) produziu dois documentos que definem o 
projeto RockQuiz:
- docs/project-brief.md (visão, propósito, funcionalidades)
- docs/domain-map.md (entidades, relações, regras de negócio)

Leia ambos e comece a coletar requisitos. Preciso de um PRD 
que sirva como contrato — tudo que for implementado deve estar 
nele, e tudo que estiver nele deve ser implementado.

*gather-requirements
```

**O que observar**: O PM vai processar os documentos do Analyst e possivelmente fazer perguntas adicionais. Ele está transformando prosa (brief) em requisitos estruturados. Note como o **contexto flui**: Analyst pesquisou → produziu docs → PM lê esses docs e constrói em cima.

---

### Passo 7 — Requisitos com critérios testáveis

Peça ao PM que gere requisitos que possam ser verificados. Não dite o formato — mas diga o que espera do resultado:

```
Pete, quero que cada requisito funcional tenha critérios de 
aceitação que eu consiga testar. Preciso saber exatamente 
quando um requisito está "pronto" — não pode ser ambíguo.

Por exemplo, se o requisito é sobre pontuação, os critérios 
devem definir a fórmula exata, os multiplicadores, e o que 
acontece em cada cenário (acerto fácil, acerto difícil, erro, 
streak, etc).

Organize por áreas (gameplay, modos de jogo, ranking, etc) 
e priorize: o que é essencial para o MVP e o que pode ficar 
para depois.
```

**Como avaliar os FRs gerados:**

> **Checklist de qualidade dos requisitos**
> - [ ] Cada requisito tem um identificador único (FR-001, etc)?
> - [ ] Os critérios de aceitação são testáveis (não vagos)?
> - [ ] A priorização está clara (o que é essencial vs nice-to-have)?
> - [ ] Há cenários de edge case nos critérios (o que acontece quando algo dá errado)?
> - [ ] A fórmula de scoring está completamente definida (sem ambiguidade)?

Se os critérios estiverem vagos:

```
Pete, o FR sobre scoring diz "deve calcular pontuação 
baseada em vários fatores". Isso é vago demais. Preciso 
da fórmula exata com cada multiplicador e cada cenário 
definido. Um dev precisa implementar isso sem me perguntar 
nada.
```

---

### Passo 8 — NFRs mensuráveis

```
Pete, além dos requisitos funcionais, defina os requisitos 
não-funcionais. Mas atenção: cada NFR precisa ser mensurável.

Não quero "deve ser rápido" — quero uma métrica com threshold 
e como medir. Se não dá pra medir, não é um requisito — é 
um desejo.

Cubra: performance, testes, tempo de build, tamanho de deploy, 
e disponibilidade.
```

**Avalie os NFRs**:

> **Checklist de NFRs**
> - [ ] Cada NFR tem uma métrica numérica (não adjetivos)?
> - [ ] Cada NFR diz COMO medir (ferramenta, comando)?
> - [ ] Os thresholds são realistas para o tamanho do projeto?

Se um NFR for vago:

```
Pete, "a API deve ter boa performance" não é mensurável. 
Defina: qual métrica (latência P95? throughput?), qual 
threshold (< 200ms? > 50 rps?), e como medir.
```

---

### Passo 9 — Compilar o PRD final

```
Pete, compile tudo em um PRD completo em docs/prd.md.

Ele deve ser a referência definitiva do projeto: qualquer 
pessoa que leia esse documento deve saber exatamente o que 
o RockQuiz faz, como se comporta em cada cenário, e quais 
são os padrões de qualidade.

Inclua também um roadmap simples: o que é MVP e o que fica 
para depois.

Use os documentos da Ana como referência (project-brief.md 
e domain-map.md).
```

**Avaliação final do PRD:**

> **Checklist do PRD completo**
> - [ ] Tem pelo menos 10 requisitos funcionais com critérios testáveis?
> - [ ] Cada FR tem prioridade clara (essencial vs depois)?
> - [ ] Os NFRs são todos mensuráveis?
> - [ ] Há um roadmap (MVP → v1.0)?
> - [ ] Referencia os documentos do Analyst?
> - [ ] Um dev que nunca conversou comigo poderia implementar o projeto lendo apenas isso?

A última pergunta é o teste definitivo: se um Dev abrisse esse PRD sem nenhum contexto adicional, ele saberia o que construir? Se não, peça ao PM para melhorar as partes ambíguas.

> **🏆 Checkpoint 3 — VITÓRIA DA AULA**: `docs/prd.md` completo e validado.

---

### Passo 10 — Verificar estado dos documentos

```bash
*exit

ls -la docs/
# Esperado: project-brief.md, domain-map.md, prd.md
```

Neste ponto, 3 documentos produzidos por 2 agentes contêm todo o contexto para projetar a arquitetura e criar stories (próxima aula).

---

## Reflexão

### O que aconteceu (e o que NÃO aconteceu)

Você NÃO ditou o formato dos documentos, NÃO prescreveu a estrutura dos requisitos, NÃO definiu como o Analyst deveria organizar o domain map. Você descreveu **necessidades** e **avaliou resultados**.

O Analyst decidiu quais perguntas fazer, como organizar o domain map, e quais seções incluir no brief. O PM decidiu o formato dos requisitos, como estruturar os critérios de aceitação, e como organizar os épicos.

Sua skill principal nesta aula foi: **formular necessidades claras + avaliar outputs criticamente + pedir refinamentos específicos**. Essa é a skill que transfere para qualquer projeto futuro — o formato muda, mas o processo é o mesmo.

### O conceito-chave

> **Descreva o problema, avalie a solução, refine até estar satisfeito. O agente é o especialista em formato e estrutura — você é o especialista em domínio e contexto.**

### Conexão com a próxima aula

Na Aula 04, o @architect vai ler o PRD e o Domain Map para projetar a arquitetura. Você vai descrever suas necessidades de infraestrutura (containers, deploy, banco) e o Architect vai propor a solução técnica. Mesmo padrão: necessidade → proposta → avaliação → refinamento.

---

## Exercício extra (opcional)

1. Releia o PRD e identifique: há algum requisito que você entende mas que um estranho não entenderia? Se sim, peça ao PM para clarificar.

2. Peça ao PM para criar uma Risk Matrix:

```
@pm
Pete, quais são os maiores riscos técnicos e de negócio 
do RockQuiz? Me ajude a identificar o que pode dar errado 
e como prevenir. Salve em docs/risk-matrix.md
```

3. Releia o Domain Map e tente identificar uma entidade ou relação que o Analyst pode ter esquecido. Se encontrar, peça para adicionar.

---

> **Anterior**: [Aula 02 — Conceitos e Fluxo](../modulo-01/aula-02-conceitos-fluxo.md)
> **Próxima**: [Aula 04 — Architect + UX + SM: Da Especificação às Stories](./aula-04-architect-stories.md)
5:["lesson","aula-03-analyst-pm","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["bootcamp",{"children":[["lesson","aula-03-analyst-pm","d"],{"children":["__PAGE__?{\"lesson\":\"aula-03-analyst-pm\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["bootcamp",{"children":[["lesson","aula-03-analyst-pm","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"aula-03-analyst-pm","module":"bootcamp","lessonIndex":2,"totalLessons":18,"nextLesson":"aula-04-architect-stories","prevLesson":"aula-02-conceitos-fluxo"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
