---
title: "Decisão 0004 — Adaptação ao hardware e ao método de implantação"
id: ZUPI-ADR-0004
type: decision
status: accepted
date: 2026-10-19
tags:
  - zupios
  - hardware
  - deploy
  - boot
  - decisao
---

# Decisão 0004 — Adaptação ao hardware e ao método de implantação

- **Estado:** aceita
- **Data:** 2026-10-19

## Decisão

O ZupiOS deve separar o comportamento do sistema da forma como ele é inicializado, instalado e executado.

- **Sistema:** deve preservar, sempre que tecnicamente possível, uma experiência consistente, APIs estáveis e compatibilidade de aplicações entre modalidades de implantação.
- **Implementação:** deve detectar e avaliar o hardware e o ambiente disponíveis, apresentar ao usuário os caminhos viáveis e permitir que ele escolha como prosseguir.
- **Adaptação:** a avaliação deve considerar capacidades reais, não apenas marca ou modelo. Exemplos incluem arquitetura do processador, memória, armazenamento, drivers, conectividade e métodos de boot suportados.
- **Detecção e seleção de drivers:** durante a instalação, a implementação deve detectar automaticamente o hardware e suas capacidades. Drivers específicos só devem ser selecionados quando sua compatibilidade estiver verificada. Quando disponíveis e compatíveis, drivers genéricos devem servir como alternativa, priorizando funcionamento básico e estabilidade. A escolha manual deve ser oferecida quando a detecção falhar, houver alternativas relevantes ou o usuário quiser intervir. Marca e modelo, isoladamente, não comprovam compatibilidade.
- **Modalidades desejadas:** boot por USB, execução a partir de USB, instalação pela rede local, inicialização pela rede e instalação remota iniciada pelo usuário a partir do site oficial do ZupiOS, por meio de um pacote baixado na própria Smart TV quando navegador, firmware e mecanismos de segurança permitirem.
- **Dispositivos sem USB:** o processo deve considerar caminhos alternativos por rede, quando suportados pelo hardware e firmware.
- **Origem dos arquivos:** a implementação deve poder orientar a configuração de rede para localizar e obter arquivos de inicialização ou implementação de uma fonte local ou remota, conforme as opções disponíveis.
- **Limites da instalação remota:** baixar um pacote pelo site não garante que a TV permita executá-lo ou instalar outro sistema. O processo deve verificar os recursos disponíveis e informar quando o aparelho não oferecer um caminho compatível; não deve presumir que uma instalação remota seja possível em toda Smart TV.
- **Reversão local após instalação:** quando houver suporte técnico e espaço suficientes, o processo poderá preservar uma forma local de retorno ao sistema anterior, como dual boot, snapshot ou mecanismo equivalente.
- **Tentativa de recuperação alternativa:** se não for viável preservar a recuperação local, a implementação deve tentar encontrar um destino alternativo compatível, como armazenamento externo ou um servidor/repositório acessível pela rede, para guardar os dados necessários à recuperação.
- **Aviso e continuidade:** se não houver espaço ou suporte local e a tentativa de recuperação alternativa não estiver disponível ou falhar, o sistema deve avisar claramente o usuário de que a recuperação não está garantida. Esse aviso não bloqueia a instalação; o usuário pode prosseguir ciente da limitação.
- **Repositório de recuperação no SaaS:** como alternativa, o SaaS deverá buscar manter imagens de sistemas originais associadas a marcas e modelos de dispositivos. A disponibilidade e cobertura dessas imagens não são garantidas.
- **Acesso à restauração:** as configurações do ZupiOS devem oferecer uma opção permanente chamada **“Restaurar sistema original”**, sujeita às capacidades do dispositivo.
- **Ação Restaurar:** quando o usuário acionar essa opção nas configurações, o ZupiOS deverá consultar o repositório e, se encontrar arquivos potencialmente compatíveis, tentar restaurar os componentes necessários e refazer a inicialização original. A operação é uma tentativa e pode falhar por ausência de imagem, incompatibilidade, limitações de acesso ou particularidades do firmware/hardware.
- **Limites gerais:** as modalidades de implantação e recuperação são objetivos de compatibilidade, não garantias universais. A estratégia concreta dependerá do hardware, firmware, armazenamento e recursos disponíveis.

## Decisão adicional — formatos de distribuição

- **Distribuição de pacotes:** o ZupiOS deve oferecer um modelo híbrido de distribuição: pacote genérico menor, pacotes customizados para famílias/configurações de hardware com compatibilidade verificada e pacote full/offline com os componentes necessários para instalação sem conexão confiável.
- **Pacote genérico:** deve permitir instalação independente e fornecer o conjunto básico de funcionalidades compatível com o dispositivo. Algumas capacidades ou periféricos podem permanecer indisponíveis até a instalação de componentes adicionais.
- **Pacote customizado:** também deve ser uma distribuição completa e independente, inicializável/instalável por si só, voltada a uma família ou configuração de hardware cuja compatibilidade tenha sido verificada. Além disso, seus componentes devem poder ser distribuídos como uma atualização customizada separada, para instalação manual pelo usuário quando desejar, sem exigir atualização automática ou reinstalação completa. Essa atualização deve substituir ou complementar drivers e componentes para habilitar suporte específico, desde que haja compatibilidade com o dispositivo e a versão instalada. Isso inclui instalações antigas realizadas antes de existir suporte específico, quando o sistema usava drivers genéricos. Não se deve exigir reinstalação completa quando a atualização segura for tecnicamente viável.
- **Pacote full/offline:** deve reunir os componentes selecionados necessários para instalação sem depender de uma conexão confiável durante o processo.
- **Base compartilhada e componentes modulares:** os formatos devem reutilizar a mesma base do sistema e o mesmo mecanismo de instalação/atualização sempre que possível. Componentes e drivers devem ser versionados, declarar dependências e ter integridade verificada. Pacotes customizados devem incluir somente componentes com compatibilidade validada; não é necessário produzir uma imagem distinta para cada modelo quando uma família de hardware puder compartilhar um perfil.

## Dispositivo de referência inicial

- **Modelo informado:** Samsung UN40J6400AGXZD (linha J6400, 40 polegadas; código de modelo base na página de suporte: UN40J6400AG).
- **Firmware confirmado pelo usuário:** 1550.0, que corresponde à versão mais recente listada na página de suporte da Samsung consultada (pacote USB modificado em 21/01/2021). O número instalado foi informado diretamente pelo usuário. Isso não comprova, por si só, a possibilidade de iniciar código arbitrário ou instalar outro sistema operacional.
- **Etiqueta física inspecionada por foto:** confirma `Model: UN40J6400AG`, `Model Code: UN40J6400AGXZD`, `Type No.: UN40J6400` e `Version No.: TH02`. O `TH02` é o código de versão indicado na etiqueta, não o firmware. Alimentação nominal indicada: 100–240 V, 50/60 Hz, 125 W.
- **Hipótese de placa principal (não confirmada na unidade):** fontes técnicas secundárias associam o modelo UN40J6400AG à placa BN41-02353B. Isso deve ser tratado apenas como pista para pesquisa; não prova que essa seja a placa instalada nesta TV. SoC, RAM e armazenamento continuam sem confirmação.
- **Pesquisa documental complementar:** um manual de serviço da família UN**J6400AG identifica a plataforma de software como `tztv-2.2.1-hawk-m-fhd-2015`. Catálogos de peças associam a placa BN41-02353B (com variantes de código de conjunto BN94) ao UN40J6400AGXZD. Essas referências são evidência secundária para orientar a investigação, não confirmação da placa desta unidade. O SoC exato, arquitetura, quantidade de RAM, armazenamento e detalhes da cadeia de boot permanecem não verificados.
- **Identificação mais específica do conjunto da placa:** catálogos de peças listam a placa BN41-02353B com códigos de conjunto BN94-08978U e BN94-08978V como compatível com UN40J6400AGXZD. Essa é evidência de compatibilidade comercial, não confirmação do código de conjunto instalado na unidade.
- **Boot e depuração:** um manual de serviço da família J6400 menciona a plataforma `tztv-2.2.1-hawk-m-fhd_2015` e procedimentos de diagnóstico; esquemas de outras placas Hawk-M mostram blocos UART/debug e eMMC/JTAG. Não foi encontrada evidência suficiente de que essas interfaces estejam acessíveis ou utilizáveis para inicialização alternativa na placa exata desta TV. Não conectar adaptadores nem alterar straps/pontos de teste sem esquema específico e inspeção técnica.
- **Componentes indicados para a placa BN41-02353B por fontes técnicas secundárias:** CPU/SoC Samsung SDP1415; memória RAM DDR3, com referências de componentes K4B2G1646Q-BCMA (densidade de 2 Gbit por componente) e K4B4G16460-BCMA (4 Gbit por componente) em variantes de placas/famílias relacionadas; eMMC Toshiba/THGBMBG5D1KBAIT, listada como 4 GB em catálogo de peças para a plataforma Hawk-M FHD; flash SPI Winbond W25Q40 (4 Mbit). As fontes divergem nos códigos/densidades de RAM e não confirmam a configuração exata da unidade UN40J6400AGXZD. Não inferir a RAM total apenas pela referência do chip: quantidade de chips e organização precisam ser confirmadas.
- Este aparelho será o primeiro alvo de investigação de hardware e implantação do ZupiOS, não uma confirmação de compatibilidade ou de viabilidade de instalação nativa.
- A documentação pública da Samsung disponibiliza firmware de atualização por USB para o modelo. Isso confirma um mecanismo de atualização oficial, mas não demonstra que seja possível iniciar código arbitrário ou substituir o sistema operacional.
- Antes de qualquer alteração, identificar o código completo da etiqueta (incluindo sufixo regional), versão de firmware e placa principal efetivamente instalada. Investigar CPU/SoC, arquitetura, RAM, armazenamento, cadeia de boot, assinatura de firmware, interfaces de depuração e possibilidades de recuperação. Não gravar firmware modificado nem alterar opções de serviço durante a fase de levantamento.

## Implicações

- A detecção de capacidades e a apresentação das opções viáveis são responsabilidades da implementação; a escolha entre alternativas compatíveis cabe ao usuário.
- A seleção de drivers deve se basear em compatibilidade verificada, não apenas em identificadores de marca/modelo.
- A distribuição deve oferecer pacotes genérico, customizado e full/offline, com uma base compartilhada e componentes modulares.
- O usuário deve poder baixar e aplicar manualmente uma atualização customizada separada quando desejar, desde que a combinação de dispositivo, versão instalada e pacote seja compatível; esse fluxo não deve depender exclusivamente de atualização automática.
- O pacote customizado deve ser completo e independente, além de poder atualizar instalações genéricas existentes, inclusive as instaladas antes de haver suporte específico para o hardware.
- Um sistema instalado pelo pacote genérico deve poder receber componentes customizados posteriormente por um fluxo de atualização compatível, sem exigir reinstalação completa quando tecnicamente viável.
- O gerenciador de pacotes/atualizações deve validar versão, dependências, integridade e compatibilidade antes de aplicar componentes.
- Drivers genéricos são fallback apenas quando forem tecnicamente compatíveis; não se deve presumir que exista um driver genérico funcional para todo componente.
- A escolha manual complementa a detecção automática e não deve exigir que todos os usuários conheçam detalhes técnicos.
- Diferenças de implantação e desempenho não devem criar diferenças desnecessárias no contrato das APIs ou no comportamento das aplicações.
- A implementação deve reconhecer capacidades ausentes e limitações, em vez de presumir suporte universal.
- O fluxo de rede pode ocorrer antes de o ambiente normal do ZupiOS estar disponível; portanto, não pode depender exclusivamente de sua interface principal.
- A localização dos arquivos, a configuração de rede e a inicialização/instalação são etapas distintas.
- Dual boot, snapshot e outros mecanismos de recuperação não são equivalentes nem universalmente suportados.
- Antes de operações potencialmente destrutivas, a implementação deve avaliar a recuperação local e, se necessário, tentar um destino alternativo externo ou de rede.
- Se nenhuma opção de recuperação estiver disponível, o sistema deve informar o risco e permitir que o usuário prossiga.
- O repositório SaaS de imagens de recuperação é uma alternativa de melhor esforço, não uma promessa de restauração.
- A procedência, redistribuição, integridade, compatibilidade e manutenção das imagens de sistemas originais precisarão ser avaliadas antes de implementar esse repositório.
- Tecnologias, bootloader, sistema-base e mecanismos específicos permanecem pendentes; esta decisão não os escolhe.

## Critérios de aceite

- A arquitetura futura distingue claramente o contrato do sistema dos mecanismos de implantação.
- Existe um processo de descoberta/avaliação de capacidades do dispositivo.
- A seleção automática de drivers usa compatibilidade verificada e contempla drivers genéricos compatíveis como fallback.
- Os formatos genérico, customizado e full/offline compartilham a mesma base sempre que possível.
- O pacote customizado funciona como distribuição independente e seus componentes também podem ser aplicados como atualização manual a uma instalação existente, inclusive genérica, quando houver compatibilidade verificada.
- Há um caminho documentado para instalar componentes customizados após a instalação genérica, com validação de compatibilidade, dependências e integridade.
- O usuário pode escolher manualmente quando a detecção falhar, houver alternativas relevantes ou desejar intervir.
- As opções apresentadas ao usuário refletem as capacidades e limitações verificadas.
- O processo prevê alternativas para dispositivos sem USB, incluindo caminhos de rede quando tecnicamente disponíveis.
- Antes da instalação, o processo avalia a viabilidade de preservar uma opção local de retorno ao sistema anterior.
- Se a recuperação local não for viável, o sistema tenta uma alternativa externa/de rede quando disponível.
- Se nenhuma alternativa viável for encontrada, o usuário recebe um aviso claro e ainda pode prosseguir.
- A opção Restaurar consulta o repositório de recuperação e informa o usuário se a imagem não estiver disponível ou se a tentativa falhar.
- As diferenças inevitáveis entre dispositivos são documentadas em perfis de dispositivo.

## Evidências adicionais — placa BN41-02353B

- Um manual de serviço da família J6400 confirma a plataforma de software `tztv-2.2.1-hawk-m-fhd_2015` e documenta diagnósticos de fábrica. Isso identifica a família de software, mas não descreve um mecanismo suportado para executar um sistema operacional alternativo. Fonte: [manual de serviço C-ES-02286-1](https://www.scribd.com/document/802354187/UWK50-UNxxJ6400AG-1).
- Um registro de reparo para UN40J6400 associa a placa BN41-02353B ao conjunto BN94-09096Z e identifica o SoC SDP1415, eMMC e EEPROM SPI. É evidência técnica secundária útil, não confirmação da revisão instalada na unidade. Fonte: [EletrônicaBR — BIOS/EEPROM UN40J6400](https://eletronicabr.com/en/topic/274293-bios-and-eeprom-samsung-un40j6400-j5500-j6300/).
- Registros de placas BN41-02353B em modelos próximos mencionam `THGBMBG5D1KBAIT`, `W25Q40CL` e RAM DDR3 com configurações diferentes. Não extrapolar a quantidade total de RAM entre modelos/revisões. Fonte: [OneTV — placa Hawk-M FHD](https://onetv-srt.com/downloads/?b=144).
- Há material de reparo com dumps de eMMC e diagramas ISP para a família. Isso demonstra que técnicos conseguem acessar a memória em bancada com ferramentas apropriadas; **não demonstra** que exista boot alternativo, desbloqueio do bootloader ou UART/JTAG acessível para executar ZupiOS. Não usar dumps de terceiros nem gravar a memória da TV como experimento.

### Avaliação provisória de viabilidade

O hardware parece ser uma plataforma proprietária de Smart TV da geração 2015, com SoC Samsung SDP1415 e armazenamento eMMC, mas a correspondência exata da placa e a configuração de RAM da unidade permanecem não verificadas. A documentação pública consultada não prova um caminho seguro e repetível para iniciar um sistema operacional independente. A recomendação é tratar a TV como alvo experimental não confirmado e não como plataforma de desenvolvimento principal até existir prova de boot controlável e um método de recuperação validado.

## Documentos relacionados

- [[planning/decisions/0003-organizacao-do-repositorio]]
- [[docs/architecture/README|Estado da arquitetura]]
- [[docs/devices/Matriz-de-suporte|Matriz de suporte a dispositivos]]
