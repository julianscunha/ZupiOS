---
title: Backlog do ZupiOS
type: planning
status: active
tags:
  - zupios
  - backlog
---

# Backlog do ZupiOS

O backlog contém os próximos trabalhos verificáveis. Prioridades e estimativas serão adicionadas quando o escopo estiver definido.

## P0 — Decisões e descoberta

### ZUPI-001 — Identificar o hardware de referência
- **Estado:** pendente
- **Objetivo:** registrar modelo exato, revisão e versão de firmware do dispositivo inicial.
- **Critérios de aceite:**
  - [x] Modelo completo e versão de firmware registrados; firmware informado pelo usuário e identificação física distinguida dos dados inferidos.
  - [ ] Especificações conhecidas ligadas a fontes verificáveis.
  - [ ] Dados desconhecidos marcados como pendentes, sem suposições apresentadas como fatos.
- **Progresso:** identificação básica registrada em [[planning/validation-roadmap|plano de validação técnica]]; tarefa permanece pendente até concluir a verificação das especificações e incertezas.

### ZUPI-002 — Definir requisitos de compatibilidade
- **Estado:** pendente
- **Objetivo:** decidir quais aplicações, recursos e comportamentos devem ser padronizados primeiro.
- **Dependência:** ZUPI-001.
- **Critérios de aceite:**
  - Casos de uso prioritários documentados.
  - Requisitos classificados por prioridade.
  - Itens fora do escopo inicial explicitamente identificados.

### ZUPI-003 — Validar viabilidade de execução nativa
- **Estado:** pendente
- **Objetivo:** determinar o caminho suportado e tecnicamente verificável para executar o ZupiOS no dispositivo de referência.
- **Dependência:** ZUPI-001.
- **Critérios de aceite:**
  - Evidências, restrições e riscos registrados.
  - Nenhuma alteração potencialmente destrutiva de firmware sem plano de recuperação validado.
  - Resultado registrado como viável, inviável com as evidências disponíveis ou inconclusivo.

### ZUPI-004 — Aprovar a arquitetura inicial
- **Estado:** bloqueado
- **Objetivo:** escolher a base do sistema, o runtime e as fronteiras entre SDK, serviços e hardware.
- **Dependência:** ZUPI-002 e ZUPI-003.
- **Critérios de aceite:**
  - Decisão arquitetural registrada com alternativas e justificativas.
  - Interfaces entre componentes identificadas.
  - Premissas ainda não validadas listadas.

## Fora do backlog de implementação por enquanto

Não iniciar launcher, marketplace ou serviços remotos antes de definir o caminho de execução no hardware e os requisitos prioritários.
