# Protótipo de interface de TV — ZupiOS

**Estado:** exploratório, versão 0.2. Não é a interface de produção nem define a tecnologia gráfica do sistema.

## Executar

Abra `index.html` diretamente em um navegador moderno. Não requer instalação, servidor, dependências externas ou rede.

## Alterações nesta versão

- Removido o texto promocional da Home; mantida uma barra superior compacta.
- Menu principal reduzido a três destinos: TV ao vivo, Aplicações e Configurações.
- TV ao vivo apresenta opções para cabo, satélite e sinal digital terrestre. A sintonia é simulada, pois nenhum sintonizador real está integrado.
- Ajuda e recuperação movida para Configurações > Sistema.
- Barra superior exibe hora local do dispositivo, perfil atual e versão da interface demonstrativa.
- Marca Premium demonstrada com faixa dourada sob o logotipo. A edição é configurada pela constante `EDITION` no script.
- Perfis Principal e Convidado alternam apenas para demonstrar o indicador; não são contas persistentes.

## Controles

- Setas: mover o foco entre ações.
- Enter: ativar a ação focada.
- Esc ou Backspace: voltar; na recuperação e em Sobre, retorna às Configurações.
- H ou Home: ir diretamente ao menu principal.

## Limites explícitos

- A versão exibida é `0.2.0-prototype`, referente somente à interface demonstrativa, não a uma versão publicada do ZupiOS.
- O relógio usa a hora local do dispositivo de execução. A configuração de fuso/relógio durante a instalação é um requisito de produto, não implementado aqui.
- Origem de TV, busca de canais, conectividade, perfis, diagnóstico e abertura de aplicativos são simulados.
- Não há runtime, SDK, reprodução real, sintonizador, instalação, atualizador ou recuperação real.
- Não mede RAM, CPU, latência de hardware, taxa de quadros nem compatibilidade com TV física.
- Paleta, tipografia e composição ainda são hipóteses revisáveis, não decisões aprovadas.

## Roteiro de revisão

1. Navegar apenas com setas/Enter/Esc e verificar foco e retorno.
2. Conferir menu TV e opções de sinal.
3. Conferir Ajuda e recuperação dentro de Configurações.
4. Conferir relógio, versão e troca de perfil.
5. Conferir a faixa Premium e o comportamento da edição Base, alterando `EDITION` no script.
6. Inspecionar janelas largas/estreitas e legibilidade à distância.

A revisão visual ainda não substitui testes de usuário nem validação em hardware representativo.
