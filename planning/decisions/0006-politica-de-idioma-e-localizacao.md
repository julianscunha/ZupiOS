---
title: Política de idioma e localização
type: decision
status: accepted
tags:
  - zupios
  - arquitetura
  - localizacao
---

# Decisão 0006 — Política de idioma e localização

- **Estado:** aprovada
- **Escopo:** sistema, interfaces, mensagens, SDK e documentação própria do projeto
- **Idioma de referência:** português brasileiro (pt-BR)

## Contexto

O ZupiOS é um projeto brasileiro. O sistema deve poder atender pessoas que usam idiomas diferentes, sem transformar o inglês na língua principal do projeto ou misturar idiomas sem necessidade na documentação.

## Decisão

1. O ZupiOS será multilíngue. A arquitetura deverá permitir adicionar idiomas sem duplicar a lógica central do sistema.
2. O idioma padrão de uma instalação nova será português brasileiro (pt-BR).
3. A documentação oficial escrita pelo projeto será produzida primeiro em português brasileiro. Traduções para outros idiomas deverão ficar em arquivos ou versões separados, ligados à versão de referência em português.
4. Interfaces, mensagens ao usuário e conteúdo próprio do sistema deverão usar recursos de localização, em vez de espalhar textos fixos pelo código.
5. Quando disponível, a preferência de idioma poderá ser escolhida pelo usuário e alterada nas configurações. A ausência de uma tradução deverá usar uma regra de fallback explícita, começando por pt-BR.
6. Identificadores exigidos por linguagens, protocolos, bibliotecas e ferramentas externas não serão traduzidos quando isso prejudicar compatibilidade. A documentação explicará esses termos em português brasileiro quando necessário.
7. Nomes internos criados pelo projeto deverão preferir português brasileiro quando isso for tecnicamente viável e consistente. A decisão não obriga a traduzir palavras-chave ou convenções de linguagens de programação.
8. Testes de localização deverão verificar pelo menos o idioma padrão, o fallback e a ausência de recursos de idioma ausentes que impeçam a inicialização.

## Consequências

- O português brasileiro é a fonte principal da documentação e das traduções.
- A arquitetura de localização deve ser considerada desde o desenho das interfaces, sem exigir que todos os idiomas sejam implementados na primeira versão.
- A inclusão de outro idioma não altera o idioma padrão do projeto.
- Esta decisão define a política linguística; não significa que a infraestrutura multilíngue já esteja implementada.

## Critérios de validação futura

- Uma instalação nova seleciona pt-BR por padrão.
- Um idioma adicional pode ser selecionado sem recompilar a lógica central, quando a arquitetura escolhida permitir.
- Textos ausentes seguem o fallback definido e não interrompem a inicialização.
- A documentação de referência permanece integralmente em português brasileiro, salvo termos externos, nomes próprios ou trechos citados cuja tradução seja inadequada.
