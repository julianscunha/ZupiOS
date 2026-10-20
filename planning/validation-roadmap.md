---
title: Plano de validação técnica do ZupiOS
type: technical-plan
status: proposed
tags:
  - zupios
  - validacao
  - hardware
  - boot
---

# Plano de validação técnica do ZupiOS

## Objetivo

Separar a validação do sistema da engenharia reversa da Samsung UN40J6400AGXZD. A TV permanece como alvo experimental de compatibilidade; não é o único ambiente de desenvolvimento.

## Princípio de trabalho

Não escolher ainda sistema-base, linguagem, runtime ou bootloader. Primeiro definir um ambiente controlável e critérios verificáveis, evitando que hipóteses sobre a TV determinem prematuramente a arquitetura.

## Etapa 1 — Ambiente controlável

Avaliar como primeiro alvo de prototipagem uma máquina virtual ou computador x86-64 com recursos conhecidos. A escolha final depende dos recursos disponíveis ao desenvolvedor. O ambiente precisa permitir inicialização reproduzível, logs de console, testes automatizados e recuperação sem risco para a TV.

Critérios mínimos:
- especificação conhecida de CPU/arquitetura, RAM, armazenamento e firmware;
- possibilidade de iniciar a partir de mídia removível ou imagem virtual;
- console/logs acessíveis para diagnóstico;
- snapshots ou restauração simples;
- documentação e testes reproduzíveis.

## Etapa 2 — Prova mínima de inicialização

Antes de desenvolver interface ou funcionalidades, produzir uma prova mínima que:
1. gere um artefato reproduzível;
2. inicialize no ambiente de teste selecionado;
3. registre informações básicas da plataforma;
4. exponha logs de inicialização e falhas;
5. possa ser substituída ou removida sem alterar a TV de referência.

O resultado comprova somente o fluxo de inicialização naquele ambiente, não compatibilidade com a Samsung.

## Etapa 3 — Perfil da TV de referência

Manter um perfil separado para a Samsung UN40J6400AGXZD, com campos de estado explícitos:
- **confirmado pelo usuário:** modelo e firmware informado 1550.0;
- **confirmado por etiqueta:** Model Code UN40J6400AGXZD, Type No. UN40J6400, Version No. TH02;
- **hipótese externa:** códigos de placa, SoC, memória e armazenamento citados por fontes secundárias;
- **desconhecido:** cadeia de boot efetiva, política de assinatura, interfaces de depuração acessíveis, possibilidade de boot alternativo e método de recuperação validado.

Não converter uma hipótese em capacidade suportada sem evidência específica da revisão física instalada.

## Etapa 4 — Portão de decisão para a TV

A investigação de execução nativa só avança quando houver:
- identificação confiável da placa e revisão instaladas;
- documentação específica para essa variante ou inspeção técnica qualificada;
- caminho de teste de baixo risco e método de recuperação comprovado;
- evidência de que o firmware permite o mecanismo de inicialização proposto.

Se esses requisitos não forem atendidos, manter a TV apenas como alvo de estudo e compatibilidade externa. Não escrever firmware, alterar eMMC/SPI, entrar em procedimentos de serviço ou conectar adaptadores a pontos de teste com base em documentação de outra variante.

## Critério de conclusão desta fase

A fase termina quando o ambiente controlável estiver escolhido, os critérios de teste forem registrados e houver uma prova de inicialização reproduzível. A arquitetura do sistema será definida depois, com base nos resultados e nas restrições confirmadas.

## Relação com outras notas

- [[planning/Next-Steps]]
- [[planning/decisions/0004-adaptacao-hardware-e-implantacao]]
