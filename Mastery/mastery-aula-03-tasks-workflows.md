# Aula 03 — Tasks, Workflows YAML e Customização Avançada

<!-- metadata
course: Mastery
module: 1
lesson: 3
title: "Tasks, Workflows YAML e Customização Avançada"
duration: 3-4 horas
agents: "@zabbix-expert (custom)"
project: Plataforma Zabbix Learning
phase: Configuração
prerequisites: Aula 02 concluída (@zabbix-expert + elicitação + Workflow Intelligence)
-->

---

> **Módulo 1** · AIOX Internals
> **Duração**: 3-4 horas
> **Agentes praticados**: `@zabbix-expert` (customizado)
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

Workflow YAML customizado para geração de conteúdo educacional, tasks customizadas, e checklists de qualidade específicos para conteúdo Zabbix — tudo funcional e validado.

**Critério binário**: Workflow custom dispara com `@zabbix-expert *generate-lesson` e produz aula passando no checklist de qualidade Zabbix.

---

## Conceito

### Tasks e Workflows: a automação do processo

No Bootcamp, o processo era manual: você chamava agentes em sequência, avaliava outputs, pedia ajustes. Isso funciona para projetos pequenos. Para a Plataforma Zabbix, com 6 subsistemas e dezenas de features, executar cada step manualmente é inviável.

Tasks são **unidades de trabalho** pré-definidas. Workflows são **sequências de tasks** orquestradas automaticamente. Em vez de chamar 5 agentes manualmente para gerar uma aula, você dispara um workflow que os orquestra:

```
Workflow: generate-zabbix-lesson
  Task 1: @zabbix-expert pesquisa tema na documentação
  Task 2: @zabbix-expert gera conteúdo da aula
  Task 3: @zabbix-expert gera quiz de verificação
  Task 4: @zabbix-expert projeta lab prático
  Task 5: @qa valida precisão e completude
  Output: aula completa (conteúdo + quiz + lab)
```

### Checklists de qualidade: o padrão que garante consistência

Conteúdo educacional sobre Zabbix tem requisitos específicos: precisão técnica contra a documentação oficial, exemplos com configurações reais (não pseudocódigo), nível adequado ao público, e exercícios que funcionam em ambiente Zabbix real. Um checklist genérico de "o conteúdo é bom?" não captura isso.

Checklists customizados codificam o padrão de qualidade do domínio. Quando o @qa revisa uma aula, usa esse checklist — não o genérico. Quando você avalia, tem critérios objetivos — não achismo.

---

## Prática

### Passo 1 — Explorar tasks existentes

```bash
cd ~/aiox-mastery/zabbix-platform

# Examinar estrutura de tasks
ls .aiox-core/development/tasks/
cat .aiox-core/development/tasks/[task-exemplo]

# Entender o formato
```

Documente o formato de tasks:

> **Checklist de entendimento de tasks**
> - <input type="checkbox" class="checkbox-input" /> Qual o formato de uma task? (YAML, MD, JSON?)
> - <input type="checkbox" class="checkbox-input" /> Quais campos são obrigatórios?
> - <input type="checkbox" class="checkbox-input" /> Como uma task referencia agentes?
> - <input type="checkbox" class="checkbox-input" /> Como uma task define inputs e outputs?
> - <input type="checkbox" class="checkbox-input" /> Como tasks são compostas em workflows?

---

### Passo 2 — Criar tasks customizadas

```bash
claude
```

```
Crie tasks customizadas para a Plataforma Zabbix Learning. 
Baseie-se no formato que encontrei em 
.aiox-core/development/tasks/.

Tasks necessárias:

1. research-zabbix-topic:
   - Agente: @zabbix-expert
   - Input: tema (ex: "LLD"), nível (beginner/intermediate/advanced)
   - Output: pesquisa estruturada com conceitos, exemplos, armadilhas
   - Referência: documentação oficial do Zabbix

2. generate-lesson-content:
   - Agente: @zabbix-expert
   - Input: pesquisa do tema, formato (texto/video-script), duração
   - Output: conteúdo da aula em Markdown
   - Requisito: usar linguagem acessível, incluir analogias

3. generate-quiz-questions:
   - Agente: @zabbix-expert
   - Input: tema da aula, número de perguntas, dificuldade
   - Output: perguntas com 4 alternativas + explicação + referência
   - Requisito: alternativas plausíveis, explicação que ensina

4. design-lab-exercise:
   - Agente: @zabbix-expert
   - Input: objetivo de aprendizado, nível, tempo disponível
   - Output: roteiro do exercício + configuração Zabbix necessária
   - Requisito: funcionar em instância real

5. validate-educational-content:
   - Agente: @qa
   - Input: conteúdo gerado (aula + quiz + lab)
   - Output: relatório de qualidade contra checklist Zabbix
   - Requisito: usar checklist customizado

Salve em .aiox-core/development/tasks/ no formato correto.
```

> **Checklist de avaliação das tasks**
> - <input type="checkbox" class="checkbox-input" /> 5 tasks criadas no formato correto?
> - <input type="checkbox" class="checkbox-input" /> Cada task referencia o agente correto?
> - <input type="checkbox" class="checkbox-input" /> Inputs e outputs estão definidos?
> - <input type="checkbox" class="checkbox-input" /> Requisitos são específicos do domínio (não genéricos)?

> **🏆 Checkpoint 1**: 5 tasks customizadas criadas.

---

### Passo 3 — Criar workflow YAML

Agora compor as tasks em workflow:

```
Crie o workflow YAML que orquestra a geração de aulas 
para a Plataforma Zabbix.

Workflow: generate-zabbix-lesson
- Sequência: research → content → quiz → lab → validate
- Cada step usa a task correspondente
- Output de um step é input do próximo
- Se validate falhar, loop de correção (máx 2 iterações)

Também crie um workflow menor:
Workflow: generate-quiz-batch
- Gerar 10 perguntas de quiz sobre um tema
- Validar cada uma contra checklist
- Output: batch de perguntas aprovadas

Salve em .aiox-core/development/workflows/ no formato YAML.
```

**Como verificar**: Execute o workflow:

```bash
# Disparar o workflow de geração de aula
# [comando depende da implementação — pode ser via Claude Code]

@zabbix-expert

Execute o workflow generate-zabbix-lesson com:
- Tema: "Zabbix Triggers: Expressões e Dependências"
- Nível: intermediate
- Formato: texto
- Duração: 30 minutos
```

> **Checklist de avaliação do workflow**
> - <input type="checkbox" class="checkbox-input" /> Workflow executa sem erro?
> - <input type="checkbox" class="checkbox-input" /> Tasks são executadas na sequência correta?
> - <input type="checkbox" class="checkbox-input" /> Output de cada task alimenta a próxima?
> - <input type="checkbox" class="checkbox-input" /> Se validation falha, loop de correção funciona?
> - <input type="checkbox" class="checkbox-input" /> Output final tem: conteúdo + quiz + lab?

Se o workflow não encadear:

```
O workflow executou a primeira task mas não passou o 
output para a segunda. Verifique a configuração YAML — 
o output de research-zabbix-topic deve ser input de 
generate-lesson-content. Confira se os nomes de 
input/output batem.
```

> **🏆 Checkpoint 2**: Workflow YAML funcional gerando aula completa.

---

### Passo 4 — Criar checklists de qualidade

```
Crie checklists de qualidade específicos para conteúdo 
educacional Zabbix. Salve em .aiox-core/quality/.

Checklist 1: zabbix-lesson-quality.md
- Precisão técnica (conceitos corretos conforme documentação)
- Completude (pré-requisitos declarados, fluxo lógico)
- Acessibilidade (linguagem clara, analogias quando aplicável)
- Exemplos práticos (configurações reais, não pseudocódigo)
- Armadilhas documentadas (erros comuns do conceito)
- Referências à documentação oficial

Checklist 2: zabbix-quiz-quality.md
- Pergunta tecnicamente correta e inequívoca
- Alternativas plausíveis (não "todas acima" ou absurdas)
- Explicação que ensina (não apenas "a resposta é C")
- Nível adequado ao público-alvo
- Referência à documentação oficial

Checklist 3: zabbix-lab-quality.md
- Exercício funciona em instância Zabbix real
- Configuração pré-definida é suficiente para o exercício
- Instruções são passo-a-passo e verificáveis
- Tempo estimado é realista
- Objetivo de aprendizado está claro e verificável
```

> **Checklist de avaliação dos checklists** (meta!)
> - <input type="checkbox" class="checkbox-input" /> 3 checklists criados no local correto?
> - <input type="checkbox" class="checkbox-input" /> Cada checklist tem critérios objetivos (não subjetivos)?
> - <input type="checkbox" class="checkbox-input" /> Critérios são específicos do domínio Zabbix?
> - <input type="checkbox" class="checkbox-input" /> O QA pode usar esses checklists em validate-educational-content?

**Teste com o conteúdo gerado no Passo 3**: Aplique o checklist na aula que o workflow gerou. Ele passa?

> **🏆 Checkpoint 3 — VITÓRIA DA AULA**: Tasks + Workflows + Checklists customizados e validados.

---

### Passo 5 — Commit

```bash
*exit

git add .
git commit -m "feat: custom tasks, workflows, and quality checklists for Zabbix content

- 5 custom tasks for educational content pipeline
- generate-zabbix-lesson workflow (research → content → quiz → lab → validate)
- generate-quiz-batch workflow for batch question generation
- 3 quality checklists: lesson, quiz, lab (Zabbix-specific criteria)
- Workflow tested with Triggers lesson"
```

---

## Reflexão

### O Módulo 1 completo: de usuário a operador

Três aulas transformaram sua relação com o AIOX:

```
Aula 01: Explorou .aiox-core/ → sabe ONDE as coisas estão
Aula 02: Criou agente + elicitação → sabe COMO customizar
Aula 03: Criou tasks + workflows + checklists → sabe COMO automatizar
```

A Plataforma Zabbix agora tem: preset de projeto, agente de domínio, perguntas de elicitação específicas, workflows de geração de conteúdo e checklists de qualidade. Nada disso existia no AIOX padrão — tudo foi customizado para o domínio.

### O conceito-chave

> **Tasks, workflows e checklists customizados transformam o AIOX de um framework genérico em uma fábrica especializada. O workflow generate-zabbix-lesson é uma linha de produção de conteúdo educacional — cada step tem agente responsável, output definido e checklist de qualidade. A Plataforma Zabbix vai ter centenas de aulas; gerar cada uma manualmente seria inviável. O workflow torna escalável.**

### Conexão com o Módulo 2

O Módulo 1 configurou o AIOX para a Plataforma Zabbix. O Módulo 2 (ADE Deep Dive) vai usar essa configuração para implementar os primeiros subsistemas. As tasks e workflows criados aqui serão exercitados de verdade quando o Content Engine começar a gerar aulas na Aula 05 (Spec Pipeline) e na Aula 06 (Execution Engine 13 steps).

---

> **Anterior**: Aula 02 — Elicitação, Workflow Intelligence e Agentes
> **Próxima**: Aula 04 — Epic 1-2: Worktrees Avançados e Migration *(Módulo 2)*
