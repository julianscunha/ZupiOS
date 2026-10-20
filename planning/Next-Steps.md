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

O usuário confirmou que a versão instalada é 1550.0, correspondente à versão mais recente listada na página de suporte da Samsung consultada (pacote USB modificado em 21/01/2021). Isso confirma o número de firmware relatado, mas não prova que a TV aceite um sistema operacional alternativo. O próximo passo é identificar a placa principal e levantar SoC/CPU, arquitetura, RAM, armazenamento, plataforma, mecanismos de assinatura e caminhos de recuperação. Priorizar documentação e inspeção não destrutiva; não presumir que seja possível iniciar código arbitrário.

Com os dados confirmados, avaliar a viabilidade de execução nativa e as opções de implantação antes de escolher tecnologias específicas. Em seguida, definir requisitos técnicos dos pacotes e do mecanismo de atualização modular.

## Instruções para continuidade

1. Leia este documento e a decisão relacionada antes de retomar.
2. Trabalhe uma decisão por vez e confirme premissas com o usuário antes de desenvolver planos extensos.
3. Quando uma decisão for aprovada, atualize o documento arquitetural/ADR correspondente e este arquivo.
4. Atualize índices e links Obsidian quando criar documentos.
5. Não declare implementação concluída quando houver apenas uma decisão ou requisito documentado.
6. Ao salvar alterações, faça commit no Git e informe o link do commit e dos arquivos alterados.
