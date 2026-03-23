# Aula 12 — Dev: Normalização, API e Persistência

<!-- metadata
module: 3
lesson: 12
title: "Dev: Normalização, API e Persistência"
duration: 4-5 horas
agents: "@dev, @qa"
project: AuctionHunter
phase: Desenvolvimento (Fase 2)
prerequisites: Aula 11 concluída (3 layers de scraping funcionando)
-->

---

> **Módulo 3** · AuctionHunter: Recomeço Estruturado
> **Duração**: 4-5 horas
> **Agentes praticados**: `@dev`, `@qa`
> **Projeto**: AuctionHunter

---

## 🏆 Vitória desta aula

Pipeline completo funcionando end-to-end: input (PDF ou URL) → scraping (qualquer layer) → normalização → persistência em banco → consulta via API. Com Recovery System real — quando um scraper falha parcialmente, o pipeline recupera o que conseguiu.

**Critério binário**: Alimentar o pipeline com um PDF e uma URL, e consultar os veículos extraídos via API com dados normalizados e persistidos no banco.

---

## Conceito

### O Data Normalizer: onde a bagunça vira dado limpo

As 3 layers de scraping extraem dados de fontes diferentes em formatos diferentes. A Memory Layer da Aula 11 documentou essas variações: placa com ou sem hífen, valor com "R$" ou sem, datas em DD/MM/YYYY ou YYYY-MM-DD, campos que às vezes existem e às vezes não.

O Data Normalizer é o **funil** que transforma essa diversidade em um schema unificado. Ele não se importa de onde o dado veio — recebe o formato intermediário de qualquer layer e produz um registro padronizado pronto para o banco. Sem ele, a persistência seria um caos de formatos, e a API retornaria dados inconsistentes.

Na primeira tentativa do AuctionHunter, o normalizer não existia. Cada parser salvava dados no seu formato. Buscar "veículos do leilão X" retornava registros com campos em formatos diferentes dependendo da fonte. Isso tornava qualquer análise impossível.

### Recovery System: falha parcial ≠ falha total

Scraping é inerentemente frágil. Um PDF com 50 veículos pode ter 45 parseados corretamente e 5 com campos faltando. Um site pode retornar 3 páginas de 5 antes de dar timeout. Na primeira tentativa, qualquer falha abortava tudo — perdia 100% dos dados por causa de 10% de falha.

O ADE Recovery System trata falha parcial como **resultado parcial**, não como erro fatal:

| Cenário | Sem Recovery | Com Recovery |
|---------|-------------|-------------|
| PDF com 50 veículos, 5 falham | Aborta, perde 50 | Salva 45, reporta 5 com erro |
| Site retorna 3 de 5 páginas | Aborta, perde tudo | Salva 3 páginas, agenda retry das 2 |
| Campo "valor" em formato inesperado | Registro descartado | Registro salvo sem valor, flag de "incompleto" |
| Layer 1 falha para uma fonte | Erro fatal | Delega para Layer 2 automaticamente |

O Recovery não inventa dados — ele **preserva o que tem** e **documenta o que faltou**. Isso é a diferença entre um sistema que funciona no mundo real e um que só funciona em condições ideais.

### O princípio aplicado

Você vai apontar o Dev para as specs de normalização e API (specs 4 e 5 da Aula 10). Vai verificar com dados reais — incluindo dados propositalmente problemáticos (campos faltando, formatos estranhos). **Não vai ditar** as regras de normalização nem o schema do banco. O Dev lê as specs e implementa; você avalia se o output é correto e robusto.

---

## Contexto

As 3 layers estão implementadas e mergeadas (Aula 11). Os insights da Memory Layer documentam quais variações de dados cada layer encontrou. Agora o Dev implementa os dois componentes que faltam: o Normalizer que padroniza e o par API + persistência que armazena e serve. O QA entra no final com review focado em edge cases — que aqui são o coração do problema.

---

## Prática

### Passo 1 — Dev implementa o Data Normalizer

```bash
cd ~/aiox-bootcamp/auctionhunter
claude
```

```
@dev

Dex, leia a spec do Data Normalizer em docs/specs/ e o 
Architecture Doc (especialmente o schema de veículos).

Implemente o Normalizer seguindo os 13 steps do ADE. 
Este componente é o funil central do sistema:
- Recebe dados no formato intermediário de QUALQUER layer
- Normaliza cada campo para o formato unificado do schema
- Valida o registro normalizado
- Retorna o registro pronto para persistência + relatório 
  de campos que não puderam ser normalizados

ANTES DE IMPLEMENTAR: leia os insights capturados nas 3 
layers (*capture-insights). Eles documentam as variações 
reais de dados que você vai precisar tratar — formatos de 
placa, variações de valor, encoding, campos ausentes.

O Normalizer é onde o failure analysis se prova: na 
tentativa anterior, a ausência desse componente fez 
cada parser ser uma ilha. Agora existe UM ponto de 
padronização.

Comece pelo plano de subtasks.
```

**O que esperar no plano**: O Dev deve decompor a normalização por tipo de campo, não por fonte de dados. A normalização de "placa" é a mesma independente de onde veio — o que muda é o formato de entrada:

- Subtask 1: Normalização de placa (formatos: ABC-1234, ABC1D23, ABC 1234, abc1234)
- Subtask 2: Normalização de chassi (17 caracteres, validação de dígito verificador)
- Subtask 3: Normalização de valor (R$ 15.000,00 → 15000.00; "lance mínimo: 15mil" → 15000.00)
- Subtask 4: Normalização de data (DD/MM/YYYY, YYYY-MM-DD, "15 de março de 2025")
- Subtask 5: Normalização de marca/modelo (case, abreviações, trimming)
- Subtask 6: Validação do registro completo + completeness score

**Como avaliar o plano**:

> **Checklist de avaliação do plano**
> - <input type="checkbox" class="checkbox-input" /> Decomposição é por campo (não por fonte)?
> - <input type="checkbox" class="checkbox-input" /> Cada campo lista as variações conhecidas (dos insights da Memory Layer)?
> - <input type="checkbox" class="checkbox-input" /> Há subtask de validação do registro completo?
> - <input type="checkbox" class="checkbox-input" /> Há tratamento para campos ausentes? (null, flag, rejeição?)
> - <input type="checkbox" class="checkbox-input" /> Há conceito de "completeness score"? (quantos campos foram preenchidos)

Se o plano não usar os insights:

```
Dex, o plano de normalização de placa trata apenas formato 
ABC-1234. Os insights da Layer 1 documentaram que editais 
também trazem placas no formato Mercosul (ABC1D23) e 
placas com espaço (ABC 1234). O plano precisa cobrir 
TODAS as variações que as layers já encontraram.
```

**Após implementação**, teste com dados reais das 3 layers:

```bash
# Alimentar o Normalizer com output de cada layer
python src/normalizer/normalize.py test-data/output-layer1.json
python src/normalizer/normalize.py test-data/output-layer2.json
python src/normalizer/normalize.py test-data/output-layer3.json
```

> **Checklist de verificação do Normalizer**
> - <input type="checkbox" class="checkbox-input" /> Aceita output de qualquer layer sem erro?
> - <input type="checkbox" class="checkbox-input" /> Placa está padronizada? (mesmo formato independente da fonte)
> - <input type="checkbox" class="checkbox-input" /> Valor é numérico? (não string com "R$")
> - <input type="checkbox" class="checkbox-input" /> Data está em formato ISO? (YYYY-MM-DD)
> - <input type="checkbox" class="checkbox-input" /> Campos ausentes são tratados (null, não string vazia)?
> - <input type="checkbox" class="checkbox-input" /> Registro tem completeness score? (ex: 10/12 campos preenchidos)

Se a normalização falhar para dados reais:

```
Dex, o Normalizer rejeita registros do Layer 2 porque o 
campo "valor" vem como "A partir de R$ 5.000" em vez de 
número. Rejeitar é errado — esse é dado real. O Normalizer 
precisa extrair o número (5000) e, se não conseguir, salvar 
o registro com valor null e flag de "valor_não_parseado", 
não descartar o registro inteiro.
```

Se dados de fontes diferentes produzirem formatos diferentes:

```
Dex, veículos do Layer 1 têm placa "ABC1D23" e do Layer 2 
têm "ABC-1D23". Depois de normalizar, os dois devem ter 
EXATAMENTE o mesmo formato. Confira que o Normalizer está 
produzindo output idêntico independente da fonte.
```

> **🏆 Checkpoint 1**: Normalizer funcionando com dados reais das 3 layers.

---

### Passo 2 — Implementar Recovery System

O Recovery é o que transforma falha parcial em resultado parcial:

```
Dex, agora implemente o Recovery System conforme a spec 
e o Architecture Doc.

O Recovery precisa tratar estes cenários:

1. LAYER FAILURE: Layer 1 falha para uma fonte → o pipeline 
   automaticamente tenta Layer 2 → se L2 falha, tenta L3
2. PARTIAL EXTRACTION: layer extraiu 45 de 50 veículos → 
   salva os 45, reporta os 5 com erro e o motivo
3. PARTIAL NORMALIZATION: veículo extraído mas 3 campos não 
   normalizaram → salva com campos disponíveis + completeness 
   score + flag dos campos faltantes
4. TOTAL FAILURE: todas as layers falharam para uma fonte → 
   registra a fonte na fila de retry com o erro de cada layer

Para cada cenário, preciso de:
- Detecção automática (como o sistema sabe que falhou?)
- Ação de recovery (o que faz quando detecta?)
- Logging (o que registra para debug?)

Isso é o ADE Recovery System — não simulado, funcionando 
com falhas reais de scraping.
```

**Como testar**: Provoque falhas propositalmente:

```bash
# Testar com PDF corrompido
python src/pipeline/run.py test-data/pdfs/corrupted.pdf

# Testar com URL que não existe
python src/pipeline/run.py --url "https://leiloeira-ficticia.com.br/lotes"

# Testar com PDF onde metade dos veículos tem dados faltando
python src/pipeline/run.py test-data/pdfs/edital-incompleto.pdf
```

> **Checklist de verificação do Recovery**
> - <input type="checkbox" class="checkbox-input" /> PDF corrompido: não crasha — retorna erro claro com motivo?
> - <input type="checkbox" class="checkbox-input" /> URL inválida: tenta outras layers antes de desistir?
> - <input type="checkbox" class="checkbox-input" /> Extração parcial: salvou os registros bons? Reportou os problemáticos?
> - <input type="checkbox" class="checkbox-input" /> Normalização parcial: registro salvo com campos disponíveis + flag?
> - <input type="checkbox" class="checkbox-input" /> Falha total: fonte registrada em fila de retry?
> - <input type="checkbox" class="checkbox-input" /> Logs: cada falha e recovery está logado com contexto suficiente para debug?

Se o Recovery não existir (só happy path):

```
Dex, o pipeline funciona quando tudo dá certo, mas crasha 
quando o PDF é inválido. Sem Recovery, qualquer falha perde 
100% dos dados — que é exatamente o problema da tentativa 
anterior. Implemente os 4 cenários de recovery que descrevi.
```

Se o fallback entre layers não funcionar:

```
Dex, quando a Layer 1 falha para uma URL, o pipeline para. 
Deveria tentar Layer 2 automaticamente. O fluxo é: 
L1 tenta → falha → log do motivo → L2 tenta → 
sucesso → continua. Ou L2 falha → L3 tenta → etc. 
Implemente a cadeia de fallback.
```

> **🏆 Checkpoint 2**: Recovery System funcionando com falhas reais provocadas.

---

### Passo 3 — API e Persistência

```
Dex, leia a spec de API + Persistência em docs/specs/.

Implemente:

1. PERSISTÊNCIA: banco de dados com o schema de veículos 
   normalizado. Cada registro deve incluir:
   - Dados do veículo (campos normalizados)
   - Metadata: fonte de origem (PDF/URL), layer que extraiu, 
     data de extração, completeness score
   - Status: completo, parcial, erro

2. API DE CONSULTA: endpoints para acessar os dados persistidos.
   - Listar veículos com filtros (marca, modelo, cidade, 
     faixa de valor, data do leilão)
   - Detalhe de um veículo específico
   - Status do pipeline (quantas fontes processadas, taxa 
     de sucesso, registros por layer)

3. PIPELINE END-TO-END: um comando que receba input (PDF 
   ou URL), passe pelas layers, normalize, persista e 
   retorne o resultado.

Siga o Architecture Doc para stack (banco, ORM, framework) 
e endpoints definidos.
```

**Como verificar o pipeline end-to-end**:

```bash
# Subir banco
docker compose up -d

# Rodar pipeline completo com PDF
python src/pipeline/run.py test-data/pdfs/edital-exemplo.pdf

# Consultar via API
curl http://localhost:8000/api/vehicles | jq

# Filtrar por marca
curl "http://localhost:8000/api/vehicles?brand=FIAT" | jq

# Status do pipeline
curl http://localhost:8000/api/pipeline/status | jq
```

> **Checklist de verificação da API + Persistência**
> - <input type="checkbox" class="checkbox-input" /> Pipeline end-to-end funciona? (PDF → banco → API retorna dados)
> - <input type="checkbox" class="checkbox-input" /> Dados no banco estão normalizados? (formato unificado)
> - <input type="checkbox" class="checkbox-input" /> Metadata está presente? (fonte, layer, data, completeness)
> - <input type="checkbox" class="checkbox-input" /> Filtros da API funcionam? (marca, modelo, valor, cidade)
> - <input type="checkbox" class="checkbox-input" /> Status endpoint mostra métricas reais do pipeline?
> - <input type="checkbox" class="checkbox-input" /> Registros parciais estão no banco com flag correto?

Se os dados no banco não estiverem normalizados:

```
Dex, a API retorna veículos mas os dados não estão 
normalizados — tem placa em formatos diferentes, valor 
como string. O Normalizer deveria ter padronizado antes 
de persistir. Verifique se o pipeline está passando pelo 
Normalizer antes da persistência.
```

Se o endpoint de status não existir:

```
Dex, preciso de um endpoint /api/pipeline/status que mostre:
- Total de fontes processadas
- Total de veículos extraídos
- Taxa de sucesso por layer (L1: 90%, L2: 75%, L3: 60%)
- Registros completos vs parciais vs com erro
- Última execução (quando, qual fonte, resultado)

Esses dados são essenciais para saber se o sistema está 
saudável sem precisar abrir o banco.
```

> **🏆 Checkpoint 3**: Pipeline end-to-end funcionando com dados reais.

---

### Passo 4 — QA Review com foco em edge cases

O QA no AuctionHunter tem um papel diferente do RockQuiz. Lá, os edge cases eram inputs inválidos em formulários. Aqui, os edge cases são **o estado normal de operação** — dados reais de leilão são inerentemente bagunçados:

```
*exit

@qa

Quinn, faça review completo do AuctionHunter.

Leia as specs em docs/specs/ e o Architecture Doc. 
Analise todo o código implementado (3 layers + normalizer 
+ API + persistência + recovery).

Aplique suas 10 fases com atenção especial a:

- FASE 3 (Error Handling): o Recovery System realmente 
  funciona? Falha parcial é tratada ou crasha?
- FASE 5 (Edge Cases): o que acontece com PDF vazio? 
  URL que retorna 403? Veículo com placa duplicada de 
  fontes diferentes? Valor "a combinar" em vez de número?
- FASE 7 (Segurança): credenciais de login estão hardcoded? 
  A API tem rate limiting? Inputs são sanitizados?
- FASE 8 (Performance): o que acontece com PDF de 500 
  veículos? Site com 100 páginas?

*review-build
```

**Exemplos reais do tipo de issue que o QA deve encontrar em sistemas de scraping**:

- "O PDF parser não tem timeout. Um PDF malformado pode travar o worker indefinidamente." *(Fase 8)*
- "Credenciais do Layer 3 estão em variável no código. Mover para environment variables." *(Fase 7)*
- "Se dois PDFs de leiloeiras diferentes listam o mesmo veículo (mesma placa), ambos são salvos como registros separados. Falta lógica de deduplicação." *(Fase 5)*
- "O Normalizer silenciosamente descarta registros com menos de 3 campos. Deveria salvar como parcial e reportar." *(Fase 3)*
- "A API não pagina resultados. GET /vehicles com 10.000 registros vai retornar tudo de uma vez." *(Fase 8)*
- "O endpoint de status expõe contagem de erros por layer, mas não os motivos. Sem o motivo, debug em produção é impossível." *(Fase 10)*

**Como avaliar o review**:

> **Checklist de qualidade do review**
> - <input type="checkbox" class="checkbox-input" /> O QA testou com dados problemáticos (não apenas happy path)?
> - <input type="checkbox" class="checkbox-input" /> Há issues sobre o Recovery System?
> - <input type="checkbox" class="checkbox-input" /> Há issues sobre deduplicação?
> - <input type="checkbox" class="checkbox-input" /> Há issues de segurança (credenciais, sanitização)?
> - <input type="checkbox" class="checkbox-input" /> Há issues de performance (timeouts, paginação)?

Se o review não testar o Recovery:

```
Quinn, o review não verificou o que acontece quando o 
scraping falha parcialmente. Teste: o que acontece se 
você alimentar um PDF onde metade dos veículos tem dados 
faltando? O pipeline salva os bons e reporta os ruins? 
Ou crasha tudo? Esse é o cenário mais comum em produção.
```

---

### Passo 5 — Ciclo de correções

```
*exit

@dev

Dex, o QA encontrou issues. Leia o relatório e corrija 
todas as issues critical e high.

Para cada correção:
1. Implemente o fix
2. Adicione teste que cobre o cenário
3. Garanta que o pipeline end-to-end continua funcionando

*apply-qa-fix
```

Depois, verificação:

```
*exit

@qa

Quinn, o Dev corrigiu as issues. 

*verify-fix

Verifique que cada issue critical e high foi resolvida 
e que as correções não quebraram o pipeline.
```

Repita até aprovação.

> **🏆 Checkpoint 4 — VITÓRIA DA AULA**: Pipeline completo + Recovery + QA aprovado.

---

### Passo 6 — Commit

```bash
*exit

git add .
git commit -m "feat: data normalizer, API, persistence, and recovery system

- Data Normalizer: unified schema from any scraping layer
- Completeness scoring per vehicle record
- Recovery System: partial extraction, layer fallback, retry queue
- REST API with filters and pipeline status endpoint
- PostgreSQL persistence with extraction metadata
- QA review fixes: deduplication, pagination, timeout handling,
  credential security, edge case coverage"
```

---

## Reflexão

### O pipeline completo — do caos ao dado limpo

Olhe para o que o AuctionHunter é agora versus o que era na tentativa anterior:

```
ANTES (tentativa anterior):
  PDF → regex frágil → JSON bagunçado → falha silenciosa

AGORA (com AIOX):
  Input (PDF/URL)
    → Layer 1 tenta (se falha → Layer 2 → Layer 3)
    → Extração parcial preservada (Recovery)
    → Normalização para schema unificado
    → Validação + completeness score
    → Persistência com metadata
    → API com filtros e status
    → Cada falha logada e rastreável
```

A diferença não é mágica — é **estrutura**. Cada componente tem responsabilidade clara, spec definida, recovery para quando falha, e logging para quando precisa debugar. Nada disso existia antes.

### Recovery como feature, não como patch

Na maioria dos projetos, error handling é adicionado depois — quando algo quebra em produção. No AuctionHunter, o Recovery System é uma **feature de primeira classe**: tem spec própria, implementação dedicada, e testes com falhas provocadas. Isso é possível porque o failure analysis da Aula 09 documentou exatamente onde as coisas falham, e as specs da Aula 10 transformaram cada ponto de falha em requisito.

### O conceito-chave

> **O Recovery System do ADE transforma um projeto que "funciona quando tudo dá certo" em um projeto que "funciona mesmo quando as coisas dão errado". Em scraping, onde fontes mudam sem aviso e dados são inerentemente inconsistentes, Recovery não é luxo — é o que permite o sistema existir em produção.**

### Conexão com a próxima aula

Na Aula 13, o @devops fecha o AuctionHunter: containerização do pipeline, scheduling para scraping periódico, observabilidade com logs e métricas de sucesso/falha, e a retrospectiva do módulo. Após a Aula 13, o AuctionHunter estará containerizado, agendado e observável — pronto para rodar de verdade.

---

> **Anterior**: Aula 11 — Dev: Implementando os Scrapers
> **Próxima**: Aula 13 — DevOps: Containerização, Scheduling e Retrospectiva
