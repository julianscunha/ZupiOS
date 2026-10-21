# Protótipo de interface de TV — ZupiOS

**Estado:** exploratório, versão 0.1. Não é a interface de produção nem define a tecnologia gráfica do sistema.

## Executar

Abra `index.html` diretamente em um navegador moderno. Não requer instalação, servidor, dependências externas, rede ou recursos remotos.

## Controles

- Setas: mover o foco entre ações.
- Enter: ativar a ação focada.
- Esc ou Backspace: retornar à Home.
- H ou Home: ir diretamente à Home.

Também é possível usar mouse para inspeção, mas nenhuma ação demonstrada exige mouse.

## Fluxos demonstrados

- Home com quatro destinos principais.
- Catálogo ilustrativo de aplicações.
- Área de mídia sem reprodução automática.
- Preferências de interface (movimento reduzido, conectividade simulada e sons).
- Falha ao abrir uma aplicação, com nova tentativa e retorno.
- Diagnóstico/recuperação conceitual com ações não destrutivas.

## Limites explícitos

- As opções são estado local temporário da página; recarregar reinicia o protótipo.
- Rede, sons, diagnóstico e falha de abertura são simulações.
- Não há runtime, SDK, reprodução real, instalação, atualizador ou recuperação real.
- Não mede RAM, CPU, latência de hardware, taxa de quadros nem compatibilidade com TV física.
- A paleta, tipografia, organização e dimensões são hipóteses para revisão, não decisões aprovadas.
- O navegador e seu mecanismo de layout não representam a futura tecnologia de interface do ZupiOS.

## Roteiro de revisão

1. Percorrer Home, Aplicações, Configurações, Mídia e Recuperação apenas com setas/Enter/Esc.
2. Confirmar que o foco está sempre visível e que o retorno não deixa a navegação sem foco.
3. Alternar conectividade e confirmar que a navegação básica continua disponível.
4. Simular falha de abertura; confirmar mensagem, nova tentativa e retorno.
5. Verificar layout em janela larga e estreita e com zoom do navegador ampliado.
6. Revisar legibilidade à distância e tamanho dos alvos numa TV real antes de aprovar a direção visual.

O fluxo de foco foi implementado para inspeção manual; ainda não constitui evidência de teste de usuário nem validação em hardware representativo.
