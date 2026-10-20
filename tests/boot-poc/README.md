# Prova experimental de inicialização BIOS em x86

Este teste reproduz uma inicialização BIOS legado em uma máquina x86 emulada. Não define a arquitetura de inicialização do ZupiOS nem comprova compatibilidade com a TV Samsung de referência.

## Requisitos

GNU Binutils (as e ld), QEMU para x86 (qemu-system-x86_64) e timeout.

## Execução

A partir da raiz do repositório, execute:

```sh
bash tests/boot-poc/run.sh
```

O script informa a versão do QEMU e os parâmetros configurados para a máquina virtual: máquina pc, CPU qemu64 e 128 MiB de RAM. Esses valores são argumentos fornecidos ao emulador, não medições detectadas pelo código convidado.

## Critérios de aprovação

- A imagem gerada tem exatamente 512 bytes.
- Os dois bytes finais da imagem correspondem à assinatura BIOS 55 aa.
- O QEMU executa a imagem e o console de depuração recebe a mensagem de inicialização esperada em português.
- O processo termina pelo limite de tempo esperado (timeout de cinco segundos, código 124), pois o setor de teste para a CPU.
- Nenhum firmware ou dispositivo físico é alterado; os artefatos são temporários e removidos ao final.

Uma aprovação comprova somente esse caminho mínimo de inicialização BIOS legado no QEMU. Não comprova kernel, drivers, desempenho, boot alternativo ou compatibilidade com a Samsung UN40J6400AGXZD.
