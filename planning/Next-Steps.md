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

Este documento contém apenas as próximas ações e decisões pendentes. Resultados de execução pertencem à documentação técnica correspondente; decisões permanentes pertencem aos ADRs. Não usar esta página como histórico de atividades.

## Próxima ação

**Definir o próximo critério técnico da prova de boot no ambiente controlado.** A prova atual em QEMU carrega e executa um segundo setor em BIOS legado, mas ainda não carrega um kernel e não comprova compatibilidade com a TV.

1. Fortalecer a prova de boot com verificações de erro de leitura, parâmetros de disco e layout da imagem.
2. Decidir se a etapa seguinte será carregar um payload mínimo de kernel experimental ou aprofundar a caracterização do ambiente x86 emulado.
3. Manter a arquitetura, o sistema-base e a linguagem em aberto até que os requisitos e o alvo de execução sejam aprovados.

## Decisões e bloqueios em aberto

- Confirmar, por documentação primária ou inspeção técnica qualificada, a placa e a revisão efetivamente instaladas na Samsung UN40J6400AGXZD.
- Determinar se existe um caminho de boot alternativo documentado e recuperável para a TV; até lá, tratá-la apenas como alvo experimental.
- Definir requisitos prioritários de compatibilidade antes de escolher a arquitetura inicial.
- Definir formato, integridade, assinatura, versionamento, dependências e atualização dos pacotes.
- Concluir a definição jurídica da licença e os requisitos de privacidade/telemetria.

## Referências de trabalho

- [[planning/validation-roadmap|Plano de validação técnica]] — critérios e etapas para ambiente controlado e TV.
- [[planning/Backlog|Backlog]] — trabalhos e critérios de aceite.
- [[planning/Roadmap|Roadmap]] — fases do projeto.
- [[docs/architecture/README|Estado da arquitetura]] — decisões arquiteturais ainda não aprovadas.
- [[tests/boot-poc/README|Prova de boot no QEMU]] — procedimento e limites da prova existente.
- [[planning/decisions/0006-politica-de-idioma-e-localizacao|Política de idioma e localização]].

## Regra de manutenção

Ao concluir uma tarefa, atualizar a documentação técnica ou de referência que ela afetar e ajustar esta página somente se a próxima ação mudar. Não registrar aqui listas de mudanças concluídas, logs de comandos ou resultados de cada execução.
