---
title: Requisitos de compatibilidade do ZupiOS
type: planning-specification
status: draft
version: 0.1
tags:
  - zupios
  - compatibilidade
  - requisitos
---

# Requisitos de compatibilidade do ZupiOS

## Estado e finalidade

Esta é uma proposta inicial para fechar ZUPI-002. Ela organiza intenções já registradas na [visão geral do produto](../docs/product/Visao-geral.md), no [estado do SDK](../docs/sdk/Visao-geral.md) e no [ADR 0004 — hardware e implantação](./decisions/0004-adaptacao-hardware-e-implantacao.md). Não aprova arquitetura, tecnologias ou compatibilidade de nenhum aparelho. Requer revisão do mantenedor antes de ser tratada como baseline aprovada.

## Princípios de compatibilidade

1. **Contrato público comum:** aplicações devem usar APIs documentadas do ZupiOS, não APIs privadas de um fabricante como requisito universal.
2. **Compatibilidade por capacidade verificada:** marca e modelo ajudam a identificar o aparelho, mas não bastam para declarar suporte. Cada perfil deve indicar firmware, recursos testados, limitações e versão do ZupiOS validada.
3. **Degradação explícita:** quando um recurso não estiver disponível, o sistema deve informar a aplicação e permitir fallback documentado; nunca simular suporte não existente.
4. **Base gratuita:** instalar ou usar a funcionalidade básica do sistema não deve exigir pagamento por dispositivo. Serviços comerciais opcionais não devem bloquear a experiência básica.
5. **Separação entre produto e implantação:** APIs e comportamento das aplicações devem variar o mínimo possível entre modalidades de boot/instalação, sem presumir que todas as modalidades sejam possíveis em todo aparelho.
6. **Segurança e recuperação:** validar integridade, dependências e compatibilidade antes de aplicar componentes; avisar sobre risco quando recuperação não puder ser garantida.

## Casos de uso priorizados

### P0 — Núcleo necessário para um primeiro produto utilizável

| ID | Caso de uso | Resultado esperado | Verificação futura |
| --- | --- | --- | --- |
| UC-01 | Navegar pela interface com controle remoto | Foco, seleção, voltar e navegação principal funcionam sem depender de mouse ou teclado. | Teste de navegação com controle remoto no perfil do dispositivo. |
| UC-02 | Abrir, usar e encerrar uma aplicação | Ciclo de vida previsível, retorno à interface principal e tratamento de falhas. | Testes de ciclo de vida e recuperação de aplicação. |
| UC-03 | Desenvolver e executar uma aplicação usando o SDK | Contrato público versionado, exemplo mínimo e testes de API antes de declarar APIs estáveis. | Aplicação de exemplo executada em ambiente de referência aprovado. |
| UC-04 | Exibir e reproduzir mídia quando o hardware suportar | APIs reportam formatos, decodificação, áudio e saídas realmente disponíveis; recursos ausentes são declarados. | Matriz de vídeo/áudio por perfil, com formatos efetivamente testados. |
| UC-05 | Usar conectividade e recursos básicos do dispositivo | Aplicações consultam capacidades de rede, entrada, tela, áudio e armazenamento através de interfaces documentadas. | Testes por capacidade, sem inferência a partir apenas do modelo. |
| UC-06 | Identificar o perfil e os limites do aparelho | O sistema distingue capacidades detectadas, testadas, indisponíveis e desconhecidas. | Perfil versionado e relatório de detecção/testes. |

### P1 — Instalação, manutenção e cobertura ampliada

| ID | Caso de uso | Resultado esperado | Verificação futura |
| --- | --- | --- | --- |
| UC-07 | Instalar ou atualizar o sistema por um caminho suportado | O instalador verifica pacote, dispositivo, versão, dependências e integridade antes de alterar o sistema. | Ensaio reproduzível em hardware compatível e procedimento de recuperação documentado. |
| UC-08 | Usar distribuição genérica, específica ou offline | Pacotes reutilizam uma base comum; pacotes específicos só incluem componentes com compatibilidade verificada; o pacote offline não depende de conexão durante a instalação. | Testes de integridade, dependências e instalação por modalidade. |
| UC-09 | Adicionar suporte específico após uma instalação genérica | Componentes compatíveis podem ser instalados manualmente sem reinstalação completa quando tecnicamente seguro. | Atualização de componente e rollback testados em dispositivo suportado. |
| UC-10 | Recuperar o sistema após falha | Há recuperação local quando suportada; alternativas externas/remotas são tentadas apenas quando disponíveis. O sistema não promete restauração universal. | Ensaio de falha e recuperação com método validado para o perfil. |

### P2 — Serviços opcionais, posteriores ao núcleo

| ID | Caso de uso | Resultado esperado | Condição |
| --- | --- | --- | --- |
| UC-11 | Descobrir e instalar aplicações por catálogo/marketplace | Catálogo, distribuição e eventuais serviços comerciais funcionam como camada opcional. | Só após contrato do SDK, modelo de segurança e distribuição aprovados. |
| UC-12 | Usar conta, ativação ou serviços premium | Serviços remotos não bloqueiam funções básicas que não dependam deles. | Definir minimização de dados, consentimento, retenção, segurança e comportamento offline antes de implementar. |
| UC-13 | Restaurar a partir de repositório remoto de recuperação | O sistema pode procurar imagem compatível e informar claramente quando não houver imagem ou a restauração falhar. | Disponibilidade, procedência, direitos de redistribuição e integridade precisam ser avaliados. |

## Requisitos não funcionais

### P0

- **Compatibilidade comprovável:** nenhum modelo é declarado suportado sem procedimento reproduzível e testes documentados para a versão exata.
- **Versionamento:** cada API pública deve declarar versão e política de compatibilidade; não marcar APIs como estáveis antes de haver especificação, implementação e testes.
- **Capacidades explícitas:** aplicações podem consultar recursos disponíveis e devem receber resultado claro quando um recurso estiver ausente ou desconhecido.
- **Confiabilidade:** falhas de aplicações e componentes não devem deixar a interface sem um caminho documentado de retorno quando o runtime permitir recuperá-la.
- **Segurança de atualização:** validar origem/integridade, compatibilidade e dependências antes de instalar componentes; não iniciar operações destrutivas sem apresentar os limites de recuperação conhecidos.
- **Idioma da documentação:** pt-BR é o padrão do projeto conforme a política de idioma existente.

### P1

- **Operação offline:** oferecer pacote offline para caminhos de instalação que tecnicamente o suportem.
- **Observabilidade:** relatórios de teste registram versão do sistema, perfil/firmware, ambiente, passos, resultados e limitações.
- **Isolamento e permissões:** definir o modelo antes de estabilizar APIs que concedam acesso a recursos do dispositivo.

Metas numéricas de desempenho, memória, inicialização e consumo de energia ficam pendentes até que a arquitetura e um alvo de teste reproduzível sejam aprovados. Não atribuir números arbitrários ao hardware ainda não caracterizado.

## Fora do escopo do primeiro marco

- Garantir que todas as Smart TVs ou todas as variantes de uma família sejam compatíveis.
- Prometer execução nativa, desbloqueio de bootloader ou substituição de firmware na Samsung UN40J6400AGXZD antes de demonstrar um caminho seguro e recuperável.
- Escolher agora sistema-base, kernel, bootloader, linguagem, runtime ou formato final de pacote.
- Garantir instalação remota, boot por rede, dual boot ou restauração em dispositivos que não exponham os mecanismos necessários.
- Tornar marketplace, conta, telemetria, promoção paga ou serviços premium pré-requisitos para uso básico.
- Declarar codecs, drivers, SoC, RAM ou interfaces de depuração como suportados com base apenas em semelhança de modelo.

## Critérios de aceitação de ZUPI-002

- [x] Casos de uso iniciais documentados e agrupados por prioridade.
- [x] Requisitos de compatibilidade e requisitos não funcionais classificados por prioridade.
- [x] Itens fora do escopo inicial identificados explicitamente.
- [ ] Proposta revisada e aprovada pelo mantenedor.
- [ ] Dependências e critérios de teste incorporados ao backlog/roadmap após aprovação.

## Questões para revisão

1. Os casos P0 refletem o primeiro produto desejado, especialmente navegação por controle remoto, execução de aplicações e mídia?
2. Instalação/atualização e recuperação devem continuar em P1 ou precisam fazer parte do P0 desde o primeiro dispositivo?
3. O primeiro marco deve priorizar aplicações nativas do SDK ou também compatibilidade com aplicações/ecossistemas existentes?
4. Quais classes de aplicação devem ser priorizadas primeiro: mídia, streaming, utilitários, jogos ou outra categoria?

As respostas devem ser registradas nesta especificação ou em um ADR se alterarem uma decisão permanente. Não criar cópias dos mesmos requisitos em README, visão geral do produto e arquitetura; esses documentos devem apontar para esta fonte de verdade.
