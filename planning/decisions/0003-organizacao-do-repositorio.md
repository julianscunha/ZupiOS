---
title: "Decisão 0003 — Organização do repositório"
id: ZUPI-ADR-0003
type: decision
status: accepted
date: 2026-10-19
tags:
  - zupios
  - repositorio
  - obsidian
  - decisao
---

# Decisão 0003 — Organização do repositório

- **Estado:** aceita
- **Data:** 2026-10-19

## Decisão

O repositório será organizado como estrutura de longo prazo, com separação explícita entre:

- docs/: documentação de referência do projeto, em Markdown compatível com Obsidian.
- planning/: planejamento em andamento, backlog, roadmap e registros de decisão.
- src/: código da plataforma, quando a implementação começar.
- sdk/: implementação e artefatos de desenvolvimento do SDK, quando definidos.
- tests/: testes automatizados e de conformidade.
- device-profiles/: perfis documentados de dispositivos e respectivas capacidades verificadas.

A presença inicial de diretórios de código não determina linguagem, sistema-base, runtime ou arquitetura interna.

## Padrão de documentação

- Markdown UTF-8.
- Frontmatter YAML no início das notas.
- Links internos Obsidian no formato [[Nome da nota]].
- Índices de navegação para documentação e planejamento.
- Estados explícitos para distinguir decidido, proposto, pendente e implementado.
- Cada decisão aceita deve receber um registro numerado no diretório planning/decisions/.
- Documentação de referência descreve o comportamento confirmado; hipóteses e trabalho futuro ficam em planning/.

## Critérios de aceite

- O README da raiz explica a estrutura.
- A documentação possui uma página inicial e um mapa.
- Planejamento, documentação e código têm diretórios separados.
- A licença definitiva continua pendente e não é presumida por esta reorganização.

## Documentos relacionados

- [[planning/decisions/0001-nome-e-objetivo]]
- [[planning/decisions/0002-politica-de-licenciamento]]
