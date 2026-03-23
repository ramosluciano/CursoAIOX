2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","188","static/chunks/app/bootcamp/%5Blesson%5D/page-3b4cd11983f1559e.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T33e5,# Aula 16 — Backend de Persistência e Analytics

<!-- metadata
module: 4
lesson: 16
title: "Backend de Persistência e Analytics"
duration: 4-5 horas
agents: "@dev"
project: Squad LinkedIn Monitoragindo
phase: Desenvolvimento (Fase 2)
prerequisites: Aula 15 concluída (Voice Profile + 3 peças de conteúdo)
-->

---

> **Módulo 4** · Squad LinkedIn Monitoragindo
> **Duração**: 4-5 horas
> **Agentes praticados**: `@dev`
> **Projeto**: Squad LinkedIn Monitoragindo

---

## 🏆 Vitória desta aula

Backend funcional com persistência de posts em banco, integração com LinkedIn API para publicação e coleta de métricas, e snapshots de engajamento em D+1, D+3, D+7.

**Critério binário**: Post salvo no banco → publicado via API (ou simulado) → métricas coletadas e persistidas → consultáveis via endpoint.

---

## Conceito

### Do squad gerador ao squad produto

Na Aula 15, o squad gerou conteúdo — texto que você avaliou e aprovou. Mas conteúdo gerado e não publicado não tem valor. Conteúdo publicado sem métricas não gera aprendizado. Métricas sem análise não melhoram o próximo conteúdo.

O backend transforma o squad de um **gerador de texto** em um **produto de software**: conteúdo é persistido com metadata, publicação é automatizável, e métricas de engajamento alimentam um feedback loop. É a diferença entre "IA que escreve pra mim" e "sistema que gerencia minha presença no LinkedIn".

Isso conecta com algo que o RockQuiz e o AuctionHunter não tinham: **o output do sistema é consumido por pessoas reais (sua audiência), e o feedback delas (likes, comments, shares) é dado de entrada para melhorar o sistema**. É um loop fechado.

### LinkedIn API: publicação e coleta de métricas

A integração com o LinkedIn tem duas faces:

| Face | O que faz | Complexidade |
|------|-----------|-------------|
| **Publicação** | OAuth 2.0 → POST de conteúdo → post publicado | Média (OAuth flow) |
| **Coleta de métricas** | GET de analytics → likes, comments, impressions, shares | Média (rate limits, paginação) |

A publicação é um evento único. A coleta de métricas é **temporal** — o engajamento de um post evolui ao longo dos dias. Um post pode ter 10 likes em D+1, 50 em D+3 e 80 em D+7. Por isso coletamos snapshots em intervalos: D+1, D+3, D+7. Esses snapshots são a matéria-prima do analytics na Aula 17.

### O princípio aplicado

Você vai descrever ao Dev as necessidades de persistência e integração. **Não vai ditar** o schema do banco, o fluxo de OAuth ou a estratégia de coleta. O Dev lê as stories (criadas na Aula 14) e o Architecture Doc. Você verifica se a integração funciona e se os dados fazem sentido.

---

## Contexto

O squad gera conteúdo (Aula 15). Agora o @dev constrói a infraestrutura que sustenta esse conteúdo: onde salvar, como publicar, como medir. Na Aula 17, o @dev constrói analytics sobre esses dados. Na Aula 18, tudo se conecta em automação end-to-end + brownfield.

---

## Prática

### Passo 1 — Schema de persistência

```bash
cd ~/aiox-bootcamp/linkedin-squad
claude
```

```
@dev

Dex, leia as stories de backend em docs/stories/ e o 
Architecture Doc em docs/architecture.md.

Implemente o schema de banco de dados para o Squad 
LinkedIn. O sistema precisa persistir:

1. POSTS: cada conteúdo gerado pelo squad
   - Texto do post, vertente editorial, hashtags
   - Status: draft, approved, published, archived
   - Metadata: data de geração, agentes que participaram, 
     Voice Profile version usada
   - Referência ao post no LinkedIn (após publicação)

2. MÉTRICAS: snapshots de engajamento
   - Likes, comments, impressions, shares, saves
   - Timestamp do snapshot (D+1, D+3, D+7)
   - Vinculado ao post

3. VOICE PROFILES: versionamento do perfil de voz
   - Versão atual e histórico
   - Quais posts foram usados como input
   - Data de geração

4. ENGAGEMENT PATTERNS: padrões identificados (Aula 17)
   - Reservar estrutura para analytics

Consulte o Architecture Doc para decisões de stack (banco, 
ORM). Siga os acceptance criteria das stories.
```

**Como verificar**:

```bash
# Subir banco
docker compose up -d

# Rodar migrations
npm run db:migrate  # ou o comando que o Dev configurou

# Verificar que tabelas existem
npm run db:studio  # ou psql direto
```

> **Checklist de avaliação do schema**
> - [ ] Tabela de posts tem todos os campos necessários?
> - [ ] Tabela de métricas tem relação com posts (FK)?
> - [ ] Snapshots permitem múltiplas coletas por post (D+1, D+3, D+7)?
> - [ ] Voice Profile tem versionamento?
> - [ ] Status do post é enum (draft/approved/published/archived)?
> - [ ] Há campo de vertente editorial (quiz/artigo/ia-sexta/mentalidade)?

Se o schema não suportar snapshots temporais:

```
Dex, o schema de métricas tem uma row por post. Preciso 
de MÚLTIPLAS rows por post — uma para cada snapshot 
(D+1, D+3, D+7). O engajamento evolui ao longo do tempo, 
e preciso rastrear essa evolução. A relação é: 1 post → 
N snapshots de métricas, cada um com timestamp.
```

Se faltar o versionamento do Voice Profile:

```
Dex, o Voice Profile não tem versionamento. Quando eu 
refizer a análise de voz (com mais posts ou padrões 
revisados), preciso saber qual versão do perfil gerou 
cada post. Adicione versão ao Voice Profile e referência 
no post.
```

> **🏆 Checkpoint 1**: Schema de banco funcional com migrations rodando.

---

### Passo 2 — Integração LinkedIn API: publicação

```
Dex, implemente a integração com a LinkedIn API para 
publicação de posts.

Requisitos:
1. Fluxo OAuth 2.0 para autenticação
2. Endpoint para publicar um post (pegar do banco, 
   formatar e enviar via API)
3. Salvar referência do post publicado (LinkedIn post ID)
4. Atualizar status do post para "published"
5. Tratar erros da API (rate limit, auth expirado, 
   formato inválido)

IMPORTANTE: Se a LinkedIn API não estiver disponível 
no ambiente de desenvolvimento (sem credenciais OAuth 
reais), implemente um MODO SIMULADO que:
- Simula a publicação (retorna fake ID)
- Loga o que SERIA enviado
- Permite testar o fluxo inteiro sem API real
- Pode ser alternado via variável de ambiente 
  (LINKEDIN_MODE=real|simulated)

O modo simulado é essencial para desenvolvimento e 
testes. O modo real é ativado em produção com credenciais.
```

**Como verificar**:

```bash
# Salvar um post via API interna
curl -X POST http://localhost:3000/api/posts \
  -H "Content-Type: application/json" \
  -d '{"content":"Teste de publicação","vertical":"quiz","hashtags":["#zabbix"]}' | jq

# Publicar (modo simulado)
curl -X POST http://localhost:3000/api/posts/1/publish | jq

# Verificar status
curl http://localhost:3000/api/posts/1 | jq
# Status deve ser "published", linkedin_post_id deve existir
```

> **Checklist de avaliação da publicação**
> - [ ] Post é salvo como draft no banco?
> - [ ] Publicação muda status para "published"?
> - [ ] LinkedIn post ID é armazenado (fake em modo simulado)?
> - [ ] Modo simulado funciona sem credenciais reais?
> - [ ] Erro de publicação não corrompe o post no banco?
> - [ ] Rate limiting da API é respeitado?

Se não houver modo simulado:

```
Dex, a integração só funciona com credenciais OAuth reais. 
Em desenvolvimento, preciso de modo simulado — sem 
credenciais, sem chamadas reais à API do LinkedIn. 
O modo simulado deve reproduzir o fluxo inteiro 
(salvar, "publicar", retornar fake ID) para que eu 
possa testar e desenvolver sem depender de acesso real.
```

> **🏆 Checkpoint 2**: Publicação funcionando (modo simulado).

---

### Passo 3 — Coleta de métricas com snapshots

```
Dex, implemente a coleta de métricas de engajamento.

O fluxo:
1. Para cada post publicado, coletar métricas em 3 momentos:
   - D+1: 24 horas após publicação
   - D+3: 72 horas após publicação
   - D+7: 7 dias após publicação
2. Cada coleta salva um snapshot com: likes, comments, 
   impressions, shares, saves, timestamp
3. A coleta é automatizável (cron job) — não manual

Em modo simulado, gerar métricas fake mas REALISTAS:
- D+1: valores iniciais (ex: 15-30 likes, 2-5 comments)
- D+3: crescimento (ex: 40-80 likes, 5-15 comments)
- D+7: estabilização (ex: 60-120 likes, 8-20 comments)
- Variação por vertente (quizzes tendem a ter mais 
  comments, artigos mais saves)

Métricas fake realistas são essenciais para desenvolver 
o analytics na Aula 17 sem depender de dados reais.
```

**Como verificar**:

```bash
# Publicar um post (modo simulado)
curl -X POST http://localhost:3000/api/posts/1/publish | jq

# Coletar métricas D+1 (trigger manual)
curl -X POST http://localhost:3000/api/posts/1/collect-metrics?snapshot=d1 | jq

# Coletar D+3 e D+7
curl -X POST http://localhost:3000/api/posts/1/collect-metrics?snapshot=d3 | jq
curl -X POST http://localhost:3000/api/posts/1/collect-metrics?snapshot=d7 | jq

# Ver métricas do post
curl http://localhost:3000/api/posts/1/metrics | jq
# Deve mostrar 3 snapshots com evolução temporal
```

> **Checklist de avaliação das métricas**
> - [ ] Snapshots D+1, D+3, D+7 são coletados e persistidos?
> - [ ] Cada snapshot tem timestamp e todos os campos de engajamento?
> - [ ] Métricas simuladas são realistas (não zeros nem milhões)?
> - [ ] Métricas variam por vertente em modo simulado?
> - [ ] API retorna evolução temporal (3 snapshots ordenados)?
> - [ ] Coleta é idempotente (rodar 2x D+1 não duplica)?

Se os snapshots não mostrarem evolução:

```
Dex, os 3 snapshots de métricas têm valores idênticos. 
Na realidade, o engajamento cresce com o tempo — D+1 < D+3 
< D+7 (com exceções, mas a tendência é de crescimento). 
O gerador de métricas simuladas precisa modelar essa 
evolução para que o analytics funcione de forma realista.
```

> **🏆 Checkpoint 3**: Métricas coletadas com evolução temporal.

---

### Passo 4 — Pipeline squad → banco → publicação

Conectar o squad com o backend — o conteúdo gerado pelo squad é persistido e publicável:

```
Dex, agora conecte o squad ao backend. O fluxo completo:

1. Squad gera conteúdo (output/quiz-da-semana.md)
2. Conteúdo é salvo no banco como draft (com vertente, 
   hashtags, metadata)
3. Após aprovação humana, é publicado via API
4. Métricas começam a ser coletadas

Implemente um endpoint ou script que:
- Leia os arquivos de output do squad
- Parse metadata (vertente, hashtags)
- Salve como draft no banco
- Retorne o ID para publicação posterior

Quero poder fazer: squad gera → salva no banco → eu reviso 
→ aprovo → publica → coleta métricas. Todo o fluxo.
```

**Como verificar**:

```bash
# Importar conteúdo do squad para o banco
curl -X POST http://localhost:3000/api/posts/import \
  -H "Content-Type: application/json" \
  -d '{"file":"output/quiz-da-semana.md"}' | jq

# Listar drafts
curl http://localhost:3000/api/posts?status=draft | jq

# Aprovar
curl -X PATCH http://localhost:3000/api/posts/1 \
  -d '{"status":"approved"}' | jq

# Publicar
curl -X POST http://localhost:3000/api/posts/1/publish | jq

# Coletar métricas
curl -X POST http://localhost:3000/api/posts/1/collect-metrics?snapshot=d1 | jq
```

> **🏆 Checkpoint 4 — VITÓRIA DA AULA**: Pipeline squad → banco → publicação → métricas funcionando.

---

### Passo 5 — Commit

```bash
*exit

git add .
git commit -m "feat: backend persistence, LinkedIn API integration, metrics collection

- PostgreSQL schema: posts, metrics snapshots, voice profiles
- LinkedIn API integration with OAuth 2.0 (real + simulated modes)
- Metrics collection: D+1, D+3, D+7 snapshots with temporal evolution
- Squad → database → publish → collect pipeline
- Realistic simulated metrics for development"
```

---

## Reflexão

### Squad + Backend = Produto

| Só squad (Aula 15) | Squad + Backend (esta aula) |
|--------------------|-----------------------------|
| Gera texto em arquivos | Gera texto persistido em banco |
| Publicação manual (copy-paste) | Publicação via API |
| Sem métricas | Snapshots de engajamento D+1/D+3/D+7 |
| Sem histórico | Todo post rastreável com metadata |
| Cada execução é isolada | Voice Profile versionado, posts linkados |

O backend é o que torna o squad **sustentável**. Sem ele, cada semana você geraria conteúdo, publicaria manualmente, e não teria registro do que funcionou. Com ele, tudo é rastreável — e na Aula 17, esses dados viram inteligência.

### O conceito-chave

> **O @dev no contexto de squads não constrói o produto final — constrói a infraestrutura que sustenta o squad. O squad gera conteúdo; o backend persiste, publica, coleta e organiza. Juntos, formam um produto de software com feedback loop.**

### Conexão com a próxima aula

Na Aula 17, o @dev constrói analytics sobre os dados de métricas: padrões de engajamento por vertente, por horário, por tipo de hook. E o feedback loop se fecha — padrões de sucesso alimentam o Content Writer para gerar conteúdo que performa melhor.

---

> **Anterior**: [Aula 15 — Voice Analysis e Geração de Conteúdo](./aula-15-voice-content.md)
> **Próxima**: [Aula 17 — Analytics de Engajamento e Padrões](./aula-17-analytics-patterns.md)
5:["lesson","aula-16-backend-persistence","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["bootcamp",{"children":[["lesson","aula-16-backend-persistence","d"],{"children":["__PAGE__?{\"lesson\":\"aula-16-backend-persistence\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["bootcamp",{"children":[["lesson","aula-16-backend-persistence","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"aula-16-backend-persistence","module":"bootcamp","lessonIndex":15,"totalLessons":18,"nextLesson":"aula-17-analytics-patterns","prevLesson":"aula-15-voice-content"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
