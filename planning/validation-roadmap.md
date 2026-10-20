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

Separar a validação do sistema da investigação de hardware da Samsung UN40J6400AGXZD. A TV permanece como alvo experimental de compatibilidade; não é o único ambiente de desenvolvimento.

## Princípio de trabalho

Não escolher sistema-base, linguagem, runtime ou bootloader antes de definir requisitos e avaliar evidências. Toda prova deve declarar exatamente o que demonstrou e o que permanece desconhecido.

## Etapa 1 — Ambiente controlável

O ambiente de prototipagem atual é um contêiner Ubuntu x86_64 com QEMU. A máquina convidada usada na prova é configurada como `pc` (BIOS legado), CPU `qemu64` e 128 MiB de RAM. Esses são parâmetros do emulador, não características detectadas na TV nem requisitos finais do ZupiOS.

Critérios do ambiente:
- inicialização reproduzível e automatizável;
- logs de console acessíveis;
- artefatos temporários e restauração simples;
- testes repetíveis sem risco ao dispositivo físico.

## Etapa 2 — Prova mínima de inicialização

A prova atual em `tests/boot-poc/` monta uma imagem raw de 1.024 bytes com dois setores. O setor inicial de 512 bytes contém a assinatura BIOS `55 aa`, lê o segundo setor via `int 13h` e transfere a execução para `0000:8000`. O segundo estágio emite um marcador no console de depuração e para a CPU. O script verifica o layout e o marcador; o verificador de repetibilidade executa cinco tentativas por padrão.

Critérios já cobertos pelo teste:
- tamanho e assinatura do setor de boot;
- tamanho máximo do segundo estágio e tamanho total da imagem;
- transferência de controle ao segundo estágio, observada por marcador;
- timeout esperado após a parada da CPU;
- execução repetida sem falha nas tentativas realizadas.

Próximos critérios técnicos a desenvolver:
- validar explicitamente o caminho de erro de leitura de disco;
- conferir preservação do identificador da unidade BIOS e limites do layout da imagem;
- decidir e documentar o contrato para carregar um payload/kernel mínimo.

Esta prova não implementa kernel, drivers, sistema-base ou runtime, e não comprova compatibilidade com a Samsung.

## Etapa 3 — Perfil da TV de referência

Manter um perfil separado para a Samsung UN40J6400AGXZD, com estados explícitos:
- **informado pelo usuário:** modelo e firmware 1550.0;
- **confirmado por etiqueta:** Model Code UN40J6400AGXZD, Type No. UN40J6400, Version No. TH02;
- **hipótese externa:** códigos de placa, SoC, memória e armazenamento mencionados por fontes secundárias;
- **desconhecido:** cadeia de boot efetiva, política de assinatura, interfaces de depuração acessíveis, possibilidade de boot alternativo e método de recuperação validado.

Não converter hipótese em capacidade suportada sem evidência específica da revisão física instalada.

## Etapa 4 — Portão de decisão para a TV

A investigação de execução nativa só avança quando houver:
- identificação confiável da placa e revisão instaladas;
- documentação específica para essa variante ou inspeção técnica qualificada;
- caminho de teste de baixo risco e método de recuperação comprovado;
- evidência de que o firmware permite o mecanismo de inicialização proposto.

Se esses requisitos não forem atendidos, manter a TV como alvo de estudo e compatibilidade externa. Não escrever firmware, alterar eMMC/SPI, executar procedimentos de serviço ou conectar adaptadores a pontos de teste com base em documentação de outra variante.

## Critério de conclusão desta fase

A fase termina quando o ambiente controlável estiver escolhido, os critérios de teste forem registrados e uma prova reproduzível for demonstrada no alvo de prototipagem escolhido. Isso não equivale a compatibilidade com a TV. A arquitetura será definida depois, com base nos resultados e nas restrições confirmadas.

## Relação com outras notas

- [[planning/Next-Steps]]
- [[planning/decisions/0004-adaptacao-hardware-e-implantacao]]
- [[tests/boot-poc/README]]
