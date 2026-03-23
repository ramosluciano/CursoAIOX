# Aula 07 — Epics 5-7: Recovery, QA Evolution, Memory Layer

<!-- metadata
course: Mastery
module: 2
lesson: 7
title: "Epics 5-7: Recovery, QA Evolution, Memory Layer"
duration: 5-6 horas
agents: "@dev, @devops, @qa, @zabbix-expert"
project: Plataforma Zabbix Learning (Lab Provisioner)
phase: ADE Deep Dive
prerequisites: Aula 06 concluída (Quiz Engine via 13 steps)
-->

---

> **Módulo 2** · ADE Deep Dive
> **Duração**: 5-6 horas
> **Agentes praticados**: `@dev`, `@devops`, `@qa`, `@zabbix-expert`
> **Projeto**: Plataforma Zabbix Learning (Lab Provisioner)

---

## 🏆 Vitória desta aula

Lab Provisioner implementado com Recovery System documentado para falhas reais de containers, QA review em 10 fases com foco em segurança, e Memory Layer consolidando insights de 3 subsistemas.

**Critério binário**: Lab Provisioner provisionando instância Zabbix efêmera + recovery-tracker documentado + QA 10 fases aprovado + memory-consolidation.md com insights de Content Engine + Quiz Engine + Lab Provisioner.

---

## Conceito

### Epics 5-7: onde a resiliência mora

Os Epics 1-4 cobriram infraestrutura (worktrees, migration), especificação (Spec Pipeline) e implementação (Execution Engine). Os Epics 5-7 cobrem o que acontece quando **as coisas dão errado** e o que o sistema **aprende** com isso:

| Epic | Problema que resolve |
|------|---------------------|
| 5 — Recovery System | Feature falhou durante implementação. Como recuperar? |
| 6 — QA Evolution | O código funciona, mas é seguro? Performático? Manutenível? |
| 7 — Memory Layer | O que aprendemos neste subsistema que vale para os próximos? |

### Por que o Lab Provisioner para exercitar Recovery

O Lab Provisioner é o subsistema mais complexo tecnicamente da Plataforma Zabbix: provisionar instâncias Zabbix reais em containers efêmeros para cada exercício do aluno. Containers com tempo de vida limitado, configuração pré-definida por exercício, acesso via iframe, cleanup automático.

Isso **vai falhar**. Containers falham por falta de recursos. Ports colidem. Networks não conectam. Volumes não montam. Zabbix dentro de Docker tem dependências específicas (banco, configuração de rede, processos do server). A complexidade de infra garante que o Recovery System será exercitado de verdade — não simulado.

### QA Evolution: 10 fases em contexto de segurança

O QA em 10 fases foi exercitado no Bootcamp (Aula 07, RockQuiz). Lá, a fase 7 (segurança) era sobre input validation e XSS. No Lab Provisioner, segurança é **existencial**: containers efêmeros que rodam Zabbix Server precisam de isolamento de rede, limites de recursos (CPU, RAM, disco), prevenção de escape de container, e cleanup garantido.

### Memory Layer: o cérebro do projeto

A Memory Layer acumula insights entre subsistemas. Os 3 subsistemas implementados até agora (Content Engine spec, Quiz Engine implementado, Lab Provisioner) geraram padrões, decisões e aprendizados. A consolidação transforma insights isolados em conhecimento do projeto.

---

## Prática

### Passo 1 — Implementar Lab Provisioner (preparar para falha)

```bash
cd ~/aiox-mastery/zabbix-platform
claude
```

```
@devops

Dex-Ops, preciso da infraestrutura para o Lab Provisioner.
O subsistema provisiona containers Zabbix efêmeros para 
exercícios práticos.

Cada lab precisa:
1. Container com Zabbix Server + banco PostgreSQL
2. Configuração pré-definida por exercício (hosts, 
   templates, triggers carregados automaticamente)
3. Tempo de vida limitado (30-60 minutos)
4. Acesso web via porta dinâmica
5. Cleanup automático após expiração
6. Isolamento: labs de alunos diferentes não se enxergam

Comece com a abordagem mais simples: Docker-in-Docker 
ou Docker Compose dinâmico. Não otimize para escala 
ainda — primeiro faça funcionar para 1 lab.

Atenção: isso VAI falhar em vários pontos. Documente 
cada falha no recovery-tracker.
```

```
@dev

Dex, implemente o Lab Provisioner service:
- API para criar lab (input: exercício, configuração)
- API para status do lab (running, expired, failed)
- API para destruir lab manualmente
- Lógica de expiração e cleanup
- Health check do container provisionado

Siga os 13 steps, mas foque nos steps 1-8 por agora. 
A self-critique (step 10) vai ser sobre o Recovery.
```

**Como verificar o básico**:

```bash
# Criar um lab
curl -X POST http://localhost:3000/api/labs/provision \
  -H "Content-Type: application/json" \
  -d '{"exercise":"basic-monitoring","ttlMinutes":30}' | jq

# Verificar status
curl http://localhost:3000/api/labs/1/status | jq

# Acessar Zabbix web do lab (porta dinâmica)
# O response deve incluir a URL de acesso
```

> **Checklist de avaliação básica**
> - <input type="checkbox" class="checkbox-input" /> Lab provisiona e Zabbix Server inicia dentro do container?
> - <input type="checkbox" class="checkbox-input" /> Configuração pré-definida é carregada? (hosts, templates)
> - <input type="checkbox" class="checkbox-input" /> Acesso web funciona na porta dinâmica?
> - <input type="checkbox" class="checkbox-input" /> Status endpoint retorna estado correto?
> - <input type="checkbox" class="checkbox-input" /> Expiração funciona (lab é destruído após TTL)?

**Espere falhas**. Se tudo funcionar de primeira, algo não está sendo testado adequadamente. Falhas típicas:

- Zabbix Server não inicia (falta de configuração de banco)
- Porta já ocupada por outro lab
- Container inicia mas Zabbix web não responde (processo ainda subindo)
- Cleanup não funciona (container órfão)
- Sem memória para novo container

> **🏆 Checkpoint 1**: Lab Provisioner básico funcionando (mesmo com falhas conhecidas).

---

### Passo 2 — Recovery System: documentar e tratar falhas

Aqui é onde o Epic 5 brilha. Cada falha é uma oportunidade de Recovery:

```
@dev

Dex, documente CADA falha que encontrou tentando 
provisionar labs. Use o recovery-tracker.

Para cada falha:
1. O QUE falhou (sintoma)
2. POR QUE falhou (causa raiz)
3. COMO recuperou (ação de recovery)
4. COMO PREVENIR (mudança no código ou config)
5. STATUS (resolvido, workaround, aceito como limitação)

Agora implemente Recovery System para os cenários 
mais comuns:

Cenário 1 — Container não inicia:
- Detectar timeout de inicialização
- Tentar reprovisionar (retry com backoff)
- Se retry falha, retornar erro claro ao aluno

Cenário 2 — Porta ocupada:
- Detectar conflito de porta
- Alocar porta alternativa automaticamente
- Atualizar URL de acesso

Cenário 3 — Zabbix web não responde:
- Health check do Zabbix após provisioning
- Wait com retry até Zabbix estar ready
- Timeout máximo com erro claro

Cenário 4 — Cleanup falha:
- Container órfão detectado por age check
- Force-remove periódico de containers expirados
- Log de containers que resistiram ao cleanup

Cenário 5 — Sem recursos:
- Verificar recursos antes de provisionar
- Queue de espera quando no limite
- Limite máximo de labs simultâneos configurável
```

Se a implementação do recovery-tracker.js estiver disponível:

```bash
# Verificar se existe no ADE
find .aiox-core/ -name "recovery-tracker*"
cat .aiox-core/development/ade/[caminho]
```

**Teste o Recovery provocando falhas**:

```bash
# Provocar porta ocupada: criar 2 labs na mesma porta
curl -X POST http://localhost:3000/api/labs/provision \
  -d '{"exercise":"test-1"}' | jq
curl -X POST http://localhost:3000/api/labs/provision \
  -d '{"exercise":"test-2"}' | jq
# O segundo deve usar porta alternativa (Recovery cenário 2)

# Provocar timeout: provisionar com imagem que não existe
curl -X POST http://localhost:3000/api/labs/provision \
  -d '{"exercise":"invalid-image-test"}' | jq
# Deve retornar erro claro após retry (Recovery cenário 1)

# Provocar cleanup failure: criar lab e matar o daemon
# de cleanup, verificar que o age check pega
```

> **Checklist de avaliação do Recovery**
> - <input type="checkbox" class="checkbox-input" /> recovery-tracker tem pelo menos 5 falhas documentadas?
> - <input type="checkbox" class="checkbox-input" /> Cada falha tem causa raiz identificada?
> - <input type="checkbox" class="checkbox-input" /> Os 5 cenários de recovery estão implementados?
> - <input type="checkbox" class="checkbox-input" /> Retry com backoff funciona?
> - <input type="checkbox" class="checkbox-input" /> Erros retornados ao aluno são claros (não stack traces)?
> - <input type="checkbox" class="checkbox-input" /> Containers órfãos são detectados e removidos?

> **🏆 Checkpoint 2**: Recovery System implementado e testado com falhas reais.

---

### Passo 3 — QA Evolution: 10 fases com foco em segurança

O Lab Provisioner manipula containers. Segurança é crítica:

```
*exit

@qa

Quinn, faça review do Lab Provisioner em 10 fases 
com atenção ESPECIAL às fases de segurança e performance.

FASE 7 — SEGURANÇA (crítica para Lab Provisioner):
- Containers estão isolados? (aluno A não acessa lab do aluno B?)
- Limites de recursos estão definidos? (CPU, RAM, disco por container)
- É possível escape de container? (bind mounts perigosos?)
- Credenciais do Zabbix dentro do lab são únicas por lab?
- A API de provisioning tem autenticação? (qualquer pessoa pode criar labs?)
- O cleanup garante que dados do aluno são destruídos?

FASE 8 — PERFORMANCE:
- Qual o tempo de provisioning? (aceitável para aluno esperando?)
- Quantos labs simultâneos o sistema suporta?
- O health check impacta performance?
- Cleanup de containers expirados é eficiente?

Aplique todas as 10 fases mas seja RIGOROSO nas fases 
7 e 8. Lab Provisioner com falha de segurança é mais 
perigoso que Lab Provisioner que não funciona.

*review-build
```

**Exemplos reais de issues de segurança em Lab Provisioner**:

- "Containers usam rede bridge padrão — todos se enxergam. Cada lab precisa de rede isolada."
- "Sem limite de CPU/RAM, um lab pode consumir todos os recursos e derrubar o host."
- "A API de provisioning não exige autenticação — qualquer request cria um container."
- "O volume de dados do Zabbix é montado em /tmp sem cleanup — dados persistem após destruição do container."
- "O password do admin do Zabbix é igual em todos os labs ('Admin/zabbix'). Deveria ser gerado por lab."

Ciclo de correções:

```
*exit
@dev
Dex, corrija TODAS as issues de segurança (fase 7) 
do QA. Issues de segurança em Lab Provisioner são 
SEMPRE critical.
*apply-qa-fix
```

```
*exit
@qa
Quinn, verifique as correções de segurança.
*verify-fix
```

> **🏆 Checkpoint 3**: QA 10 fases aprovado com segurança rigorosa.

---

### Passo 4 — Memory Layer: consolidação de 3 subsistemas

Agora o Epic 7 — consolidar insights de tudo que foi implementado:

```
@dev

Dex, consolide a Memory Layer dos 3 subsistemas da 
Plataforma Zabbix implementados até agora.

Leia:
- Insights do Content Engine (spec da Aula 05)
- Insights do Quiz Engine (execution-log da Aula 06)
- Insights do Lab Provisioner (recovery-tracker desta aula)

Produza docs/memory-consolidation.md com:

1. PADRÕES CROSS-SUBSISTEMA:
   - Quais patterns de código se repetiram?
   - Quais decisões arquiteturais foram consistentes?
   - Quais problemas apareceram em mais de um subsistema?

2. INSIGHTS POR SUBSISTEMA:
   - Content Engine: o que aprendeu sobre RAG para Zabbix
   - Quiz Engine: o que aprendeu sobre gamificação e adaptatividade
   - Lab Provisioner: o que aprendeu sobre containers efêmeros

3. RECOMENDAÇÕES PARA SUBSISTEMAS FUTUROS:
   - O que fazer diferente no Learning Path Engine?
   - O que fazer diferente no Tooling Interativo?
   - Quais decisões são "boas por default" para a plataforma?

4. DÍVIDA TÉCNICA CONSOLIDADA:
   - Fragilidades do Quiz Engine (self-critique da Aula 06)
   - Limitações do Lab Provisioner (recovery-tracker)
   - Priorização: o que atacar primeiro?

*capture-insights
```

Se codebase-mapper.js e pattern-extractor.js existirem:

```bash
find .aiox-core/ -name "codebase-mapper*" -o -name "pattern-extractor*"
```

Use-os para automatizar a análise cross-subsistema.

> **Checklist de avaliação da Memory Layer**
> - <input type="checkbox" class="checkbox-input" /> Padrões cross-subsistema foram identificados?
> - <input type="checkbox" class="checkbox-input" /> Insights são específicos (não genéricos)?
> - <input type="checkbox" class="checkbox-input" /> Recomendações para subsistemas futuros são acionáveis?
> - <input type="checkbox" class="checkbox-input" /> Dívida técnica está consolidada e priorizada?
> - <input type="checkbox" class="checkbox-input" /> O documento é útil para quem trabalhar no próximo subsistema?

> **🏆 Checkpoint 4 — VITÓRIA DA AULA**: Recovery + QA Evolution + Memory Layer completos.

---

### Passo 5 — Commit

```bash
*exit

git add .
git commit -m "feat: Lab Provisioner with Recovery, QA security review, Memory Layer

- Lab Provisioner: ephemeral Zabbix containers with auto-cleanup
- Recovery System: 5 failure scenarios with documented recovery
- QA 10-phase review with rigorous security (network isolation,
  resource limits, auth, credential rotation)
- Memory Layer consolidation: Content Engine + Quiz Engine +
  Lab Provisioner patterns and recommendations
- Technical debt consolidated and prioritized"
```

---

## Reflexão

### O Módulo 2 completo: ADE por dentro

Quatro aulas cobriram os 7 Epics do ADE:

```
Aula 04: Epics 1-2 → Worktrees + Migration
Aula 05: Epic 3    → Spec Pipeline (3 iterações documentadas)
Aula 06: Epic 4    → Execution Engine (13 steps documentados)
Aula 07: Epics 5-7 → Recovery + QA Evolution + Memory Layer
```

No Bootcamp, o ADE era uma caixa preta que você acionava implicitamente. Agora você viu cada engrenagem: como specs evoluem por iteração, como implementação é decomposta em steps, como falhas são rastreadas e recuperadas, como reviews são estruturados em 10 fases, e como insights acumulam entre subsistemas.

### Recovery como competência, não como reação

No Bootcamp (AuctionHunter), o Recovery tratava falhas de scraping — externas, previsíveis. No Lab Provisioner, as falhas são de **infraestrutura** — mais imprevisíveis e mais perigosas. A diferença entre os dois:

| AuctionHunter Recovery | Lab Provisioner Recovery |
|----------------------|------------------------|
| Scraper falha → tenta próxima layer | Container falha → retry com backoff |
| Dados parciais preservados | Estado de container é binário (running ou não) |
| Falha é esperada por design | Falha pode comprometer o host |
| Recovery é sobre dados | Recovery é sobre infraestrutura |

O Recovery System é uma **competência** que se aplica em qualquer contexto — mas o tipo de falha e a estratégia de recuperação mudam. No Mastery, você aprendeu a reconhecer isso.

### O conceito-chave

> **Os Epics 5-7 do ADE são o sistema imunológico do projeto. Recovery (Epic 5) trata falhas quando acontecem. QA Evolution (Epic 6) previne falhas por revisão rigorosa. Memory Layer (Epic 7) acumula conhecimento para evitar repetir erros. Juntos, transformam um projeto que "funciona quando tudo dá certo" em um projeto que "funciona apesar das coisas darem errado" — e melhora a cada subsistema implementado.**

### Conexão com o Módulo 3

O Módulo 2 dominou o ADE. O Módulo 3 (Aulas 08-10) retorna à Plataforma Zabbix com foco em planejamento e arquitetura do SaaS completo: Analyst pesquisa profunda do domínio educacional, PM + Architect especificam o PRD de 30+ FRs com 6 subsistemas, e DevOps projeta a infraestrutura de 10+ containers com a decisão mais complexa do projeto: como provisionar labs em escala.

---

> **Anterior**: Aula 06 — Epic 4: Execution Engine 13 Steps
> **Próxima**: Aula 08 — Analyst: Domínio Educacional + Zabbix *(Módulo 3)*
