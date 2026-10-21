# Protótipo de interface de TV — ZupiOS

**Estado:** exploratório, versão 0.4. Não é a interface de produção nem define a tecnologia gráfica do sistema.

## Executar

Abra `index.html` diretamente em um navegador moderno. Não requer instalação, servidor, dependências externas ou rede.

## Alterações nesta versão

- Home mantém três menus principais: TV ao vivo, Aplicações e Configurações.
- A área de atalhos usa um bloco de adição com sinal de mais, sem instruções ou botões de remoção ocupando espaço.
- A Home aceita no máximo sete atalhos, mantendo o bloco de adição na grade e reservando duas linhas de quatro posições.
- A Home é dimensionada para caber na tela sem barra de rolagem; em telas menores os cartões de atalho ficam mais compactos.
- A barra superior exibe hora local e avatar circular com o nome do perfil logo abaixo.
- A tela Perfis permite alternar entre Principal e Convidado e escolher entre dez avatares ilustrativos.
- As opções de atalhos, perfis e avatares são mantidas somente durante a sessão da página; ainda não são persistentes.
- TV ao vivo apresenta opções para cabo, satélite e sinal digital terrestre. A sintonia é simulada, pois nenhum sintonizador real está integrado.
- Ajuda e recuperação fica em Configurações > Sistema.
- A faixa dourada Premium permanece sob o logotipo. A edição é configurada pela constante `EDITION` no script.

## Controles

- Setas: mover o foco entre ações.
- Enter: ativar a ação focada.
- Esc ou Backspace: voltar; na recuperação e em Sobre, retorna às Configurações.
- H ou Home: ir diretamente ao menu principal.

## Limites explícitos

- A versão exibida é `0.4.0-prototype`, referente somente à interface demonstrativa, não a uma versão publicada do ZupiOS.
- O relógio usa a hora local do dispositivo de execução. A configuração de fuso/relógio durante a instalação é um requisito de produto, não implementado aqui.
- Origem de TV, busca de canais, conectividade, perfis, avatares, atalhos, widgets, diagnóstico e abertura de aplicativos são simulados.
- Não há runtime, SDK, reprodução real, sintonizador, instalação, atualizador ou recuperação real.
- Não mede RAM, CPU, latência de hardware, taxa de quadros nem compatibilidade com TV física.
- Paleta, tipografia e composição ainda são hipóteses revisáveis, não decisões aprovadas.

## Roteiro de revisão

1. Navegar apenas com setas/Enter/Esc e verificar foco e retorno.
2. Adicionar atalhos até o limite de sete; conferir o bloco de adição e confirmar que a Home não apresenta barra de rolagem.
3. Abrir Perfis, alternar o perfil e escolher um avatar; conferir avatar circular e nome abaixo na barra superior.
4. Conferir menu TV e opções de sinal.
5. Conferir Ajuda e recuperação dentro de Configurações.
6. Conferir relógio, versão e faixa Premium; testar a edição Base alterando `EDITION` no script.
7. Inspecionar janelas largas/estreitas e legibilidade à distância.

A revisão visual ainda não substitui testes de usuário nem validação em hardware representativo.
