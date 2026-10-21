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

**Revisar o protótipo exploratório de ZUPI-006 e fechar o protocolo inicial de medição de ZUPI-007.** Em paralelo, manter a estratégia multiplataforma de boot e perfis de hardware avançando sem eleger uma TV como arquitetura universal. A Samsung UN40J6400AGXZD continua sendo um alvo experimental de compatibilidade, mas a falta de confirmação de seu SoC não deve bloquear o desenho independente do sistema, do contrato de plataforma nem o desenvolvimento host/QEMU. A imagem de boot deve ser tratada como artefato específico de uma combinação compatível de arquitetura, firmware/cadeia de boot e hardware; uma imagem única só poderá ser considerada para alvos que compartilhem requisitos comprovados.

Na revisão, percorrer todos os fluxos somente com setas/Enter/Esc, verificar foco e retorno, testar estados sem rede e falha de abertura, e inspecionar janelas largas/estreitas. Registrar feedback antes de aprovar a direção visual. O protótipo está em [[prototypes/tv-ui/README|protótipo de interface de TV]]; não define a tecnologia gráfica final nem substitui testes em TV física. Para ZUPI-007, definir procedimento reproduzível no primeiro ambiente executável, incluindo medições de inicialização, resposta a entradas e recursos. Em paralelo, registrar categorias de perfil de boot sem selecionar arquiteturas sem evidência. Manter a portabilidade nativa para a Samsung bloqueada até haver identificação confiável da placa/SoC, documentação da cadeia de boot e método de recuperação validado. Não modificar firmware.

## Fonte de verdade por assunto

- [[planning/Backlog|Backlog]] — tarefas, dependências e critérios de aceite.
- [[planning/Roadmap|Roadmap]] — fases e marcos de alto nível.
- [[planning/compatibility-requirements|Requisitos de compatibilidade]] — baseline v1.0 aprovada; divisão gratuito/Premium ainda em aberto.
- [[docs/product/requisitos-de-desempenho|Requisitos de desempenho e leveza]] — métricas, protocolo e metas.
- [[docs/product/direcao-visual-e-interacao|Direção visual e modelo de interação]] — princípios e fluxos da interface de TV.
- [[planning/validation-roadmap|Plano de validação técnica]] — métodos, evidências e limites dos testes.
- [[tests/boot-poc/README|Prova de boot em QEMU]] — instruções para executar o teste atual.
- [[docs/architecture/README|Estado da arquitetura]] — decisões arquiteturais ainda não aprovadas.
- [[planning/decisions/0004-adaptacao-hardware-e-implantacao|ADR 0004]] — restrições de hardware e implantação.
- [[planning/decisions/0006-politica-de-idioma-e-localizacao|Política de idioma e localização]].

## Regra de manutenção

Atualizar esta página apenas quando mudar a próxima ação. Registrar tarefas e critérios no backlog, fases no roadmap, procedimentos e resultados técnicos no documento de validação e decisões permanentes nos ADRs. Não manter aqui histórico de execução.
