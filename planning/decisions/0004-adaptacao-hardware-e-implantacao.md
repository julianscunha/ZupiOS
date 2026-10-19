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
- **Modalidades desejadas:** boot por USB, execução a partir de USB, instalação pela rede e inicialização pela rede.
- **Dispositivos sem USB:** o processo deve considerar caminhos alternativos por rede, quando suportados pelo hardware e firmware.
- **Origem dos arquivos:** a implementação deve poder orientar a configuração de rede para localizar e obter arquivos de inicialização ou implementação de uma fonte local ou remota, conforme as opções disponíveis.
- **Reversão local após instalação:** quando houver suporte técnico e espaço suficientes, o processo poderá preservar uma forma local de retorno ao sistema anterior, como dual boot, snapshot ou mecanismo equivalente.
- **Sem espaço ou suporte para recuperação local:** a implementação deve avisar o usuário sobre a limitação, mas não bloquear a instalação por esse motivo. O usuário poderá prosseguir ciente de que não há recuperação local garantida.
- **Repositório de recuperação no SaaS:** como alternativa, o SaaS deverá buscar manter imagens de sistemas originais associadas a marcas e modelos de dispositivos. A disponibilidade e cobertura dessas imagens não são garantidas.
- **Ação Restaurar:** quando o usuário solicitar a restauração, o ZupiOS deverá consultar o repositório e, se encontrar arquivos potencialmente compatíveis, tentar restaurar os componentes necessários e refazer a inicialização original. A operação é uma tentativa e pode falhar por ausência de imagem, incompatibilidade, limitações de acesso ou particularidades do firmware/hardware.
- **Limites gerais:** as modalidades de implantação e recuperação são objetivos de compatibilidade, não garantias universais. A estratégia concreta dependerá do hardware, firmware, armazenamento e recursos disponíveis.

## Implicações

- A detecção de capacidades e a apresentação das opções viáveis são responsabilidades da implementação; a escolha entre alternativas compatíveis cabe ao usuário.
- Diferenças de implantação e desempenho não devem criar diferenças desnecessárias no contrato das APIs ou no comportamento das aplicações.
- A implementação deve reconhecer capacidades ausentes e limitações, em vez de presumir suporte universal.
- O fluxo de rede pode ocorrer antes de o ambiente normal do ZupiOS estar disponível; portanto, não pode depender exclusivamente de sua interface principal.
- A localização dos arquivos, a configuração de rede e a inicialização/instalação são etapas distintas.
- Dual boot, snapshot e outros mecanismos de recuperação não são equivalentes nem universalmente suportados.
- A verificação de espaço e suporte para recuperação local deve ocorrer antes de operações potencialmente destrutivas. A falta de uma alternativa local gera um aviso, mas não impede a continuidade.
- O repositório SaaS de imagens de recuperação é uma alternativa de melhor esforço, não uma promessa de restauração.
- A procedência, redistribuição, integridade, compatibilidade e manutenção das imagens de sistemas originais precisarão ser avaliadas antes de implementar esse repositório.
- Tecnologias, bootloader, sistema-base e mecanismos específicos permanecem pendentes; esta decisão não os escolhe.

## Critérios de aceite

- A arquitetura futura distingue claramente o contrato do sistema dos mecanismos de implantação.
- Existe um processo de descoberta/avaliação de capacidades do dispositivo.
- As opções apresentadas ao usuário refletem as capacidades e limitações verificadas.
- O processo prevê alternativas para dispositivos sem USB, incluindo caminhos de rede quando tecnicamente disponíveis.
- Antes da instalação, o processo avalia a viabilidade de preservar uma opção local de retorno ao sistema anterior.
- Se não houver recuperação local viável, o usuário recebe um aviso claro e ainda pode prosseguir.
- A opção Restaurar consulta o repositório de recuperação e informa o usuário se a imagem não estiver disponível ou se a tentativa falhar.
- As diferenças inevitáveis entre dispositivos são documentadas em perfis de dispositivo.

## Documentos relacionados

- [[planning/decisions/0003-organizacao-do-repositorio]]
- [[docs/Arquitetura]]
- [[docs/Dispositivos]]
