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

## Implicações

- A detecção de capacidades e a apresentação das opções viáveis são responsabilidades da implementação; a escolha entre alternativas compatíveis cabe ao usuário.
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
