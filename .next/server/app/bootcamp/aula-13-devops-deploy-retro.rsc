2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","188","static/chunks/app/bootcamp/%5Blesson%5D/page-3b4cd11983f1559e.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T4465,# Aula 13 — DevOps: Containerização, Scheduling e Retrospectiva

<!-- metadata
module: 3
lesson: 13
title: "DevOps: Containerização, Scheduling e Retrospectiva"
duration: 3-4 horas
agents: "@devops, @qa"
project: AuctionHunter
phase: Entrega
prerequisites: Aula 12 concluída (pipeline completo + Recovery + QA aprovado)
-->

---

> **Módulo 3** · AuctionHunter: Recomeço Estruturado
> **Duração**: 3-4 horas
> **Agentes praticados**: `@devops`, `@qa`
> **Projeto**: AuctionHunter

---

## 🏆 Vitória desta aula

AuctionHunter containerizado, com scheduling automático para scraping periódico, observabilidade com métricas de sucesso/falha por layer, e retrospectiva do módulo inteiro consolidando os insights da Memory Layer.

**Critério binário**: `docker compose up` sobe o sistema completo → cron dispara scraping → métricas aparecem no dashboard → API responde com dados extraídos automaticamente.

---

## Conceito

### Containerização de pipelines de scraping: diferente de containerizar uma API

No RockQuiz (Aula 05), a containerização era de uma aplicação web clássica: API, banco, cache, frontend. Serviços long-running que sobem e ficam esperando requests.

O AuctionHunter é diferente. O pipeline de scraping é **batch** — roda periodicamente, processa fontes, persiste resultados e para. Os workers não ficam rodando 24/7 esperando requests; eles acordam, fazem o trabalho e dormem. Isso muda como os containers são orquestrados:

| Aspecto | RockQuiz (web app) | AuctionHunter (pipeline) |
|---------|-------------------|--------------------------|
| Lifecycle | Serviço long-running | Job batch periódico |
| Trigger | Request do usuário | Cron / scheduler |
| Falha | Retry individual por request | Retry do job inteiro ou parcial |
| Observabilidade | Latência, throughput | Taxa de sucesso, registros extraídos |
| Scaling | Mais instâncias da API | Mais workers em paralelo |

### Observabilidade de scraping: o que monitorar

A observabilidade do AuctionHunter precisa responder perguntas diferentes das do RockQuiz:

- **Quantas fontes processou na última execução?** (não "quantos requests por segundo")
- **Qual a taxa de sucesso por layer?** (Layer 1 extraiu 90%, Layer 2 extraiu 70%)
- **Quantos veículos foram extraídos vs esperados?** (50 veículos no PDF, extraiu 47)
- **Quantos registros são parciais?** (campos faltando que precisam de atenção)
- **Qual fonte falhou e por quê?** (timeout, captcha, PDF corrompido)

Sem essas métricas, o pipeline roda silenciosamente e você não sabe se está extraindo 100% ou 30% dos dados. Pior: não sabe se uma leiloeira mudou o site e o scraper está falhando toda semana sem aviso.

### O princípio aplicado

Você vai descrever ao DevOps as necessidades de entrega: "preciso que o pipeline rode sozinho toda semana e que eu saiba se está funcionando". **Não vai ditar** a configuração do cron, a estrutura do Docker Compose ou as queries do dashboard. O DevOps propõe, você avalia se atende.

---

## Contexto

Esta é a **última aula do AuctionHunter e do Módulo 3**. O pipeline completo foi implementado (Aulas 11-12): 3 layers de scraping, normalização, persistência, API e Recovery System. Esta aula empacota tudo em containers, automatiza a execução e adiciona visibilidade. Ao final, o AuctionHunter estará pronto para rodar de verdade — não como exercício de curso, mas como ferramenta funcional.

---

## Prática

### Passo 1 — Containerização do pipeline

```bash
cd ~/aiox-bootcamp/auctionhunter
claude
```

```
@devops

Dex-Ops, preciso containerizar o AuctionHunter completo. 
Leia o Architecture Doc (docs/architecture.md) para a 
definição dos serviços.

O sistema tem componentes com lifecycles diferentes:
- API de consulta: serviço long-running (fica rodando)
- Pipeline de scraping: job batch (roda periodicamente)
- Banco de dados: serviço long-running
- Workers de scraping: podem rodar em paralelo

Preciso de um Docker Compose que:
1. Suba a API + banco + serviços de suporte (sempre rodando)
2. Permita executar o pipeline de scraping como job (roda e para)
3. Isole dependências de scraping (Playwright, pdfplumber, etc.) 
   no container correto
4. Use multi-stage builds para manter as imagens leves

O RockQuiz tinha containers simples — aqui temos a 
complexidade adicional de jobs batch vs serviços 
long-running. Configure para que ambos coexistam.
```

**Como verificar**:

```bash
# Subir todo o stack
docker compose up -d

# Verificar que API e banco estão rodando
docker compose ps
curl http://localhost:8000/health

# Executar o pipeline como job
docker compose run --rm scraper python src/pipeline/run.py test-data/pdfs/edital-exemplo.pdf

# Verificar que dados chegaram ao banco via API
curl http://localhost:8000/api/vehicles | jq
```

> **Checklist de avaliação da containerização**
> - [ ] `docker compose up -d` sobe API + banco sem erro?
> - [ ] API responde no health check?
> - [ ] Pipeline de scraping roda como job separado (não fica rodando)?
> - [ ] O job de scraping acessa o banco que a API usa (rede compartilhada)?
> - [ ] Imagens usam multi-stage build (build stage separado de runtime)?
> - [ ] Dependências pesadas (Playwright, Chromium) estão só no container de scraping?

Se o Playwright não funcionar dentro do container:

```
Dex-Ops, o web scraper falha dentro do container porque 
o Playwright não encontra o Chromium. Containers headless 
precisam de dependências específicas (libnss3, libatk1.0, 
etc.) e o Chromium instalado. Use a imagem base do 
Playwright ou instale as dependências no Dockerfile.
```

Se os containers não se enxergarem:

```
Dex-Ops, o job de scraping não consegue conectar no banco. 
O container do pipeline e o container do PostgreSQL precisam 
estar na mesma rede Docker. Verifique o network do Compose.
```

> **🏆 Checkpoint 1**: Stack containerizada — API rodando + pipeline executável como job.

---

### Passo 2 — Scheduling automático

```
Dex-Ops, preciso que o pipeline de scraping rode 
automaticamente em intervalos regulares. Requisitos:

1. Scraping semanal: toda segunda-feira às 6h, o pipeline 
   processa as fontes configuradas (lista de URLs e caminhos 
   de PDF)
2. A lista de fontes deve ser configurável (arquivo ou 
   variável de ambiente — não hardcoded no código)
3. Se uma execução falhar, deve registrar o erro e NÃO 
   impedir a próxima execução agendada
4. Cada execução deve gerar um log com: início, fim, 
   fontes processadas, veículos extraídos, erros

Pode ser cron no container, Docker Compose com restart 
policy, ou outra abordagem — me explique o trade-off 
da sua escolha.
```

**Como verificar** (sem esperar a segunda-feira):

```bash
# Testar o scheduling manualmente
# O DevOps deve fornecer um comando para trigger imediato
docker compose run --rm scheduler python src/pipeline/schedule.py --now

# Ou o comando equivalente que ele configurou
# Verificar log da execução
docker compose logs scheduler
```

> **Checklist de avaliação do scheduling**
> - [ ] O scheduler está configurado com intervalo definido?
> - [ ] A lista de fontes é configurável (não hardcoded)?
> - [ ] Tem comando para trigger manual (para teste)?
> - [ ] O log da execução mostra: início, fim, fontes, resultados?
> - [ ] Falha em uma execução não bloqueia a próxima?
> - [ ] Múltiplas fontes são processadas na mesma execução?

Se a lista de fontes estiver hardcoded:

```
Dex-Ops, as URLs de leiloeiras estão hardcoded no script 
de scheduling. Preciso que sejam configuráveis — um arquivo 
sources.yaml ou variáveis de ambiente. Quando descobrir uma 
nova leiloeira, quero adicionar sem alterar código.
```

Se o log for insuficiente:

```
Dex-Ops, o log do scheduler diz apenas "execution complete". 
Preciso saber: quantas fontes processou, quantos veículos 
extraiu, quantas falhas houve e quais fontes falharam. 
Sem isso, não sei se o pipeline está saudável.
```

> **🏆 Checkpoint 2**: Scheduling funcionando com trigger manual verificado.

---

### Passo 3 — Observabilidade do pipeline

```
Dex-Ops, preciso de observabilidade para o AuctionHunter. 
As métricas que preciso são diferentes do RockQuiz — aqui 
o foco é saúde do PIPELINE, não latência de API.

Métricas essenciais:
1. Taxa de sucesso por layer (L1: X%, L2: Y%, L3: Z%)
2. Veículos extraídos por execução (total, completos, parciais)
3. Fontes processadas vs fontes com erro
4. Tempo de execução do pipeline por fonte
5. Registros no retry queue (fontes que falharam em todas as layers)
6. Trend: veículos extraídos ao longo do tempo (está crescendo 
   ou caindo? Se cair, algum scraper pode ter quebrado)

Configure Prometheus para coletar e Grafana com dashboards 
pré-provisionados — mesma abordagem do RockQuiz, mas com 
métricas de pipeline.

E configure um alerta: se a taxa de sucesso geral cair 
abaixo de 50%, algo está errado e eu preciso saber.
```

**Como verificar**:

```bash
# Rodar o pipeline para gerar métricas
docker compose run --rm scraper python src/pipeline/run.py test-data/pdfs/edital-exemplo.pdf

# Verificar endpoint de métricas
curl http://localhost:8000/metrics

# Abrir Grafana
# Verificar que dashboards de pipeline existem
# Verificar que métricas aparecem após execução
```

> **Checklist de avaliação da observabilidade**
> - [ ] Endpoint /metrics expõe métricas de pipeline (não apenas de API)?
> - [ ] Há métricas por layer? (taxa de sucesso L1, L2, L3)
> - [ ] Há métrica de veículos extraídos por execução?
> - [ ] Dashboard do Grafana está pré-provisionado?
> - [ ] Após rodar o pipeline, os gráficos mostram dados reais?
> - [ ] Alerta de taxa de sucesso < 50% está configurado?

Se as métricas forem só de API:

```
Dex-Ops, as métricas são de latência e requests da API — 
isso é o que o RockQuiz tinha. O AuctionHunter precisa de 
métricas de PIPELINE: quantos PDFs parseou, quantas páginas 
scrapeou, quantos veículos extraiu, quantos falharam. 
Essas métricas vêm do pipeline de scraping, não da API.
```

Se o dashboard não mostrar trends:

```
Dex-Ops, o dashboard mostra dados da última execução mas 
não mostra evolução ao longo do tempo. Preciso de um 
gráfico de "veículos extraídos por execução" que mostre 
a tendência. Se esse número cair de uma semana pra outra, 
pode significar que um scraper quebrou — é o alerta 
mais importante do sistema.
```

> **🏆 Checkpoint 3**: Observabilidade com métricas de pipeline + dashboards + alerta.

---

### Passo 4 — QA valida o sistema completo

```
*exit

@qa

Quinn, valide o AuctionHunter como sistema completo:

1. docker compose up sobe tudo sem erro?
2. Pipeline roda como job e extrai dados de fontes reais?
3. Recovery funciona? (alimente um PDF corrompido — não crasha?)
4. Dados normalizados estão acessíveis via API?
5. Scheduling funciona? (trigger manual → execução → logs)
6. Métricas aparecem no Grafana após execução?
7. Se eu adicionar uma nova fonte em sources.yaml, o 
   próximo run a processa?
```

> **Checklist de validação end-to-end**
> - [ ] Stack sobe e todos os serviços estão healthy?
> - [ ] Pipeline processa fontes e persiste dados?
> - [ ] Recovery preserva dados parciais em falha?
> - [ ] API retorna dados normalizados com filtros?
> - [ ] Scheduling funciona com trigger manual?
> - [ ] Grafana mostra métricas de pipeline reais?
> - [ ] Nova fonte é processada sem alterar código?

> **🏆 Checkpoint 4**: QA aprovou o sistema completo.

---

### Passo 5 — Memory Layer: consolidação do módulo

Este é o momento mais importante para a Memory Layer. Cinco aulas de trabalho acumularam insights — hora de consolidar:

```
@qa

Quinn, antes do commit final, consolide os insights de 
TODO o módulo AuctionHunter.

*exit

@dev

Dex, leia todos os *capture-insights do projeto 
(Layers 1, 2, 3, Normalizer, Recovery) e produza um 
documento de consolidação:

docs/memory-layer-consolidation.md

Esse documento deve conter:
1. Padrões de dados descobertos (formatos de placa, valor, 
   data, encoding)
2. Estratégias de extração que funcionaram vs falharam
3. Fragilidades conhecidas (self-critiques das 3 layers)
4. Insights sobre o domínio de leilões que não estavam 
   no domain map original
5. Recomendações para manutenção futura (o que vai 
   precisar de atenção quando fontes mudarem)

Esse documento é a memória persistente do projeto. Quando 
um scraper quebrar daqui a 3 meses, esse documento é o 
primeiro lugar para buscar contexto.

*capture-insights
```

> **🏆 Checkpoint 5**: Memory Layer consolidada em documento.

---

### Passo 6 — Commit e retrospectiva

```bash
*exit

git add .
git commit -m "infra: containerization, scheduling, observability, and memory consolidation

- Docker Compose: API (long-running) + scraper (batch job) + DB
- Scheduling: configurable sources, weekly cron, manual trigger
- Observability: pipeline metrics, per-layer success rates,
  Grafana dashboards, alert on <50% success
- Memory Layer consolidation: patterns, fragilities, recommendations"
```

---

## Reflexão

### Retrospectiva do Módulo 3: o que o AuctionHunter é agora

Cinco aulas transformaram um projeto abandonado em um sistema funcional:

```
Aula 09: @analyst        → Domínio mapeado + Failure Analysis honesta
Aula 10: @pm + @architect → PRD por layer + Arch Doc com fallback + 5 specs aprovadas
Aula 11: @dev            → 3 layers de scraping com Memory Layer
Aula 12: @dev + @qa      → Normalizer + API + Recovery System + QA aprovado
Aula 13: @devops + @qa   → Containers + Scheduling + Observabilidade
```

**9 de 11 agentes** usados (mesmos do RockQuiz, mas em contexto completamente diferente). Dois recursos AIOX que o RockQuiz não exercitou apareceram pela primeira vez:

- **ADE Recovery System**: Não simulado — exercitado com falhas reais de scraping (PDFs corrompidos, sites inacessíveis, dados parciais). O Recovery é o que torna o sistema viável em produção.
- **Memory Layer**: Insights acumularam de Layer 1 → Layer 2 → Layer 3 → Normalizer. Cada componente foi informado pelo anterior. O documento de consolidação (Passo 5) é a memória persistente do projeto.

### A narrativa do recomeço

Compare:

| | Tentativa anterior | Com AIOX (este módulo) |
|---|---|---|
| Início | Direto no código | 1 aula inteira de análise de domínio |
| Planejamento | Nenhum | PRD + Arch Doc + 5 specs iteradas com QA |
| Falha | Silenciosa (parser retorna vazio) | Recovery preserva dados parciais + log |
| Formato de dados | Cada parser no seu formato | Schema unificado via Normalizer |
| Manutenção | Impossível (sem documentação) | Memory Layer + observabilidade |
| Execução | Manual, quando lembrava | Scheduling automático semanal |
| Visibilidade | Zero (só abria o JSON e olhava) | Dashboards com métricas por layer |

Não é que o AIOX tenha tornado o scraping fácil — scraping continua sendo frágil, sites mudam, PDFs surpreendem. O que mudou é que agora existe **estrutura para lidar com a fragilidade**: fallback entre layers, recovery de dados parciais, observabilidade para detectar quando algo quebra, e documentação para saber como consertar.

### O conceito-chave

> **O AuctionHunter é a prova de que o valor do AIOX não está em fazer projetos fáceis — está em tornar projetos difíceis viáveis. Análise antes de código, specs antes de implementação, recovery quando falha, observabilidade para detectar. A metodologia não elimina a complexidade. Ela torna a complexidade gerenciável.**

### Conexão com o Módulo 4

O RockQuiz (Módulo 2) ensinou o pipeline. O AuctionHunter (Módulo 3) ensinou a aplicar o pipeline em domínio hostil com Recovery e Memory Layer.

No Módulo 4 (Aulas 14-18), entramos em **território novo**: Squads. O Squad LinkedIn Monitoragindo é um sistema de 6 agentes que produzem conteúdo com a sua voz para 4 vertentes editoriais. Não é mais um dev solo com agentes de suporte — é um time de agentes trabalhando em conjunto, com workflows por vertente, voice profiling e feedback loop data-driven.

E o Módulo 4 termina com brownfield real: migrar o protótipo do Google AI Studio para a nova arquitetura. Tudo que aprendemos sobre brownfield no AuctionHunter (failure analysis, migração estruturada) se aplica lá de forma mais profunda.

---

## Exercício extra (opcional)

1. Adicione uma nova fonte ao `sources.yaml` (uma leiloeira real que não estava nos testes). Rode o pipeline e veja se o sistema extrai dados sem alterar código. Se falhar, use o log e as métricas para diagnosticar por quê.

2. Provoque uma falha no scheduling: quebre propositalmente o acesso a uma fonte (URL inválida). Verifique que a próxima fonte é processada normalmente e que a falha aparece no dashboard.

3. Peça ao Dev para gerar um relatório de qualidade dos dados:

```
@dev
Dex, analise os dados extraídos e gere um relatório:
- Quantos registros completos vs parciais?
- Quais campos são os que mais faltam?
- Qual layer tem melhor taxa de extração completa?
- Documente em docs/data-quality-report.md
```

---

> **Anterior**: [Aula 12 — Dev: Normalização, API e Persistência](./aula-12-dev-normalization-api.md)
> **Próxima**: [Aula 14 — Squad LinkedIn: Arquitetura do Squad de Conteúdo](../modulo-04/aula-14-squad-architecture.md) *(Módulo 4)*
5:["lesson","aula-13-devops-deploy-retro","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["bootcamp",{"children":[["lesson","aula-13-devops-deploy-retro","d"],{"children":["__PAGE__?{\"lesson\":\"aula-13-devops-deploy-retro\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["bootcamp",{"children":[["lesson","aula-13-devops-deploy-retro","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"aula-13-devops-deploy-retro","module":"bootcamp","lessonIndex":12,"totalLessons":18,"nextLesson":"aula-14-squad-architecture","prevLesson":"aula-12-dev-normalization-api"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
