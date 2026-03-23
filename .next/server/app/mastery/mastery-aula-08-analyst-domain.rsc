2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T2125,# Aula 08 — Analyst: Domínio Educacional + Zabbix

<!-- metadata
course: Mastery
module: 3
lesson: 8
title: "Analyst: Domínio Educacional + Zabbix"
duration: 4-5 horas
agents: "@analyst, @zabbix-expert"
project: Plataforma Zabbix Learning
phase: Planejamento
prerequisites: Aula 07 concluída (ADE Deep Dive completo)
-->

---

> **Módulo 3** · Plataforma Zabbix: Planejamento e Arquitetura
> **Duração**: 4-5 horas
> **Agentes praticados**: `@analyst`, `@zabbix-expert`
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

Pesquisa profunda do domínio educacional técnico concluída: análise competitiva de plataformas existentes, taxonomia de conteúdo Zabbix mapeada, personas de alunos definidas, e decisão RAG vs fine-tuning fundamentada.

**Critério binário**: `docs/project-brief.md` + `docs/competitive-analysis.md` + `docs/content-taxonomy.md` + `docs/personas.md` gerados e coerentes.

---

## Conceito

### Pesquisa profunda: dois domínios, não um

A Plataforma Zabbix Learning vive na interseção de dois domínios que o Analyst precisa pesquisar:

| Domínio | O que pesquisar | Por que importa |
|---------|----------------|-----------------|
| **Educacional** | Como plataformas técnicas ensinam (Pluralsight, KodeKloud, A Cloud Guru, labs AWS) | Definir o modelo pedagógico |
| **Zabbix** | Taxonomia completa do Zabbix (conceitos → config → automação → API) | Definir o currículo |

No RockQuiz, o Analyst pesquisou um domínio simples. No AuctionHunter, pesquisou um domínio hostil. Aqui, pesquisa **dois domínios simultaneamente** e precisa conectá-los: como ensinar Zabbix de forma eficaz.

### O @zabbix-expert como validador de domínio

O Analyst pesquisa, mas pode não ter profundidade técnica em Zabbix. O @zabbix-expert (criado na Aula 02) valida: a taxonomia de conteúdo cobre todos os conceitos relevantes? Os níveis de dificuldade fazem sentido? As personas refletem o público real?

---

## Prática

### Passo 1 — Análise competitiva

```bash
cd ~/aiox-mastery/zabbix-platform
claude
```

```
@analyst

Alex, pesquise profundamente o domínio de plataformas 
educacionais técnicas. Analise como as seguintes 
plataformas ensinam:

- Pluralsight: modelo de aprendizado, assessments, paths
- KodeKloud: labs práticos, hands-on environments
- A Cloud Guru / Cantrill: AWS training com labs
- Exercism: exercícios práticos com mentoria
- TryHackMe: gamificação + labs de segurança

Para cada plataforma, documente:
1. Modelo pedagógico (vídeo? texto? hands-on? misto?)
2. Como medem progresso do aluno
3. Se têm labs práticos e como funcionam
4. Gamificação (se houver)
5. Modelo de pricing (free/paid tiers)
6. Pontos fortes e fracos

Depois, identifique: o que a Plataforma Zabbix Learning 
pode aprender de cada uma? O que nenhuma faz que nós 
poderíamos fazer?

*research-domain
```

> **Checklist de avaliação da análise competitiva**
> - [ ] Pelo menos 4 plataformas analisadas com profundidade?
> - [ ] Modelo pedagógico documentado para cada uma?
> - [ ] Labs práticos comparados (quem tem, como funciona)?
> - [ ] Gaps identificados (o que ninguém faz)?
> - [ ] Recomendações para a Plataforma Zabbix extraídas?

Se a análise for superficial:

```
Alex, a análise do KodeKloud diz apenas "tem labs". 
Como funcionam? São containers? VMs? Quanto tempo duram? 
O aluno configura do zero ou recebe ambiente pré-configurado? 
Esse detalhe é crucial — nosso Lab Provisioner precisa 
dessas referências.
```

> **🏆 Checkpoint 1**: Análise competitiva completa.

---

### Passo 2 — Taxonomia de conteúdo Zabbix

```
Alex, agora mapeie o conteúdo Zabbix completo em uma 
taxonomia pedagógica. Use a documentação oficial como 
fonte primária.

*exit

@zabbix-expert

Ajude a construir a taxonomia de conteúdo. Organize 
o conhecimento Zabbix em módulos progressivos:

Nível 1 — Fundamentos:
- O que é monitoramento, por que importa
- Arquitetura Zabbix (Server, Proxy, Agent)
- Instalação básica

Nível 2 — Configuração:
- Hosts, templates, items, triggers
- Discovery (LLD, network discovery)
- Mapas e dashboards

Nível 3 — Operação:
- Actions, alertas, escalation
- Manutenção, SLA
- Troubleshooting

Nível 4 — Avançado:
- API Zabbix
- Scripts e automação
- Alta disponibilidade
- Performance tuning

Nível 5 — Expert:
- Arquitetura enterprise (proxies distribuídos)
- Integrações (Grafana, ELK, n8n)
- Custom modules
- Preparação para certificação

Para cada tópico: o que ensinar, pré-requisitos, 
estimativa de duração, tipo de exercício (leitura, quiz, 
lab prático).

Salve em docs/content-taxonomy.md
```

> **Checklist de avaliação da taxonomia**
> - [ ] Cobre do iniciante ao expert?
> - [ ] Progressão lógica (cada nível depende do anterior)?
> - [ ] Cada tópico tem tipo de exercício definido?
> - [ ] O @zabbix-expert validou a completude técnica?
> - [ ] Há estimativa de duração por tópico?

> **🏆 Checkpoint 2**: Taxonomia de conteúdo validada pelo @zabbix-expert.

---

### Passo 3 — Personas de alunos

```
@analyst

Alex, defina as personas de alunos da Plataforma Zabbix:

Persona 1 — Iniciante:
- Quem é? Experiência? Motivação?
- O que espera da plataforma?
- Quanto tempo tem para aprender?

Persona 2 — Intermediário:
- Já usa Zabbix mas quer aprofundar
- Quais gaps típicos?

Persona 3 — Avançado:
- Quer automação, API, enterprise
- Pode estar buscando certificação

Persona 4 — Migrador:
- Vem de outra ferramenta (Nagios, Prometheus, Datadog)
- Precisa de "tradução" de conceitos

Para cada persona: jornada ideal na plataforma, 
funcionalidades que mais usa, métrica de sucesso.

Salve em docs/personas.md
```

> **🏆 Checkpoint 3**: Personas definidas com jornadas.

---

### Passo 4 — Avaliação RAG vs fine-tuning

```
@analyst

Alex, para o Content Engine, avalie duas abordagens:

Opção A — RAG (Retrieval-Augmented Generation):
- Ingerir documentação Zabbix como knowledge base
- Chunking + embedding + vector store
- Gerar aulas buscando chunks relevantes

Opção B — Fine-tuning:
- Treinar modelo com documentação + exemplos de aulas
- Gerar aulas diretamente

Analise: custo, qualidade, atualização (quando Zabbix 
lança versão nova), controle, escalabilidade.

*exit

@zabbix-expert

Valide: qual abordagem gera melhor conteúdo educacional 
sobre Zabbix? RAG permite atualizar com cada versão nova. 
Fine-tuning pode gerar conteúdo mais fluido. Qual priorizar?

Documente a decisão fundamentada em docs/rag-vs-finetuning.md
```

> **🏆 Checkpoint 4 — VITÓRIA DA AULA**: 4 documentos + decisão RAG/fine-tuning fundamentada.

---

### Passo 5 — Commit

```bash
*exit
git add .
git commit -m "docs: domain research - competitive analysis, content taxonomy, personas, RAG evaluation

- Competitive analysis of 5 educational platforms
- Zabbix content taxonomy (5 levels, beginner to expert)
- 4 student personas with learning journeys
- RAG vs fine-tuning decision documented"
```

---

## Reflexão

### A complexidade de planejar uma plataforma

Compare o planejamento dos 3 projetos:

| Projeto | Domínios pesquisados | Complexidade da análise |
|---------|---------------------|------------------------|
| RockQuiz | 1 (quiz de rock) | Baixa — domínio óbvio |
| AuctionHunter | 1 (leilões + scraping) | Média — domínio hostil |
| Plataforma Zabbix | 2 (educação + Zabbix) | Alta — interseção de domínios |

A Plataforma Zabbix exige que o Analyst pense em duas dimensões: **o que ensinar** (taxonomia Zabbix) e **como ensinar** (modelo pedagógico da plataforma). Cada decisão aqui afeta os 6 subsistemas.

### O conceito-chave

> **Projetos com múltiplos domínios exigem pesquisa que os conecte, não apenas pesquisa isolada de cada um. A taxonomia de conteúdo é a ponte: ela é tanto pedagógica (como organizar o aprendizado) quanto técnica (quais conceitos Zabbix cobrir). O @zabbix-expert garante que a ponte é sólida dos dois lados.**

### Conexão com a próxima aula

Na Aula 09, PM e Architect transformam toda essa pesquisa em especificação: PRD com 30+ FRs organizados por subsistema, e arquitetura SaaS com 10+ containers.

---

> **Anterior**: [Aula 07 — Epics 5-7: Recovery, QA Evolution, Memory Layer](../modulo-02/aula-07-recovery-qa-memory.md)
> **Próxima**: [Aula 09 — PM + Architect: PRD e Arquitetura de SaaS](./aula-09-prd-architecture.md)
5:["lesson","mastery-aula-08-analyst-domain","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-08-analyst-domain","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-08-analyst-domain\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-08-analyst-domain","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-08-analyst-domain","module":"mastery","lessonIndex":7,"totalLessons":22,"nextLesson":"mastery-aula-09-prd-architecture","prevLesson":"mastery-aula-07-recovery-qa-memory"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
