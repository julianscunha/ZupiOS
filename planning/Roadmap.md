---
title: Roadmap do ZupiOS
type: planning
status: draft
tags:
  - zupios
  - roadmap
---

# Roadmap do ZupiOS

> [!warning] Rascunho
> O roadmap apresenta fases de descoberta, não datas prometidas. A arquitetura e o hardware-alvo ainda não foram aprovados.

## Fase 0 — Fundamentos e decisões

- [x] Definir o nome do sistema como ZupiOS.
- [x] Definir objetivos iniciais de licenciamento e monetização para avaliação jurídica.
- [x] Separar documentação, planejamento e código no repositório.
- [x] Registrar o hardware de referência e as especificações publicamente verificáveis, com incertezas explicitadas.
- [ ] Definir e aprovar os requisitos prioritários de compatibilidade. A proposta v0.2 está em [[planning/compatibility-requirements|requisitos de compatibilidade]] e aguarda revisão.
- [ ] Escolher a base técnica após a análise de viabilidade.

## Fase 1 — Prova de viabilidade

- [x] Criar uma prova experimental de boot BIOS legado em QEMU, incluindo leitura e execução de um segundo setor.
- [x] Definir e demonstrar o contrato de carregamento de um payload mínimo no ambiente de prototipagem.
- [ ] Validar um caminho reproduzível para executar software próprio no hardware escolhido.
- [ ] Documentar limites de boot, firmware, drivers, vídeo, áudio, rede e entrada no hardware escolhido.
- [ ] Registrar a decisão arquitetural com evidências e riscos.

A prova em QEMU valida apenas o fluxo mínimo do emulador; não conta como validação da TV Samsung nem como kernel funcional. Consulte [[tests/boot-poc/README|procedimento e limites da prova]] e [[planning/validation-roadmap|resultados de validação]].

## Fase 2 — Contrato e SDK

- [ ] Definir o contrato inicial das APIs públicas.
- [ ] Definir como as aplicações declaram versão e capacidades necessárias.
- [ ] Criar uma aplicação de exemplo e testes de contrato.

## Fase 3 — Runtime e validação de dispositivo

- [ ] Implementar o runtime de acordo com a arquitetura aprovada.
- [ ] Criar o primeiro perfil de dispositivo suportado.
- [ ] Executar testes de conformidade e estabilidade.

## Fase 4 — Serviços opcionais

- [ ] Especificar atualização automática e identificação de instalações.
- [ ] Definir privacidade, consentimento, retenção e telemetria antes da coleta real.
- [ ] Especificar marketplace e promoção paga de aplicações.

## Critério para avançar entre fases

Uma fase avança quando seus resultados são documentados e os critérios de aceite são demonstrados. O roadmap deve ser revisto após cada decisão técnica importante.
