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

A prova em `tests/boot-poc/` monta uma imagem raw de 1.536 bytes com três setores. O setor inicial de 512 bytes contém a assinatura BIOS `55 aa`, lê o segundo setor via `int 13h` e transfere a execução para `0000:8000`. O segundo estágio carrega o terceiro setor em `0000:9000`, trata erro de leitura e transfere o controle ao payload. O payload independente emite um marcador no console de depuração e para a CPU.

### Contrato experimental do payload

- **Endereço de carga:** segmento:offset `0000:9000` (endereço físico `0x9000` em modo real).
- **Ponto de entrada:** `0000:9000`; o carregador faz salto distante para esse endereço.
- **Limite de tamanho:** exatamente um setor reservado, com máximo de 512 bytes. O teste de construção rejeita payload maior que esse limite.
- **Estado mínimo:** modo real BIOS de 16 bits; o payload não depende de stack, heap, interrupções ou serviços de sistema. O carregador inicializa `DS` e `ES` a zero e preserva o identificador de unidade BIOS em `DL` durante a leitura; o payload deve inicializar os segmentos de que precisar.
- **Falha de carga:** a leitura BIOS do setor 3 verifica o carry flag e emite `ZupiOS: falha ao carregar payload` antes de parar a CPU.
- **Evidência de sucesso:** o payload escreve `ZupiOS: payload minimo carregado e executado` no console de depuração do QEMU.

O carregador atual lê um setor fixo; não lê metadados, não suporta payloads maiores ou de tamanho variável e não define um formato executável. O endereço e o estado acima são apenas o contrato desta prova, não a arquitetura final de kernel.

Critérios cobertos pelo script:
- tamanho e assinatura do setor de boot;
- limite de 512 bytes para segundo estágio e payload;
- tamanho total da imagem e layout de três setores;
- transferência de controle ao payload, observada por marcador;
- caso positivo: marcador de execução do payload e timeout esperado após a parada da CPU;
- caso negativo com imagem truncada: marcador de falha de leitura e ausência do marcador do payload;
- execução repetida pelo verificador de repetibilidade.

### Resultado de validação local

**Resultado: aprovado — 5 de 5 execuções consecutivas.** A execução ocorreu no contêiner de desenvolvimento Ubuntu x86_64 do repositório, com GNU Binutils e QEMU 10.2.1. O verificador `bash tests/boot-poc/repeat.sh 5` terminou com código de saída 0; cada uma das cinco execuções aprovou os cenários positivo e negativo. Também foi executado `bash scripts/dev-check.sh`, concluído com código 0.

Evidências observadas em cada execução:
- imagem raw: 1.536 bytes; setor de boot: 512 bytes; assinatura: `55aa`;
- segundo estágio: 510 bytes; payload: 67 bytes de um máximo de 512;
- caso positivo: marcador `ZupiOS: payload minimo carregado e executado` e transferência de controle para `0000:9000`;
- caso negativo: marcador `ZupiOS: falha ao carregar payload` e ausência do marcador de execução do payload;
- máquina emulada: `pc`, BIOS legado, CPU `qemu64`, RAM 128 MiB; QEMU 10.2.1.

Esta evidência é de execução local equivalente, não um resultado do GitHub Actions. A ausência de um resultado hospedado não invalida o critério local alternativo, mas o estado do workflow remoto não deve ser presumido.

Esta prova não implementa kernel, drivers, sistema-base ou runtime, e não comprova compatibilidade com a Samsung. O teste só demonstra leitura e transferência de controle para um payload de um setor em BIOS legado no QEMU configurado; não valida hardware físico, boot alternativo, desempenho, drivers ou arquitetura final.

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

A prova mínima de payload em ambiente controlável foi demonstrada e repetida com sucesso. O próximo trabalho é verificar as especificações e incertezas do hardware de referência. A conclusão da prova não equivale a compatibilidade com a TV nem aprova a arquitetura final.

## Relação com outras notas

- [[planning/Next-Steps]]
- [[planning/decisions/0004-adaptacao-hardware-e-implantacao]]
- [[tests/boot-poc/README]]
