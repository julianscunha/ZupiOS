---
title: "Decisão 0005 — Conta, ativação por instalação e serviços Premium"
id: ZUPI-ADR-0005
type: decision
status: accepted
date: 2026-10-19
tags: [zupios, premium, conta, servicos, decisao]
---

# Decisão 0005 — Conta, ativação por instalação e serviços Premium

- **Estado:** aceita
- **Data:** 2026-10-19

## Decisão

O ZupiOS deve permanecer utilizável sem ativação Premium. Uma contribuição de apoio à manutenção dos serviços online ativa benefícios Premium **por instalação**, sem transformar os recursos básicos do sistema em funcionalidades pagas.

- **Uso básico:** o ZupiOS pode ser usado sem conta e sem token Premium, preservadas as funções locais suportadas pelo dispositivo.
- **Conta opcional:** o usuário pode criar uma conta no site, entrar nela pela TV e vincular a instalação. Registrar-se ou vincular uma TV não ativa Premium por si só.
- **Ativação por instalação:** é necessária uma contribuição por instalação. Os benefícios Premium só ficam disponíveis enquanto houver um token ativo para aquela instalação. Sem ele, a instalação continua utilizável, mas não usufrui dos benefícios Premium.
- **Conta e instalações:** a conta permite administrar instalações vinculadas, mas não substitui o token nem ativa automaticamente todas as TVs associadas.
- **Catálogo público de compatibilidade e homologação:** com transparência ao usuário e controles de privacidade adequados, dados técnicos minimizados poderão contribuir para um catálogo público. O catálogo deverá distinguir aparelhos apenas vinculados, instalações identificadas e níveis de homologação. Vínculo de conta não comprova instalação nem compatibilidade.
- **Homologação parcial:** aplicável quando houver evidência de que o ZupiOS foi instalado e iniciou no dispositivo. Essa classificação confirma a instalação/inicialização observada, mas não garante que todos os componentes e recursos funcionem. O registro deve indicar a versão e a variante testada (genérica ou customizada), quando conhecidas.
- **Homologação total:** aplicável quando a instalação for ativada online, coletar automaticamente dados técnicos do dispositivo e passar pelas verificações técnicas mínimas definidas pelo projeto. A ativação online e a coleta automática aumentam a confiabilidade da identificação, mas não substituem testes de funcionamento. Se as verificações não forem executadas ou falharem, o dispositivo não deve ser classificado como totalmente homologado.
- **Dados do token e identificação do dispositivo:** o token de solicitação poderá incluir ou referenciar dados técnicos que a instalação consiga obter, como fabricante, modelo, versão do sistema e variante instalada (genérica ou customizada). A origem e o nível de confiança dos dados devem ser identificáveis: dados declarados pelo usuário não equivalem a dados detectados automaticamente. Não incluir dados pessoais ou segredos desnecessários no token.
- **Ativação online como evidência:** o servidor poderá validar o token e registrar dados técnicos enviados pela instalação, oferecendo evidência mais forte que um vínculo de conta isolado. A ativação online, por si só, não comprova que todos os componentes ou recursos funcionam.
- **Token e contra-token:** o fluxo proposto usa um token apresentado pela instalação e um contra-token emitido pelo site. Formato, segurança, validade, renovação, revogação e recuperação ainda precisam ser especificados.
- **Serviços Premium pretendidos:** atualização automática; sincronização de perfil e preferências; marketplace oficial; agendamento remoto de desligamento; controles parentais remotos; visualização e gestão das instalações vinculadas/ativas na conta; e acesso a repositórios de bootloaders ou arquivos de recuperação quando houver disponibilidade, compatibilidade e autorização para distribuição.
- **Aplicativos:** instalar aplicativos por outros meios suportados, como pendrive, não deve exigir Premium, mesmo que o marketplace oficial seja um benefício Premium.
- **Finalidade da contribuição:** apoiar o projeto, incluindo a operação e manutenção dos serviços online. A contribuição também pode ser motivada pelo apoio ao projeto, sem expectativa de uso dos serviços online. A redação pública e o modelo jurídico/financeiro devem ser revisados antes do lançamento.
- **Premium em instalações offline:** uma instalação sem conectividade pode manter o reconhecimento local de seu estado Premium, desde que a licença possa ser validada localmente. O sistema deve oferecer alguns recursos locais gratuitos e reservar opções adicionais ou avançadas para o Premium. Candidatos a recursos locais incluem proteções de tela, temas, personalização e mini-games; a divisão exata entre opções gratuitas e Premium ainda não está decidida.
- **Limites:** serviços dependentes de conectividade, servidores, compatibilidade ou direitos de distribuição são condicionais; não se deve prometer disponibilidade universal.

## Implicações

- A arquitetura deve separar recursos locais básicos, benefícios Premium locais e serviços online Premium.
- O estado Premium deve poder ser reconhecido localmente em instalações offline, se a licença tiver sido validada; isso não implica disponibilidade de serviços que dependam de rede.
- Deve existir uma oferta de recursos locais gratuitos e uma camada de opções locais adicionais/avançadas Premium.
- A divisão exata de proteções de tela, temas, personalização e mini-games entre gratuito e Premium permanece em aberto.
- Autenticação da conta e ativação Premium são estados distintos.
- O Premium é verificado por instalação, não apenas por conta.
- Ausência, expiração ou invalidação do token retira os benefícios Premium sem bloquear o uso básico.
- A prevenção contra cópia indevida de tokens entre instalações, o tratamento de reinstalações e o comportamento de transferência permanecem decisões técnicas pendentes.
- Ações remotas que afetem a TV exigem autenticação, autorização e proteções contra uso indevido.
- A coleta para o catálogo deve ser transparente, limitada ao necessário e não deve expor identificadores de conta, tokens de licença ou dados pessoais no catálogo público.
- A homologação parcial e total deve ter critérios verificáveis e publicados. A ativação online não deve ser tratada, isoladamente, como prova de compatibilidade total.
- O escopo dos benefícios e a política de continuidade caso os serviços online sejam encerrados deverão ser documentados antes do lançamento.

## Critérios de aceite

- O sistema básico funciona sem conta e sem ativação Premium.
- É possível entrar em uma conta e vincular uma instalação sem ativar automaticamente os benefícios.
- Cada instalação requer ativação própria e token ativo.
- Sem token ativo, o sistema mantém o uso básico e não oferece os benefícios Premium.
- Instalar aplicativos por pendrive, quando suportado, não depende de Premium.
- O fluxo de token/contra-token é especificado com requisitos de segurança antes da implementação.
- O catálogo diferencia dados declarados, dados detectados automaticamente, instalação iniciada, homologação parcial e homologação total.

## Documentos relacionados

- [[planning/decisions/0002-politica-de-licenciamento]]
- [[planning/decisions/0004-adaptacao-hardware-e-implantacao]]
- [[planning/Next-Steps]]
