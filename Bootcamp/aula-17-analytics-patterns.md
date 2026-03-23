# Aula 17 — Analytics de Engajamento e Padrões

<!-- metadata
module: 4
lesson: 17
title: "Analytics de Engajamento e Padrões"
duration: 4 horas
agents: "@dev, @qa"
project: Squad LinkedIn Monitoragindo
phase: Desenvolvimento (Fase 2)
prerequisites: Aula 16 concluída (backend + métricas + publicação)
-->

---

> **Módulo 4** · Squad LinkedIn Monitoragindo
> **Duração**: 4 horas
> **Agentes praticados**: `@dev`, `@qa`
> **Projeto**: Squad LinkedIn Monitoragindo

---

## 🏆 Vitória desta aula

Dashboard de analytics com padrões de engajamento identificados por vertente, e feedback loop implementado — padrões de sucesso alimentam diretamente o Content Writer para gerar conteúdo melhor.

**Critério binário**: Dashboard mostrando métricas reais por vertente + feedback loop funcional (padrões extraídos → Content Writer gera usando os padrões).

---

## Conceito

### Data-driven content: o feedback loop que melhora o squad

Até agora o squad gera conteúdo baseado no Voice Profile (quem você é) e na knowledge base (documentação Zabbix). Isso garante autenticidade e precisão. Mas não garante **performance** — qual tipo de post sua audiência prefere? Qual hook gera mais comentários? Qual vertente tem mais alcance?

O analytics fecha esse loop: métricas de engajamento → análise de padrões → recomendações → Content Writer incorpora → novo conteúdo → novas métricas. É evolução contínua baseada em dados.

```
Squad gera → Publica → Coleta métricas → Analisa padrões
  ↑                                              |
  └──────── Feedback loop ←───────────────────────┘
```

### Padrões de engajamento: o que procurar

As métricas brutas (likes, comments) são úteis, mas os **padrões** são o que realmente gera valor:

| Padrão | Pergunta que responde | Exemplo de insight |
|--------|----------------------|-------------------|
| Por vertente | Qual tipo de conteúdo performa melhor? | "Quizzes têm 3x mais comentários que artigos" |
| Por horário | Quando publicar? | "Posts às 8h têm 40% mais impressions que às 14h" |
| Por hook | Qual abertura funciona? | "Posts que abrem com pergunta têm 2x mais engagement" |
| Por tamanho | Qual extensão ideal? | "Posts de 800-1200 caracteres performam melhor" |
| Temporal | O engajamento está crescendo? | "Engagement rate subiu 15% no último mês" |

### O princípio aplicado

Você vai descrever ao Dev que precisa de analytics e um feedback loop. **Não vai ditar** quais queries rodar, como calcular métricas ou como estruturar o feedback. O Dev implementa o analytics; o QA verifica se os dados e insights fazem sentido.

---

## Contexto

O banco tem posts com métricas coletadas (Aula 16). Para o analytics funcionar com dados suficientes, precisamos de volume. Na prática, o gerador de métricas simuladas da Aula 16 vai popular dados de 20-30 posts simulados para que os padrões sejam identificáveis. Em produção, os dados reais substituem os simulados ao longo das semanas.

---

## Prática

### Passo 1 — Popular dados para analytics

Antes do analytics, precisamos de volume de dados:

```bash
cd ~/aiox-bootcamp/linkedin-squad
claude
```

```
@dev

Dex, preciso de dados suficientes para analytics. 
Crie um seed script que popule o banco com:

- 30 posts simulados (distribuídos pelas 4 vertentes)
- Publicados ao longo de 8 semanas simuladas
- Cada post com 3 snapshots de métricas (D+1, D+3, D+7)
- Métricas realistas com variação por vertente:
  - Quizzes: mais comments e saves
  - Artigos técnicos: mais impressions e saves
  - IA na Sexta: mais likes e shares
  - Mentalidade: mais comments
- Variação por horário de publicação (manhã vs tarde)
- Alguns posts claramente melhores que outros (outliers)

Os dados precisam ter padrões IDENTIFICÁVEIS para que 
o analytics consiga extraí-los. Se tudo for uniforme, 
o analytics não encontra nada útil.
```

**Como verificar**:

```bash
# Rodar seed
npm run db:seed  # ou o comando que o Dev configurou

# Verificar volume
curl http://localhost:3000/api/posts | jq '.total'
# Deve retornar ~30

# Verificar distribuição por vertente
curl "http://localhost:3000/api/posts?vertical=quiz" | jq '.total'
curl "http://localhost:3000/api/posts?vertical=article" | jq '.total'
```

> **🏆 Checkpoint 1**: 30 posts com métricas no banco.

---

### Passo 2 — Analytics engine

```
Dex, implemente o analytics engine. Leia as stories 
de analytics em docs/stories/ e o Architecture Doc.

Preciso de endpoints que respondam:

1. PERFORMANCE POR VERTENTE:
   - Média de likes, comments, impressions por vertente
   - Qual vertente tem melhor engagement rate?
   - Evolução por vertente ao longo das semanas

2. PERFORMANCE POR HORÁRIO:
   - Horários de publicação com melhor performance
   - Distribuição de engagement por dia da semana

3. ANÁLISE DE HOOKS:
   - Classificar posts pelo primeiro parágrafo 
     (pergunta, afirmação, história, dado numérico)
   - Correlacionar tipo de hook com engagement

4. ANÁLISE DE TAMANHO:
   - Correlacionar tamanho do post (caracteres) 
     com engagement
   - Faixas de tamanho com melhor performance

5. TOP PERFORMERS:
   - Posts com melhor performance absoluta
   - Posts com melhor performance relativa (vs média 
     da vertente)
   - O que têm em comum? (vertente, hook, tamanho, horário)

Cada endpoint deve retornar dados estruturados em JSON 
que possam alimentar dashboards.
```

**Como verificar**:

```bash
# Performance por vertente
curl http://localhost:3000/api/analytics/by-vertical | jq

# Performance por horário
curl http://localhost:3000/api/analytics/by-time | jq

# Top performers
curl http://localhost:3000/api/analytics/top-posts | jq

# O que funciona (padrões identificados)
curl http://localhost:3000/api/analytics/patterns | jq
```

> **Checklist de avaliação do analytics**
> - <input type="checkbox" class="checkbox-input" /> Cada endpoint retorna dados estruturados?
> - <input type="checkbox" class="checkbox-input" /> Performance por vertente mostra diferenças claras?
> - <input type="checkbox" class="checkbox-input" /> Análise de hooks classifica posts pelo tipo de abertura?
> - <input type="checkbox" class="checkbox-input" /> Top performers identificam o que os melhores posts têm em comum?
> - <input type="checkbox" class="checkbox-input" /> Dados fazem sentido? (quizzes realmente têm mais comments se o seed simulou isso?)
> - <input type="checkbox" class="checkbox-input" /> Há endpoint consolidado de padrões (/api/analytics/patterns)?

Se os padrões não forem identificáveis:

```
Dex, o endpoint de patterns retorna "sem padrões 
identificados". Se o seed criou dados com variação por 
vertente e por horário, os padrões devem ser detectáveis. 
Verifique: o analytics está comparando métricas entre 
grupos? Ou só calculando médias globais?
```

Se o analytics for puramente numérico:

```
Dex, os endpoints retornam números mas não insights. 
Preciso que /api/analytics/patterns retorne insights 
acionáveis: "Posts da vertente quiz têm 3x mais 
comentários que artigos", "Posts publicados entre 8h-10h 
têm 40% mais impressions". Esses insights vão alimentar 
o Content Writer.
```

> **🏆 Checkpoint 2**: Analytics engine retornando padrões identificáveis.

---

### Passo 3 — Dashboard de analytics

```
Dex, crie um dashboard (página web ou Grafana) que 
visualize os dados do analytics.

O dashboard deve mostrar:
1. Visão geral: total de posts, média de engagement, 
   tendência (subindo/descendo)
2. Comparativo por vertente: gráfico de barras com 
   engagement médio por vertente
3. Timeline: engagement ao longo das semanas 
   (gráfico de linha)
4. Mapa de calor: dia da semana × horário com 
   intensidade de engagement
5. Top 5 posts: lista com preview do hook e métricas

O dashboard deve funcionar com os dados reais do banco — 
não dados hardcoded na UI.
```

**Como verificar**: Abrir o dashboard no browser e conferir que os gráficos refletem os dados do banco.

> **Checklist de avaliação do dashboard**
> - <input type="checkbox" class="checkbox-input" /> Dashboard carrega sem erro?
> - <input type="checkbox" class="checkbox-input" /> Gráficos mostram dados reais (não estáticos)?
> - <input type="checkbox" class="checkbox-input" /> Comparativo por vertente mostra diferenças?
> - <input type="checkbox" class="checkbox-input" /> Timeline mostra tendência ao longo do tempo?
> - <input type="checkbox" class="checkbox-input" /> Top posts são realmente os melhores (confira no banco)?

> **🏆 Checkpoint 3**: Dashboard visual funcionando com dados reais.

---

### Passo 4 — Feedback loop: padrões → Content Writer

Esta é a feature que fecha o ciclo:

```
Dex, implemente o feedback loop. O fluxo:

1. Analytics identifica padrões de sucesso 
   (endpoint /api/analytics/patterns)
2. Padrões são formatados como INSTRUÇÕES para o 
   Content Writer (documento legível por agente)
3. O Content Writer, ao gerar próximo conteúdo, lê 
   essas instruções e as incorpora

Exemplo concreto:
- Analytics identifica: "Posts com hook de pergunta 
  retórica têm 2x mais comentários"
- Instrução gerada: "Priorizar hooks com pergunta 
  retórica — dados mostram 2x mais comentários"
- Content Writer recebe essa instrução como contexto 
  adicional ao Voice Profile

Gere o documento de feedback em docs/content-feedback.md
e implemente um endpoint que retorne as instruções 
atualizadas.
```

**Como verificar**: Gere uma nova peça de conteúdo com o feedback loop ativo e compare com as peças da Aula 15 (sem feedback). O conteúdo deve refletir os padrões identificados:

```bash
# Gerar padrões
curl http://localhost:3000/api/analytics/patterns | jq

# Ver instruções formatadas para o Content Writer
curl http://localhost:3000/api/analytics/content-feedback | jq

# Verificar que docs/content-feedback.md existe e tem insights
cat docs/content-feedback.md
```

> **Checklist de avaliação do feedback loop**
> - <input type="checkbox" class="checkbox-input" /> Padrões são traduzidos em instruções acionáveis?
> - <input type="checkbox" class="checkbox-input" /> Instruções são específicas (não "faça posts melhores")?
> - <input type="checkbox" class="checkbox-input" /> O documento é legível por outro agente (Content Writer)?
> - <input type="checkbox" class="checkbox-input" /> As instruções mudam conforme novos dados chegam?
> - <input type="checkbox" class="checkbox-input" /> O feedback inclui tanto "faça mais disso" quanto "evite isso"?

Se o feedback for genérico:

```
Dex, o content-feedback.md diz "publique conteúdo de 
qualidade". Isso não é insight — é obviedade. Os dados 
mostram padrões específicos. Preciso de instruções como: 
"Vertente quiz: abra com cenário prático (não pergunta 
direta) — posts assim tiveram 2x mais saves. Evitar 
posts > 2000 caracteres nesta vertente."
```

> **🏆 Checkpoint 4**: Feedback loop funcional — padrões → instruções → Content Writer.

---

### Passo 5 — QA Review do sistema

```
*exit

@qa

Quinn, revise o sistema de analytics e feedback loop.

Foco especial em:
- FASE 5: Os padrões identificados são estatisticamente 
  válidos? (com 30 posts, alguma conclusão pode ser espúria)
- FASE 8: Queries de analytics são eficientes? (não vão 
  travar com 1000 posts?)
- FASE 3: O que acontece se não houver dados suficientes 
  para um padrão? (divisão por zero? Null?)
- FASE 10: Os insights são documentados e versionados?

*review-build
```

Ciclo de correções padrão:

```
*exit
@dev
Dex, corrija as issues critical e high do QA.
*apply-qa-fix
```

```
*exit
@qa
Quinn, verifique as correções.
*verify-fix
```

> **🏆 Checkpoint 5 — VITÓRIA DA AULA**: Analytics + Dashboard + Feedback loop + QA aprovado.

---

### Passo 6 — Commit

```bash
*exit

git add .
git commit -m "feat: analytics engine, dashboard, and content feedback loop

- Analytics by vertical, time, hook type, post length
- Pattern detection with actionable insights
- Dashboard with charts and top performers
- Feedback loop: patterns → content instructions → Content Writer
- QA review fixes applied"
```

---

## Reflexão

### O squad agora é um sistema com inteligência

Olhe para a evolução ao longo das 4 aulas do módulo:

```
Aula 14: Arquitetura     → Squad definido (6 agentes, 4 workflows)
Aula 15: Voice + Content → Conteúdo gerado na sua voz
Aula 16: Backend         → Persistência + publicação + métricas
Aula 17: Analytics       → Padrões + feedback loop
```

O squad evoluiu de "configuração de agentes" para "sistema de inteligência de conteúdo". Não é mais "IA que escreve posts" — é **plataforma que gera, publica, mede e melhora conteúdo continuamente**.

### O conceito-chave

> **O feedback loop data-driven é o que transforma um squad estático em um squad que evolui. Sem analytics, cada peça de conteúdo é uma aposta. Com analytics, cada peça é informada pelas anteriores. O squad não só gera conteúdo — ele aprende qual conteúdo funciona.**

### Conexão com a próxima aula

Na Aula 18 — a última do Bootcamp — fechamos tudo: automação end-to-end (scheduling semanal do squad), brownfield do protótipo Google AI Studio, deploy e a retrospectiva completa dos 3 projetos. Depois da Aula 18, o Bootcamp estará concluído e você terá 3 projetos reais funcionando.

---

> **Anterior**: Aula 16 — Backend de Persistência e Analytics
> **Próxima**: Aula 18 — Automação, Brownfield e Consolidação do Bootcamp
