# Testes do ZupiOS

Este diretório contém provas experimentais e será ampliado com testes automatizados, testes de contrato e verificações de conformidade à medida que a arquitetura for definida.

## Provas existentes

- [`boot-poc/`](boot-poc/README.md): prova experimental de boot BIOS legado em QEMU. Verifica um setor de boot, leitura do segundo setor e transferência de execução para um segundo estágio. Não implementa kernel nem comprova compatibilidade com a TV Samsung de referência.

Testes de dispositivos devem registrar modelo, firmware, versão testada, método, evidências e limitações. Resultados de emulador e de hardware físico devem permanecer claramente separados.
