# Protótipo de interface de TV — ZupiOS

**Estado:** exploratório, versão 0.7. Não é a interface de produção nem define a tecnologia gráfica do sistema.

## Executar

Abra `index.html` diretamente em um navegador moderno. Não requer instalação, servidor, dependências externas ou rede.

## Alterações nesta versão

- Navegação por setas baseada na posição real dos controles, sem exigir avanço linear entre linhas e colunas.
- Ícones SVG inline, tipografia de sistema, estados de foco/pressão consistentes e respeito à preferência de movimento reduzido.
- Em janelas com pouca altura, a Home permite rolagem vertical em vez de cortar conteúdo. O relógio atualiza na virada do minuto.

- TV ao vivo, Aplicações e Mídia são as áreas principais. Configurações aparece como um botão compacto com apenas a engrenagem, com Ajuda logo abaixo.
- A área de atalhos usa um bloco de adição com sinal de mais, sem instruções ou botões de remoção ocupando espaço. Em Configurações, o usuário pode alternar entre os layouts Equilibrado, Compacto e Atalhos em destaque.
- A Home aceita no máximo sete atalhos, mantendo o bloco de adição na grade e reservando duas linhas de quatro posições.
- A Home prioriza caber sem rolagem nas alturas comuns; em janelas baixas permite rolagem em vez de cortar conteúdo.
- A barra superior exibe hora local e avatar circular com o nome do perfil logo abaixo. A versão do protótipo fica no rodapé, junto aos controles de navegação.
- A tela Perfis permite alternar entre Principal e Convidado e escolher entre dez avatares ilustrativos.
- As opções de atalhos, perfis e avatares são mantidas somente durante a sessão da página; ainda não são persistentes.
- TV ao vivo apresenta opções para cabo, satélite e sinal digital terrestre. A sintonia é simulada, pois nenhum sintonizador real está integrado.
- Ajuda também tem um botão próprio abaixo da engrenagem na tela inicial; Ajuda e recuperação continua acessível em Configurações > Sistema.
- A faixa dourada Premium permanece sob o logotipo. A edição é configurada pela constante `EDITION` no script.

## Controles

- Setas: mover o foco entre ações.
- Enter: ativar a ação focada.
- Esc ou Backspace: voltar; na recuperação e em Sobre, retorna às Configurações.
- H ou Home: ir diretamente ao menu principal.

## Limites explícitos

- A versão exibida é `0.7.0-prototype`, referente somente à interface demonstrativa, não a uma versão publicada do ZupiOS.
- O relógio usa a hora local do dispositivo de execução. A configuração de fuso/relógio durante a instalação é um requisito de produto, não implementado aqui.
- Origem de TV, busca de canais, conectividade, perfis, avatares, atalhos, widgets, diagnóstico e abertura de aplicativos são simulados.
- Não há runtime, SDK, reprodução real, sintonizador, instalação, atualizador ou recuperação real.
- Não mede RAM, CPU, latência de hardware, taxa de quadros nem compatibilidade com TV física.
- Paleta e composição continuam exploratórias, não são decisões aprovadas. A tipografia usa fontes locais do sistema; os ícones vetoriais estão incorporados ao HTML.

## Roteiro de revisão

1. Navegar apenas com setas/Enter/Esc; conferir movimento espacial entre linhas/colunas, foco visível e retorno.
2. Adicionar atalhos até o limite de sete; conferir o bloco de adição e confirmar que a Home não apresenta rolagem em altura comum e que permite rolagem em janelas baixas.
3. Abrir Perfis, alternar o perfil e escolher um avatar; conferir avatar circular e nome abaixo na barra superior.
4. Conferir os menus TV, Aplicações e Mídia.
5. Abrir Ajuda pelo botão abaixo da engrenagem e também por Configurações > Sistema.
6. Alternar o layout da tela inicial em Configurações e conferir as três opções; conferir relógio, versão e faixa Premium; testar a edição Base alterando `EDITION` no script.
7. Inspecionar janelas largas/estreitas e legibilidade à distância.

A revisão visual ainda não substitui testes de usuário nem validação em hardware representativo.


## Cobertura automatizada do protótipo

A suíte `node --test tests/ui-prototype-navigation.test.cjs` verifica a geometria da navegação direcional, o tratamento de limites, ícones SVG locais, versão/recursos sem rede externa e a presença dos fluxos prioritários e atalhos globais. Na revisão de 2026-10-21, passou em 8/8 testes.

Além dos testes de fonte, em 2026-10-21 uma sessão real do Microsoft Edge headless controlada pelo Chrome DevTools Protocol passou pelos fluxos de foco inicial, setas, Enter, Esc, Configurações, sem rede, falha de abertura/tentar novamente, perfil e avatar. O script de execução foi temporário e ficou em artefatos locais ignorados pelo Git; não adiciona dependências ao protótipo. Essa passagem cobre apenas os cenários declarados, não toda a interface. Ainda é necessária inspeção visual em janelas largas e baixas, revisão de legibilidade e textos longos/localização, percurso de todas as telas e teste com controle remoto/TV representativos. A aprovação da direção visual permanece pendente.
