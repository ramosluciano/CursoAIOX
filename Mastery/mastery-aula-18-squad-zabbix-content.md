# Aula 18 — Squad Zabbix Content (para a Plataforma)

<!-- metadata
course: Mastery
module: 6
lesson: 18
title: "Squad Zabbix Content"
duration: 4-5 horas
agents: "squad Zabbix Content (5 agentes)"
project: Plataforma Zabbix Learning
phase: Squads Avançados
prerequisites: Aula 17 concluída (brownfield LinkedIn completo)
-->

---

> **Módulo 6** · Squads Avançados
> **Duração**: 4-5 horas
> **Agentes praticados**: Squad Zabbix Content (5 agentes)
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

Squad de conteúdo educacional Zabbix funcional com 5 agentes especializados, workflow de geração em lote, e integração com o Content Engine da plataforma. Módulo inteiro gerado de uma vez.

**Critério binário**: Squad definido com 5 agentes + workflow de lote testado + módulo completo gerado (3+ aulas com quiz e lab cada).

---

## Conceito

### Squad de conteúdo: escala que 1 agente não atinge

O @zabbix-expert gera aulas individuais. Mas a Plataforma precisa de centenas — organizadas em módulos, com progressão lógica, quizzes alinhados e labs configurados. Um squad de 5 agentes especializados, cada um responsável por uma dimensão, mantém coerência em escala:

| Agente | Responsabilidade |
|--------|-----------------|
| Curriculum Planner | Planeja módulo: aulas, ordem, pré-requisitos, duração |
| Lesson Writer | Escreve conteúdo de cada aula (RAG + @zabbix-expert) |
| Quiz Generator | Gera perguntas por tema/dificuldade com alternativas |
| Lab Designer | Projeta exercícios práticos com exercise manifests |
| Reviewer | Revisa precisão técnica, completude e pedagogia |

O workflow de lote orquestra os 5: input (tema + nível) → output (módulo completo com aulas, quizzes, labs).

---

## Prática

### Passo 1 — Definir o squad

```bash
cd ~/aiox-mastery/zabbix-platform
claude
```

```
Crie o Squad Zabbix Content com 5 agentes no formato V3.

Cada agente deve:
- Ter role e comandos claros
- Referenciar knowledge base (documentação Zabbix)
- Referenciar checklists de qualidade (Aula 03)
- Interagir com outros agentes do squad

Crie o workflow de geração em lote:
1. Curriculum Planner recebe tema + nível
2. Define estrutura do módulo (3-5 aulas com progressão)
3. Lesson Writer gera cada aula via RAG
4. Quiz Generator gera quiz por aula (5 perguntas)
5. Lab Designer projeta lab por aula (exercise manifest)
6. Reviewer valida tudo (loop de correção se necessário)

config.yaml + workflows em .aiox-core/squads/zabbix-content/
```

> **Checklist do squad**
> - <input type="checkbox" class="checkbox-input" /> 5 agentes no formato V3?
> - <input type="checkbox" class="checkbox-input" /> Workflows de geração em lote definidos?
> - <input type="checkbox" class="checkbox-input" /> Checklists de qualidade referenciados?
> - <input type="checkbox" class="checkbox-input" /> config.yaml válido?

> **🏆 Checkpoint 1**: Squad definido.

---

### Passo 2 — Testar geração em lote

```
Execute o workflow de lote para gerar o módulo 
"Zabbix Triggers" (nível intermediário).

Espero:
- Aula 1: Conceitos de triggers (expressões básicas)
- Aula 2: Trigger dependencies e correlação
- Aula 3: Trigger actions e escalation
- Cada aula com: conteúdo + quiz (5 perguntas) + lab manifest
```

> **Checklist de geração em lote**
> - <input type="checkbox" class="checkbox-input" /> Curriculum Planner definiu estrutura coerente?
> - <input type="checkbox" class="checkbox-input" /> 3 aulas geradas com conteúdo substantivo?
> - <input type="checkbox" class="checkbox-input" /> Quizzes tecnicamente corretos?
> - <input type="checkbox" class="checkbox-input" /> Labs com exercise manifests funcionais?
> - <input type="checkbox" class="checkbox-input" /> Reviewer encontrou e corrigiu issues?
> - <input type="checkbox" class="checkbox-input" /> Progressão entre aulas é lógica?

Se o Reviewer não encontrar nada:

```
Reviewer, releia a Aula 2 sobre trigger dependencies. 
A explicação está correta mas falta um exemplo prático 
de dependency entre trigger de servidor e trigger de 
serviço. Sem exemplo, o aluno não consegue aplicar.
```

> **🏆 Checkpoint 2**: Módulo completo gerado em lote.

---

### Passo 3 — Integrar com Content Engine

```
Integre o output do squad com a plataforma:
- Aulas geradas → ingestão no Content Engine
- Quizzes → Quiz Engine
- Labs → exercise manifests para Lab Provisioner
- Tudo vinculado ao Learning Path

Após integração, o módulo deve aparecer na plataforma 
como qualquer conteúdo — navegável, jogável, com labs.
```

> **🏆 Checkpoint 3 — VITÓRIA DA AULA**: Squad gerando módulos integrados com a plataforma.

---

### Passo 4 — Commit

```bash
*exit
git add .
git commit -m "feat: Zabbix Content Squad - batch generation of educational modules

- 5-agent squad: Curriculum Planner, Lesson Writer, Quiz Generator, Lab Designer, Reviewer
- Batch workflow: module from topic + level (3+ lessons with quizzes and labs)
- Tested with Zabbix Triggers module
- Full integration with Content Engine, Quiz Engine, Lab Provisioner"
```

---

## Reflexão

### O conceito-chave

> **Squads de conteúdo escalam produção de "1 aula por vez" para "1 módulo por vez" com qualidade consistente. O Reviewer como agente dedicado garante autocorreção. O workflow de lote é a linha de produção que a Plataforma precisa para ter centenas de aulas — impossível gerar manualmente, viável com squad.**

### Conexão com a próxima aula

Na Aula 19, o @squad-creator gera o Squad N8N automaticamente e comparamos com design manual.

---

> **Anterior**: Aula 17 — Brownfield LinkedIn
> **Próxima**: Aula 19 — @squad-creator + Squad N8N
