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

**Revisar o artefato e os limites da prova Linux em QEMU antes de propor a próxima etapa arquitetural.** A primeira prova automatizada passou em 2026-10-22: o kernel Linux iniciou com initramfs mínimo, emitiu os marcadores de boot e desligamento e o QEMU terminou com código 0 ([execução CI](https://github.com/julianscunha/ZupiOS/actions/runs/39781473737), commit `76c6888`). Registrar qualquer refinamento de procedimento em [[planning/validation-roadmap|Plano de validação técnica]]. Não declarar ZUPI-004 concluído: a decisão arquitetural continua bloqueada pela viabilidade nativa inconclusiva em ZUPI-003. O próximo trabalho deve resolver/documentar as decisões de arquitetura e requisitos de execução, mantendo separadas a prova QEMU e a compatibilidade com a TV. Os contratos de fronteira em [[docs/architecture/README|Estado da arquitetura]] ainda são rascunhos, não APIs implementadas.

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
