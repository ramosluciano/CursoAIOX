# Aula 02 — Elicitação, Workflow Intelligence e Definição de Agentes

<!-- metadata
course: Mastery
module: 1
lesson: 2
title: "Elicitação, Workflow Intelligence e Definição de Agentes"
duration: 3-4 horas
agents: "agente custom @zabbix-expert (criado nesta aula)"
project: Plataforma Zabbix Learning
phase: Configuração
prerequisites: Aula 01 concluída (mapa do .aiox-core/ + preset)
-->

---

> **Módulo 1** · AIOX Internals
> **Duração**: 3-4 horas
> **Agentes praticados**: Agente customizado `@zabbix-expert` (criado nesta aula)
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

Agente custom `@zabbix-expert` criado no formato autoClaude V3 e funcional, sistema de elicitação customizado para o domínio Zabbix, e Workflow Intelligence explorado com decisões documentadas.

**Critério binário**: `@zabbix-expert *help` retorna comandos customizados + elicitação faz perguntas específicas sobre Zabbix + Workflow Intelligence documentado em `docs/workflow-intelligence.md`.

---

## Conceito

### Agentes customizados: além dos 11 core

Os 11 agentes core do AIOX cobrem o pipeline genérico de desenvolvimento. Mas a Plataforma Zabbix tem necessidades que nenhum agente core atende: gerar conteúdo educacional sobre Zabbix com precisão técnica, validar configurações contra a documentação oficial, e planejar exercícios práticos em ambientes Zabbix reais.

O `@zabbix-expert` é um agente de domínio — ele sabe Zabbix como o @analyst sabe pesquisa e o @dev sabe código. Na Plataforma Zabbix, ele vai participar de múltiplos subsistemas: Content Engine (gerar aulas), Quiz Engine (gerar perguntas), Lab Provisioner (projetar exercícios).

### Elicitação: como agentes fazem perguntas inteligentes

Quando você chama `@analyst *research-domain`, o Analyst não pula direto para a pesquisa. Primeiro, ele faz **perguntas de esclarecimento** — elicitação. Essas perguntas são governadas pelo sistema de elicitação em `.aiox-core/`.

A elicitação padrão é genérica. Para a Plataforma Zabbix, você quer perguntas específicas: "Qual versão do Zabbix a plataforma vai cobrir?", "O conteúdo deve seguir a estrutura da documentação oficial ou uma estrutura pedagógica própria?", "Os labs práticos usam Zabbix Server ou Zabbix Proxy?"

### Workflow Intelligence: o motor de decisão

O Workflow Intelligence é o sistema que decide automaticamente qual workflow aplicar baseado no contexto. Quando você diz "preciso de uma nova feature", ele decide: usar o ADE Spec Pipeline? Direto para o Dev? Precisa de Architect review? Essas decisões são configuráveis — e para um projeto da escala da Plataforma Zabbix, os defaults não são suficientes.

---

## Prática

### Passo 1 — Explorar definições de agentes existentes

Antes de criar, entenda o formato:

```bash
cd ~/aiox-mastery/zabbix-platform

# Examinar um agente core em detalhe
cat .aiox-core/agents/analyst.md

# Examinar outro para comparar formato
cat .aiox-core/agents/dev.md

# Verificar se existe documentação sobre formato V3
find .aiox-core/ -name "*.md" | xargs grep -l "autoClaude\|V3\|agent format" 2>/dev/null
```

Documente o formato que encontrar:

> **Checklist de entendimento do formato de agente**
> - <input type="checkbox" class="checkbox-input" /> Quais campos são obrigatórios? (name, role, commands...)
> - <input type="checkbox" class="checkbox-input" /> Como os comandos são declarados?
> - <input type="checkbox" class="checkbox-input" /> Onde fica a system prompt / personality do agente?
> - <input type="checkbox" class="checkbox-input" /> Como um agente referencia outros agentes?
> - <input type="checkbox" class="checkbox-input" /> Como um agente acessa knowledge base?

---

### Passo 2 — Criar @zabbix-expert

Crie o agente baseado no formato que explorou:

```bash
claude
```

```
Preciso criar um agente customizado chamado @zabbix-expert 
para a Plataforma Zabbix Learning.

Com base no formato autoClaude V3 que encontrei em 
.aiox-core/agents/, crie o agente com:

ROLE: Especialista em Zabbix com 15+ anos de experiência. 
Conhece a documentação oficial profundamente. Sabe traduzir 
conceitos complexos para linguagem acessível. Domina:
- Instalação e configuração (Server, Proxy, Agent, Agent2)
- Monitoramento (items, triggers, discovery, templates)
- Automação (API, scripts, webhooks, actions)
- Arquitetura (HA, partitioning, proxy distribution)
- Troubleshooting (performance, logs, capacity planning)

COMMANDS:
- *generate-lesson: Gerar aula sobre um conceito Zabbix 
  (input: conceito, nível, formato)
- *generate-quiz: Gerar pergunta de quiz com 4 alternativas 
  (input: tema, dificuldade)
- *design-lab: Projetar exercício prático com configuração 
  Zabbix (input: objetivo, nível, duração)
- *validate-config: Validar se uma configuração Zabbix está 
  correta contra a documentação
- *explain-concept: Explicar um conceito com analogia e 
  exemplo prático

KNOWLEDGE BASE: 
- Documentação oficial do Zabbix (referenciada, não embutida)
- Best practices de monitoramento enterprise
- Patterns de configuração para diferentes escalas

Salve em .aiox-core/agents/zabbix-expert.md no formato V3.
```

**Como verificar**:

```bash
# Verificar que o arquivo existe e está no formato correto
cat .aiox-core/agents/zabbix-expert.md

# Tentar usar o agente
@zabbix-expert *help

# Testar um comando
@zabbix-expert *explain-concept "Zabbix LLD (Low-Level Discovery)"
```

> **Checklist de avaliação do agente**
> - <input type="checkbox" class="checkbox-input" /> Arquivo segue o formato V3 (mesma estrutura dos agentes core)?
> - <input type="checkbox" class="checkbox-input" /> `*help` lista os 5 comandos customizados?
> - <input type="checkbox" class="checkbox-input" /> `*explain-concept` gera explicação com profundidade técnica?
> - <input type="checkbox" class="checkbox-input" /> `*generate-quiz` gera pergunta que um Zabbix Expert consideraria boa?
> - <input type="checkbox" class="checkbox-input" /> `*design-lab` gera exercício com configuração Zabbix real?
> - <input type="checkbox" class="checkbox-input" /> O agente referencia documentação oficial (não inventa features)?

Se o agente gerar conteúdo genérico:

```
O @zabbix-expert gerou uma explicação de LLD que poderia 
ser sobre qualquer ferramenta de discovery. Preciso de 
especificidade Zabbix: menção a discovery rules, item 
prototypes, trigger prototypes, host prototypes. Exemplos 
com macros como {#FSNAME}, {#IFNAME}. O agente é um 
EXPERT, não um generalista.
```

Se o formato não bater com V3:

```
O arquivo não segue o formato dos agentes core. Compare 
com .aiox-core/agents/analyst.md — as seções devem ser 
as mesmas. Adapte o conteúdo para o formato V3 correto.
```

> **🏆 Checkpoint 1**: @zabbix-expert funcional com 5 comandos customizados.

---

### Passo 3 — Customizar elicitação

O sistema de elicitação determina quais perguntas os agentes fazem antes de executar. Configure para o domínio Zabbix:

```bash
# Encontrar onde elicitação é configurada
find .aiox-core/ -name "*elicit*" -o -name "*question*" | head -20
cat .aiox-core/[caminho que encontrar]
```

```
Preciso customizar o sistema de elicitação para a 
Plataforma Zabbix. Quando o @analyst pesquisa domínio 
para esta plataforma, as perguntas de esclarecimento 
devem incluir:

- Qual versão do Zabbix cobrir? (6.0 LTS, 6.4, 7.0?)
- Conteúdo segue estrutura da doc oficial ou pedagógica?
- Labs usam Server, Proxy ou Agent standalone?
- Público-alvo: iniciantes, intermediários ou certificação?
- Idioma do conteúdo: PT-BR, EN, ambos?

Quando o @zabbix-expert gera aulas, deve perguntar:
- Nível do aluno (conceitos → configuração → automação → API)
- Formato (texto, vídeo script, hands-on lab)
- Duração estimada da aula
- Pré-requisitos assumidos

Configure no local correto do .aiox-core/ para que 
essas perguntas sejam feitas automaticamente.
```

> **Checklist de avaliação da elicitação**
> - <input type="checkbox" class="checkbox-input" /> Perguntas customizadas estão no local correto?
> - <input type="checkbox" class="checkbox-input" /> Ao chamar `@analyst *research-domain`, as perguntas Zabbix aparecem?
> - <input type="checkbox" class="checkbox-input" /> Ao chamar `@zabbix-expert *generate-lesson`, as perguntas de aula aparecem?
> - <input type="checkbox" class="checkbox-input" /> As perguntas são específicas (não genéricas)?

> **🏆 Checkpoint 2**: Elicitação customizada funcionando.

---

### Passo 4 — Explorar e documentar Workflow Intelligence

```bash
# Localizar o workflow intelligence
find .aiox-core/ -path "*workflow*intelligence*" -o -path "*workflow*decision*"
cat .aiox-core/[caminho encontrado]
```

```
Explore o Workflow Intelligence do AIOX e documente:

1. Como o sistema decide qual workflow aplicar?
2. Quais inputs o motor de decisão usa?
3. Quais decisões são automáticas vs humanas?
4. Como customizar as regras de decisão para a 
   Plataforma Zabbix?

Exemplo: quando eu digo "preciso de uma nova feature 
para o Content Engine", o Workflow Intelligence deve 
decidir automaticamente que isso requer ADE Spec Pipeline 
(porque é um subsistema complexo), não implementação 
direta pelo Dev.

Documente em docs/workflow-intelligence.md com:
- Mapeamento das regras de decisão existentes
- Regras customizadas para a Plataforma Zabbix
- Fluxograma de decisão
```

> **Checklist de avaliação**
> - <input type="checkbox" class="checkbox-input" /> O motor de decisão foi identificado e documentado?
> - <input type="checkbox" class="checkbox-input" /> As regras de decisão estão mapeadas?
> - <input type="checkbox" class="checkbox-input" /> Há proposta de customização para a Plataforma Zabbix?
> - <input type="checkbox" class="checkbox-input" /> O fluxograma mostra o caminho de decisão?

> **🏆 Checkpoint 3 — VITÓRIA DA AULA**: Agente custom + elicitação + Workflow Intelligence documentados.

---

### Passo 5 — Commit

```bash
*exit

git add .
git commit -m "feat: custom @zabbix-expert agent, elicitation, and workflow intelligence

- @zabbix-expert agent in autoClaude V3 format (5 custom commands)
- Custom elicitation questions for Zabbix domain
- Workflow Intelligence analysis and customization plan
- Documentation of decision engine for Zabbix Platform context"
```

---

## Reflexão

### O poder do agente de domínio

O @zabbix-expert é qualitativamente diferente dos agentes core. Os agentes core sabem *como* trabalhar (pesquisar, especificar, implementar, testar). O @zabbix-expert sabe *sobre o quê* trabalhar (Zabbix: conceitos, configurações, troubleshooting, API). Quando os dois trabalham juntos, o resultado é superior: @analyst pesquisa + @zabbix-expert valida a profundidade técnica.

Na Plataforma Zabbix, o @zabbix-expert participa de quase tudo: valida aulas geradas pelo Content Engine, gera quizzes para o Quiz Engine, projeta labs para o Lab Provisioner, e verifica configurações. Sem ele, cada agente core improvisaria sobre Zabbix. Com ele, há um especialista dedicado.

### O conceito-chave

> **Agentes customizados no formato V3 estendem o AIOX para domínios específicos sem alterar o core. O @zabbix-expert não substitui nenhum agente — ele complementa todos. Elicitação customizada garante que as perguntas são relevantes para o domínio. Workflow Intelligence garante que as decisões refletem a complexidade do projeto.**

### Conexão com a próxima aula

Na Aula 03, você cria tasks, workflows YAML e checklists customizados para a Plataforma Zabbix. O @zabbix-expert criado aqui será referenciado nos workflows — é a peça que faltava entre "agente de domínio" e "processo customizado".

---

> **Anterior**: Aula 01 — Por Dentro do .aiox-core/
> **Próxima**: Aula 03 — Tasks, Workflows YAML e Customização Avançada
