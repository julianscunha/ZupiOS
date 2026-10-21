---
title: Direção visual e modelo de interação do ZupiOS
type: product-specification
status: draft
tags:
  - zupios
  - interface
  - tv
  - acessibilidade
---

# Direção visual e modelo de interação do ZupiOS

## Estado

Proposta inicial para discussão e prototipagem. Esta é a fonte de verdade para princípios visuais e comportamento de interação. Não define toolkit, compositor, linguagem, resolução mínima nem arquitetura gráfica. As decisões devem ser validadas em protótipos e em hardware representativo antes de se tornarem contratos estáveis.

## Objetivo de experiência

O ZupiOS deve parecer rápido porque responde rapidamente: o foco é sempre evidente, a ação principal é clara, a navegação não exige precisão de mouse e a tela evita conteúdo desnecessário. A interface deve ser legível a uma distância típica de sala e continuar funcional em hardware de recursos limitados.

A interface é uma camada central do produto, mas não pode consumir recursos que prejudiquem a função principal da TV. A regra é **clareza primeiro, resposta imediata, decoração mínima**.

## Princípios visuais propostos

1. **Composição 2D simples:** superfícies sólidas e contraste claro; evitar depender de blur, transparências em camadas, partículas, vídeo de fundo ou sombras extensas.
2. **Hierarquia à distância:** poucos elementos primários por tela, títulos legíveis, rótulos curtos e espaçamento suficiente; não reproduzir a densidade de uma interface de telefone ou desktop.
3. **Foco inequívoco:** o elemento navegável atual deve se distinguir sem depender apenas de mudança sutil de cor. Usar contorno ou expansão controlada, contraste e indicação de seleção consistentes.
4. **Movimento funcional:** transições curtas e opcionais, sem bloquear a entrada seguinte; nenhuma informação essencial deve depender de animação. Em perfil limitado, reduzir ou desativar movimento sem perder contexto.
5. **Consistência:** a mesma ação, foco, retorno e estado usam o mesmo padrão em Home, configurações, aplicações do sistema, instalação e recuperação.
6. **Conteúdo antes de ornamentação:** capas e imagens de aplicações podem aparecer quando ajudam a escolher conteúdo; fundos decorativos e previews automáticos não são requisitos da Home.
7. **Acessibilidade e localização:** contraste suficiente, texto ampliável, linguagem simples, foco previsível e layout que suporte strings maiores e idiomas diferentes.
8. **Estados explícitos:** carregando, sem rede, indisponível, erro e recuperação devem explicar o que ocorreu e oferecer uma ação possível, sem animações infinitas.

## Modelo de navegação por controle remoto

- Setas movem o foco em uma ordem previsível; a ordem visual deve corresponder à ordem de navegação sempre que possível.
- OK/Enter ativa o item focado. A ativação fornece feedback imediato, mesmo quando a operação continua em segundo plano.
- Voltar retorna um nível ou fecha a camada transitória atual; não descarta silenciosamente uma operação ou configuração não salva.
- Home retorna à interface principal por uma ação global consistente. O comportamento durante uma operação crítica deve ser definido pelo contrato do sistema, não improvisado por cada tela.
- O foco não pode desaparecer após atualização de conteúdo, erro ou fechamento de uma aplicação. Se o item focado deixar de existir, mover o foco para um destino próximo e previsível.
- Alvos de interação devem tolerar navegação por passos discretos; nenhuma tarefa básica deve exigir ponteiro, gesto de toque ou teclado físico.
- Estados desabilitados continuam legíveis e, quando útil, explicam por que a função não está disponível.
- Operações demoradas não podem congelar a navegação global; oferecer cancelamento quando for seguro e indicar progresso sem polling visual excessivo.

## Estrutura inicial de telas

### Home

- Uma faixa principal com os destinos e aplicações mais usados, organizada para navegação por setas.
- Ação principal e item focado claramente destacados.
- Atalhos de sistema essenciais, como configurações e estado de conectividade, sem transformar a tela inicial em painel de métricas.
- Sem reprodução automática de vídeo nem fundo animado por padrão.
- Imagens e metadados são carregados sob demanda; placeholders estáveis evitam deslocamento dos itens enquanto carregam.

### Navegação e abertura de aplicação

- Selecionar um item apresenta feedback imediato; a preparação da aplicação ocorre sem bloquear a interface mais do que o necessário.
- Exibir estado de abertura apenas quando houver espera perceptível; não manter animação contínua sem progresso.
- Se falhar, apresentar mensagem compreensível, opção de tentar novamente quando apropriado e caminho claro de retorno à Home.

### Configurações

- Categorias em lista simples com foco explícito e painel de detalhe previsível.
- Mudanças com efeito imediato devem indicar o novo estado; alterações que exigem confirmação devem permitir cancelar.
- Configurações avançadas não devem ocupar a Home nem iniciar serviços desnecessários apenas por estarem visíveis.

### Instalação, erro e recuperação

- Interfaces funcionais e de alto contraste, sem dependência de imagens, rede ou animações.
- Mostrar claramente etapa atual, resultado e próxima ação segura.
- Em recuperação, priorizar estabilidade e legibilidade; não presumir que o hardware suporta uma opção até que a capacidade seja detectada.

## Requisitos de desempenho aplicados à interface

- O desenho deve obedecer a [[docs/product/requisitos-de-desempenho|Requisitos de desempenho e leveza]].
- Evitar renderizações repetidas de telas estáticas e atualizar somente regiões cujo conteúdo mudou, quando a tecnologia permitir.
- Limitar quantidade e resolução de imagens simultaneamente residentes; liberar recursos quando itens saem da área relevante.
- Não carregar todas as capas, previews ou metadados de um catálogo extenso de uma só vez.
- Evitar trabalho de rede no caminho crítico da navegação; a Home deve permanecer utilizável quando a rede está lenta ou indisponível.
- Animações, efeitos e previews são melhorias opcionais, nunca pré-requisitos de interação ou legibilidade.
- A degradação graciosa em perfil limitado deve preservar as funções básicas e a mesma lógica de navegação.

## Protótipo exploratório v0.1

Foi criado um protótipo HTML autocontido em [[prototypes/tv-ui/README|protótipo de interface de TV]]. Ele cobre Home, Aplicações, Configurações, Mídia, falha de abertura e recuperação conceitual, com navegação por setas/Enter/Esc, foco visível e estados simulados. Não usa dependências remotas nem define a tecnologia gráfica de produção.

O protótipo serve para revisar o fluxo e a hierarquia visual; não é uma implementação do ZupiOS e não demonstra consumo de recursos, compatibilidade com controle remoto físico ou desempenho em TV. A direção visual permanece em rascunho até revisão do fluxo, inspeção em diferentes tamanhos e validação em hardware representativo.

## Validação necessária

Antes de aprovar a direção visual, revisar o protótipo leve das quatro áreas descritas acima e verificar:

- navegação completa apenas com controle remoto, incluindo retorno e recuperação de foco;
- legibilidade à distância em tamanhos de tela representativos;
- comportamento com textos maiores, mudança de idioma e opções indisponíveis;
- funcionamento sem rede e com carregamento lento de imagens;
- diferença de custo entre efeitos ativados e desativados, quando houver implementação instrumentável;
- tempos de resposta e consumo medidos conforme o protocolo de [[docs/product/requisitos-de-desempenho|Requisitos de desempenho e leveza]].

A proposta não deve ser considerada aprovada apenas por uma imagem estática: o fluxo de foco e o feedback das ações precisam ser testados.

## Decisões ainda abertas

- paleta final, tipografia e identidade gráfica;
- densidade e organização final da Home;
- resolução e dimensões de referência por perfil de hardware;
- política de animações e transições após testes de custo;
- toolkit, compositor e tecnologia de renderização;
- comportamento de integração com aplicações e serviços que ainda não foram implementados.

## Relação com outros documentos

- [[docs/product/Visao-geral|Visão geral do produto]]: posicionamento e princípios gerais.
- [[docs/product/requisitos-de-desempenho|Requisitos de desempenho e leveza]]: orçamento e método de medição.
- [[planning/compatibility-requirements|Requisitos de compatibilidade]]: requisitos funcionais e prioridades.
- [[planning/Backlog|Backlog]]: trabalho e critérios de aceite.
