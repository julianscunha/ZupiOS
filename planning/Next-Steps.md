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

**Avançar na definição da arquitetura executável (ZUPI-004) sem presumir compatibilidade com a TV Samsung.** Primeiro definir fronteiras e contratos independentes de hardware; em seguida comparar opções concretas de sistema-base/kernel, perfil de execução e toolchain para uma fatia inicial testável em ambiente controlado. Critérios e estado atual estão em [[docs/architecture/README|Estado da arquitetura]] e [[planning/Backlog|Backlog]].

A revalidação automatizada do protótipo ZUPI-006 passou em 2026-10-22: 14/14 testes de navegação, interação no navegador, viewports 1920×1080 e 1280×600, nomes longos de perfil e verificação de diff. Isso não exige teste em TV física nesta fase. A direção visual continua exploratória; aprovação estética final pelo mantenedor é uma revisão separada, e teste com controle remoto/TV representativos fica condicionado à existência de hardware e procedimento adequados.

A prova de boot atual permanece um teste isolado de BIOS legado em QEMU, não um kernel nem um bootloader de produto. A linha de base de desempenho do produto continua bloqueada até existir um sistema executável e instrumentável. A portabilidade nativa para a Samsung permanece não demonstrada; não modificar firmware nem assumir arquitetura de CPU sem evidência específica.

## Fonte de verdade por assunto

- [[planning/Backlog|Backlog]] — tarefas, dependências e critérios de aceite.
- [[planning/Roadmap|Roadmap]] — fases e marcos de alto nível.
- [[docs/architecture/README|Estado da arquitetura]] — fronteiras, alternativas e decisões arquiteturais pendentes.
- [[planning/compatibility-requirements|Requisitos de compatibilidade]] — baseline v1.0 aprovada; divisão gratuito/Premium ainda em aberto.
- [[docs/product/requisitos-de-desempenho|Requisitos de desempenho e leveza]] — métricas, protocolo e metas.
- [[docs/product/direcao-visual-e-interacao|Direção visual e modelo de interação]] — princípios e fluxos da interface de TV.
- [[planning/validation-roadmap|Plano de validação técnica]] — métodos, evidências e limites dos testes.
- [[tests/boot-poc/README|Prova de boot em QEMU]] — instruções para executar o teste atual.
- [[planning/decisions/0004-adaptacao-hardware-e-implantacao|ADR 0004]] — restrições de hardware e implantação.
- [[planning/decisions/0006-politica-de-idioma-e-localizacao|Política de idioma e localização]].

## Regra de manutenção

Atualizar esta página apenas quando mudar a próxima ação. Registrar tarefas e critérios no backlog, fases no roadmap, procedimentos e resultados técnicos no documento de validação e decisões permanentes nos ADRs. Não manter aqui histórico de execução.
