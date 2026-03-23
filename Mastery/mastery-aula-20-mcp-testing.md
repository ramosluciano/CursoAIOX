# Aula 20 — MCP Integration e Squad Testing

<!-- metadata
course: Mastery
module: 6
lesson: 20
title: "MCP Integration e Squad Testing"
duration: 4-5 horas
agents: "squad N8N, squad LinkedIn"
project: Squad N8N + LinkedIn
phase: Squads Avançados
prerequisites: Aula 19 concluída (Squad N8N funcional)
-->

---

> **Módulo 6** · Squads Avançados
> **Duração**: 4-5 horas
> **Agentes praticados**: Squad N8N, Squad LinkedIn
> **Projeto**: Squad N8N Automation + LinkedIn Automation

---

## 🏆 Vitória desta aula

MCP integration conectando agentes a sistemas externos (n8n, LinkedIn), e framework de testing formal para squads com 5 níveis de validação aprovados.

**Critério binário**: MCP server conectado → agente deploya via MCP (não HTTP direto) → squad testing 5 níveis passando para N8N e LinkedIn.

---

## Conceito

### MCP: protocolo padronizado para interações externas

MCP (Model Context Protocol) abstrai como agentes se comunicam com sistemas externos. Em vez de HTTP hardcoded no código do agente, MCP padroniza a conexão — trocar o backend (n8n por Temporal, por exemplo) é mudar o MCP server, não reescrever o agente.

### Squad Testing: squads são software, e software tem testes

| Nível | O que testa |
|-------|------------|
| 1. Config | config.yaml é válido contra schema AIOX |
| 2. Agent | Cada agente responde a seus comandos |
| 3. Workflow | Cada workflow executa end-to-end |
| 4. Integration | Squad funciona como unidade coesa |
| 5. Quality | Output atende checklists de domínio |

---

## Prática

### Passo 1 — MCP para Squad N8N

```bash
cd ~/aiox-mastery/n8n-squad
claude
```

```
Configure MCP integration para o Squad N8N:

1. MCP server para n8n:
   - Conectar agente Deployer ao n8n via MCP
   - Conectar agente Monitor para observar execuções
2. Testar: Deployer deploya workflow via MCP
3. MCP server para LinkedIn (squad LinkedIn):
   - Conectar Publisher para publicação
   - Conectar metrics collector para engagement
```

> **Checklist MCP**
> - <input type="checkbox" class="checkbox-input" /> MCP server do n8n configurado e conectado?
> - <input type="checkbox" class="checkbox-input" /> Deployer usa MCP (não HTTP direto)?
> - <input type="checkbox" class="checkbox-input" /> Monitor lê execuções via MCP?
> - <input type="checkbox" class="checkbox-input" /> MCP do LinkedIn conectado?

> **🏆 Checkpoint 1**: MCP integration funcional.

---

### Passo 2 — Squad Testing Framework

```
Implemente testing formal para squads N8N e LinkedIn.

5 níveis de teste:
1. CONFIG: config.yaml válido contra schema
2. AGENT: cada agente responde a *help e 1+ comando
3. WORKFLOW: workflow completo executa (happy + error path)
4. INTEGRATION: squad como unidade produz output correto
5. QUALITY: output atende checklist de domínio

Scripts:
- npm run test:squad -- --squad=n8n
- npm run test:squad -- --squad=linkedin
```

> **Checklist de testing**
> - <input type="checkbox" class="checkbox-input" /> 5 níveis implementados?
> - <input type="checkbox" class="checkbox-input" /> Squad N8N passa em todos?
> - <input type="checkbox" class="checkbox-input" /> Squad LinkedIn passa em todos?
> - <input type="checkbox" class="checkbox-input" /> Error paths testados?
> - <input type="checkbox" class="checkbox-input" /> Scripts automatizáveis?

> **🏆 Checkpoint 2 — VITÓRIA DA AULA**: MCP + testing formal aprovado.

---

### Passo 3 — Commit

```bash
*exit
git add .
git commit -m "feat: MCP integration + 5-level squad testing framework

- MCP server for n8n (deploy + monitor)
- MCP server for LinkedIn (publish + metrics)
- 5-level testing: config, agent, workflow, integration, quality
- Both squads passing all test levels"
```

---

## Reflexão

### O conceito-chave

> **MCP padroniza integrações externas — sem MCP, cada integração é HTTP customizado. Com MCP, trocar backend é mudar o server, não o agente. Squad testing garante confiabilidade: squads são software que precisa funcionar toda vez, verificável por testes automatizados, não por execução manual e esperança.**

### Conexão com a próxima aula

Na Aula 21, squads se conectam entre si: composição cross-squad com @aiox-orchestrator.

---

> **Anterior**: Aula 19 — @squad-creator + Squad N8N
> **Próxima**: Aula 21 — Squad Composition e Ecossistema
