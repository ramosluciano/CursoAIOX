# Aula 05 — Epic 3: Spec Pipeline com Iteração Real

<!-- metadata
course: Mastery
module: 2
lesson: 5
title: "Epic 3: Spec Pipeline com Iteração Real"
duration: 4-5 horas
agents: "@pm, @qa, @zabbix-expert"
project: Plataforma Zabbix Learning (Content Engine)
phase: ADE Deep Dive
prerequisites: Aula 04 concluída (worktrees + migration)
-->

---

> **Módulo 2** · ADE Deep Dive
> **Duração**: 4-5 horas
> **Agentes praticados**: `@pm`, `@qa`, `@zabbix-expert`
> **Projeto**: Plataforma Zabbix Learning (Content Engine)

---

## 🏆 Vitória desta aula

Spec do Content Engine aprovada após 3 iterações reais entre PM e QA, com cada iteração documentada mostrando o que mudou e por quê.

**Critério binário**: Spec em `docs/specs/content-engine.md` aprovada pelo QA + `docs/spec-iterations.md` documentando as 3 iterações completas.

---

## Conceito

### Spec Pipeline: 7 etapas, sem atalho

No Bootcamp (Aula 10, AuctionHunter), o Spec Pipeline foi exercitado com 1-2 iterações. Funcionou porque as specs eram relativamente simples — cada layer de scraping tinha escopo claro. O Content Engine da Plataforma Zabbix é outra história: RAG pipeline com documentação oficial, geração de aulas em múltiplos formatos, renderização de Markdown, versionamento de conteúdo, e integração com o @zabbix-expert.

As 7 etapas do Spec Pipeline existem porque specs complexas **nunca ficam boas na primeira versão**. A iteração não é burocracia — é onde a qualidade emerge:

| Etapa | O que acontece | Por que é necessário |
|-------|---------------|---------------------|
| 1. Elicitação | PM faz perguntas ao humano | Esclarecer ambiguidades antes de especificar |
| 2. Spec draft | PM escreve primeira versão | Cristalizar entendimento em documento |
| 3. Self-critique | PM identifica falhas próprias | Humildade antes de revisão externa |
| 4. QA critique | QA identifica falhas adicionais | Olhos frescos encontram o que autor não vê |
| 5. Iteração | PM corrige baseado no feedback | Spec melhora com cada ciclo |
| 6. Aprovação | QA aprova | Spec é um contrato — precisa de aceite |
| 7. Spec executável | Pronta para o Dev | Nenhuma ambiguidade remanescente |

Nesta aula, as etapas 3-6 serão repetidas **3 vezes**. Cada iteração vai melhorar a spec de forma documentada. Ao final, você vai ter um registro claro de como uma spec evolui de "boa" para "pronta para implementação".

### Internals do Spec Pipeline

No Bootcamp, você usou o Spec Pipeline sem ver a mecânica. Agora, explore os arquivos internos:

- `spec-tmpl.md`: Template que o PM usa como base
- `self-critique-checklist.md`: Checklist que o PM usa para auto-avaliação
- Schema de validação de specs

---

## Prática

### Passo 1 — Explorar internals do Spec Pipeline

```bash
cd ~/aiox-mastery/zabbix-platform

# Ir para o worktree do Content Engine
cd feature/content-engine

claude
```

```
Antes de especificar, preciso entender o Spec Pipeline 
por dentro. Mostre-me:

1. O template de spec: .aiox-core/development/ade/spec-tmpl.md
2. O checklist de self-critique: 
   .aiox-core/development/ade/self-critique-checklist.md
3. O schema de validação de specs (se existir)

Para cada arquivo, explique: o que contém, como é usado 
pelo PM, e como o QA o referencia.
```

> **Checklist de entendimento dos internals**
> - <input type="checkbox" class="checkbox-input" /> Template de spec foi lido e entendido?
> - <input type="checkbox" class="checkbox-input" /> Checklist de self-critique foi lido?
> - <input type="checkbox" class="checkbox-input" /> Schema de validação foi identificado?
> - <input type="checkbox" class="checkbox-input" /> Entende como PM e QA interagem com esses artefatos?

---

### Passo 2 — Iteração 1: Draft + Self-critique

```
@pm

Patty, escreva a spec do Content Engine da Plataforma 
Zabbix Learning. Use o template de spec do ADE 
(.aiox-core/development/ade/spec-tmpl.md).

O Content Engine é o subsistema que:
- Ingere a documentação oficial do Zabbix (fonte primária)
- Processa via RAG: chunk → embed → vector store → retrieve
- Gera aulas em Markdown com linguagem acessível
- Renderiza conteúdo (Markdown → componentes React)
- O @zabbix-expert (agente custom) participa da geração

Consulte:
- docs/project-brief.md (se existir, ou crie baseado 
  no escopo da Plataforma)
- O Architecture Doc (quando existir)
- O checklist de qualidade zabbix-lesson-quality.md 
  (criado na Aula 03)

A spec deve cobrir:
- Functional Requirements com acceptance criteria
- Non-Functional Requirements (performance de RAG, 
  qualidade de conteúdo)
- Decisões técnicas pendentes (qual vector store? 
  Qual modelo de embedding? Chunk size?)
- Edge cases (documentação incompleta, conceitos sem 
  análogo simples, versões conflitantes)

*write-spec
```

Após o draft, self-critique:

```
Patty, antes de enviar ao QA, faça self-critique.

Use o checklist em 
.aiox-core/development/ade/self-critique-checklist.md

Para cada item do checklist, avalie honestamente:
- Passa? Por quê?
- Não passa? O que falta?

Corrija o que identificou na self-critique ANTES 
de enviar ao QA.

Liste o que mudou entre o draft original e o 
draft pós-self-critique.
```

> **Checklist de avaliação do draft + self-critique**
> - <input type="checkbox" class="checkbox-input" /> Spec segue o template?
> - <input type="checkbox" class="checkbox-input" /> FRs têm acceptance criteria testáveis?
> - <input type="checkbox" class="checkbox-input" /> Decisões técnicas pendentes estão listadas (não resolvidas prematuramente)?
> - <input type="checkbox" class="checkbox-input" /> Self-critique foi honesta (encontrou problemas reais)?
> - <input type="checkbox" class="checkbox-input" /> Mudanças pós-self-critique foram documentadas?

**Documente a Iteração 1** em `docs/spec-iterations.md`:

```markdown
## Iteração 1: Draft + Self-Critique

### O que o PM escreveu (resumo)
[Resumo do draft]

### Self-critique: o que o PM encontrou
[Issues identificadas pelo próprio PM]

### O que mudou
[Diferenças entre draft original e draft corrigido]
```

> **🏆 Checkpoint 1**: Draft + self-critique documentados.

---

### Passo 3 — Iteração 2: QA Critique + Correção

```
*exit

@qa

Quinn, critique a spec do Content Engine.

Leia docs/specs/content-engine.md (draft pós-self-critique).

Aplique critique profunda:

1. COMPLETUDE: A spec cobre todo o pipeline RAG? 
   (ingestão → chunking → embedding → storage → 
   retrieval → generation → rendering)
2. TESTABILIDADE: Cada FR é verificável? Cada NFR 
   tem métrica? "O conteúdo deve ser bom" NÃO é testável.
3. CONSISTÊNCIA: Os FRs são compatíveis entre si? 
   Os NFRs são alcançáveis com a stack sugerida?
4. EDGE CASES: O que acontece quando a documentação 
   Zabbix tem informações conflitantes entre versões? 
   Quando um conceito não tem análogo simples? Quando 
   o RAG retorna chunk irrelevante?
5. DOMAIN-SPECIFIC: O @zabbix-expert (Aula 02) valida 
   se os FRs fazem sentido para conteúdo educacional 
   sobre Zabbix. Use o checklist zabbix-lesson-quality.md.

*critique-spec

Classifique cada issue por severidade e explique 
o impacto no projeto.
```

**O que esperar na Iteração 2**: O QA vai encontrar gaps que o PM não viu na self-critique. Exemplos do tipo de issue em specs de Content Engine:

- "FR-CE-04 diz 'gerar aulas em linguagem acessível' — o que é 'acessível'? Para um iniciante em Zabbix? Para alguém que já usa? Defina o nível-alvo ou varie por learning path."
- "NFR de performance diz 'RAG deve responder em tempo aceitável'. Defina: < 3s? < 5s? Com qual tamanho de knowledge base?"
- "Não há FR para versionamento de conteúdo. Se a documentação do Zabbix 7.0 mudar um conceito, as aulas existentes ficam desatualizadas. Como detectar e atualizar?"
- "O pipeline RAG não tem FR para avaliação de qualidade dos chunks. Chunk ruim = aula ruim. Quem valida se o chunking está adequado?"

Agora o PM corrige:

```
*exit

@pm

Patty, o QA criticou a spec. Leia o relatório e corrija 
cada issue.

Para CADA issue:
1. Indique se concorda ou discorda
2. Se concorda, descreva a correção
3. Se discorda, justifique por quê

Atualize a spec e me diga o que mudou.
```

**Documente a Iteração 2**:

```markdown
## Iteração 2: QA Critique + Correção PM

### Issues do QA (resumo)
[Lista de issues com severidade]

### Resposta do PM
[Concordou/discordou de cada issue + ação]

### O que mudou na spec
[Diferenças entre draft da Iteração 1 e Iteração 2]
```

> **🏆 Checkpoint 2**: Iteração 2 documentada com issues e correções.

---

### Passo 4 — Iteração 3: QA re-critique + Aprovação

```
*exit

@qa

Quinn, o PM corrigiu baseado no seu critique. 

Verifique:
1. Cada issue critical e high foi resolvida?
2. As correções são substanciais (não cosméticas)?
3. Novas ambiguidades foram introduzidas?
4. A spec está pronta para implementação?

Se encontrar issues remanescentes, reporte. 
Se está satisfeito, APROVE a spec.

*critique-spec
```

**Cenário ideal**: QA aprova após 2-3 issues menores resolvidas. **Cenário real**: QA encontra 1-2 issues que a correção introduziu (efeito colateral). O PM corrige e o QA re-verifica.

Se o QA não aprovar na terceira iteração:

```
Quinn, já iteramos 3 vezes. Liste APENAS as issues 
que impedem aprovação (critical). Issues "nice to have" 
podem ser endereçadas durante implementação. Separe 
bloqueantes de melhorias.
```

**Documente a Iteração 3**:

```markdown
## Iteração 3: Re-critique + Aprovação

### Issues remanescentes
[Lista — deve ser curta]

### Resolução final
[Como cada issue bloqueante foi resolvida]

### Status: APROVADO ✅
[Data, quem aprovou, condições (se houver)]
```

> **🏆 Checkpoint 3 — VITÓRIA DA AULA**: Spec aprovada + 3 iterações documentadas.

---

### Passo 5 — Commit

```bash
*exit

git add .
git commit -m "docs: Content Engine spec approved after 3 iterations

- Spec with FRs for complete RAG pipeline
- Self-critique by PM (iteration 1)
- QA critique with domain-specific issues (iteration 2)
- Final approval after resolving blockers (iteration 3)
- spec-iterations.md documenting full evolution"
```

---

## Reflexão

### O que 3 iterações fizeram com a spec

Compare o draft da Iteração 1 com a versão final:

| Aspecto | Iteração 1 (draft) | Iteração 3 (aprovada) |
|---------|-------------------|-----------------------|
| FRs | Genéricos ("gerar conteúdo") | Específicos por step do pipeline RAG |
| NFRs | Vagos ("rápido", "bom") | Mensuráveis (< 3s resposta, 85%+ precisão) |
| Edge cases | Não cobertos | Documentação conflitante, chunk irrelevante, conceito sem análogo |
| Versionamento | Não mencionado | FR dedicado com estratégia de detecção |
| Testabilidade | Parcial | Cada FR com acceptance criteria verificável |

Essa evolução não é acidente — é o design do Spec Pipeline. Cada etapa (self-critique, QA critique, iteração) adiciona uma camada de rigor. A spec da Iteração 1 seria implementável, mas geraria retrabalho. A spec da Iteração 3 é um contrato sólido.

### O conceito-chave

> **O Spec Pipeline (Epic 3 do ADE) existe porque specs complexas não ficam prontas na primeira versão — nem na segunda. As 7 etapas com iterações forçam melhoria progressiva. Documentar cada iteração não é overhead — é a evidência de que a spec foi realmente trabalhada, não apenas escrita e aprovada de carimbo.**

### Conexão com a próxima aula

Na Aula 06, a spec aprovada do Content Engine não é implementada inteira de uma vez — é decomposta em subtasks e implementada via os 13 steps do Execution Engine (Epic 4). Mas aplicamos no Quiz Engine, não no Content Engine, para exercitar o mesmo rigor em outro subsistema e expandir a Plataforma em paralelo.

---

> **Anterior**: Aula 04 — Epic 1-2: Worktrees Avançados e Migration
> **Próxima**: Aula 06 — Epic 4: Execution Engine 13 Steps
