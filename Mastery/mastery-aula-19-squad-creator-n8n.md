# Aula 19 — @squad-creator + Squad N8N Automation

<!-- metadata
course: Mastery
module: 6
lesson: 19
title: "@squad-creator + Squad N8N Automation"
duration: 4-5 horas
agents: "@squad-creator, squad N8N (6 agentes)"
project: Squad N8N Automation
phase: Squads Avançados
prerequisites: Aula 18 concluída (Squad Zabbix Content)
-->

---

> **Módulo 6** · Squads Avançados
> **Duração**: 4-5 horas
> **Agentes praticados**: `@squad-creator`, Squad N8N (6 agentes)
> **Projeto**: Squad N8N Automation

---

## 🏆 Vitória desta aula

Squad N8N Automation criado via @squad-creator, comparado com design manual, refinado, e funcional: agentes que projetam, criam, deployam e testam workflows n8n.

**Critério binário**: @squad-creator gera squad → comparação com design esperado → refinamento → squad funcional que deploya workflow n8n real.

---

## Conceito

### @squad-creator: meta-automação com refinamento humano

O @squad-creator automatiza a criação de squads: você descreve o objetivo e ele gera agentes, workflows e config.yaml. Mas output automatizado raramente é perfeito na primeira versão — assim como specs precisam de iteração (Aula 05), squads gerados precisam de refinamento.

O fluxo é: @squad-creator gera → você compara com design manual esperado → refina o que falta ou está errado → testa.

### Squad N8N: automação que cria automação

O projeto mais recursivo do programa: agentes AIOX que projetam, criam, deployam e monitoram workflows n8n. É IA criando automações — meta em dois níveis.

---

## Prática

### Passo 1 — @squad-creator gera o squad

```bash
mkdir -p ~/aiox-mastery/n8n-squad
cd ~/aiox-mastery/n8n-squad
git init
claude
```

```
@squad-creator

Gere um squad para automação de workflows n8n.

O squad deve:
- Entender necessidades de automação de um usuário
- Projetar o workflow n8n (nodes, connections, logic)
- Gerar o JSON do workflow
- Deployar via API do n8n
- Testar a execução
- Monitorar execuções e detectar erros

Contexto: n8n roda em Docker com Redis workers.
API disponível em http://n8n:5678/api/v1/.
Workflows são JSON com nodes e connections.
```

---

### Passo 2 — Comparar com design manual esperado

```
Compare o output do @squad-creator com o que eu esperaria:

Agentes esperados:
1. Automation Analyst: entende necessidade de automação
2. Workflow Designer: projeta workflow (nodes, connections, logic)
3. Workflow Builder: gera JSON do workflow
4. Deployer: deploya via API n8n
5. Tester: executa workflow e valida resultado
6. Monitor: observa execuções e detecta erros

O @squad-creator gerou esses? Faltou algum? Algum está 
duplicado ou desnecessário? Os workflows fazem sentido?

Documente diferenças em docs/squad-creator-comparison.md.
Faça os ajustes necessários no config.yaml e agentes.
```

> **Checklist**
> - <input type="checkbox" class="checkbox-input" /> @squad-creator gerou output válido?
> - <input type="checkbox" class="checkbox-input" /> 6 agentes presentes (ou equivalentes)?
> - <input type="checkbox" class="checkbox-input" /> Workflows cobrem ciclo completo (design → deploy → test → monitor)?
> - <input type="checkbox" class="checkbox-input" /> Diferenças com design esperado documentadas?
> - <input type="checkbox" class="checkbox-input" /> Refinamento aplicado e documentado?

> **🏆 Checkpoint 1**: Squad gerado + refinado.

---

### Passo 3 — Testar com workflow real

```
Execute o Squad N8N para criar um workflow real:

"Preciso de um workflow n8n que toda segunda às 8h:
1. Busque os 5 posts mais recentes do meu LinkedIn
2. Calcule engagement rate de cada um
3. Envie relatório por email com ranking dos posts"

O squad deve: analisar → projetar → gerar JSON → 
deployar → testar.
```

> **Checklist**
> - <input type="checkbox" class="checkbox-input" /> Workflow JSON gerado é válido (importável no n8n)?
> - <input type="checkbox" class="checkbox-input" /> Nodes fazem sentido para a automação pedida?
> - <input type="checkbox" class="checkbox-input" /> Deploy via API funcionou?
> - <input type="checkbox" class="checkbox-input" /> Teste de execução passou (ou simulou corretamente)?

Se o JSON for inválido:

```
O JSON gerado pelo Workflow Builder não importa no n8n — 
falta o campo "connections" entre nodes. O Builder precisa 
gerar JSON completo que o n8n aceita via POST /api/v1/workflows.
Valide contra o schema da API do n8n.
```

> **🏆 Checkpoint 2 — VITÓRIA DA AULA**: Squad N8N funcional com workflow deployado.

---

### Passo 4 — Commit

```bash
*exit
git add .
git commit -m "feat: N8N Automation Squad via @squad-creator + refinement

- @squad-creator generated initial squad definition
- Comparison with manual design: docs/squad-creator-comparison.md
- Manual refinement: 6 agents aligned with n8n lifecycle
- Tested with real workflow: LinkedIn engagement report
- Deploy via n8n API verified"
```

---

## Reflexão

### O conceito-chave

> **O @squad-creator acelera criação mas não elimina design humano. Output automatizado é draft — bom ponto de partida que precisa de refinamento baseado em domínio. A comparação "gerado vs esperado" ensina a avaliar e melhorar outputs do @squad-creator para qualquer domínio futuro.**

### Conexão com a próxima aula

Na Aula 20, MCP integration conecta agentes ao n8n e testing formal valida os squads como software.

---

> **Anterior**: Aula 18 — Squad Zabbix Content
> **Próxima**: Aula 20 — MCP Integration e Squad Testing
