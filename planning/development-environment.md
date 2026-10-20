---
title: Ambiente local de desenvolvimento
type: development-guide
status: proposed
tags:
  - zupios
  - vscode
  - docker
  - desenvolvimento
---

# Ambiente local de desenvolvimento

## Objetivo

Usar Visual Studio Code e Docker para criar um ambiente isolado e reproduzível para o desenvolvimento do ZupiOS. Este ambiente é para desenvolvimento de software; não prova compatibilidade nem inicialização na Samsung UN40J6400AGXZD.

## Pré-requisitos

- Visual Studio Code atualizado.
- Docker Desktop no Windows/macOS ou Docker Engine no Linux.
- Extensão **Dev Containers** da Microsoft no VS Code.
- Repositório ZupiOS clonado localmente.

## Abrir o ambiente

1. Inicie o Docker e confirme que está em execução.
2. Abra a pasta raiz do repositório ZupiOS no VS Code.
3. Instale a extensão **Dev Containers** se ainda não estiver instalada.
4. Abra a paleta de comandos e execute **Dev Containers: Reopen in Container**.
5. Aguarde a criação do contêiner e a execução de `scripts/dev-check.sh`.
6. No terminal integrado, execute `bash scripts/dev-check.sh` para repetir a verificação.

Na primeira execução, o Docker precisa baixar a imagem base, portanto é necessária conexão com a internet.

## O que esta configuração faz

- Usa uma imagem base Ubuntu para desenvolvimento.
- Instala o ambiente de ferramentas comuns e Git.
- Define configurações básicas do VS Code e extensões úteis para Markdown.
- Executa uma verificação simples de sistema, arquitetura e Git.
- Mantém o ambiente isolado do sistema operacional hospedeiro.

## O que ainda não faz

- Não compila um sistema operacional.
- Não cria uma imagem inicializável do ZupiOS.
- Não instala nem modifica firmware da TV.
- Não fornece drivers, SDK ou runtime próprios.
- Não valida boot alternativo na Samsung.

## Próxima etapa

Depois de abrir o contêiner com sucesso, registrar o sistema operacional hospedeiro e a arquitetura do computador. Em seguida, selecionar a primeira prova de conceito técnica sem assumir prematuramente uma linguagem ou sistema-base.

## Segurança e reprodutibilidade

Não montar diretórios sensíveis do hospedeiro no contêiner nem passar credenciais por arquivos versionados. Não executar comandos de gravação de firmware ou armazenamento da TV a partir deste ambiente. A configuração inicial usa uma imagem base de desenvolvimento e não precisa de acesso privilegiado ao Docker daemon.
