# Aula 07 — Dev + QA: Frontend, Testes e Qualidade

<!-- metadata
module: 2
lesson: 7
title: "Dev + QA: Frontend, Testes e Qualidade"
duration: 4 horas
agents: "@dev, @qa"
project: RockQuiz
phase: Desenvolvimento + Qualidade
prerequisites: Aula 06 concluída (API funcional)
-->

---

> **Módulo 2** · RockQuiz: Pipeline Completo
> **Duração**: 4 horas
> **Agentes praticados**: `@dev`, `@qa`
> **Projeto**: RockQuiz

---

## 🏆 Vitória desta aula

Frontend funcional integrado à API + testes com cobertura sólida + QA review completo com ciclo de correções aprovado.

**Critério binário**: App jogável no browser + testes passando + QA aprovou.

---

## Conceito

### O QA: o par crítico que torna o código profissional

Até agora o @dev implementou sozinho. A partir desta aula, o @qa entra como **par crítico**. Ele não procura bugs triviais (testes fazem isso) — ele avalia qualidade holística em **10 fases**, cada uma olhando por uma lente diferente:

| Fase | Lente |
|------|-------|
| 1 | Conformidade com acceptance criteria |
| 2 | Qualidade e legibilidade do código |
| 3 | Robustez do error handling |
| 4 | Cobertura e qualidade dos testes |
| 5 | Edge cases não cobertos |
| 6 | Consistência com Architecture Doc |
| 7 | Segurança |
| 8 | Performance |
| 9 | Manutenibilidade |
| 10 | Documentação |

O ciclo de feedback é formal:

```
@qa encontra issues → *request-fix → @dev corrige → *apply-qa-fix → @qa verifica → *verify-fix
```

### O princípio aplicado ao QA

Você não vai dizer ao QA **o que procurar** — ele sabe (as 10 fases são seu checklist interno). Você vai pedir o review, ler o relatório, e garantir que o Dev corrige o que foi encontrado. Seu papel é **orquestrar o ciclo**, não dirigir a análise.

---

## Contexto

Nesta aula fazemos três coisas: o Dev implementa o frontend (story correspondente), o Dev escreve testes, e o QA faz review de **tudo** (backend + frontend + testes). O QA vai encontrar problemas — e cada fix melhora o projeto.

---

## Prática

### Passo 1 — Dev implementa o frontend

```bash
cd ~/aiox-bootcamp/rockquiz
claude
```

```
@dev

Dex, leia a story de frontend em docs/stories/ e o UX Spec 
em docs/ux-spec.md.

Implemente o frontend completo do RockQuiz. A Uma (UX Expert) 
definiu o design, o fluxo de telas e os padrões visuais no 
UX Spec. A Aria (Architect) definiu a stack e a estrutura no 
Architecture Doc.

Preciso de:
- Todas as telas que o UX Spec define (landing, quiz, resultado, ranking)
- A integração com a API que você implementou na aula anterior
- O feedback visual que a Uma especificou (acerto/erro/streak/timer)
- Responsividade (funcionar em mobile e desktop)

Siga os acceptance criteria da story. Se algo do UX Spec 
não estiver claro para implementar, me pergunte.
```

**Como verificar**: Abra o browser e teste o fluxo completo.

```bash
# Garantir que API está rodando
cd packages/api && npm run dev &

# Iniciar frontend
cd packages/web && npm run dev

# Abrir http://localhost:3000
```

> **Checklist de verificação visual** (teste você mesmo no browser)
> - <input type="checkbox" class="checkbox-input" /> Landing carrega com campo de nickname e opções de modo
> - <input type="checkbox" class="checkbox-input" /> Clicar para jogar inicia um jogo e mostra pergunta
> - <input type="checkbox" class="checkbox-input" /> Alternativas são clicáveis com feedback visual
> - <input type="checkbox" class="checkbox-input" /> Timer funciona (se o UX Spec definiu timer)
> - <input type="checkbox" class="checkbox-input" /> Score atualiza a cada resposta correta
> - <input type="checkbox" class="checkbox-input" /> Streak é visualmente indicado
> - <input type="checkbox" class="checkbox-input" /> Tela de resultado mostra score e estatísticas
> - <input type="checkbox" class="checkbox-input" /> Ranking carrega e mostra dados
> - <input type="checkbox" class="checkbox-input" /> Funciona razoavelmente em tela pequena (redimensione o browser)

Se algo não funcionar ou não corresponder ao UX Spec:

```
Dex, a tela de quiz não mostra feedback quando erro uma 
pergunta — só pula para a próxima. O UX Spec diz que a 
alternativa errada deve ficar vermelha e a correta deve 
aparecer em verde com a explicação. Corrija.
```

```
Dex, no mobile as 4 alternativas ficam espremidas. 
Verifique a responsividade — em telas < 640px as 
alternativas devem empilhar verticalmente.
```

> **🏆 Checkpoint 1**: App jogável no browser — fluxo completo funciona.

---

### Passo 2 — Dev escreve testes

```
Dex, agora preciso de testes para garantir que o que 
construímos não vai quebrar quando fizermos mudanças.

Olhe os acceptance criteria de TODAS as stories implementadas 
(backend + frontend). Cada cenário de aceitação deve ter pelo 
menos um teste correspondente.

Preciso de:
- Testes unitários para a lógica de negócio (scoring, quiz engine)
- Testes de integração para os endpoints da API (com banco real)
- Pelo menos um teste E2E que percorra o fluxo completo no browser

Os testes devem cobrir tanto o caminho feliz (tudo funciona) 
quanto os caminhos de erro (input inválido, recurso não encontrado, 
estado inconsistente).

Consulte o Architecture Doc para a estratégia de testes que a 
Aria definiu.
```

**Como verificar**:

```bash
# Rodar testes
cd packages/api
npm test

# Com cobertura
npm test -- --coverage
```

> **Checklist de testes**
> - <input type="checkbox" class="checkbox-input" /> Testes passam sem erros?
> - <input type="checkbox" class="checkbox-input" /> Cobertura de linhas é razoável (≥80%)?
> - <input type="checkbox" class="checkbox-input" /> Há testes para o scoring (a lógica mais complexa)?
> - <input type="checkbox" class="checkbox-input" /> Há testes de erro (o que acontece com input inválido)?
> - <input type="checkbox" class="checkbox-input" /> Há teste E2E (fluxo completo funciona no browser)?

Se a cobertura estiver baixa:

```
Dex, a cobertura está em 65%. Os acceptance criteria do PRD 
definem vários cenários de scoring (speed bonus, streak, 
cap de multiplicador, erro). Verifique se cada cenário 
tem teste correspondente.
```

> **🏆 Checkpoint 2**: Testes passando com cobertura adequada.

---

### Passo 3 — QA Review

Agora vem o momento mais importante da aula. O QA analisa **tudo**:

```
*exit

@qa

Quinn, faça review completo do RockQuiz.

Analise todo o código implementado (backend e frontend), 
todos os testes, e verifique contra os acceptance criteria 
das stories em docs/stories/ e contra o Architecture Doc 
em docs/architecture.md.

Aplique suas 10 fases de review. Para cada issue encontrada, 
classifique por severidade (critical, high, medium, low) e 
explique exatamente o que está errado e por quê.

*review-build
```

**O que esperar**: O QA vai retornar um relatório com issues organizadas por severidade. Exemplos **reais** do tipo de coisa que o QA encontra e que testes não pegam:

- "O scoring service usa números hardcoded (100, 1.5, 0.8). Extrair para constantes nomeadas melhora manutenibilidade." *(Fase 9)*
- "Se Redis estiver indisponível, a API retorna erro 500 sem mensagem útil. Implementar fallback ou mensagem clara." *(Fase 3)*
- "O endpoint POST /api/games não valida se playerId existe antes de criar o jogo. Vai gerar erro de FK." *(Fase 5)*
- "O frontend não desabilita o botão após clicar uma alternativa. Double-click envia duas respostas." *(Fase 5)*
- "Nenhum endpoint tem rate limiting. Um usuário pode enviar 1000 requests/segundo." *(Fase 7)*
- "A query de listagem de rankings faz N+1 para buscar nicknames." *(Fase 8)*

**Como avaliar o review do QA**:

> **Checklist de qualidade do review**
> - <input type="checkbox" class="checkbox-input" /> O QA cobriu as 10 fases (não apenas testou se funciona)?
> - <input type="checkbox" class="checkbox-input" /> Cada issue tem severidade clara?
> - <input type="checkbox" class="checkbox-input" /> Cada issue explica o problema E por que é problema?
> - <input type="checkbox" class="checkbox-input" /> Há issues de segurança (fase 7)?
> - <input type="checkbox" class="checkbox-input" /> Há issues de performance (fase 8)?

Se o review parecer superficial:

```
Quinn, o review não mencionou segurança. O RockQuiz tem 
endpoints que aceitam input do usuário (nickname, respostas). 
Verifique se há validação adequada contra injection, XSS, 
e payloads malformados. Também verifique se o correctAnswer 
não vaza em nenhuma resposta antes do jogador responder.
```

---

### Passo 4 — Ciclo de correções

O QA encontrou issues. Agora o Dev corrige:

```
*exit

@dev

Dex, o QA (Quinn) encontrou issues no review. Leia o relatório 
e aplique as correções para todas as issues de severidade 
critical e high.

*apply-qa-fix

Para cada correção:
1. Implemente o fix
2. Adicione teste que cobre o cenário (se não existia)
3. Rode os testes para garantir que não quebrou nada existente
```

**Como acompanhar**: O Dev vai listar as correções que aplicou. Verifique que cada issue crítica e alta foi endereçada:

```
Dex, o QA reportou 3 issues critical e 4 high. Confirme 
que todas as 7 foram corrigidas. Liste cada issue e o que 
você fez para resolver.
```

Se o Dev disser que uma issue "não é problema":

```
Dex, você diz que o rate limiting não é necessário porque 
"o projeto é pequeno". O QA classificou como HIGH porque 
sem rate limit qualquer script pode derrubar a API. 
Implemente — é uma prática de segurança básica.
```

---

### Passo 5 — QA verifica as correções

```
*exit

@qa

Quinn, o Dev aplicou correções para as issues que você encontrou.

*verify-fix

Verifique:
1. Cada issue critical e high foi realmente corrigida?
2. As correções não introduziram novos problemas (regressão)?
3. Os testes cobrem os cenários que estavam faltando?
```

O QA deve confirmar: "Todas as issues critical/high foram resolvidas. Sem regressão detectada."

Se o QA encontrar que algo não foi corrigido adequadamente, o ciclo repete:

```
@qa → *request-fix (issue específica) → @dev → *apply-qa-fix → @qa → *verify-fix
```

Repita até o QA aprovar.

> **🏆 Checkpoint 3 — VITÓRIA DA AULA**: QA aprovou após ciclo de correções.

---

### Passo 6 — Commit consolidado

```bash
*exit

git add .
git commit -m "feat: frontend + tests + QA review fixes

- Frontend complete (all pages + components + API integration)
- Unit tests for scoring and quiz engine
- Integration tests for all API endpoints
- E2E test for complete quiz flow
- QA fixes: input validation, error handling, rate limiting,
  loading states, code quality improvements"
```

---

## Reflexão

### Testes vs QA: complementares, não redundantes

| O que testes automatizados verificam | O que o QA verifica além dos testes |
|--------------------------------------|-------------------------------------|
| "Dado input X, retorna Y?" | "O código é legível para o próximo dev?" |
| Caminho feliz funciona | Edge cases não óbvios |
| Regressão (nada quebrou) | Segurança (injection, XSS, data leak) |
| Cobertura de linhas | Performance (N+1 queries, missing indexes) |
| | Manutenibilidade (magic numbers, coupling) |
| | Consistência com Architecture Doc |

**Testes garantem que funciona. QA garante que é bom.** Ambos são necessários.

### O conceito-chave

> **O ciclo QA → Dev → QA é onde a qualidade real emerge. Cada issue encontrada e corrigida torna o projeto mais robusto de uma forma que testes sozinhos não conseguem. O QA é o agente que vê o que ninguém mais vê.**

### Conexão com a próxima aula

Na Aula 08, o @devops fecha o RockQuiz: CI/CD com GitHub Actions, observabilidade com métricas e dashboards, e deploy. Após a Aula 08, o RockQuiz estará completo, protegido e observável.

---

> **Anterior**: Aula 06 — Dev: Backend
> **Próxima**: Aula 08 — DevOps: CI/CD, Observabilidade e Deploy
