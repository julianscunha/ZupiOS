# Prova mínima de sistema Linux em QEMU

Este ensaio complementa, mas não substitui, `tests/boot-poc`: em vez de executar um payload de três setores via BIOS legado, ele inicializa um kernel Linux x86_64 real com um initramfs BusyBox criado durante o teste. Não é ainda uma distribuição ZupiOS, não inclui drivers ou interface de produto e não demonstra compatibilidade com a TV Samsung.

## Requisitos

- Linux x86_64 com uma imagem de kernel em `/boot/vmlinuz-*` (ou caminho em `ZUPIOS_KERNEL`);
- `qemu-system-x86_64`, `busybox` (preferencialmente `busybox-static`), `cpio`, `gzip` e `timeout`.

No Ubuntu, as dependências usadas no CI são instaladas com:

```sh
sudo apt-get update
sudo apt-get install --yes linux-image-generic busybox-static cpio gzip qemu-system-x86 coreutils
```

## Executar

Na raiz do repositório:

```sh
bash tests/system-poc/run.sh
```

O teste cria um initramfs temporário com BusyBox estático e um `/init` que registra um marcador na consola serial, espera brevemente e solicita desligamento. O QEMU executa em TCG, com CPU `max` e 256 MiB de RAM, sem aceleração de hardware necessária. O modelo `max` expõe os recursos de CPU emulados necessários ao BusyBox estático fornecido pelo runner; não representa nem valida a CPU da TV.

## Aprovação

O teste só retorna código zero quando a saída serial contém ambos os marcadores `ZUPIOS_SYSTEM_BOOT_OK` e `ZUPIOS_SYSTEM_SHUTDOWN`. A ausência de qualquer marcador, kernel ausente, dependência ausente ou timeout causa falha. O log inclui a versão do QEMU, o nome/tamanho do kernel e o tamanho do initramfs.

O workflow `.github/workflows/system-poc.yml` usa `ubuntu-24.04`, instala as dependências e executa o ensaio em pushes relevantes, pull requests e acionamento manual. Ao final, publica por 14 dias o manifesto de versões/tamanhos e o log serial como artefato `zupios-system-boot-evidence`. A versão do kernel ainda vem do repositório de pacotes Ubuntu e não está fixada; o ensaio é reproduzível dentro do ambiente descrito, mas ainda não garante builds idênticos ao longo do tempo. Não considerar o teste aprovado até confirmar o resultado real do GitHub Actions.

## Limites

Este teste valida apenas que o kernel escolhido consegue inicializar o initramfs e executar o processo `/init` nesse perfil QEMU. O kernel é fornecido pelo pacote Ubuntu, não construído a partir de código do ZupiOS. O ensaio não define ABI/API de produto, não valida drivers de TV, GPU, codecs, Wi-Fi, controle remoto, persistência, atualização ou recuperação, nem prova arquitetura/boot nativo da Samsung.
