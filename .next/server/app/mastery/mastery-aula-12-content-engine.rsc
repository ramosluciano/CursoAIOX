2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T24c0,# Aula 12 — Content Engine com RAG

<!-- metadata
course: Mastery
module: 4
lesson: 12
title: "Content Engine com RAG"
duration: 5-6 horas
agents: "@dev, @zabbix-expert, @qa"
project: Plataforma Zabbix Learning
phase: Desenvolvimento Core
prerequisites: Aula 11 concluída (auth + multi-tenant)
-->

---

> **Módulo 4** · Plataforma Zabbix: Desenvolvimento Core
> **Duração**: 5-6 horas
> **Agentes praticados**: `@dev`, `@zabbix-expert`, `@qa`
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

Content Engine gerando aulas sobre Zabbix a partir da documentação oficial via RAG pipeline, com o @zabbix-expert participando da geração e renderização de Markdown em componentes React.

**Critério binário**: Documentação Zabbix ingerida → query sobre conceito → aula gerada em Markdown com qualidade validada → renderizada na UI.

---

## Conceito

### RAG Pipeline: a fábrica de conteúdo educacional

O Content Engine é o subsistema mais impactante da plataforma — é ele que gera as centenas de aulas que os alunos consomem. O pipeline RAG transforma documentação técnica densa em conteúdo educacional acessível:

```
Documentação oficial Zabbix
  → Chunk (dividir por conceito)
  → Embed (gerar vetores)
  → Store (vector database)
       ↓
Query ("Explique LLD", nível intermediário)
  → Retrieve (chunks relevantes)
  → Generate (@zabbix-expert + contexto)
  → Output (Markdown estruturado)
       ↓
Renderização (Markdown → React components)
```

Cada decisão do pipeline afeta a qualidade final:

| Decisão | Impacto na qualidade |
|---------|---------------------|
| Chunk size pequeno | Mais preciso, mas pode perder contexto |
| Chunk size grande | Mais contexto, mas pode incluir ruído |
| Chunk overlap | Evita cortar conceitos no meio |
| Embedding model | Qualidade da busca por similaridade |
| Retrieval top-k | Quantos chunks alimentam a geração |
| Prompt de geração | Tom, formato, profundidade da aula |

### @zabbix-expert no pipeline

O @zabbix-expert (criado na Aula 02) não é apenas validador — ele **participa da geração**. O pipeline usa o agente como gerador com contexto RAG: os chunks relevantes são o conhecimento, o @zabbix-expert é a voz que transforma documentação em aula acessível.

---

## Contexto

Auth e multi-tenancy estão prontos (Aula 11). O Content Engine é o segundo subsistema — e o que mais define o valor da plataforma. A spec do Content Engine foi aprovada após 3 iterações na Aula 05. A taxonomia de conteúdo foi definida na Aula 08. Agora implementamos.

---

## Prática

### Passo 1 — Ingestão da documentação Zabbix

```bash
cd ~/aiox-mastery/zabbix-platform
cd feature/content-engine  # worktree da Aula 04
claude
```

```
@dev

Dex, implemente o pipeline de ingestão da documentação 
Zabbix. Consulte docs/specs/content-engine.md (spec 
aprovada na Aula 05).

Pipeline de ingestão:
1. Carregar documentação (markdown/HTML da doc oficial)
2. Preprocessing: limpar formatação, extrair texto útil
3. Chunking: dividir por conceito — NÃO por tamanho fixo.
   Cada chunk deve cobrir um conceito coeso.
   Use overlap de 10-15% para evitar cortes no meio 
   de explicações
4. Embedding: gerar embeddings dos chunks
5. Storage: armazenar no vector store configurado

Decisões do Architecture Doc:
- Chunk size e overlap conforme spec
- Embedding model conforme decisão da Aula 08
- Vector store conforme infra da Aula 10
```

**Como verificar**:

```bash
# Rodar ingestão
npm run content:ingest -- --source=docs/zabbix-docs/

# Verificar chunks no vector store
curl http://localhost:3000/api/content/chunks/stats | jq
# Deve mostrar: total de chunks, distribuição por conceito

# Testar busca por similaridade
curl -X POST http://localhost:3000/api/content/search \
  -d '{"query":"Low-Level Discovery"}' | jq
# Deve retornar chunks relevantes sobre LLD
```

> **Checklist de ingestão**
> - [ ] Documentação carregada e parseada sem erros?
> - [ ] Chunking respeita limites semânticos?
> - [ ] Overlap evita cortes no meio de conceitos?
> - [ ] Embeddings gerados e armazenados?
> - [ ] Busca por similaridade retorna chunks relevantes?
> - [ ] Chunks irrelevantes não poluem resultados?

Se a busca retornar chunks irrelevantes:

```
Dex, a busca por "trigger expressions" retorna chunks 
sobre instalação do Zabbix. O chunking provavelmente 
está quebrando por tamanho fixo sem respeitar fronteiras 
de conceito. Revise: cada chunk deve ser sobre UM 
conceito. Se o documento muda de assunto, é um novo chunk.
```

> **🏆 Checkpoint 1**: Documentação ingerida com busca funcional.

---

### Passo 2 — Geração de aulas via RAG

```
Dex, implemente a geração de aulas via RAG.

Fluxo:
1. Input: tema, nível (da taxonomia da Aula 08), formato
2. Retrieve: buscar top-k chunks relevantes no vector store
3. Augment: montar prompt com chunks + instruções + Voice Profile
4. Generate: @zabbix-expert gera aula usando contexto
5. Validate: verificar contra checklist zabbix-lesson-quality.md
6. Output: aula em Markdown estruturado

Use o workflow generate-zabbix-lesson criado na Aula 03.

O prompt de geração deve instruir o @zabbix-expert a:
- Usar linguagem acessível (não copiar documentação)
- Incluir exemplos práticos de configuração
- Mencionar armadilhas comuns
- Adaptar profundidade ao nível solicitado
- Referenciar conceitos pré-requisitos
```

**Teste com conceito real**:

```bash
curl -X POST http://localhost:3000/api/content/generate \
  -H "Content-Type: application/json" \
  -d '{"topic":"Zabbix LLD","level":"intermediate","format":"text"}' | jq
```

> **Checklist de geração**
> - [ ] Aula gerada é tecnicamente correta? (validar manualmente)
> - [ ] Usa linguagem acessível (não é doc copiada)?
> - [ ] Inclui exemplos práticos de configuração?
> - [ ] Menciona armadilhas comuns?
> - [ ] Nível adequado ao solicitado?
> - [ ] Passa no checklist zabbix-lesson-quality.md?

Se o conteúdo for documentação copiada:

```
Dex, a aula gerada é basicamente a documentação oficial 
reformatada. O @zabbix-expert deve TRANSFORMAR a 
documentação em conteúdo educacional: começar com 
contexto ("por que LLD existe"), explicar com analogia, 
dar exemplo prático, alertar sobre erros comuns. 
Ajuste o prompt de geração.
```

Se o RAG retornar contexto insuficiente:

```
Dex, a aula sobre triggers está superficial porque o 
RAG retornou poucos chunks relevantes. Aumente o top-k 
ou revise o chunking — conceitos complexos precisam de 
mais contexto para gerar aulas com profundidade.
```

> **🏆 Checkpoint 2**: Geração de aulas via RAG com qualidade validada.

---

### Passo 3 — Renderização Markdown → React

```
Dex, implemente a renderização de conteúdo:

1. Markdown → componentes React
2. Syntax highlighting para configurações Zabbix 
   (trigger expressions, item keys, API calls)
3. Blocos de código com copy button
4. Imagens e diagramas inline
5. Navegação entre seções da aula
6. Feature gating: conteúdo premium mostra preview 
   com overlay "Upgrade para acessar"
```

> **Checklist de renderização**
> - [ ] Markdown renderiza corretamente (headings, lists, code)?
> - [ ] Syntax highlighting funciona para configs Zabbix?
> - [ ] Code blocks têm copy button?
> - [ ] Navegação entre seções funciona?
> - [ ] Feature gating mostra preview para conteúdo premium?

> **🏆 Checkpoint 3**: Renderização completa e gatada por plano.

---

### Passo 4 — QA review do Content Engine

```
*exit

@qa

Quinn, review do Content Engine completo.

Foco:
- Qualidade das aulas geradas (precisão técnica, 
  acessibilidade, exemplos práticos)
- Performance do RAG (tempo de resposta aceitável?)
- Feature gating funciona (free vs premium)?
- Edge cases: query sobre conceito que não existe na doc?
  Query muito ampla ("Zabbix")? Query em outro idioma?

*review-build
```

Ciclo de correções.

> **🏆 Checkpoint 4 — VITÓRIA DA AULA**: Content Engine gerando e renderizando aulas.

---

### Passo 5 — Commit

```bash
*exit
git add .
git commit -m "feat: Content Engine with RAG pipeline for Zabbix educational content

- Documentation ingestion: semantic chunking + embedding + vector storage
- RAG-powered lesson generation with @zabbix-expert
- Quality validation against zabbix-lesson-quality checklist
- Markdown rendering to React with syntax highlighting
- Feature gating: free preview with upgrade overlay
- QA review approved"
```

---

## Reflexão

### O conceito-chave

> **O Content Engine é a prova de que RAG não é buzzword — é arquitetura. Cada decisão (chunk size, embedding model, retrieval strategy, generation prompt) impacta diretamente a qualidade do conteúdo. O @zabbix-expert como agente especialista no pipeline garante que a IA não inventa — ela explica com base na documentação oficial, traduzindo complexidade técnica em aprendizado acessível.**

### Conexão com a próxima aula

Na Aula 13, o Quiz Engine se integra com o Content Engine: quizzes são gerados a partir do conteúdo das aulas, e o Learning Path usa resultados de quiz para adaptar a jornada do aluno.

---

> **Anterior**: [Aula 11 — Auth, Multi-Tenant e Billing](./aula-11-auth-billing.md)
> **Próxima**: [Aula 13 — Quiz Engine Gamificado + Learning Path](./aula-13-quiz-learning-path.md)
5:["lesson","mastery-aula-12-content-engine","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-12-content-engine","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-12-content-engine\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-12-content-engine","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-12-content-engine","module":"mastery","lessonIndex":11,"totalLessons":22,"nextLesson":"mastery-aula-13-quiz-learning-path","prevLesson":"mastery-aula-11-auth-billing"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
