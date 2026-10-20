---
title: Próximos passos do ZupiOS
type: project-continuity
status: active
tags:
  - zupios
  - planejamento
  - continuidade
---

# Próximos passos do ZupiOS

Este documento é o ponto de retomada do trabalho. Atualize-o ao concluir uma decisão e antes de encerrar uma etapa de planejamento. As decisões confirmadas devem ficar nos documentos arquiteturais ou ADRs correspondentes; este arquivo apenas resume o que foi registrado e identifica a próxima decisão em discussão.

## Estado documentado

- [[planning/decisions/0006-politica-de-idioma-e-localizacao|Decisão 0006 — Política de idioma e localização]]: sistema multilíngue, idioma padrão pt-BR e documentação oficial em português brasileiro.

- [[planning/decisions/0001-nome-e-objetivo|Decisão 0001 — Nome e objetivo]]: nome e objetivo do projeto.
- [[planning/decisions/0002-politica-de-licenciamento|Decisão 0002 — Política de licenciamento]]: diretrizes desejadas para uso, derivados e serviços comerciais; a licença jurídica definitiva continua pendente.
- [[planning/decisions/0003-organizacao-do-repositorio|Decisão 0003 — Organização do repositório]]: separação entre documentação, planejamento, código, SDK, testes e perfis de dispositivos.
- [[planning/decisions/0004-adaptacao-hardware-e-implantacao|Decisão 0004 — Adaptação ao hardware e à implantação]]: implantação flexível, detecção de capacidades, política de drivers (detecção automática, compatibilidade verificada, fallback genérico compatível e escolha manual quando necessário), alternativas de boot, instalação remota iniciada pelo site oficial quando o dispositivo permitir, tentativa de recuperação local/externa/rede, opção permanente “Restaurar sistema original” e distribuição híbrida de pacotes (genérico, customizado e full/offline): o customizado é completo e independente; seus componentes também podem ser baixados e aplicados manualmente como atualização sob demanda, inclusive em instalações genéricas antigas, quando houver compatibilidade verificada. Recuperação e instalação dependem do dispositivo e não são garantidas.
- [[planning/decisions/0005-conta-ativacao-e-servicos-premium|Decisão 0005 — Conta, ativação por instalação e serviços Premium]]: sistema básico sem conta/licença; ativação exige uma licença por instalação; login na TV pode ser ignorado; a TV gera token de solicitação, o usuário o informa no site e aplica o contra-token recebido na TV, que valida e ativa localmente sem precisar de internet. O token poderá incluir ou referenciar fabricante, modelo, versão e variante (genérica/customizada), conforme os dados tecnicamente disponíveis. Dados declarados e detectados devem ser distinguidos. O catálogo terá homologação parcial quando houver evidência de que o sistema foi instalado e iniciou, e total quando houver ativação online, coleta automática de dados técnicos e verificações mínimas definidas pelo projeto. Ativação online isolada não comprova funcionamento completo. O ID do dispositivo deve ser conceitualmente separado do ID da instalação, para que uma reinstalação possa reconhecer o mesmo hardware se houver um identificador estável e acessível. Instalações offline podem reconhecer localmente o estado Premium. Haverá alguns recursos locais gratuitos e opções adicionais/avançadas Premium; proteções de tela, temas, personalização e mini-games são candidatos, mas a divisão exata ainda está em aberto. A contribuição também pode representar apoio ao projeto, mesmo sem uso dos serviços online. Transferência de licença e detalhes de segurança continuam pendentes.

## Pendências conhecidas

- Avaliar a TV de referência identificada pelo usuário: Samsung UN40J6400AGXZD (sufixo regional XZD confirmado pelo usuário).
- Levantar SoC/CPU e arquitetura, RAM, armazenamento, firmware/plataforma, cadeia de boot, restrições de assinatura e opções seguras de recuperação; a possibilidade de instalação nativa ainda não está confirmada.
- Definir requisitos de compatibilidade a partir do hardware real.
- Especificar formato, assinatura/integridade, versionamento, dependências e fluxo de atualização dos pacotes modulares.
- Avaliar viabilidade de execução nativa e, depois, estabelecer a arquitetura sem presumir sistema-base, runtime, linguagem ou bootloader.
- Definir a licença jurídica final e revisar as implicações de distribuição de imagens de sistemas originais.
- Detalhar privacidade, consentimento, minimização e retenção para telemetria futura, incluindo a contribuição opcional de dados técnicos ao catálogo público de compatibilidade.
- Publicar critérios verificáveis para homologação parcial e total, incluindo os testes funcionais mínimos da classificação total.
- Especificar quais dados de fabricante/modelo/versão/variante podem ser obtidos pela instalação, quais são apenas declarados, como o servidor valida os dados recebidos e quais evidências são exigidas para confirmar compatibilidade.
- Definir como reconhecer a mesma TV após formatação/reinstalação, quais identificadores de hardware são realmente acessíveis por plataforma e como proceder quando não houver identificador estável; não publicar identificadores brutos de hardware.

## Próxima decisão em andamento

**Investigar o hardware e a cadeia de boot da Samsung UN40J6400AGXZD.**

O usuário confirmou o firmware 1550.0. Catálogos associam a placa BN41-02353B e os conjuntos BN94-08978U/BN94-08978V ao modelo UN40J6400AGXZD. Fontes secundárias indicam a plataforma `tztv-2.2.1-hawk-m-fhd_2015`, SoC Samsung SDP1415, eMMC de referência THGBMBG5D1KBAIT e flash SPI W25Q40; a capacidade de RAM permanece indeterminada devido a variantes. Manual de serviço da família e esquemas de placas Hawk-M relacionadas mencionam diagnósticos, UART/debug e eMMC/JTAG, mas não comprovam interfaces acessíveis ou boot alternativo na placa exata. Próximo passo: localizar documentação primária específica do conjunto BN94-08978U/V; se não houver, obter foto legível da placa por técnico qualificado para confirmar códigos e componentes. Não ligar adaptadores nem alterar pontos de teste com base em esquemas de outra variante.

Com os dados confirmados, avaliar a viabilidade de execução nativa e as opções de implantação antes de escolher tecnologias específicas. Em seguida, definir requisitos técnicos dos pacotes e do mecanismo de atualização modular.

## Instruções para continuidade

1. Leia este documento e a decisão relacionada antes de retomar.
2. Trabalhe uma decisão por vez e confirme premissas com o usuário antes de desenvolver planos extensos.
3. Quando uma decisão for aprovada, atualize o documento arquitetural/ADR correspondente e este arquivo.
4. Atualize índices e links Obsidian quando criar documentos.
5. Não declare implementação concluída quando houver apenas uma decisão ou requisito documentado.
6. Ao salvar alterações, faça commit no Git e informe o link do commit e dos arquivos alterados.


## Resultado da investigação documental da TV

A pesquisa encontrou manual de serviço da família J6400 e registros técnicos secundários que associam a placa BN41-02353B/BN94-09096Z ao UN40J6400 e identificam o SoC SDP1415, eMMC `THGBMBG5D1KBAIT` e flash SPI `W25Q40CL`. A configuração de RAM varia entre placas relacionadas e não está confirmada nesta unidade. Dumps de eMMC/diagramas ISP para reparo não demonstram que seja possível iniciar um sistema operacional alternativo. A viabilidade de boot do ZupiOS na TV permanece **não comprovada**. Próximo passo: não fazer modificações; decidir se o projeto precisa manter esta TV como alvo prioritário ou adotar uma plataforma de desenvolvimento controlável para prototipagem, mantendo a TV como alvo de compatibilidade posterior.


## Resultado da primeira prova de inicialização

O contêiner foi validado em Ubuntu 26.04 x86_64 com scripts/dev-check.sh. A prova experimental tests/boot-poc/ verifica imagem BIOS de 512 bytes, assinatura 55aa, marcador no console de depuração e encerramento esperado por tempo limite. O script declara máquina pc, CPU qemu64 e RAM de 128 MiB, além de informar a versão do QEMU; esses parâmetros são configuração do emulador, não dados detectados pelo código convidado. A aprovação comprova somente o fluxo mínimo no QEMU e não compatibilidade com a Samsung. Critérios e limites estão documentados em tests/boot-poc/README.md.

## Próxima etapa após a investigação da TV

Foi registrado o plano [[planning/validation-roadmap]] para separar a prototipagem da investigação de hardware. Próxima ação: escolher um ambiente de desenvolvimento controlável (máquina virtual ou computador x86-64, conforme os recursos disponíveis) e executar uma prova mínima de inicialização antes de selecionar sistema-base, linguagem ou runtime. A Samsung UN40J6400AGXZD continua como alvo experimental; não há comprovação de que aceite boot alternativo.


## Ambiente de desenvolvimento local

Foi adicionada a configuração inicial de VS Code Dev Containers com Docker em [[planning/development-environment]]. O ambiente usa uma imagem base Ubuntu e executa `scripts/dev-check.sh` para validar o contêiner. Próxima ação: o usuário deve abrir o repositório local no VS Code, executar **Dev Containers: Reopen in Container** e informar se a construção funcionou e qual sistema operacional hospeda o Docker. Isso não implementa ainda o sistema operacional ZupiOS nem comprova compatibilidade com a TV.


## Ajuste de robustez da prova QEMU

Em execuções anteriores, houve uma falha isolada em que o marcador não foi encontrado com o limite de três segundos, embora execuções diagnósticas e subsequentes tenham passado. Para reduzir a sensibilidade ao tempo de inicialização do ambiente, o limite foi ampliado para cinco segundos. A validação desta revisão deve incluir pelo menos cinco execuções consecutivas, além de `git diff --check` e `scripts/dev-check.sh`. Isso melhora a tolerância do teste, mas não substitui investigação caso a falha volte a ocorrer.


## Verificador de repetibilidade da prova QEMU

Foi criado `tests/boot-poc/repeat.sh`, que executa a prova individual cinco vezes por padrao (ou uma quantidade positiva fornecida como argumento), interrompe na primeira falha e informa o numero da tentativa e as aprovacoes anteriores. Isso padroniza a verificacao de repetibilidade e melhora a localizacao de falhas intermitentes; nao prova ausencia de falhas nem identifica automaticamente sua causa.
