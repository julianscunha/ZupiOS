---
title: Estado da arquitetura do ZupiOS
type: reference
status: draft
tags:
  - zupios
  - arquitetura
---

# Estado da arquitetura do ZupiOS

A arquitetura técnica ainda não foi aprovada. O desenho comum do sistema pode avançar sem escolher uma TV como alvo universal, mas a escolha de sistema-base, runtime e perfil final de boot exige critérios explícitos e evidências de viabilidade.

## Estado confirmado

- Existe uma prova experimental de boot BIOS legado em QEMU que carrega e transfere o controle para um payload mínimo.
- A prova BIOS legado continua sendo apenas um carregador de payload. Separadamente, `tests/system-poc` inicializa um kernel Linux x86_64 fornecido pelo runner Ubuntu com initramfs mínimo em QEMU; isso não fornece drivers de TV, runtime de produto, serviços ou interface gráfica e não identifica a arquitetura da TV Samsung.
- O caminho de execução nativa na Samsung UN40J6400AGXZD permanece inconclusivo. Não há método de instalação e recuperação validado para essa unidade.
- O protótipo de interface é uma demonstração de navegador, independente da futura tecnologia gráfica.
- A arquitetura deve separar o comportamento comum do sistema dos mecanismos de boot, instalação e adaptação a dispositivos, conforme a ADR 0004.

## Direção estrutural para avaliação

Estas são fronteiras de projeto a investigar, não componentes já implementados nem uma escolha de kernel:

1. **Boot e carregamento:** código específico da combinação de arquitetura e firmware, responsável por carregar o próximo estágio e comunicar informações mínimas da plataforma.
2. **Núcleo do sistema:** inicialização, memória, execução e abstrações fundamentais. A escolha entre kernel existente e kernel próprio permanece aberta.
3. **Camada de plataforma:** capacidades detectadas, drivers e interfaces dependentes do hardware. Não expor APIs específicas de fabricante no contrato público.
4. **Serviços do sistema:** funções que podem ser testadas isoladamente e iniciadas conforme necessidade, evitando serviços residentes sem justificativa.
5. **Interface e aplicações:** interface de TV e SDK consumidores de contratos estáveis, sem dependência direta de detalhes do boot.
6. **Instalação, atualização e recuperação:** operações separadas do uso normal, com validação de compatibilidade, integridade e estratégia de retorno quando tecnicamente suportada.

## Contratos mínimos entre fronteiras (rascunho para revisão)

Os contratos abaixo definem responsabilidades e dados trocados, não APIs implementadas. Permanecem independentes de linguagem, kernel e formato binário; devem ser refinados somente quando um componente real exigir mais detalhe.

| Fronteira | Entrada mínima | Saída / garantia | Falha observável |
| --- | --- | --- | --- |
| Boot → núcleo | Endereço/intervalo do payload, mapa de memória quando disponível, identificador da plataforma e origem dos dados | Transferência explícita ao ponto de entrada; o núcleo valida novamente os dados antes de confiar neles | Código/estado de falha e diagnóstico acessível pelo mecanismo disponível; nunca presumir que o handoff foi válido |
| Núcleo → camada de plataforma | Interfaces de descoberta e operações suportadas pelo núcleo | Capacidades detectadas com estado `suportado`, `ausente` ou `desconhecido`; capacidade desconhecida não equivale a suporte | Erro tipado ou estado indisponível, sem selecionar driver por marca/modelo apenas |
| Plataforma → serviços | Capacidades e recursos efetivamente disponíveis | Serviço declara dependências, estado de inicialização e como encerra/libera recursos | Falha identificável, dependentes informados e possibilidade de continuar quando o serviço for opcional |
| Serviços → interface/aplicações | Operações públicas versionadas, resultado e capacidades/permissões concedidas | Resultado explícito; operação longa não deve bloquear a navegação global | Erro estável e compreensível, com recuperação/cancelamento quando seguro |
| Sistema → instalador/atualizador/recuperação | Perfil detectado, origem do pacote, versão, dependências e evidências de integridade | Plano validado antes de alterar o sistema; compatibilidade declarada para a combinação alvo | Interromper antes de alteração destrutiva quando validação falhar; informar claramente quando recuperação não estiver garantida |

### Invariantes transversais

- Ausência de informação deve ser representada como desconhecida, não preenchida por inferência.
- Toda operação entre componentes deve distinguir sucesso, indisponibilidade e falha; mensagens de diagnóstico não substituem um resultado verificável.
- Dados fornecidos por bootloader, pacote ou dispositivo devem ser validados na fronteira que os consome.
- Capacidades específicas do dispositivo não entram no contrato público de aplicações; são expostas por declarações de capacidade versionadas.
- Instalação e recuperação não podem ser tratadas como garantidas até que o mecanismo tenha sido validado para o perfil correspondente.
- Estes contratos não definem ainda estruturas binárias, syscalls, ABI, formato de pacote, política de permissões nem protocolo de boot final.

## Princípios de implementação

- Manter os contratos entre camadas pequenos e verificáveis.
- Desenvolver e testar componentes independentes no host sempre que isso não mascarar requisitos do hardware.
- Tratar QEMU como perfil de desenvolvimento controlado, não como prova de compatibilidade com a TV.
- Não fixar a arquitetura final de CPU a partir de referências secundárias sobre a placa Samsung.
- Não prometer USB, rede, dual boot, recuperação ou drivers antes de comprovar suporte no perfil de dispositivo correspondente.
- Preferir componentes existentes quando forem adequados, mantidos, compatíveis com os requisitos e avaliados quanto a licença e custo operacional.
- Tornar falhas de carregamento e inicialização observáveis e reproduzíveis.
- Não introduzir marketplace, serviços remotos ou telemetria antes de existir um sistema executável e os requisitos de privacidade correspondentes.

## Decisões que ainda precisam de evidência

| Decisão | O que precisa ser comparado |
| --- | --- |
| Sistema-base / kernel | Requisitos de hardware, licença, manutenção, drivers, isolamento, tamanho e possibilidade de testar no perfil de desenvolvimento |
| Perfil inicial de execução | A prova Linux x86_64 com initramfs mínimo passou em QEMU no CI; ainda é necessário reproduzir a imagem a partir de entradas fixadas e identificar separadamente o perfil de hardware físico |
| Bootloader e protocolo de boot | Firmwares suportados, carregamento de payload, informação entregue ao núcleo, diagnóstico e recuperação |
| Linguagem e toolchain | Suporte à arquitetura-alvo, compilação reproduzível, depuração, bibliotecas e integração com ferramentas existentes |
| SDK e runtime de aplicações | Contrato de API, capacidades, permissões, ciclo de vida e compatibilidade entre dispositivos |
| Gráficos e entrada | Requisitos mínimos de renderização, foco por controle remoto, acessibilidade e custo de recursos |
| Atualização e recuperação | Verificação de integridade, compatibilidade de versões, atomicidade e caminho de retorno demonstrável |

## Próxima atividade técnica

Preparar a decisão arquitetural ZUPI-004 em duas partes, sem confundi-las:

1. **Arquitetura independente do hardware:** definir contratos e fronteiras entre boot, núcleo, plataforma, serviços, interface/SDK e instalação/recuperação.
2. **Perfil executável de desenvolvimento:** comparar alternativas concretas de sistema-base/kernel e toolchain contra os requisitos, escolhendo apenas um perfil que possa ser construído e testado em ambiente controlado. A prova BIOS atual pode continuar como teste de carregamento isolado, mas não deve ser tratada automaticamente como o bootloader final.

A decisão deve registrar alternativas consideradas, evidências, riscos, critérios de aceitação e pontos explicitamente adiados. A escolha do perfil de desenvolvimento não equivale à aprovação de compatibilidade com a Samsung.

## Referências

- [[planning/Backlog|Backlog]]
- [[planning/Roadmap|Roadmap]]
- [[planning/validation-roadmap|Plano de validação técnica]]
- [[planning/decisions/0004-adaptacao-hardware-e-implantacao|ADR 0004 — Adaptação ao hardware e implantação]]
- [[tests/boot-poc/README|Prova de boot em QEMU]]

## Comparação inicial de bases e perfil de desenvolvimento (2026-10-22)

Esta comparação separa a escolha do ambiente de prototipagem da escolha do produto final. É uma recomendação de engenharia para reduzir risco, não a aprovação de uma arquitetura de produção.

| Alternativa | Vantagens | Custos / riscos | Uso nesta etapa |
| --- | --- | --- | --- |
| Kernel Linux existente + espaço de usuário mínimo | Drivers e subsistemas maduros; ferramentas de depuração; suporte a processos, memória, rede e multimídia já existente; evita criar um kernel inteiro antes de validar o produto. | Tamanho e consumo dependem da configuração; cada dispositivo ainda exige drivers e cadeia de boot compatíveis; licença GPLv2 do kernel e licenças dos demais componentes precisam ser respeitadas. | **Candidato validado apenas como prova mínima em QEMU:** kernel do runner Ubuntu + initramfs BusyBox iniciam e desligam com marcadores verificados. A imagem não é uma distribuição ZupiOS nem um build reprodutível do produto. Não declara suporte à Samsung. |
| Kernel próprio (bare metal / no_std) | Controle direto sobre o código inicial e o ambiente; payload pequeno. | Exigiria implementar ou integrar memória virtual, escalonamento, drivers, sistema de arquivos, segurança, rede e suporte de mídia; risco elevado de desviar o projeto do SDK e da experiência de TV. | Manter apenas como experimento educacional ou prova isolada; não recomendado como base do produto sem requisito concreto que justifique o custo. |
| Distribuição Linux existente como produto quase pronto | Acelera a obtenção de interface, serviços e ferramentas já integrados. | Pode trazer serviços, atualizações, consumo e políticas desnecessários; personalização e manutenção da distribuição tornam-se parte do produto. | Comparar depois de existir um perfil mínimo e critérios de RAM/armazenamento; não selecionar distribuição completa antecipadamente. |

### Perfil de execução recomendado para o próximo marco

- **Host de ferramentas:** contêiner Docker Linux, reproduzível e sem privilégios especiais.
- **Alvo de desenvolvimento inicial:** x86_64 em QEMU, exclusivamente como perfil controlado de desenvolvimento. A prova BIOS legada existente continua separada e demonstra apenas leitura de setores.
- **Sistema-base candidato:** kernel Linux existente com espaço de usuário mínimo. O boot ponta a ponta de um kernel Linux fornecido pelo runner e de um initramfs mínimo passou no CI; ainda falta reproduzir a construção da imagem a partir de entradas fixadas e medir os recursos do artefato.
- **Toolchain:** usar ferramentas existentes no contêiner e fixar versões após a primeira compilação reproduzível. A imagem Docker aic-rust:1 foi confirmada com rustc 1.99.1 e cargo 1.99.1; isso comprova a presença do toolchain Rust, não a disponibilidade de QEMU, de um alvo bare-metal configurado ou de uma cadeia completa de build do kernel.
- **Fora do marco:** driver de TV, interface gráfica final, codecs, instalação na Samsung, dual boot, atualização e recuperação em hardware físico.

### Portão de validação antes de consolidar a escolha

1. **Concluído no CI (2026-10-22):** iniciar o kernel Linux do runner Ubuntu com initramfs BusyBox mínimo em QEMU, capturar marcadores de inicialização/desligamento e exigir código de saída zero. Evidência: [workflow](https://github.com/julianscunha/ZupiOS/actions/runs/39781473737), commit `76c6888`.
2. **Pendente:** fixar e documentar as entradas/versões necessárias para reproduzir a imagem sem depender implicitamente do kernel instalado no runner.
3. **Pendente:** publicar versões e tamanhos do kernel/initramfs como artefatos CI recuperáveis.
4. **Pendente:** comparar custos do sistema-base após obter imagem reproduzível; não inferir desempenho de produto a partir deste ensaio.

**Conclusão provisória:** usar Linux existente para investigar um sistema executável, em vez de começar por um kernel próprio. O primeiro boot de kernel Linux + initramfs mínimo está validado em QEMU no CI, mas depende do kernel disponível no runner e ainda não é um build reprodutível do produto. ZUPI-004 permanece bloqueado para aprovação final enquanto a dependência de viabilidade de hardware (ZUPI-003) não for resolvida.
