---
title: Estado da arquitetura do ZupiOS
type: reference
status: draft
tags:
  - zupios
  - arquitetura
---

# Estado da arquitetura do ZupiOS

A arquitetura técnica ainda não foi aprovada. A escolha da base do sistema e do runtime depende da definição do hardware de referência e de uma prova de viabilidade reproduzível.

## Princípios a investigar

- Separar o contrato público do SDK de sua implementação.
- Isolar particularidades de cada dispositivo para evitar que APIs específicas de um fabricante se tornem o contrato público.
- Não declarar suporte a recursos de hardware sem evidências e testes.
- Planejar atualização e recuperação como requisitos de confiabilidade.

Esses princípios orientam a investigação; não constituem uma arquitetura implementada ou uma decisão sobre tecnologias específicas.

## Decisões pendentes

- Hardware inicial e caminho de instalação.
- Sistema-base e runtime.
- Linguagem e ferramentas do SDK.
- Fronteiras de permissões, isolamento e acesso a recursos.
- Modelo de atualização e recuperação.

Acompanhe os trabalhos em [[planning/Backlog|backlog]] e [[planning/Roadmap|roadmap]].
