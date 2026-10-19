---
title: "Decisão 0004 — Adaptação ao hardware e ao método de implantação"
id: ZUPI-ADR-0004
type: decision
status: accepted
date: 2026-10-19
tags:
  - zupios
  - hardware
  - deploy
  - boot
  - decisao
---

# Decisão 0004 — Adaptação ao hardware e ao método de implantação

- **Estado:** aceita
- **Data:** 2026-10-19

## Decisão

O ZupiOS deve separar o comportamento do sistema da forma como ele é inicializado, instalado e executado.

- **Sistema:** deve preservar, sempre que tecnicamente possível, uma experiência consistente, APIs estáveis e compatibilidade de aplicações entre modalidades de implantação.
- **Implementação:** deve detectar e avaliar o hardware e o ambiente disponíveis e escolher um caminho de inicialização e operação compatível com as capacidades verificadas.
- **Adaptação:** a avaliação deve considerar capacidades reais, não apenas marca ou modelo. Exemplos incluem arquitetura do processador, memória, armazenamento, drivers, conectividade e métodos de boot suportados.
- **Modalidades desejadas:** boot por USB, execução a partir de USB, instalação pela rede e inicialização pela rede.
- **Limites:** essas modalidades são objetivos de compatibilidade, não uma garantia de suporte em todos os dispositivos. A estratégia concreta dependerá do hardware, firmware e ambiente disponíveis.

## Implicações

- A detecção de capacidades e a seleção do caminho de execução devem ser tratadas como responsabilidades da implementação.
- Diferenças de implantação e desempenho não devem criar diferenças desnecessárias no contrato das APIs ou no comportamento das aplicações.
- A implementação deve reconhecer capacidades ausentes e limitações, em vez de presumir suporte universal.
- Tecnologias, bootloader, sistema-base e mecanismos específicos permanecem pendentes; esta decisão não os escolhe.

## Critérios de aceite

- A arquitetura futura distingue claramente o contrato do sistema dos mecanismos de implantação.
- Existe um processo de descoberta/avaliação de capacidades do dispositivo.
- A escolha do caminho de inicialização considera capacidades verificadas e possui comportamento definido para recursos indisponíveis.
- As diferenças inevitáveis entre dispositivos são documentadas em perfis de dispositivo.

## Documentos relacionados

- [[planning/decisions/0003-organizacao-do-repositorio]]
- [[docs/Arquitetura]]
- [[docs/Dispositivos]]
