# Aula 08 — Analyst: Domínio Educacional + Zabbix

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
> - <input type="checkbox" class="checkbox-input" /> Pelo menos 4 plataformas analisadas com profundidade?
> - <input type="checkbox" class="checkbox-input" /> Modelo pedagógico documentado para cada uma?
> - <input type="checkbox" class="checkbox-input" /> Labs práticos comparados (quem tem, como funciona)?
> - <input type="checkbox" class="checkbox-input" /> Gaps identificados (o que ninguém faz)?
> - <input type="checkbox" class="checkbox-input" /> Recomendações para a Plataforma Zabbix extraídas?

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
> - <input type="checkbox" class="checkbox-input" /> Cobre do iniciante ao expert?
> - <input type="checkbox" class="checkbox-input" /> Progressão lógica (cada nível depende do anterior)?
> - <input type="checkbox" class="checkbox-input" /> Cada tópico tem tipo de exercício definido?
> - <input type="checkbox" class="checkbox-input" /> O @zabbix-expert validou a completude técnica?
> - <input type="checkbox" class="checkbox-input" /> Há estimativa de duração por tópico?

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

> **Anterior**: Aula 07 — Epics 5-7: Recovery, QA Evolution, Memory Layer
> **Próxima**: Aula 09 — PM + Architect: PRD e Arquitetura de SaaS
