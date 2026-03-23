# Aula 13 — Quiz Engine Gamificado + Learning Path

<!-- metadata
course: Mastery
module: 4
lesson: 13
title: "Quiz Engine Gamificado + Learning Path"
duration: 4-5 horas
agents: "@dev, @zabbix-expert, @qa"
project: Plataforma Zabbix Learning
phase: Desenvolvimento Core
prerequisites: Aula 12 concluída (Content Engine com RAG)
-->

---

> **Módulo 4** · Plataforma Zabbix: Desenvolvimento Core
> **Duração**: 4-5 horas
> **Agentes praticados**: `@dev`, `@zabbix-expert`, `@qa`
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

Quiz Engine com gamificação completa integrado ao Content Engine, e Learning Path adaptativo que ajusta a jornada baseado na performance do aluno.

**Critério binário**: Quiz jogável com XP/badges/ranking + dificuldade adaptativa + path que avança ou recua baseado em acertos + integração content ↔ quiz ↔ path funcional.

---

## Conceito

### A tríade ensino-avaliação-adaptação

O Content Engine gera aulas. O Quiz Engine avalia se o aluno aprendeu. O Learning Path decide o próximo passo. Juntos, formam um ciclo que nenhuma playlist estática oferece:

```
Content Engine → Aluno estuda aula
  → Quiz Engine → Aluno responde quiz
    → Performance? 
      → ≥80%: Learning Path avança
      → 60-80%: Revisão leve + quiz alternativo
      → <60%: Re-estudo + conteúdo suplementar
```

### Gamificação que engaja sem infantilizar

A audiência são profissionais de TI — gamificação precisa ser motivadora sem ser condescendente. XP e streaks funcionam como reconhecimento de progresso. Badges celebram conquistas reais ("Mestre de Triggers" requer acertar 50 perguntas sobre triggers). Ranking cria competição saudável entre colegas.

| Elemento | Propósito | Cuidado |
|----------|-----------|---------|
| XP | Progresso visível | Não inflacionar — pontos devem significar algo |
| Streaks | Consistência de estudo | Grace period para não punir 1 dia ausente |
| Badges | Conquistas de domínio | Baseados em competência, não tempo |
| Ranking | Competição saudável | Opt-in, não forçado |
| Levels | Progressão geral | Alinhados com a taxonomia (Nível 1 = Fundamentos) |

---

## Contexto

O Quiz Engine básico foi implementado na Aula 06 (ADE 13 steps). Agora integramos com Content Engine e Learning Path, adicionando a camada de adaptatividade que transforma a plataforma de "repositório" em "tutor personalizado".

---

## Prática

### Passo 1 — Integrar Quiz com Content Engine

```bash
cd ~/aiox-mastery/zabbix-platform
claude
```

```
@dev

Dex, integre o Quiz Engine com o Content Engine.

Requisitos:
1. Cada aula do Content Engine tem quizzes vinculados
2. @zabbix-expert gera perguntas baseadas no conteúdo 
   específico da aula (não perguntas genéricas)
3. Múltiplos tipos de pergunta:
   - Múltipla escolha (4 alternativas)
   - Verdadeiro/Falso
   - Ordenação (colocar passos na ordem correta)
   - Completar frase (preencher lacuna em config)
4. Cada pergunta tem: enunciado, alternativas, resposta 
   correta, explicação detalhada, referência à doc, 
   dificuldade (easy/medium/hard)
5. Perguntas são armazenadas no banco vinculadas à aula

Consulte a spec do Quiz Engine e o PRD shard 
docs/prd/prd-quiz-engine.md.
```

**Como verificar**:

```bash
# Gerar perguntas para uma aula existente
curl -X POST http://localhost:3000/api/quiz/generate \
  -d '{"lessonId":1,"count":5,"difficulty":"medium"}' | jq

# Iniciar sessão de quiz
curl -X POST http://localhost:3000/api/quiz/start \
  -d '{"userId":1,"lessonId":1}' | jq

# Responder
curl -X POST http://localhost:3000/api/quiz/answer \
  -d '{"sessionId":1,"questionId":1,"answer":"B","timeMs":5000}' | jq
```

> **Checklist de integração quiz ↔ content**
> - <input type="checkbox" class="checkbox-input" /> Perguntas são geradas do conteúdo da aula específica?
> - <input type="checkbox" class="checkbox-input" /> Múltiplos tipos de pergunta funcionam?
> - <input type="checkbox" class="checkbox-input" /> Explicação é educativa (não apenas "a resposta é C")?
> - <input type="checkbox" class="checkbox-input" /> Dificuldade é classificada corretamente?
> - <input type="checkbox" class="checkbox-input" /> @zabbix-expert valida precisão técnica?

> **🏆 Checkpoint 1**: Quiz integrado com Content Engine.

---

### Passo 2 — Gamificação completa

```
Dex, implemente gamificação no Quiz Engine:

1. XP: pontos por acerto
   - Easy: 10 XP
   - Medium: 25 XP
   - Hard: 50 XP
   - Multiplicador por speed (resposta rápida = mais XP)
   - Multiplicador por streak (sequência de acertos)

2. Streaks: sequência de acertos consecutivos
   - Visual na UI (🔥 x5)
   - Streak bonus a cada 5 acertos

3. Badges baseados em competência:
   - "Primeiro Quiz" (completar 1 quiz)
   - "Sem Erro" (quiz completo sem errar)
   - "Mestre de [Tópico]" (50 acertos no tópico)
   - "Maratonista" (5 quizzes no mesmo dia)
   - "Streak de 10" / "Streak de 25" / "Streak de 50"

4. Ranking: global e por módulo
   - Opt-in (aluno escolhe participar)
   - Atualiza em tempo real

5. Levels: XP acumulado → level up
   - Level 1: Novato (0-500 XP)
   - Level 2: Aprendiz (500-2000 XP)
   - Level 3: Praticante (2000-5000 XP)
   - Level 4: Especialista (5000-15000 XP)
   - Level 5: Mestre (15000+ XP)
```

> **Checklist de gamificação**
> - <input type="checkbox" class="checkbox-input" /> XP calcula com multiplicadores corretos?
> - <input type="checkbox" class="checkbox-input" /> Streaks incrementam e resetam corretamente?
> - <input type="checkbox" class="checkbox-input" /> Badges são concedidos quando critério é atingido?
> - <input type="checkbox" class="checkbox-input" /> Ranking atualiza em tempo real?
> - <input type="checkbox" class="checkbox-input" /> Levels correspondem ao XP acumulado?

> **🏆 Checkpoint 2**: Gamificação completa funcional.

---

### Passo 3 — Learning Path adaptativo

```
Dex, implemente o Learning Path Engine:

1. Jornada definida pela taxonomia da Aula 08 
   (5 níveis, múltiplos tópicos por nível)

2. Progressão adaptativa:
   - Aluno completa aula → faz quiz
   - ≥80% acertos → avança para próximo tópico
   - 60-80% → revisão leve (resumo + quiz alternativo)
   - <60% → re-estudo (conteúdo suplementar + quiz mais fácil)

3. Path é personalizado por aluno:
   - Cada aluno tem seu progresso
   - Pode avançar mais rápido em tópicos que domina
   - É direcionado para revisão em tópicos fracos

4. Visualização:
   - Mapa de progresso (quais tópicos completou)
   - Próximo passo sugerido
   - Estimativa de tempo até conclusão

5. Integração:
   - Content Engine: busca aula do próximo tópico
   - Quiz Engine: avalia e retorna performance
   - Auth: path gatado por plano (free = caminho limitado)
```

**Como verificar**: Simule dois alunos com performances diferentes e verifique que os paths divergem:

```bash
# Aluno A: acerta tudo
# Deve avançar rápido pelo path

# Aluno B: erra muito
# Deve receber conteúdo de revisão

# Comparar: /api/learning-path/1 vs /api/learning-path/2
# Os próximos passos devem ser diferentes
```

> **Checklist do Learning Path**
> - <input type="checkbox" class="checkbox-input" /> Performance ≥80% → avança?
> - <input type="checkbox" class="checkbox-input" /> Performance <60% → revisão?
> - <input type="checkbox" class="checkbox-input" /> Path é personalizado por aluno (dois alunos divergem)?
> - <input type="checkbox" class="checkbox-input" /> Mapa de progresso visualiza conquistas?
> - <input type="checkbox" class="checkbox-input" /> Feature gating funciona (free = caminho limitado)?
> - <input type="checkbox" class="checkbox-input" /> Estimativa de tempo é calculada?

> **🏆 Checkpoint 3**: Learning Path adaptativo funcional.

---

### Passo 4 — QA review da integração

```
*exit

@qa

Quinn, review da integração Content Engine ↔ Quiz Engine 
↔ Learning Path.

Foco:
- A adaptatividade REALMENTE funciona? Simule aluno que 
  acerta tudo vs aluno que erra muito — os paths divergem?
- A gamificação é consistente? XP nunca fica negativo? 
  Badges são concedidos uma vez (não repetidamente)?
- O feature gating funciona no path (free limitado)?
- Edge cases: aluno completa quiz com 0% de acerto? 
  Quiz sem perguntas disponíveis? Path sem próximo passo?

*review-build
```

Ciclo de correções até aprovação.

> **🏆 Checkpoint 4 — VITÓRIA DA AULA**: Quiz gamificado + Learning Path adaptativo + integração aprovada.

---

### Passo 5 — Commit

```bash
*exit
git add .
git commit -m "feat: gamified Quiz Engine + adaptive Learning Path

- Quiz integrated with Content Engine (contextual questions)
- 4 question types: multiple choice, true/false, ordering, fill-in
- Full gamification: XP with multipliers, streaks, badges, ranking, levels
- Adaptive Learning Path: advance/review/restudy based on performance
- Personalized per student with progress visualization
- QA integration review approved"
```

---

## Reflexão

### O conceito-chave

> **O Learning Path adaptativo transforma a plataforma de "repositório de conteúdo" em "tutor personalizado". Cada aluno tem jornada diferente baseada no que sabe e no que precisa aprender. A tríade Content Engine → Quiz Engine → Learning Path cria um ciclo de ensino-avaliação-adaptação que nenhuma playlist estática oferece.**

### Conexão com a próxima aula

Na Aula 14, o último par de subsistemas: Ferramentas Interativas (mini-apps que ensinam Zabbix na prática) e Lab Provisioner real (instâncias Zabbix efêmeras). Após a Aula 14, os 6 subsistemas da plataforma estarão implementados.

---

> **Anterior**: Aula 12 — Content Engine com RAG
> **Próxima**: Aula 14 — Ferramentas Interativas e Lab Provisioner
