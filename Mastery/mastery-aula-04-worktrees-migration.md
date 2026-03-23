# Aula 04 — Epic 1-2: Worktrees Avançados e Migration

<!-- metadata
course: Mastery
module: 2
lesson: 4
title: "Epic 1-2: Worktrees Avançados e Migration"
duration: 4 horas
agents: "@devops, @dev"
project: Plataforma Zabbix Learning + LinkedIn Squad (migration)
phase: ADE Deep Dive
prerequisites: Aula 03 concluída (tasks, workflows, checklists customizados)
-->

---

> **Módulo 2** · ADE Deep Dive
> **Duração**: 4 horas
> **Agentes praticados**: `@devops`, `@dev`
> **Projeto**: Plataforma Zabbix Learning + LinkedIn Squad (migration)

---

## 🏆 Vitória desta aula

3 worktrees ativos para subsistemas da Plataforma Zabbix rodando em paralelo, e o squad LinkedIn do Bootcamp migrado para formato V3 com validação aprovada.

**Critério binário**: 3 worktrees com código independente + squad LinkedIn migrado + `asset-inventory.js` e schemas de validação passando.

---

## Conceito

### ADE Epic 1: Worktree Manager — paralelismo real

No Bootcamp (AuctionHunter, Aula 11), você usou worktrees para isolar layers de scraping. Era simples: 3 branches, 3 diretórios. Na Plataforma Zabbix, a escala é outra: 6 subsistemas que podem ser desenvolvidos em paralelo por agentes diferentes, cada um com suas dependências e seu estado.

O Worktree Manager do ADE gerencia isso: cria, lista, sincroniza e resolve conflitos entre worktrees. Não é `git worktree add` manual — é um subsistema que sabe quais worktrees existem, quais estão ativos, e quando é seguro mergear.

### ADE Epic 2: Migration V2 → V3

O squad LinkedIn foi criado no Bootcamp em um formato que pode não ser o V3 atual do AIOX. Migration é o processo de atualizar artefatos de uma versão do AIOX para outra: agentes, workflows, configurações. O ADE tem ferramentas para isso:

| Ferramenta | O que faz |
|-----------|-----------|
| `asset-inventory.js` | Lista todos os artefatos AIOX do projeto |
| `migrate-agent.js` | Migra definição de agente para formato V3 |
| Schemas de validação | Verifica se artefatos estão no formato correto |

Isso é relevante para qualquer projeto de longo prazo: o AIOX evolui, e seus projetos precisam evoluir junto.

---

## Prática

### Passo 1 — Worktrees avançados para a Plataforma Zabbix

```bash
cd ~/aiox-mastery/zabbix-platform
claude
```

```
@devops

Dex-Ops, a Plataforma Zabbix tem 6 subsistemas. Preciso 
de worktrees para desenvolver 3 deles em paralelo:

1. feature/content-engine — Content Engine (RAG + geração)
2. feature/quiz-engine — Quiz Engine (gamificação)
3. feature/auth-billing — Auth + Billing (multi-tenant)

Cada worktree precisa:
- Branch isolada com estrutura de diretórios própria
- Acesso ao banco (conexão compartilhada ou DB por worktree)
- Capacidade de rodar testes independentemente
- Sem interferência entre worktrees

Use o Worktree Manager do ADE se disponível. Se não, 
configure manualmente mas documente o fluxo de gestão 
(criar, listar, sincronizar, mergear).

Quero poder alternar entre subsistemas sem reconstruir 
o ambiente cada vez.
```

**Como verificar**:

```bash
# Listar worktrees
git worktree list

# Verificar que cada worktree tem sua branch
cd feature/content-engine && git branch --show-current
cd ../quiz-engine && git branch --show-current
cd ../auth-billing && git branch --show-current

# Verificar independência: alterar arquivo em um worktree
# não afeta os outros
```

> **Checklist de avaliação dos worktrees**
> - <input type="checkbox" class="checkbox-input" /> 3 worktrees criados com branches separadas?
> - <input type="checkbox" class="checkbox-input" /> Cada um tem estrutura de diretórios independente?
> - <input type="checkbox" class="checkbox-input" /> Alteração em um não aparece nos outros?
> - <input type="checkbox" class="checkbox-input" /> Banco de dados está acessível de todos os worktrees?
> - <input type="checkbox" class="checkbox-input" /> Testes rodam independentemente em cada worktree?

**Cenário avançado** — desenvolver em paralelo:

```
Dex-Ops, simule desenvolvimento paralelo:
1. No worktree content-engine: crie um arquivo placeholder src/content/index.ts
2. No worktree quiz-engine: crie src/quiz/index.ts
3. No worktree auth-billing: crie src/auth/index.ts
4. Agora mergeie os 3 na main sem conflito

Documente o fluxo de merge que funcionou.
```

> **🏆 Checkpoint 1**: 3 worktrees funcionando em paralelo com merge limpo.

---

### Passo 2 — Asset Inventory do LinkedIn Squad

Antes de migrar, inventariar o que existe:

```bash
# Apontar para o projeto LinkedIn do Bootcamp
cd ~/aiox-bootcamp/linkedin-squad
```

```
Execute o asset-inventory do ADE para o projeto 
LinkedIn Squad.

Quero saber:
1. Quais artefatos AIOX existem neste projeto?
   (agentes, workflows, tasks, configs, presets)
2. Em qual versão/formato cada artefato está?
3. Quais precisam de migração para V3?
4. Quais estão obsoletos ou duplicados?

Se asset-inventory.js estiver disponível no .aiox-core/,
use-o. Se não, faça o inventário manualmente listando 
e classificando cada artefato.
```

**O que esperar**: Um inventário que lista cada agente do squad (Voice Analyst, Quiz Crafter, Content Writer, Editor, Trend Scout, Publisher), os workflows por vertente, o config.yaml, templates e checklists.

> **Checklist de avaliação do inventário**
> - <input type="checkbox" class="checkbox-input" /> Todos os 6 agentes do squad foram listados?
> - <input type="checkbox" class="checkbox-input" /> Workflows das 4 vertentes foram encontrados?
> - <input type="checkbox" class="checkbox-input" /> config.yaml foi analisado (versão, formato)?
> - <input type="checkbox" class="checkbox-input" /> Artefatos que precisam de migração foram identificados?
> - <input type="checkbox" class="checkbox-input" /> Artefatos obsoletos foram marcados?

> **🏆 Checkpoint 2**: Inventário completo do LinkedIn Squad.

---

### Passo 3 — Migration V2 → V3

```
Agora migre os artefatos do LinkedIn Squad para formato V3.

Prioridade:
1. Agentes (6 agentes → formato autoClaude V3 como 
   o @zabbix-expert da Aula 02)
2. config.yaml (atualizar para schema V3)
3. Workflows (atualizar formato YAML se necessário)

Para cada artefato migrado:
- Faça backup do original
- Migre para V3
- Valide contra o schema de validação
- Teste se funciona

Se migrate-agent.js estiver disponível, use-o. Se não, 
migre manualmente baseado no formato V3 que aprendemos 
na Aula 02.
```

**Como verificar**:

```bash
# Validar cada agente migrado
# [comando de validação — depende da versão do AIOX]

# Testar funcionalidade
@voice-analyst *help  # deve funcionar no novo formato
```

> **Checklist de avaliação da migration**
> - <input type="checkbox" class="checkbox-input" /> Todos os 6 agentes foram migrados para V3?
> - <input type="checkbox" class="checkbox-input" /> Backups dos originais existem?
> - <input type="checkbox" class="checkbox-input" /> Validação contra schema V3 passa para cada agente?
> - <input type="checkbox" class="checkbox-input" /> config.yaml está no formato atualizado?
> - <input type="checkbox" class="checkbox-input" /> O squad funciona após migration (não quebrou)?

Se a migração quebrar funcionalidade:

```
O squad parou de funcionar após migration — o Voice 
Analyst não reconhece o comando *analyze-voice. Verifique 
se a migração preservou todos os comandos customizados. 
Compare o backup com a versão V3 — algum comando pode 
ter sido perdido na conversão.
```

**Validação final**: Rode o workflow completo do squad com os artefatos migrados e compare o output com o da Aula 15 do Bootcamp. Deve ser equivalente ou melhor.

> **🏆 Checkpoint 3 — VITÓRIA DA AULA**: 3 worktrees + squad migrado e validado em V3.

---

### Passo 4 — Commit

```bash
*exit

# No projeto Zabbix Platform
cd ~/aiox-mastery/zabbix-platform
git add .
git commit -m "feat: 3 parallel worktrees for Zabbix Platform subsystems

- content-engine, quiz-engine, auth-billing worktrees
- Parallel development workflow documented
- Clean merge process validated"

# No projeto LinkedIn Squad
cd ~/aiox-bootcamp/linkedin-squad
git add .
git commit -m "refactor: migrate LinkedIn Squad to AIOX V3 format

- 6 agents migrated to autoClaude V3
- config.yaml updated to V3 schema
- Workflows updated and validated
- Backups preserved in legacy/"
```

---

## Reflexão

### Worktrees: a infraestrutura do projeto grande

No Bootcamp, desenvolvimento era sequencial: uma story de cada vez, uma feature de cada vez. Na Plataforma Zabbix, isso não escala — 6 subsistemas com desenvolvimento sequencial levariam meses. Worktrees permitem paralelismo real: um agente trabalhando no Content Engine enquanto outro trabalha no Auth System, sem interferência.

A complexidade está no merge. Três worktrees desenvolvendo em paralelo podem criar conflitos se tocarem nos mesmos arquivos. O fluxo de merge documentado nesta aula é a disciplina que previne conflitos — e quando acontecem, ter worktrees isolados facilita a resolução.

### Migration: projetos evoluem, ferramentas evoluem

Migrar o LinkedIn Squad do Bootcamp para V3 é a prova de que projetos de longo prazo precisam de manutenção de formato. O que você construiu no Bootcamp ainda funciona — mas no formato V3 funciona **melhor** (schemas de validação, formato padronizado, compatibilidade com features novas).

### O conceito-chave

> **Epics 1 e 2 do ADE não são sobre código — são sobre infraestrutura de desenvolvimento. Worktrees permitem escalar desenvolvimento para projetos com múltiplos subsistemas. Migration garante que artefatos existentes evoluem com o framework. Sem eles, projetos grandes ficam engessados e projetos antigos ficam defasados.**

### Conexão com a próxima aula

Na Aula 05, o Spec Pipeline (Epic 3) é exercitado com profundidade: 3 iterações reais entre PM e QA para a spec do Content Engine. A infra de worktrees criada aqui será usada — o Content Engine vive no worktree `feature/content-engine`.

---

> **Anterior**: Aula 03 — Tasks, Workflows YAML e Customização Avançada
> **Próxima**: Aula 05 — Epic 3: Spec Pipeline com Iteração Real
