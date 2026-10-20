# Prova experimental de inicialização BIOS em x86

Este é um teste reproduzível de inicialização em emulador. Não define a arquitetura de inicialização do ZupiOS nem comprova compatibilidade com a TV Samsung de referência.

Requisitos: GNU Binutils (s, ld), emulador de sistema QEMU para x86 e 	imeout.

Execute a partir da raiz do repositório:

`sh
bash tests/boot-poc/run.sh
`

O teste monta um setor de inicialização BIOS legado de 512 bytes, verifica a assinatura 55 aa, inicia a imagem no QEMU e procura uma mensagem emitida pelo console de depuração do emulador. Como o código de teste para e aguarda, o comando 	imeout encerra o QEMU após o prazo esperado. Nenhum firmware ou dispositivo físico é alterado; os artefatos de compilação ficam em um diretório temporário e são removidos ao final.
