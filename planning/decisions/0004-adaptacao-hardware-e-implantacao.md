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
- **Pacote customizado:** também deve ser uma distribuição completa e independente, inicializável/instalável por si só, voltada a uma família ou configuração de hardware cuja compatibilidade tenha sido verificada. Além disso, deve poder atuar como atualização de uma instalação genérica existente, substituindo ou complementando drivers e componentes para habilitar suporte específico, desde que haja compatibilidade com o dispositivo e a versão instalada. Isso inclui instalações antigas realizadas antes de existir suporte específico, quando o sistema usava drivers genéricos. Não se deve exigir reinstalação completa quando a atualização segura for tecnicamente viável.
- **Pacote full/offline:** deve reunir os componentes selecionados necessários para instalação sem depender de uma conexão confiável durante o processo.
- **Base compartilhada e componentes modulares:** os formatos devem reutilizar a mesma base do sistema e o mesmo mecanismo de instalação/atualização sempre que possível. Componentes e drivers devem ser versionados, declarar dependências e ter integridade verificada. Pacotes customizados devem incluir somente componentes com compatibilidade validada; não é necessário produzir uma imagem distinta para cada modelo quando uma família de hardware puder compartilhar um perfil.

## Implicações

- A detecção de capacidades e a apresentação das opções viáveis são responsabilidades da implementação; a escolha entre alternativas compatíveis cabe ao usuário.
- A seleção de drivers deve se basear em compatibilidade verificada, não apenas em identificadores de marca/modelo.
- A distribuição deve oferecer pacotes genérico, customizado e full/offline, com uma base compartilhada e componentes modulares.
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
- O pacote customizado funciona como distribuição independente e pode atualizar uma instalação genérica existente quando houver compatibilidade verificada.
- Há um caminho documentado para instalar componentes customizados após a instalação genérica, com validação de compatibilidade, dependências e integridade.
- O usuário pode escolher manualmente quando a detecção falhar, houver alternativas relevantes ou desejar intervir.
- As opções apresentadas ao usuário refletem as capacidades e limitações verificadas.
- O processo prevê alternativas para dispositivos sem USB, incluindo caminhos de rede quando tecnicamente disponíveis.
- Antes da instalação, o processo avalia a viabilidade de preservar uma opção local de retorno ao sistema anterior.
- Se a recuperação local não for viável, o sistema tenta uma alternativa externa/de rede quando disponível.
- Se nenhuma alternativa viável for encontrada, o usuário recebe um aviso claro e ainda pode prosseguir.
- A opção Restaurar consulta o repositório de recuperação e informa o usuário se a imagem não estiver disponível ou se a tentativa falhar.
- As diferenças inevitáveis entre dispositivos são documentadas em perfis de dispositivo.

## Documentos relacionados

- [[planning/decisions/0003-organizacao-do-repositorio]]
- [[docs/Arquitetura]]
- [[docs/Dispositivos]]
