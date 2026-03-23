# Aula 14 — Ferramentas Interativas e Lab Provisioner

<!-- metadata
course: Mastery
module: 4
lesson: 14
title: "Ferramentas Interativas e Lab Provisioner"
duration: 5-6 horas
agents: "@dev, @devops, @zabbix-expert, @qa"
project: Plataforma Zabbix Learning
phase: Desenvolvimento Core
prerequisites: Aula 13 concluída (Quiz + Learning Path)
-->

---

> **Módulo 4** · Plataforma Zabbix: Desenvolvimento Core
> **Duração**: 5-6 horas
> **Agentes praticados**: `@dev`, `@devops`, `@zabbix-expert`, `@qa`
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

Ferramentas interativas Zabbix funcionais (item creator, trigger creator, macro search) e Lab Provisioner provisionando instância Zabbix efêmera com configuração pré-definida acessível via iframe na tela da aula.

**Critério binário**: 3+ ferramentas interativas gerando configs válidas + lab provisionado com Zabbix acessível + Recovery System tratando falhas de containers.

---

## Conceito

### Tooling interativo: aprender fazendo, não lendo

Cada ferramenta interativa é uma mini-app que ensina um conceito Zabbix pela prática. Em vez de ler sobre trigger expressions, o aluno monta uma expressão visualmente, vê o resultado e exporta para usar no Zabbix real:

| Ferramenta | O que faz | Conceito que ensina |
|-----------|-----------|-------------------|
| Item Creator | Monta itens de monitoramento com preview | Items, keys, preprocessing |
| Trigger Creator | Monta expressões de trigger visualmente | Trigger expressions, severity |
| Macro Search | Pesquisa macros com exemplos de uso | Macros, context, templates |
| Script Generator | Gera scripts por prompt → IA → código | External checks, preprocessing |
| LLD Designer | Projeta discovery rules interativamente | Low-Level Discovery |

### Lab Provisioner: onde teoria vira prática de verdade

O design foi feito na Aula 10. A Aula 07 implementou o protótipo com Recovery System. Agora integramos com a plataforma: o aluno clica "Iniciar Lab" na tela de exercício e em 30-60 segundos tem uma instância Zabbix real, pré-configurada para aquele exercício, acessível na própria tela.

---

## Contexto

Esta é a última aula do Módulo 4. Após ela, os 6 subsistemas da Plataforma Zabbix estarão implementados: Auth (Aula 11), Content Engine (Aula 12), Quiz Engine + Learning Path (Aula 13), Ferramentas + Labs (esta aula). O Módulo 5 foca em refinamento avançado.

---

## Prática

### Passo 1 — Ferramentas interativas

```bash
cd ~/aiox-mastery/zabbix-platform
claude
```

```
@dev

Dex, implemente as ferramentas interativas Zabbix.
Consulte docs/prd/prd-tooling.md.

Para cada ferramenta:
1. Interface React com inputs relevantes ao conceito
2. @zabbix-expert no backend validando e sugerindo
3. Preview do resultado (como ficaria no Zabbix real)
4. Exportar configuração (copiar/download para usar)

Comece com 3 essenciais:

ITEM CREATOR:
- Selecionar tipo de item (Zabbix agent, SNMP, HTTP, etc.)
- Configurar key com parâmetros
- Definir preprocessing steps
- Preview: como o item apareceria no Zabbix
- @zabbix-expert sugere preprocessing baseado no tipo

TRIGGER CREATOR:
- Builder visual de expressões de trigger
- Drag-and-drop de funções (avg, last, diff, change)
- Definir severity, dependencies
- Preview: expressão completa + resultado esperado
- @zabbix-expert valida sintaxe

MACRO SEARCH:
- Busca por nome ou contexto
- Mostra: nome da macro, valor, onde é usada, exemplos
- Sugere macros para cenários comuns
- @zabbix-expert explica quando usar cada tipo 
  (global, host, template, LLD)
```

> **Checklist de ferramentas interativas**
> - <input type="checkbox" class="checkbox-input" /> Item Creator gera item válido com key correta?
> - <input type="checkbox" class="checkbox-input" /> Trigger Creator monta expressão sintaticamente correta?
> - <input type="checkbox" class="checkbox-input" /> Macro Search retorna macros reais com exemplos?
> - <input type="checkbox" class="checkbox-input" /> @zabbix-expert valida e sugere em tempo real?
> - <input type="checkbox" class="checkbox-input" /> Preview mostra como ficaria no Zabbix?
> - <input type="checkbox" class="checkbox-input" /> Export gera config utilizável?

Se as ferramentas gerarem configs inválidas:

```
Dex, o Trigger Creator gerou a expressão 
"last(host:key)" — essa é a sintaxe antiga (pré-6.0). 
A sintaxe atual é "last(/host/key)". O @zabbix-expert 
deve validar contra a versão do Zabbix que a plataforma 
cobre. Atualize.
```

> **🏆 Checkpoint 1**: 3 ferramentas interativas funcionais.

---

### Passo 2 — Lab Provisioner integrado

```
*exit

@devops

Dex-Ops, integre o Lab Provisioner (protótipo da Aula 07) 
com a plataforma completa.

Requisitos de integração:
1. Botão "Iniciar Lab" na tela de exercício da aula
2. Provisioning: subir container Zabbix pré-configurado
3. Exercise manifests: YAML que define a configuração 
   de cada lab (hosts, templates, triggers carregados)
4. Acesso via iframe na própria tela da aula
5. TTL: 30-60 minutos com countdown visível
6. Cleanup automático após expiração
7. Feature gating: free = sem labs, pro = 3/dia, 
   premium = ilimitado

Recovery System (da Aula 07):
- Retry com backoff se provisioning falhar
- Porta dinâmica se conflito
- Health check do Zabbix antes de marcar como ready
- Orphan cleanup periódico
```

**Teste completo**:

```bash
# Provisionar lab
curl -X POST http://localhost:3000/api/labs/provision \
  -H "Authorization: Bearer $TOKEN_PRO" \
  -d '{"exerciseId":"basic-monitoring","lessonId":3}' | jq

# Verificar status (deve passar por: provisioning → configuring → ready)
curl http://localhost:3000/api/labs/1/status | jq

# Acessar URL do Zabbix web
# A URL retornada deve abrir Zabbix com config pré-definida

# Verificar que lab expira após TTL
# Esperar 30 minutos (ou reduzir TTL para teste)
```

> **Checklist do Lab Provisioner**
> - <input type="checkbox" class="checkbox-input" /> Lab provisiona em < 60 segundos?
> - <input type="checkbox" class="checkbox-input" /> Zabbix web acessível via URL retornada?
> - <input type="checkbox" class="checkbox-input" /> Configuração pré-definida carregada (hosts, templates)?
> - <input type="checkbox" class="checkbox-input" /> Iframe funciona na tela da aula?
> - <input type="checkbox" class="checkbox-input" /> TTL com countdown visível?
> - <input type="checkbox" class="checkbox-input" /> Cleanup automático após expiração?
> - <input type="checkbox" class="checkbox-input" /> Feature gating funciona (free bloqueado)?
> - <input type="checkbox" class="checkbox-input" /> Recovery System trata falhas de provisioning?

> **🏆 Checkpoint 2**: Lab Provisioner integrado com a plataforma.

---

### Passo 3 — QA review dos 4 subsistemas

```
*exit

@qa

Quinn, review de integração dos 4 subsistemas do Módulo 4:
Auth + Content Engine + Quiz/Learning Path + Tooling/Labs.

Foco em integração cross-subsistema:
- Auth protege TODOS os endpoints dos 4 subsistemas?
- Feature gating funciona nos labs E no conteúdo?
- Content → Quiz → Path flui sem breaks?
- Labs respeitam isolamento de tenants?
- Ferramentas interativas são acessíveis conforme plano?
- Performance: tempo de geração de aula + quiz + lab 
  é aceitável para o aluno?

*review-build
```

Ciclo de correções.

> **🏆 Checkpoint 3 — VITÓRIA DA AULA E DO MÓDULO 4**: 6 subsistemas implementados e integrados.

---

### Passo 4 — Commit

```bash
*exit
git add .
git commit -m "feat: interactive tools + Lab Provisioner integrated with platform

- 3 interactive tools: Item Creator, Trigger Creator, Macro Search
- @zabbix-expert validation and suggestions in real-time
- Lab Provisioner: ephemeral Zabbix with exercise manifests
- Lab iframe embedded in lesson UI with countdown timer
- Recovery system for container failures
- Feature gating across all tools and labs
- QA cross-subsystem integration review approved"
```

---

## Reflexão

### O Módulo 4 completo: de planejamento a produto

Quatro aulas transformaram a Plataforma Zabbix de especificações em produto funcional:

```
Aula 11: Auth      → Fundação (quem é, o que pode, a quem pertence)
Aula 12: Content   → Valor (aulas geradas por IA com qualidade)
Aula 13: Quiz+Path → Engajamento (gamificação + adaptatividade)
Aula 14: Tools+Lab → Prática (ferramentas + ambiente real)
```

### O conceito-chave

> **Cada subsistema da Plataforma Zabbix foi implementado com o rigor do ADE (specs aprovadas, 13 steps, recovery, review) e validado pelo QA em integração. É um SaaS real com 6 subsistemas trabalhando juntos: auth protege, content ensina, quiz avalia, path adapta, tools praticam, labs experimentam. O Módulo 5 vai refinar e expandir essa base.**

### Conexão com o Módulo 5

O Módulo 5 (Aulas 15-17): hooks de lifecycle para automação, multi-IDE testando a plataforma em Claude Code + Gemini CLI + Codex CLI, e brownfield completo do LinkedIn Automation.

---

> **Anterior**: Aula 13 — Quiz Engine + Learning Path
> **Próxima**: Aula 15 — Hooks de Lifecycle + Automação *(Módulo 5)*
