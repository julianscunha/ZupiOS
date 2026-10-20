---
title: Próximos passos do ZupiOS
type: project-continuity
status: active
tags:
  - zupios
  - planejamento
  - continuidade
---

# Próximos passos do ZupiOS

Esta página é somente um ponto de entrada para a próxima ação. Não replica tarefas, critérios de aceite, fases ou resultados registrados em outros documentos.

## Próxima ação

**Validar ZUPI-005: executar a prova de payload em QEMU, incluindo cinco repetições e o caso de falha de leitura induzida.** O contrato e os dois cenários já estão implementados, mas a validação ainda não foi aprovada: o ambiente local não dispõe de GNU `as`. Não implementar kernel nem inferir compatibilidade com a TV a partir desta prova. Os critérios de aceite estão no [[planning/Backlog#zupi-005--definir-contrato-de-carregamento-de-payload-mínimo|backlog]].

## Fonte de verdade por assunto

- [[planning/Backlog|Backlog]] — tarefas, dependências e critérios de aceite.
- [[planning/Roadmap|Roadmap]] — fases e marcos de alto nível.
- [[planning/validation-roadmap|Plano de validação técnica]] — procedimento, evidências, limites e portões de decisão para boot e hardware.
- [[tests/boot-poc/README|Prova de boot em QEMU]] — instruções para executar o teste atual.
- [[docs/architecture/README|Estado da arquitetura]] — decisões arquiteturais ainda não aprovadas.
- [[planning/decisions/0004-adaptacao-hardware-e-implantacao|ADR 0004]] — restrições de hardware e implantação.
- [[planning/decisions/0006-politica-de-idioma-e-localizacao|Política de idioma e localização]].

## Regra de manutenção

Atualizar esta página apenas quando mudar a próxima ação. Registrar tarefas e critérios no backlog, fases no roadmap, procedimentos e resultados técnicos no documento de validação e decisões permanentes nos ADRs. Não manter aqui histórico de execução.
