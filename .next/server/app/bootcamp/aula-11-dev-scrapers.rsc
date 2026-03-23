2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","188","static/chunks/app/bootcamp/%5Blesson%5D/page-3b4cd11983f1559e.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T4f48,# Aula 11 — Dev: Implementando os Scrapers

<!-- metadata
module: 3
lesson: 11
title: "Dev: Implementando os Scrapers"
duration: 5-6 horas
agents: "@dev, @devops"
project: AuctionHunter
phase: Desenvolvimento (Fase 2)
prerequisites: Aula 10 concluída (PRD + Arch Doc + 5 specs aprovadas)
-->

---

> **Módulo 3** · AuctionHunter: Recomeço Estruturado
> **Duração**: 5-6 horas
> **Agentes praticados**: `@dev`, `@devops`
> **Projeto**: AuctionHunter

---

## 🏆 Vitória desta aula

Três layers de scraping implementadas e funcionando com dados reais de teste: PDF parser extraindo veículos de editais, web scraper navegando sites de leiloeiras, e auth scraper lidando com login.

**Critério binário**: Alimentar cada layer com input real (PDF de edital, URL de leiloeira) e receber dados de veículos extraídos no formato intermediário definido na spec.

---

## Conceito

### ADE Execution Engine: os 13 steps na prática

No RockQuiz, o Dev implementou stories — o fluxo era: ler story → implementar → verificar acceptance criteria. Funcionou porque o domínio era previsível: CRUD, quiz engine, scoring. Tudo determinístico.

No AuctionHunter, o domínio é **não-determinístico**. Um PDF pode ter tabelas, outro texto corrido, outro imagens escaneadas. A mesma leiloeira pode mudar o layout do site entre uma semana e outra. O Dev vai implementar e **vai encontrar falhas** — não por incompetência, mas porque scraping é inerentemente frágil.

O ADE Execution Engine estrutura a implementação em 13 steps para que falhas sejam detectadas cedo e tratadas com método:

| Step | O que faz | Por que importa aqui |
|------|-----------|---------------------|
| 1-3 | Analisar spec + planejar subtasks | Decompor cada layer em partes testáveis |
| 4-6 | Implementar subtasks | Código real, layer por layer |
| 7-8 | Integrar + testar | Verificar com dados reais (não mocks) |
| 9 | Edge cases | PDFs malformados, sites offline, timeouts |
| 10 | **Self-critique** | Dev avalia seu próprio código honestamente |
| 11-12 | Refinar + documentar | Melhorar baseado na self-critique |
| 13 | Capturar insights | Memory Layer: o que aprendeu nesta layer |

O step 10 (self-critique) é particularmente importante em scraping: o Dev precisa perguntar "onde meu parser vai quebrar?" antes que quebre em produção.

### Memory Layer: aprendizados entre layers

Cada layer de scraping vai gerar insights: "PDFs da leiloeira X usam encoding latin1", "o site Y carrega dados via JavaScript depois de 3 segundos", "campos de valor às vezes têm 'lance mínimo' em vez de 'valor mínimo'".

O `*capture-insights` ao final de cada layer alimenta a Memory Layer. Quando o Dev começa a Layer 2, os insights da Layer 1 já estão disponíveis. Quando começa a Layer 3, tem insights de L1 e L2. O conhecimento acumula — e isso é o que faltou na tentativa anterior, onde cada parser era uma ilha isolada.

### O princípio aplicado

Você vai apontar o Dev para a spec de cada layer e deixar ele implementar seguindo os 13 steps. Seu papel é: fornecer dados reais de teste (PDFs, URLs), verificar se a extração produz dados corretos, e pedir ajustes quando o output não bater. **Não vai ditar** a lógica de parsing, a estratégia de seletores CSS ou a ordem de extração.

---

## Contexto

As 5 specs foram aprovadas pelo QA na Aula 10. Nesta aula, implementamos as 3 layers de scraping (specs 1, 2 e 3). A Aula 12 cobre as specs 4 e 5 (normalização, API e persistência). Cada layer é desenvolvida com worktree isolado para evitar interferência, e cada uma culmina com `*capture-insights` para alimentar a Memory Layer.

Esta é a aula mais longa do módulo porque scraping exige iteração: o primeiro parsing raramente funciona perfeito. É normal rodar, ver que extraiu 8 de 12 campos, ajustar, rodar de novo. Esse ciclo é o ADE em ação.

---

## Prática

### Passo 1 — Preparar worktrees e dados de teste

Antes de implementar, isolar cada layer em worktree e preparar dados reais:

```bash
cd ~/aiox-bootcamp/auctionhunter
claude
```

```
@devops

Dex-Ops, preciso de worktrees isolados para implementar 
cada layer de scraping em paralelo, sem que o código de 
uma interfira na outra.

Crie:
- feature/layer-1-pdf — para o PDF parser
- feature/layer-2-web — para o web scraper
- feature/layer-3-auth — para o auth scraper

Também preciso da infraestrutura base do projeto configurada:
- Estrutura de diretórios conforme o Architecture Doc
- Dependências do projeto instaladas
- Docker Compose com os serviços que o Arch Doc define 
  para desenvolvimento

Consulte docs/architecture.md para a stack e estrutura.

*create-worktree
```

**Em paralelo, prepare dados de teste reais**. Scraping só se valida com dados reais — mocks escondem os problemas:

```bash
# Criar diretório de dados de teste
mkdir -p test-data/pdfs test-data/urls

# Baixar 2-3 PDFs reais de editais de leilão
# (busque em sites de DETRAN ou leiloeiras — são públicos)
# Coloque em test-data/pdfs/

# Listar 2-3 URLs reais de leiloeiras com listagens navegáveis
# Salve em test-data/urls/sites.txt
```

> **Importante**: Use editais REAIS. PDFs fabricados para teste não exercitam os problemas reais: encoding, formatação inconsistente, campos em posições inesperadas. Se não tiver PDFs à mão, busque "edital leilão veículos apreendidos" em sites de DETRAN estaduais — são documentos públicos.

> **🏆 Checkpoint 1**: Worktrees criados + dados de teste reais disponíveis.

---

### Passo 2 — Layer 1: PDF Parser

Mude para o worktree da Layer 1 e aponte o Dev para a spec:

```bash
# Mudar para o worktree da Layer 1
cd feature/layer-1-pdf  # ou o caminho que o DevOps configurou
claude
```

```
@dev

Dex, leia a spec do PDF Parser em docs/specs/ 
e o Architecture Doc em docs/architecture.md.

Implemente o PDF Parser seguindo os 13 steps do ADE. 
Esta layer é responsável por:
- Receber um arquivo PDF de edital de leilão
- Extrair dados de veículos (placa, chassi, marca, modelo, 
  ano, cor, valor, lote, etc.)
- Retornar os dados no formato intermediário definido na spec

Tenho PDFs reais de teste em test-data/pdfs/. Use-os para 
validar a implementação — não crie dados fictícios.

Atenção especial ao que o failure analysis apontou: na 
tentativa anterior, regex hard-coded para posição fixa 
quebrava entre editais de leiloeiras diferentes. A solução 
precisa ser mais robusta que regex posicional.

Comece pela análise da spec (steps 1-3) e me mostre o 
plano de subtasks antes de implementar.
```

**O que esperar nos steps 1-3**: O Dev vai decompor a spec em subtasks. Para um PDF parser, algo como:

- Subtask 1: Detectar tipo de PDF (tabular, texto corrido, escaneado)
- Subtask 2: Extrair dados de PDFs tabulares (pdfplumber tables)
- Subtask 3: Extrair dados de PDFs texto corrido (parsing de blocos)
- Subtask 4: Fallback LLM para campos não extraídos
- Subtask 5: Validar dados extraídos contra schema

**Como avaliar o plano**:

> **Checklist de avaliação do plano de subtasks**
> - [ ] Há detecção do tipo de PDF (não assume que todos são iguais)?
> - [ ] Há mais de uma estratégia de extração (não depende só de regex)?
> - [ ] Há fallback para quando a estratégia principal falha?
> - [ ] Há validação dos dados extraídos?
> - [ ] As subtasks são testáveis individualmente?

Se o plano for simplista:

```
Dex, o plano tem uma subtask única "extrair dados do PDF". 
Isso é o que fiz na tentativa anterior — e falhou. O domain 
map identifica pelo menos 3 tipos de PDF com estratégias 
diferentes. Decomponha em subtasks que tratem cada tipo.
```

**Após implementação (steps 4-8)**, teste com os PDFs reais:

```bash
# Rodar o parser contra um PDF de teste
python src/layers/pdf_parser.py test-data/pdfs/edital-exemplo.pdf

# Ou o comando que o Dev definiu — verifique no código
```

**Verificar o output**:

> **Checklist de verificação da Layer 1**
> - [ ] Extraiu veículos do PDF? (não retornou vazio)
> - [ ] Os campos obrigatórios estão presentes? (placa, marca, modelo no mínimo)
> - [ ] Os dados estão corretos? (compare manualmente com o PDF — abra e confira)
> - [ ] Funciona para mais de um PDF? (teste com os 2-3 que você baixou)
> - [ ] Quando um campo não é encontrado, retorna null/None (não inventa dado)?

Se a extração estiver incompleta:

```
Dex, o parser extraiu placa e modelo mas não extraiu valor 
mínimo e data do leilão. Esses campos estão no PDF — abri 
e confirmei. Verifique a lógica de extração para esses 
campos. Pode ser que estejam em posição diferente do que 
o parser espera.
```

Se funcionar para um PDF mas não para outro:

```
Dex, o parser funciona para edital-01.pdf mas retorna 
zero veículos para edital-02.pdf. Abri o segundo PDF e 
os dados estão lá, mas em formato diferente (texto corrido 
em vez de tabela). Esse é exatamente o problema que tivemos 
antes. A detecção de tipo de PDF precisa funcionar para 
ambos os formatos.
```

**Step 10 — Self-critique**:

```
Dex, hora da self-critique. Olhe para o código do PDF 
Parser e me diga honestamente:

1. Onde esse parser VAI quebrar? (qual formato de PDF 
   ele não suporta?)
2. Quais heurísticas são frágeis? (o que depende de 
   posição ou formato específico?)
3. Se eu alimentar com 100 PDFs diferentes, qual 
   porcentagem você estima que vai parsear corretamente?
4. O que melhoraria a robustez mas você não implementou 
   ainda?

*track-attempt
```

A honestidade da self-critique é mais valiosa que otimismo. Se o Dev diz "funciona para tudo", desconfie. Se diz "funciona para tabulares mas PDFs com texto corrido dependem de heurística de quebra de bloco que pode falhar", isso é útil.

**Step 13 — Capturar insights da Layer 1**:

```
*capture-insights

Dex, registre os insights da implementação da Layer 1:
- Quais tipos de PDF encontrou nos dados de teste?
- Quais estratégias de extração funcionaram melhor?
- Quais campos foram mais difíceis de extrair e por quê?
- Que padrões de dados apareceram? (formato de placa, 
  encoding, separadores)

Esses insights vão ser usados nas próximas layers e na 
normalização.
```

> **🏆 Checkpoint 2**: Layer 1 extraindo dados de PDFs reais + self-critique documentada + insights capturados.

---

### Passo 3 — Layer 2: Web Scraper

Mude para o worktree da Layer 2:

```bash
*exit

# Mudar para worktree da Layer 2
cd ../feature/layer-2-web  # ou o caminho configurado
claude
```

```
@dev

Dex, leia a spec do Web Scraper em docs/specs/ e o 
Architecture Doc.

Implemente o Web Scraper seguindo os 13 steps. Esta 
layer é responsável por:
- Acessar sites de leiloeiras com listagens navegáveis
- Navegar pela paginação (se houver)
- Extrair dados de veículos das páginas HTML
- Retornar no mesmo formato intermediário da Layer 1

IMPORTANTE: Leia os insights que você capturou na Layer 1 
(*capture-insights). Os padrões de dados que apareceram 
nos PDFs vão se repetir aqui — mesmos campos, formatos 
similares, mesmas inconsistências.

Use as URLs reais em test-data/urls/sites.txt para validar.

Comece pela análise da spec e plano de subtasks.
```

**O que esperar**: O Web Scraper é fundamentalmente diferente do PDF Parser — lida com HTML dinâmico, paginação, e potencialmente JavaScript renderizado client-side. Mas o output é o mesmo formato intermediário.

**Como avaliar**:

> **Checklist de verificação da Layer 2**
> - [ ] Acessa a URL e extrai dados? (não retorna vazio nem erro de conexão)
> - [ ] Lida com paginação? (se o site tem múltiplas páginas, navega todas)
> - [ ] Os dados extraídos correspondem ao que o site mostra? (confira manualmente)
> - [ ] Respeita rate limiting? (não dispara 100 requests por segundo)
> - [ ] O formato de output é idêntico ao da Layer 1? (mesmo schema intermediário)

Se o scraper não lidar com conteúdo dinâmico:

```
Dex, o scraper retorna HTML vazio para a listagem de 
veículos. Abri o site no browser e os dados aparecem, 
mas são carregados via JavaScript depois do page load. 
O scraper precisa esperar o conteúdo renderizar antes de 
extrair. Verifique se está usando browser headless com 
wait adequado.
```

Se o output não bater com o da Layer 1:

```
Dex, a Layer 1 retorna {"plate": "ABC1D23"} e a Layer 2 
retorna {"placa": "ABC-1D23"}. O formato intermediário 
deve ser IDÊNTICO entre layers — o Normalizer espera 
receber o mesmo schema de qualquer fonte. Alinhe com 
a spec.
```

**Self-critique e insights (mesmos steps da Layer 1)**:

```
Dex, self-critique da Layer 2:
1. Quais sites vão quebrar esse scraper? (JavaScript 
   heavy, anti-bot, layout não-padrão)
2. Se o site mudar o CSS amanhã, o que acontece?
3. Como o scraper sabe que terminou de paginar?

*track-attempt
```

```
*capture-insights

Registre os insights da Layer 2. Compare com os da Layer 1:
- Os dados vieram em formatos diferentes dos PDFs?
- Quais campos foram mais fáceis/difíceis via HTML vs PDF?
- Algum padrão da Layer 1 se confirmou?
```

> **🏆 Checkpoint 3**: Layer 2 extraindo dados de sites reais + insights capturados.

---

### Passo 4 — Layer 3: Auth Scraper

A layer mais complexa — sites que exigem autenticação:

```bash
*exit

cd ../feature/layer-3-auth
claude
```

```
@dev

Dex, leia a spec do Auth Scraper em docs/specs/ e o 
Architecture Doc.

Esta é a layer mais complexa. Sites que exigem:
- Login (formulário de autenticação)
- Potencialmente captcha após login
- Sessão autenticada para acessar listagens

Implemente seguindo os 13 steps. Atenção especial:
- A automação de login precisa ser robusta (não quebrar 
  se o formulário mudar levemente)
- Captcha handling: defina a estratégia conforme o 
  Arch Doc (serviço externo como 2captcha, ou detecção 
  para pular fontes com captcha nesta versão)
- Sessão: manter cookies entre requests

Consulte os insights das Layers 1 e 2 — os padrões de 
dados são similares.

Comece pelo plano de subtasks. Se a spec definir captcha 
como "fora do escopo v1", implemente login sem captcha 
e documente a limitação.
```

**Realidade importante**: A Layer 3 é onde o projeto mais provavelmente vai encontrar resistência. Sites com captcha são difíceis de automatizar por design. Se a spec definiu captcha como fora do escopo para v1, tudo bem — o importante é que login + navegação autenticada funcione.

**Como avaliar**:

> **Checklist de verificação da Layer 3**
> - [ ] Login automatizado funciona? (credenciais → sessão autenticada)
> - [ ] Após login, acessa listagens que exigem autenticação?
> - [ ] Mantém sessão entre requests? (não faz login a cada request)
> - [ ] Se login falha (credencial inválida, site fora), retorna erro claro?
> - [ ] Se captcha aparece, o comportamento é definido? (pula, usa serviço, ou falha com mensagem)

Se o login não funcionar:

```
Dex, o login falha com "invalid credentials" mas as 
credenciais estão corretas (testei manualmente no browser). 
Pode ser que o formulário use campos hidden (CSRF token) 
ou que o login seja via AJAX, não form submit. Investigue 
o fluxo real de autenticação do site.
```

Se captcha bloquear completamente:

```
Dex, o site agora exige captcha antes do login. Se a spec 
definiu captcha handling como fora do escopo v1, documente 
essa limitação e implemente detecção: o scraper identifica 
que há captcha, reporta a limitação, e retorna status 
"blocked_by_captcha" em vez de falhar silenciosamente. 
Na v2 isso se resolve com serviço externo.
```

**Self-critique e insights**:

```
Dex, self-critique final da Layer 3:
1. Quantos sites com login esse scraper suporta? Um? Vários?
2. O que acontece quando o site muda o formulário de login?
3. Se eu precisar adicionar um novo site com login, quanto 
   esforço é necessário?

*track-attempt
```

```
*capture-insights

Registre insights da Layer 3 e consolide com L1 e L2:
- Quais padrões se repetiram nas 3 layers?
- Qual layer foi mais difícil e por quê?
- Quais insights da L1 ajudaram na L2/L3?
- O que a Memory Layer deveria "lembrar" para a normalização?
```

> **🏆 Checkpoint 4**: Layer 3 funcional (dentro do escopo definido) + insights consolidados.

---

### Passo 5 — Merge das layers e verificação integrada

```bash
*exit

# Voltar para main e mergear as layers
cd ~/aiox-bootcamp/auctionhunter

git checkout main
# Merge cada worktree (na ordem L1 → L2 → L3)
```

Após merge, verificação integrada:

```bash
claude
```

```
@dev

Dex, as 3 layers estão mergeadas na main. Faça uma 
verificação integrada:

1. Rode a Layer 1 contra test-data/pdfs/ — todas extraem?
2. Rode a Layer 2 contra test-data/urls/ — todas extraem?
3. Rode a Layer 3 contra o site com login — funciona?
4. Os outputs das 3 layers estão no MESMO formato 
   intermediário? (mesmo schema, mesmos nomes de campo)
5. Há conflitos de merge entre as layers?

Se alguma layer quebrou no merge, corrija.
```

> **Checklist de verificação integrada**
> - [ ] As 3 layers rodam independentemente após merge?
> - [ ] Não há conflitos de dependência entre layers?
> - [ ] O formato intermediário é consistente entre as 3?
> - [ ] O total de veículos extraídos corresponde ao esperado? (confira contra os dados de teste)

> **🏆 Checkpoint 5 — VITÓRIA DA AULA**: 3 layers de scraping funcionando com dados reais, mergeadas e verificadas.

---

### Passo 6 — Commit consolidado

```bash
*exit

git add .
git commit -m "feat: three scraping layers implemented and integrated

- Layer 1: PDF parser (tabular + text extraction, LLM fallback)
- Layer 2: Web scraper (HTML parsing, pagination, dynamic content)
- Layer 3: Auth scraper (automated login, session management)
- All layers output unified intermediate format
- Self-critique documented per layer
- Memory Layer insights captured across all layers"
```

---

## Reflexão

### A Memory Layer em ação

Nesta aula você experimentou algo que não existia no RockQuiz: **aprendizado entre componentes**. Os insights capturados na Layer 1 (tipos de PDF, padrões de dados) informaram a Layer 2. Os insights combinados de L1+L2 (formatos de campos, inconsistências) informaram a Layer 3.

Sem a Memory Layer, cada layer seria uma ilha — o Dev repetiria os mesmos erros e redescobertas. Com ela, o conhecimento acumula e a implementação fica progressivamente mais informada. Na Aula 12, esses insights acumulados vão ser cruciais para o Data Normalizer: ele vai saber quais variações esperar porque as layers documentaram o que encontraram.

### Self-critique: a honestidade que previne bugs

O step 10 (self-critique) é desconfortável por design. Pedir ao Dev "onde seu código vai quebrar?" força uma avaliação honesta. Se a self-critique da Layer 1 disse "PDFs com texto corrido dependem de heurística frágil", isso é um risco documentado — não uma surpresa em produção.

Na primeira tentativa do AuctionHunter, não havia self-critique. O parser "funcionava" até encontrar um PDF diferente e silenciosamente retornava lixo. Agora, cada fragilidade está documentada e vira input para o Recovery System na próxima fase.

### O conceito-chave

> **Os 13 steps do ADE Execution Engine não são burocracia — são a estrutura que transforma "implementei e espero que funcione" em "implementei, sei onde é frágil, documentei os riscos, e capturei o que aprendi para o próximo componente". Em scraping, onde falha é a regra e não a exceção, essa estrutura é a diferença entre abandonar o projeto e levá-lo adiante.**

### Conexão com a próxima aula

Na Aula 12, o @dev implementa o Data Normalizer (convergir os 3 formatos intermediários em um schema unificado), a API de consulta e a persistência em banco. O Recovery System do ADE entra em cena: quando um scraper falha parcialmente, o pipeline não perde tudo — recupera o que conseguiu, reporta o que falhou, e segue. O QA faz review com foco em edge cases de dados reais.

---

> **Anterior**: [Aula 10 — PM + Architect: Spec Completa Multi-Layer](./aula-10-pm-architect-spec.md)
> **Próxima**: [Aula 12 — Dev: Normalização, API e Persistência](./aula-12-dev-normalization-api.md)
5:["lesson","aula-11-dev-scrapers","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["bootcamp",{"children":[["lesson","aula-11-dev-scrapers","d"],{"children":["__PAGE__?{\"lesson\":\"aula-11-dev-scrapers\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["bootcamp",{"children":[["lesson","aula-11-dev-scrapers","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"aula-11-dev-scrapers","module":"bootcamp","lessonIndex":10,"totalLessons":18,"nextLesson":"aula-12-dev-normalization-api","prevLesson":"aula-10-pm-architect-spec"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
