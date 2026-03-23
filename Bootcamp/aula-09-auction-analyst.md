# Aula 09 — Analyst: Entendendo o Domínio de Leilões

<!-- metadata
module: 3
lesson: 9
title: "Analyst: Entendendo o Domínio de Leilões"
duration: 3-4 horas
agents: "@analyst"
project: AuctionHunter
phase: Planejamento (Fase 1)
prerequisites: Aula 08 concluída (RockQuiz deployado)
-->

---

> **Módulo 3** · AuctionHunter: Recomeço Estruturado
> **Duração**: 3-4 horas
> **Agentes praticados**: `@analyst`
> **Projeto**: AuctionHunter

---

## 🏆 Vitória desta aula

Domínio de leilões de veículos apreendidos completamente mapeado, estratégia de scraping multi-layer definida, e análise honesta de por que a tentativa anterior falhou.

**Critério binário**: `docs/project-brief.md` + `docs/domain-map.md` + `docs/failure-analysis.md` gerados e coerentes entre si.

---

## Conceito

### O Analyst como redutor de risco

No RockQuiz, o @analyst tinha um domínio simples: quiz de rock. Categorias, perguntas, modos de jogo — tudo previsível. No AuctionHunter, o domínio é **hostil**. PDFs mudam de formato entre leiloeiras. Sites exigem login. Captchas bloqueiam automação. Dados vêm semi-estruturados, com campos faltando ou em posições diferentes.

O @analyst existe para **reduzir risco antes de escrever uma linha de código**. No RockQuiz, pular a análise custaria retrabalho. No AuctionHunter, pular a análise é exatamente o que fez o projeto falhar da primeira vez.

O Analyst faz três coisas que nenhum outro agente faz:

| Capacidade | Por que importa aqui |
|-----------|---------------------|
| Pesquisa de domínio | Leilões têm regras legais, formatos de editais, vocabulário próprio |
| Mapeamento de fontes de dados | Cada leiloeira publica dados de forma diferente (PDF, HTML, API) |
| Análise de risco técnico | Identificar antecipadamente onde o scraping vai falhar |

### Recomeço estruturado: a narrativa deste módulo

O AuctionHunter não é um projeto novo — é um projeto que **já falhou**. Você tentou antes: pdfplumber com regex, lógica frágil, sem fallback, sem estrutura. Funcionava para um PDF e quebrava no próximo.

Neste módulo, a narrativa é **recomeço com método**. O AIOX não é mágica — os scrapers vão continuar falhando (sites mudam, captchas bloqueiam, PDFs surpreendem). A diferença é que agora existe um processo: análise antes de código, specs antes de implementação, fallback por design, recovery quando algo quebra.

### O princípio aplicado

Você vai descrever ao Analyst o que o AuctionHunter precisa fazer e qual é o domínio. **Não vai ditar** quais sites analisar, quais formatos de PDF documentar ou quais riscos listar. O Analyst pesquisa, mapeia e identifica — você avalia se a análise está completa e realista.

---

## Contexto

Este é o **primeiro contato** do pipeline AIOX com o AuctionHunter. Diferente do RockQuiz (que começou do zero), aqui existe história: uma tentativa anterior com código parcial, insights sobre o que não funcionou, e conhecimento de domínio acumulado. O Analyst vai usar tudo isso como input.

A complexidade deste projeto vai exercitar recursos do AIOX que o RockQuiz não precisou: nas próximas aulas, o ADE Recovery System vai entrar em ação quando scrapers falharem de verdade (não simulado), e a Memory Layer vai acumular insights entre layers de scraping. Mas tudo começa aqui — com uma análise de domínio sólida.

---

## Prática

### Passo 1 — Iniciar o projeto e contextualizar o Analyst

```bash
mkdir -p ~/aiox-bootcamp/auctionhunter
cd ~/aiox-bootcamp/auctionhunter
git init
claude
```

```
@analyst

Alex, vou te contextualizar sobre um projeto chamado AuctionHunter.

O OBJETIVO é automatizar a coleta de dados de veículos em leilões 
de veículos apreendidos no Brasil. Esses leilões são organizados 
por leiloeiras credenciadas (como Sodré Santoro, Lance Certo, 
Mega Leilões, etc.) que publicam editais com listas de veículos.

AS FONTES DE DADOS são variadas:
- PDFs de editais (publicados em sites de leiloeiras e do DETRAN)
- Sites de leiloeiras com listagens navegáveis (HTML)
- Alguns sites exigem login e/ou têm captcha

OS DADOS que preciso extrair de cada veículo incluem: placa, 
chassi, marca, modelo, ano, cor, cidade/UF, lote, valor mínimo, 
data do leilão, leiloeira responsável, e status de documentação.

CONTEXTO IMPORTANTE: eu já tentei construir este projeto antes 
sem metodologia — comecei direto no código, usei pdfplumber com 
regex frágil, e o resultado funcionava para 1 formato de PDF e 
quebrava nos outros. O projeto foi abandonado.

Preciso que você faça:
1. Pesquisa profunda do domínio de leilões de veículos apreendidos
2. Mapeamento das fontes de dados (tipos, formatos, dificuldades)
3. Análise de riscos técnicos para automação de scraping
4. Análise honesta do que provavelmente deu errado na tentativa anterior

*research-domain
```

**O que esperar**: O Analyst vai produzir uma pesquisa estruturada sobre o domínio. Ele deve cobrir aspectos legais (editais públicos, regras de leilão), aspectos técnicos (formatos de publicação, variedade de fontes) e aspectos de risco (o que torna esse domínio difícil para automação).

**Como avaliar**:

> **Checklist de avaliação da pesquisa de domínio**
> - <input type="checkbox" class="checkbox-input" /> Cobriu o fluxo legal? (como um veículo apreendido chega a leilão, quem publica, prazos)
> - <input type="checkbox" class="checkbox-input" /> Identificou categorias de fontes? (editais PDF, sites navegáveis, portais com login)
> - <input type="checkbox" class="checkbox-input" /> Mapeou a variedade de formatos? (PDFs tabulares vs texto corrido vs escaneados)
> - <input type="checkbox" class="checkbox-input" /> Identificou os dados-chave de cada veículo? (placa, chassi, lote, valor, etc.)
> - <input type="checkbox" class="checkbox-input" /> Listou riscos técnicos reais? (anti-bot, captcha, mudança de layout, PDF malformado)

Se a pesquisa estiver superficial:

```
Alex, a pesquisa não mencionou a variedade de formatos de PDF. 
Na minha experiência, cada leiloeira publica editais em formatos 
diferentes — algumas usam tabelas, outras texto corrido, outras 
PDFs escaneados (imagem). Essa variedade é o principal desafio 
técnico. Aprofunde essa análise.
```

Se faltou o aspecto de risco:

```
Alex, os riscos técnicos estão genéricos ("sites podem mudar"). 
Preciso de riscos ESPECÍFICOS para este domínio: captchas em 
portais de leiloeiras, PDFs com encoding quebrado, dados de 
veículos em posições inconsistentes dentro do mesmo edital, 
sites que bloqueiam scraping por User-Agent ou rate limiting.
```

> **🏆 Checkpoint 1**: Pesquisa de domínio completa e realista.

---

### Passo 2 — Domain Map: as fontes de dados

```
Alex, agora preciso que você mapeie as fontes de dados em 
um Domain Map estruturado.

Para cada tipo de fonte, documente:
- Formato (PDF, HTML, API)
- Como acessar (público, login, captcha)
- Estrutura dos dados (tabular, texto corrido, misto)
- Dificuldade estimada de extração (baixa/média/alta)
- Exemplo de cenário (descreva um caso concreto)

Organize por "layers" de scraping — da mais simples (PDF público) 
à mais complexa (site com login + captcha + paginação dinâmica).

Isso vai alimentar a arquitetura multi-layer que o Architect 
vai projetar na próxima aula.

*extract-patterns
```

**O que esperar**: O Analyst deve produzir um mapeamento que organize as fontes em layers de complexidade crescente. Algo como:

- **Layer 1**: PDFs de editais públicos (acesso direto, parsing de texto/tabela)
- **Layer 2**: Sites com listagens HTML navegáveis (scraping de HTML, paginação)
- **Layer 3**: Sites com login obrigatório e/ou captcha (automação de autenticação)

**Como avaliar**:

> **Checklist de avaliação do Domain Map**
> - <input type="checkbox" class="checkbox-input" /> As fontes estão organizadas por complexidade crescente?
> - <input type="checkbox" class="checkbox-input" /> Cada layer tem dificuldade estimada com justificativa?
> - <input type="checkbox" class="checkbox-input" /> Os cenários são concretos? (não apenas "um site com captcha", mas como o captcha funciona)
> - <input type="checkbox" class="checkbox-input" /> Há clareza sobre quais dados estão disponíveis em cada tipo de fonte?
> - <input type="checkbox" class="checkbox-input" /> O mapeamento cobre o espectro completo? (PDF simples → site complexo)

Se as layers estiverem mal definidas:

```
Alex, você colocou PDF e HTML na mesma layer, mas a 
dificuldade é completamente diferente. PDF de edital público 
é download direto + parsing local. Site HTML é navegação + 
paginação + potencialmente JavaScript dinâmico. Separe as 
layers por complexidade real de implementação.
```

Se faltar concretude:

```
Alex, o Layer 3 diz "sites com captcha" mas não detalha 
que tipo de captcha. Captcha de imagem simples é diferente 
de reCAPTCHA v2 (checkbox) que é diferente de reCAPTCHA v3 
(invisible). O tipo de captcha define a estratégia de bypass. 
Detalhe.
```

> **🏆 Checkpoint 2**: Domain Map com layers claras e cenários concretos.

---

### Passo 3 — Failure Analysis: por que falhou antes

Esta é a parte mais valiosa da aula. Ser honesto sobre o que deu errado:

```
Alex, a tentativa anterior do AuctionHunter falhou. Vou te 
dar o contexto do que foi feito:

- Comecei direto pelo código, sem análise de domínio
- Usei pdfplumber + regex para extrair dados de PDFs
- A regex funcionava para um formato de edital mas quebrava 
  para outros (posição dos campos mudava)
- Não havia fallback — se a regex falhava, perdia o dado
- Não tinha normalização — dados vinham em formatos diferentes 
  (placa com hífen, sem hífen, com espaço)
- Não tinha persistência estruturada — salvava em JSON flat
- Não tinha scheduling — rodava manualmente
- Quando um site mudava o layout, todo o scraper quebrava 
  sem aviso

Analise essa experiência e produza um Failure Analysis que 
identifique:
1. As causas raiz da falha (não os sintomas)
2. Quais decisões técnicas foram problemáticas
3. O que o pipeline AIOX vai fazer diferente desta vez
4. Quais riscos da tentativa anterior ainda existem 
   (e como mitigar)

Seja direto — essa análise é para aprender, não para 
justificar.
```

**O que esperar**: O Analyst deve produzir uma análise que vá além de "faltou planejamento" e identifique causas estruturais. Exemplos do tipo de insight esperado:

- "Regex hard-coded para posição fixa é frágil por design — editais de leiloeiras diferentes têm layouts diferentes"
- "Sem schema de dados definido antecipadamente, cada fonte virava um parser customizado sem padrão"
- "Ausência de fallback significava que falha em qualquer etapa perdia 100% dos dados daquela fonte"
- "Sem testes contra PDFs variados, a falha só aparecia em produção com dados reais"

**Como avaliar**:

> **Checklist de avaliação do Failure Analysis**
> - <input type="checkbox" class="checkbox-input" /> Identifica causas raiz (não apenas sintomas)?
> - <input type="checkbox" class="checkbox-input" /> Diferencia problemas de processo (falta de análise) de problemas técnicos (regex frágil)?
> - <input type="checkbox" class="checkbox-input" /> Propõe como o AIOX endereça cada causa raiz?
> - <input type="checkbox" class="checkbox-input" /> Identifica riscos que persistem mesmo com AIOX? (sites mudam, captchas existem)
> - <input type="checkbox" class="checkbox-input" /> O tom é analítico, não justificativo?

Se a análise for superficial:

```
Alex, a análise diz "faltou planejamento" como causa raiz. 
Isso é genérico demais. QUAL planejamento faltou? Faltou 
definir um schema de dados antes de parsear? Faltou mapear 
a variedade de formatos de PDF? Faltou definir uma estratégia 
de fallback? Seja específico — cada causa raiz se torna um 
requisito para a nova versão.
```

Se estiver otimista demais:

```
Alex, a análise sugere que com AIOX "tudo vai funcionar". 
Não vai. Sites vão mudar layout, captchas vão bloquear, 
PDFs vão ter formatos inesperados. O AIOX não elimina esses 
problemas — ele estrutura a resposta. Inclua na análise quais 
riscos PERMANECEM e como o Recovery System do ADE vai lidar 
com eles.
```

> **🏆 Checkpoint 3**: Failure Analysis honesta com causas raiz e mitigações.

---

### Passo 4 — Gerar os documentos finais

```
Alex, consolide toda a análise em três documentos:

1. docs/project-brief.md — o brief do AuctionHunter:
   - Propósito do projeto
   - Público-alvo (quem usa os dados de leilão)
   - Escopo (o que faz e o que NÃO faz)
   - Restrições e premissas

2. docs/domain-map.md — o mapeamento completo:
   - Domínio de leilões (fluxo legal, stakeholders)
   - Fontes de dados por layer (complexidade crescente)
   - Dados a extrair (campos, formatos, variações)
   - Riscos técnicos por layer

3. docs/failure-analysis.md — a análise da tentativa anterior:
   - O que foi feito
   - Causas raiz da falha
   - Lições aprendidas
   - Como o AIOX endereça cada causa
   - Riscos que persistem

*write-spec
```

**Como verificar**:

```bash
ls docs/
# Deve conter: project-brief.md, domain-map.md, failure-analysis.md
```

> **Checklist de avaliação dos documentos**
> - <input type="checkbox" class="checkbox-input" /> Os três documentos existem e têm conteúdo substancial?
> - <input type="checkbox" class="checkbox-input" /> O brief define escopo claro (inclusive o que NÃO está no escopo)?
> - <input type="checkbox" class="checkbox-input" /> O domain map referencia layers que serão specs na próxima aula?
> - <input type="checkbox" class="checkbox-input" /> O failure analysis é útil como input para o PM e Architect?
> - <input type="checkbox" class="checkbox-input" /> Os três documentos são coerentes entre si? (brief → domain → failure se complementam)

Se os documentos forem inconsistentes:

```
Alex, o brief diz que captcha handling está no escopo, 
mas o domain map não tem uma layer para sites com captcha. 
E o failure analysis não menciona captcha como risco que 
persiste. Alinhe os três documentos — cada informação 
relevante deve aparecer onde faz sentido.
```

> **🏆 Checkpoint 4 — VITÓRIA DA AULA**: Três documentos gerados, coerentes e completos.

---

### Passo 5 — Commit

```bash
*exit

git add .
git commit -m "docs: AuctionHunter project brief, domain map, and failure analysis

- Domain research: vehicle auction ecosystem in Brazil
- Multi-layer source mapping (PDF, HTML, login/captcha)
- Honest failure analysis of previous attempt
- Risk assessment for scraping automation"
```

---

## Reflexão

### RockQuiz vs AuctionHunter: o salto de complexidade

| Dimensão | RockQuiz | AuctionHunter |
|----------|----------|---------------|
| Domínio | Simples (quiz) | Hostil (scraping de fontes heterogêneas) |
| Fontes de dados | Nenhuma externa | PDFs, sites, portais com login |
| Ponto de falha | Bug no código | Fonte de dados muda sem aviso |
| Histórico | Nenhum | Tentativa anterior falhou |
| Papel do Analyst | Opcional (domínio óbvio) | Crítico (domínio complexo e arriscado) |

No RockQuiz, você poderia ter pulado o Analyst e começado pelo PM — o domínio era simples o suficiente. No AuctionHunter, **pular o Analyst é repetir o erro da primeira tentativa**: ir direto pro código sem entender o domínio.

### O conceito-chave

> **O Analyst é o agente que transforma "eu acho que sei como funciona" em "eu documentei como funciona e onde vai dar problema". No AuctionHunter, cada risco identificado agora é um bug evitado depois.**

### Conexão com a próxima aula

Na Aula 10, o @pm e o @architect transformam a análise do Analyst em especificações executáveis. O domain map vira PRD com FRs por layer. Os riscos viram NFRs e decisões de fallback na arquitetura. A failure analysis vira requisito: "tudo que falhou antes tem spec e teste desta vez".

---

> **Anterior**: Aula 08 — DevOps: CI/CD, Observabilidade e Deploy
> **Próxima**: Aula 10 — PM + Architect: Spec Completa Multi-Layer
