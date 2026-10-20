# Prova experimental de inicialização BIOS em x86

Este teste reproduz uma inicialização BIOS legado em uma máquina x86 emulada. Não define a arquitetura de inicialização do ZupiOS nem comprova compatibilidade com a TV Samsung de referência.

## Requisitos

GNU Binutils (as e ld), QEMU para x86 (qemu-system-x86_64) e timeout, além de dd para montar a imagem temporária.

## Execução

A partir da raiz do repositório, execute:

```sh
bash tests/boot-poc/run.sh
```

Para executar a prova repetidamente e interromper na primeira falha, use o verificador de repetibilidade (cinco execuções por padrão):

```sh
bash tests/boot-poc/repeat.sh
```

É possível informar outra quantidade positiva, por exemplo `bash tests/boot-poc/repeat.sh 10`. O relatório identifica a tentativa que falhou e quantas aprovações ocorreram antes dela; cada execução individual mantém os diagnósticos do `run.sh`.

O workflow `.github/workflows/boot-poc.yml` executa a verificação de ambiente e cinco provas QEMU em pushes para `main`, pull requests e acionamento manual. O resultado hospedado só pode ser confirmado após o GitHub Actions executar o workflow.

O script informa a versão do QEMU e os parâmetros configurados para a máquina virtual: máquina `pc`, CPU `qemu64` e 128 MiB de RAM. Esses valores são argumentos fornecidos ao emulador, não medições detectadas pelo código convidado.

## Contrato demonstrado

A imagem raw contém exatamente 1.536 bytes (três setores de 512 bytes):

1. **Setor 1 — boot:** verifica a assinatura BIOS `55 aa`, lê o segundo setor com `int 13h` e transfere o controle para `0000:8000`.
2. **Setor 2 — carregador:** lê o setor 3 para `0000:9000`, preserva o identificador da unidade BIOS recebido em `DL`, trata erro de leitura com mensagem de diagnóstico e transfere o controle para `0000:9000`.
3. **Setor 3 — payload:** código independente que escreve um marcador no console de depuração e para a CPU.

O contrato experimental fixa o endereço de carga e de entrada em `0000:9000` e limita o payload a um setor, no máximo 512 bytes. O carregador atual lê um setor fixo; não interpreta cabeçalhos, não carrega tamanhos variáveis e não valida um formato de executável. O endereço é específico desta prova em modo real e não é uma decisão de arquitetura final.

## Critérios de aprovação

- O setor de boot tem exatamente 512 bytes e termina com a assinatura `55 aa`.
- O segundo estágio e o payload cabem cada um em um setor de 512 bytes.
- A imagem gerada tem exatamente 1.536 bytes e o QEMU executa o payload do terceiro setor.
- O console de depuração recebe `ZupiOS: payload minimo carregado e executado`, emitido pelo payload independente.
- Não aparece o marcador de erro de leitura do payload.
- O processo termina pelo limite de tempo esperado (timeout de cinco segundos, código 124), pois o payload para a CPU após emitir a mensagem.
- Nenhum firmware ou dispositivo físico é alterado; os artefatos são temporários e removidos ao final.

Uma aprovação comprova somente a leitura e transferência de controle para um payload de um setor em BIOS legado no QEMU configurado. Não comprova kernel, drivers, proteção de memória, formatos de payload variáveis, desempenho, boot alternativo ou compatibilidade com a Samsung UN40J6400AGXZD.
