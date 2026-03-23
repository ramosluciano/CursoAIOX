2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","188","static/chunks/app/bootcamp/%5Blesson%5D/page-3b4cd11983f1559e.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T2086,# Aula 05 — DevOps: Infra do RockQuiz

<!-- metadata
module: 2
lesson: 5
title: "DevOps: Infra do RockQuiz"
duration: 3 horas
agents: "@devops"
project: RockQuiz
phase: Infraestrutura
prerequisites: Aula 04 concluída (docs/architecture.md existe)
-->

---

> **Módulo 2** · RockQuiz: Pipeline Completo
> **Duração**: 3 horas
> **Agentes praticados**: `@devops`
> **Projeto**: RockQuiz

---

## 🏆 Vitória desta aula

Infraestrutura completa de desenvolvimento e produção criada pelo @devops, validada por você.

**Critério binário**: DevContainer funcional + `docker compose up -d` sobe todos os serviços healthy.

---

## Conceito

### O @devops: guardião da infraestrutura

O @devops cuida de tudo que não é código da aplicação mas é essencial para que funcione: containers, ambientes, CI/CD, deploy, worktrees Git. Ele atua em 3 momentos: antes do código (esta aula), durante (worktrees), e depois (CI/CD e deploy — Aula 08).

### DevContainer vs Docker Compose

São dois ambientes com propósitos opostos. O DevContainer é para **desenvolvimento** (código montado do host, hot reload, dados descartáveis). O Docker Compose produção é para **deploy** (código dentro da imagem, imutável, dados persistentes). Ambos usam Docker, mas a configuração é completamente diferente.

### O princípio aplicado: o Architecture Doc como input

O Architect definiu a infraestrutura no Architecture Doc (Aula 04). O DevOps **lê** essas definições e as implementa. Você não vai ditar Dockerfiles — vai dizer ao DevOps "implemente o que o Architect especificou" e avaliar se fez certo.

---

## Contexto

O Architecture Doc define quantos serviços, quais tecnologias e como se comunicam. O DevOps transforma isso em arquivos de configuração Docker. O Dev (Aula 06) precisa deste ambiente pronto para implementar.

---

## Prática

### Passo 1 — Estrutura do monorepo

```bash
cd ~/aiox-bootcamp/rockquiz
claude
```

```
@devops

Dex-Ops, leia docs/architecture.md — especificamente as seções 
de stack técnica e estrutura de diretórios.

O Architect definiu um monorepo com backend e frontend separados. 
Preciso que você configure a estrutura de diretórios e os 
package.json com todas as dependências que o Architect especificou.

Inicialize tudo — quero poder rodar `npm install` na raiz e ter 
ambos os packages prontos para desenvolvimento.
```

**Como avaliar**: Após o DevOps gerar a estrutura:

```bash
# Verificar que a estrutura faz sentido
ls packages/
# Deve ter api/ e web/ (ou os nomes que o Architect definiu)

# Verificar que npm workspaces está configurado
cat package.json | grep -A5 workspaces

# Instalar dependências
npm install

# Verificar que instalou ambos
npm ls --workspaces --depth=0
```

Se algo não fizer sentido:

```
Dex-Ops, a estrutura que você criou não tem a pasta de 
plugins que o Architect definiu em packages/api/src/plugins/. 
Adicione a estrutura completa conforme o Architecture Doc.
```

> **🏆 Checkpoint 1**: Monorepo com 2 packages instalados.

---

### Passo 2 — DevContainer

Descreva a necessidade — não o arquivo:

```
Dex-Ops, preciso de um ambiente de desenvolvimento que:

1. Suba com um único comando (ou automaticamente no VS Code)
2. Tenha todos os serviços que o Architect definiu rodando 
   (banco, cache, etc) — não quero instalar nada manualmente
3. Me permita editar código e ver as mudanças ao vivo (hot reload)
4. Tenha as ferramentas de desenvolvimento instaladas 
   (extensões de IDE, formatadores, linters)
5. Funcione idêntico para qualquer pessoa que clonar o projeto

Use o Architecture Doc para saber quais serviços são necessários.
Configure tudo em .devcontainer/
```

**Como avaliar**:

```bash
# Verificar arquivos criados
ls .devcontainer/

# Subir os serviços de desenvolvimento
docker compose -f .devcontainer/docker-compose.yml up -d

# Verificar saúde dos serviços
docker compose -f .devcontainer/docker-compose.yml ps
```

> **Checklist de validação do DevContainer**
> - [ ] Todos os serviços do Arch Doc estão configurados?
> - [ ] Cada serviço tem health check (necessário para depends_on)?
> - [ ] As portas estão mapeadas (posso acessar banco e cache do host)?
> - [ ] Há script de post-create (instalar deps, rodar migrations)?
> - [ ] Extensões de IDE estão configuradas?

Se algo faltar:

```
Dex-Ops, os serviços subiram mas o banco não tem health check. 
Isso significa que a API pode tentar conectar antes do banco 
estar pronto. Adicione health checks para todos os serviços.
```

> **🏆 Checkpoint 2**: DevContainer sobe com todos os serviços healthy.

---

### Passo 3 — Docker Compose produção

```
Dex-Ops, além do ambiente de dev, preciso de uma configuração 
de produção otimizada. As diferenças em relação ao dev:

- O código deve estar DENTRO da imagem (não montado do host)
- As imagens devem ser as menores possíveis (multi-stage build)
- Os dados do banco devem persistir entre restarts (volumes)
- Cada serviço deve ter health check e restart automático
- A aplicação deve rodar com usuário non-root (segurança)

Consulte o Architecture Doc para saber quais serviços incluir.
Crie os Dockerfiles de produção para API e frontend, e o 
docker-compose.yml na raiz do projeto.
```

**Como avaliar**:

```bash
# Build das imagens
docker compose build

# Verificar tamanho das imagens
docker images | grep rockquiz
```

> **Checklist de validação da produção**
> - [ ] Dockerfiles usam multi-stage build (imagens < 200MB)?
> - [ ] Há .dockerignore (não copia node_modules para o build)?
> - [ ] Cada serviço tem health check?
> - [ ] Volumes de banco são nomeados (persistem entre restarts)?
> - [ ] Containers rodam com user non-root?
> - [ ] Há restart policy (unless-stopped)?

Se as imagens forem grandes:

```
Dex-Ops, a imagem da API tem 600MB. Isso é muito para produção. 
Verifique se o Dockerfile está usando multi-stage build corretamente 
— a imagem final deve ter apenas o artefato compilado e as 
dependências de produção, não o TypeScript compiler ou devDependencies.
```

---

### Passo 4 — Testar a stack completa

```bash
# Subir produção
docker compose up -d

# Verificar saúde (pode levar 10-30s)
docker compose ps

# Verificar logs
docker compose logs --tail 20

# Derrubar
docker compose down
```

> **Nota**: API e frontend ainda não têm código funcional (próxima aula). Os containers devem subir, mas podem mostrar erros de "entry point not found" — isso é esperado neste momento.

> **🏆 Checkpoint 3**: Stack de produção sobe com serviços respondendo.

---

### Passo 5 — Primeiro worktree

```
Dex-Ops, nas próximas aulas o Dev vai implementar features. 
Preciso de um sistema para trabalhar em features isoladas 
sem poluir a branch principal. 

Como você organizaria isso? Crie a estrutura para a primeira 
feature (setup da API).

*create-worktree feature/api-setup
```

```
*list-worktrees
```

**Entenda o output**: O DevOps criou um worktree em diretório separado com branch própria. Nas próximas aulas, o Dev trabalha ali e depois faz merge.

---

### Passo 6 — Commit

```bash
*exit

git add .
git commit -m "infra: DevContainer, Docker Compose, Dockerfiles, monorepo structure"
```

> **🏆 Checkpoint 4 — VITÓRIA DA AULA**: Infra completa criada pelo agente, validada por você.

---

## Reflexão

### O que você NÃO fez nesta aula

Você não escreveu um Dockerfile. Não configurou docker-compose.yml. Não definiu volumes ou health checks. O @devops fez tudo isso — você **descreveu necessidades** ("preciso de ambiente de dev que suba com 1 comando", "imagens menores possíveis para produção") e **avaliou resultados** (checklists de validação).

Se amanhã você precisar configurar Docker para outro projeto, o processo é o mesmo: descreva a necessidade ao @devops, avalie, refine. Você não precisa memorizar syntax de Dockerfile.

### O conceito-chave

> **O @devops implementa infraestrutura a partir do Architecture Doc. Você descreve necessidades e avalia resultados — a expertise técnica de Docker, CI/CD e deploy é do agente.**

---

> **Anterior**: [Aula 04 — Architect + SM](./aula-04-architect-stories.md)
> **Próxima**: [Aula 06 — Dev: Backend do RockQuiz](./aula-06-dev-backend.md)
5:["lesson","aula-05-devops-infra","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["bootcamp",{"children":[["lesson","aula-05-devops-infra","d"],{"children":["__PAGE__?{\"lesson\":\"aula-05-devops-infra\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["bootcamp",{"children":[["lesson","aula-05-devops-infra","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"aula-05-devops-infra","module":"bootcamp","lessonIndex":4,"totalLessons":18,"nextLesson":"aula-06-dev-backend","prevLesson":"aula-04-architect-stories"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
