---
title: Requisitos de compatibilidade do ZupiOS
type: planning-specification
status: approved
version: 1.0
tags:
  - zupios
  - compatibilidade
  - requisitos
---

# Requisitos de compatibilidade do ZupiOS

## Estado e finalidade

Esta especificação organiza os requisitos do primeiro produto e é a fonte de verdade para os casos de uso e prioridades de compatibilidade. **Baseline de produto v1.0 aprovada pelo mantenedor em 2026-10-21**, com base na confirmação explícita nesta conversa. A aprovação fixa prioridades e direção do produto; não aprova arquitetura, tecnologias, APIs, nem declara compatibilidade de qualquer dispositivo.

Os rótulos P0/P1/P2 indicam prioridade de produto, não a ordem garantida de implementação nem a declaração de que a funcionalidade já existe. Os critérios de verificação descrevem evidência futura necessária.

## Rastreabilidade das decisões existentes

- **Visão geral do produto:** plataforma de software para televisores, SDK próprio, redução da fragmentação entre APIs e uso básico sem cobrança por instalação/dispositivo.
- **ADR 0004 — Hardware e implantação:** comportamento do sistema separado do método de boot/instalação; suporte declarado com base em capacidades verificadas; pacotes genérico, customizado e offline como objetivos condicionais, não garantias universais; recuperação dependente do dispositivo.
- **ADR 0005 — Conta e Premium:** conta opcional; uso básico sem conta ou token Premium; ativação por instalação para benefícios Premium; instalar aplicações por meios suportados, como USB, não exige Premium; coleta técnica e homologação devem distinguir dados declarados de dados detectados.
- **ADR 0006 — Idioma e localização:** pt-BR como idioma padrão e idioma principal da documentação; arquitetura multilíngue pretendida.
- **SDK:** linguagem, APIs, runtime, isolamento, formato de pacote e política de versionamento ainda não foram aprovados.

Esta especificação detalha requisitos derivados desses princípios e propõe prioridades. Em caso de conflito, as decisões aceitas e a visão de produto prevalecem; uma alteração permanente exige revisão do documento ou novo ADR.

## Princípios de compatibilidade

1. **Contrato público comum:** aplicações usam APIs documentadas do ZupiOS, não APIs privadas de um fabricante como requisito universal.
2. **Compatibilidade por capacidade verificada:** marca e modelo identificam o aparelho, mas não bastam para declarar suporte. Cada perfil deve registrar firmware, versão do ZupiOS, capacidades testadas, limitações e evidências.
3. **Estados de evidência explícitos:** distinguir capacidade declarada pelo usuário, detectada pelo sistema, testada com sucesso, não suportada e desconhecida. Não apresentar uma inferência como detecção nem uma inicialização isolada como homologação total.
4. **Degradação explícita:** quando um recurso estiver indisponível, a aplicação recebe um resultado documentado e pode usar fallback quando existir; o sistema não simula suporte inexistente.
5. **Uso básico sem pagamento obrigatório:** o funcionamento básico local não exige conta, token Premium ou pagamento por instalação. Serviços e benefícios comerciais opcionais não podem bloquear funções básicas suportadas.
6. **Separação entre produto e implantação:** APIs e comportamento das aplicações variam o mínimo possível entre métodos de boot/instalação, sem presumir que todo método seja possível em todo aparelho.
7. **Segurança e recuperação:** verificar origem/integridade, dependências e compatibilidade antes de aplicar componentes. Antes de operações destrutivas, apresentar os limites de recuperação conhecidos; não prometer restauração universal.
8. **Privacidade por padrão:** coleta de dados técnicos deve ser minimizada, transparente e limitada à finalidade declarada; identificadores brutos e tokens não devem ser expostos em catálogos públicos.

## Casos de uso priorizados

### P0 — Núcleo necessário para um primeiro produto utilizável

**Baseline aprovada:** priorizar navegação por controle remoto, ciclo de vida de aplicações, SDK próprio, reprodução de mídia quando suportada e detecção de capacidades. A categoria inicial de aplicações prioriza mídia/streaming e, em seguida, utilitários. O primeiro alvo de ecossistema são aplicações desenvolvidas para o SDK do ZupiOS; compatibilidade com aplicações de terceiros não é promessa do primeiro marco.

| ID | Caso de uso | Resultado esperado | Evidência futura mínima |
| --- | --- | --- | --- |
| UC-01 | Navegar pela interface com controle remoto | Foco, seleção, voltar e navegação principal funcionam sem mouse/teclado como requisito. | Roteiro de navegação repetível por perfil suportado, incluindo foco, seleção e retorno. |
| UC-02 | Abrir, usar e encerrar uma aplicação | Ciclo de vida previsível, retorno à interface principal e tratamento de falhas. | Teste de abertura, uso, encerramento e falha de uma aplicação de exemplo. |
| UC-03 | Desenvolver e executar uma aplicação com o SDK | Contrato público versionado, exemplo mínimo e testes de API antes de declarar APIs estáveis. | Exemplo de aplicação compilado/empacotado e executado no ambiente de referência aprovado; APIs exercitadas por testes. |
| UC-04 | Exibir e reproduzir mídia quando suportado | APIs reportam formatos, decodificação, áudio e saídas realmente disponíveis; recursos ausentes são declarados. | Matriz de formatos e saídas testados por perfil; não implica suporte universal a codecs. |
| UC-05 | Consultar capacidades básicas do dispositivo | Aplicações consultam capacidades de rede, entrada, tela, áudio e armazenamento por interfaces documentadas. | Testes de detecção e estados disponíveis/indisponíveis/desconhecidos por perfil. |
| UC-06 | Identificar perfil e limites do aparelho | O sistema distingue capacidades detectadas, testadas, indisponíveis e desconhecidas. | Relatório versionado com origem dos dados, versão/firmware e evidências dos testes. |

### P1 — Instalação, manutenção e cobertura ampliada

| ID | Caso de uso | Resultado esperado | Evidência futura mínima |
| --- | --- | --- | --- |
| UC-07 | Instalar ou atualizar por caminho suportado | Verificar pacote, dispositivo, versão, dependências e integridade antes de alterar o sistema. | Ensaio reproduzível em perfil compatível, com logs e procedimento de recuperação documentado. |
| UC-08 | Usar distribuição genérica, customizada ou offline | Reutilizar uma base comum; incluir apenas componentes compatíveis verificados; permitir instalação offline quando o método suportar. | Testes de integridade, dependências e instalação por modalidade suportada. |
| UC-09 | Adicionar suporte específico após instalação genérica | Instalar componentes compatíveis sem reinstalação completa quando tecnicamente seguro. | Atualização e rollback testados em dispositivo/perfil suportado. |
| UC-10 | Recuperar o sistema após falha | Usar recuperação local quando suportada; tentar alternativa externa/remota apenas quando disponível; informar quando a recuperação não for garantida. | Ensaio de falha e recuperação com método validado para o perfil. |

### P2 — Serviços opcionais posteriores ao núcleo

| ID | Caso de uso | Resultado esperado | Condição para implementação |
| --- | --- | --- | --- |
| UC-11 | Descobrir e instalar aplicações por catálogo | Catálogo e distribuição oficial são opcionais; a instalação por outros meios suportados não exige Premium. | Contrato do SDK, modelo de segurança e regras de distribuição aprovados. |
| UC-12 | Usar conta, ativação ou serviços Premium | Conta é opcional; ativação Premium é separada do vínculo de conta; funções básicas continuam disponíveis sem token. | Especificação de tokens, privacidade, segurança, renovação/revogação e modo offline aprovada. |
| UC-13 | Restaurar por repositório remoto | Procurar imagem potencialmente compatível e informar claramente indisponibilidade ou falha. | Procedência, direitos de redistribuição, integridade, cobertura e compatibilidade avaliados. |

## Requisitos não funcionais

### P0

- **Desempenho e leveza:** minimizar consumo desnecessário de RAM, CPU, armazenamento e recursos gráficos; priorizar responsividade e evitar trabalho em segundo plano sem benefício demonstrável. Métricas, métodos e metas pertencem a [[docs/product/requisitos-de-desempenho|Requisitos de desempenho e leveza]]; não fixar limites sem linha de base reproduzível.

- **Compatibilidade comprovável:** não declarar um perfil de dispositivo como suportado sem procedimento reproduzível e testes documentados para a combinação exata de hardware/firmware e versão do ZupiOS.
- **Versionamento:** APIs públicas declaram versão e política de compatibilidade; nenhuma API é estável antes de especificação, implementação e testes.
- **Capacidades explícitas:** aplicações recebem respostas claras para recursos disponíveis, ausentes ou desconhecidos.
- **Confiabilidade:** quando o runtime permitir recuperação, falhas de aplicação não devem impedir indefinidamente o retorno à interface principal.
- **Segurança de atualização:** validar origem, integridade, compatibilidade e dependências antes de instalar; apresentar limites de recuperação antes de operações potencialmente destrutivas.
- **Privacidade:** dados técnicos são minimizados, têm finalidade documentada e não expõem identificadores brutos, dados pessoais ou tokens em catálogos públicos.
- **Localização:** pt-BR é o idioma padrão; a arquitetura deve permitir localização e fallback explícito, conforme ADR 0006.

### P1

- **Operação offline:** oferecer pacote offline para modalidades de instalação que tecnicamente o suportem.
- **Observabilidade:** relatórios registram versão do sistema, perfil/firmware, ambiente, passos, resultados e limitações.
- **Isolamento e permissões:** definir o modelo antes de estabilizar APIs que concedam acesso a recursos do dispositivo.

Metas numéricas de desempenho, memória, inicialização e consumo de energia ficam pendentes até a escolha da arquitetura e de um alvo de teste reproduzível. Não atribuir números arbitrários ao hardware ainda não caracterizado.

## Fora do escopo do primeiro marco

- Garantir compatibilidade com todas as Smart TVs ou todas as variantes de uma família.
- Prometer execução nativa, desbloqueio de bootloader ou substituição de firmware na Samsung UN40J6400AGXZD antes de demonstrar um caminho seguro e recuperável.
- Escolher sistema-base, kernel, bootloader, linguagem, runtime ou formato final de pacote nesta especificação.
- Garantir instalação remota, boot por rede, dual boot ou restauração em dispositivos que não exponham os mecanismos necessários.
- Tornar marketplace, conta, telemetria, promoção paga ou serviços Premium pré-requisitos para uso básico.
- Declarar codecs, drivers, SoC, RAM ou interfaces de depuração como suportados por semelhança de modelo.
- Considerar a prova de payload em QEMU como evidência de compatibilidade com hardware físico ou de implementação de um kernel.

## Dependências e relação com o backlog

- **ZUPI-001:** identificação documental básica concluída; detalhes internos da TV permanecem desconhecidos.
- **ZUPI-002:** baseline v1.0 aprovada. Converter requisitos prioritários em tarefas verificáveis no backlog/roadmap, sem duplicar esta especificação. A divisão exata de recursos gratuitos e Premium continua em aberto.
- **ZUPI-003:** viabilidade de execução nativa deve ser avaliada separadamente; os requisitos de produto não provam que o hardware de referência os suporte.
- **ZUPI-004:** arquitetura permanece bloqueada até a revisão de requisitos e a análise de viabilidade.

## Critérios de aceitação de ZUPI-002

- [x] Casos de uso documentados e priorizados.
- [x] Requisitos não funcionais e limites do primeiro marco explicitados.
- [x] Requisitos alinhados com os ADRs aceitos sobre hardware/implantação, Premium e localização.
- [x] Evidência futura mínima definida para cada caso de uso.
- [x] Proposta revisada e baseline v1.0 aprovada explicitamente pelo mantenedor em 2026-10-21.
- [x] Prioridades P0/P1/P2, foco inicial de aplicações e limite de compatibilidade com terceiros registrados.
- [x] Dependências e próxima etapa registradas no backlog/roadmap.

## Decisão registrada e questão em aberto

A baseline aprovada resolve as prioridades do primeiro produto: mídia/streaming primeiro, utilitários em seguida; aplicações próprias do SDK antes de qualquer compromisso de compatibilidade com ecossistemas de terceiros. Instalação, atualização e recuperação permanecem P1 e condicionadas às capacidades comprovadas do dispositivo.

Permanece em aberto apenas a divisão detalhada de recursos opcionais entre gratuito e Premium, conforme ADR 0005. Essa questão não pode bloquear o uso básico local nem a definição técnica do núcleo. Alterações futuras nas prioridades devem ser registradas nesta especificação ou em ADR quando mudarem uma decisão permanente. A visão geral do produto, a visão do SDK e a arquitetura devem apontar para esta fonte de verdade, sem copiar a tabela de requisitos.
