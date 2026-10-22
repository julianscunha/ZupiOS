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
- A prova atual não é um kernel, não fornece drivers, runtime, serviços ou interface gráfica e não identifica a arquitetura da TV Samsung.
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
| Perfil inicial de execução | O que o QEMU atual demonstra e qual perfil adicional é necessário para validar a primeira fatia executável |
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
| Kernel Linux existente + espaço de usuário mínimo | Drivers e subsistemas maduros; ferramentas de depuração; suporte a processos, memória, rede e multimídia já existente; evita criar um kernel inteiro antes de validar o produto. | Tamanho e consumo dependem da configuração; cada dispositivo ainda exige drivers e cadeia de boot compatíveis; licença GPLv2 do kernel e licenças dos demais componentes precisam ser respeitadas. | **Candidato preferido para o primeiro perfil de sistema completo em QEMU**, condicionado a definir uma imagem mínima e medir seus custos. Não declara suporte à Samsung. |
| Kernel próprio (bare metal / no_std) | Controle direto sobre o código inicial e o ambiente; payload pequeno. | Exigiria implementar ou integrar memória virtual, escalonamento, drivers, sistema de arquivos, segurança, rede e suporte de mídia; risco elevado de desviar o projeto do SDK e da experiência de TV. | Manter apenas como experimento educacional ou prova isolada; não recomendado como base do produto sem requisito concreto que justifique o custo. |
| Distribuição Linux existente como produto quase pronto | Acelera a obtenção de interface, serviços e ferramentas já integrados. | Pode trazer serviços, atualizações, consumo e políticas desnecessários; personalização e manutenção da distribuição tornam-se parte do produto. | Comparar depois de existir um perfil mínimo e critérios de RAM/armazenamento; não selecionar distribuição completa antecipadamente. |

### Perfil de execução recomendado para o próximo marco

- **Host de ferramentas:** contêiner Docker Linux, reproduzível e sem privilégios especiais.
- **Alvo de desenvolvimento inicial:** x86_64 em QEMU, exclusivamente como perfil controlado de desenvolvimento. A prova BIOS legada existente continua separada e demonstra apenas leitura de setores.
- **Sistema-base candidato:** kernel Linux existente com espaço de usuário mínimo; a escolha permanece provisória até compilar e iniciar uma imagem de ponta a ponta, verificar logs e registrar recursos usados.
- **Toolchain:** usar ferramentas existentes no contêiner e fixar versões após a primeira compilação reproduzível. A imagem Docker aic-rust:1 foi confirmada com rustc 1.99.1 e cargo 1.99.1; isso comprova a presença do toolchain Rust, não a disponibilidade de QEMU, de um alvo bare-metal configurado ou de uma cadeia completa de build do kernel.
- **Fora do marco:** driver de TV, interface gráfica final, codecs, instalação na Samsung, dual boot, atualização e recuperação em hardware físico.

### Portão de validação antes de consolidar a escolha

1. Construir a imagem do perfil mínimo de forma reproduzível dentro do contêiner.
2. Inicializá-la no QEMU com configuração explicitamente registrada.
3. Capturar marcador de inicialização e logs; falhas devem produzir código de saída não zero.
4. Repetir o ensaio automatizado e guardar os comandos e resultados.
5. Registrar tamanho do artefato e consumo/tempo apenas com metodologia identificada; não comparar esses valores diretamente com a TV.
6. Rever a escolha se o custo de construção, depuração ou configuração mínima não atender aos requisitos.

**Conclusão provisória:** usar Linux existente para investigar um sistema executável, em vez de começar por um kernel próprio. O passo ainda não está concluído: a imagem de sistema ponta a ponta não foi construída nem iniciada; ZUPI-004 permanece bloqueado para aprovação final enquanto a dependência de viabilidade de hardware (ZUPI-003) não for resolvida.

