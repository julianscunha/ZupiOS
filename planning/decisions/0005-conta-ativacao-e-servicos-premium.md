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
- **Token e contra-token:** o fluxo proposto usa um token apresentado pela instalação e um contra-token emitido pelo site. Formato, segurança, validade, renovação, revogação e recuperação ainda precisam ser especificados.
- **Serviços Premium pretendidos:** atualização automática; sincronização de perfil e preferências; marketplace oficial; agendamento remoto de desligamento; controles parentais remotos; visualização e gestão das instalações vinculadas/ativas na conta; e acesso a repositórios de bootloaders ou arquivos de recuperação quando houver disponibilidade, compatibilidade e autorização para distribuição.
- **Aplicativos:** instalar aplicativos por outros meios suportados, como pendrive, não deve exigir Premium, mesmo que o marketplace oficial seja um benefício Premium.
- **Finalidade da contribuição:** apoiar a operação e manutenção dos serviços online. A redação pública e o modelo jurídico/financeiro devem ser revisados antes do lançamento.
- **Limites:** serviços dependentes de conectividade, servidores, compatibilidade ou direitos de distribuição são condicionais; não se deve prometer disponibilidade universal.

## Implicações

- A arquitetura deve separar recursos locais básicos dos serviços online Premium.
- Autenticação da conta e ativação Premium são estados distintos.
- O Premium é verificado por instalação, não apenas por conta.
- Ausência, expiração ou invalidação do token retira os benefícios Premium sem bloquear o uso básico.
- A prevenção contra cópia indevida de tokens entre instalações, o tratamento de reinstalações e o comportamento de transferência permanecem decisões técnicas pendentes.
- Ações remotas que afetem a TV exigem autenticação, autorização e proteções contra uso indevido.
- O escopo dos benefícios e a política de continuidade caso os serviços online sejam encerrados deverão ser documentados antes do lançamento.

## Critérios de aceite

- O sistema básico funciona sem conta e sem ativação Premium.
- É possível entrar em uma conta e vincular uma instalação sem ativar automaticamente os benefícios.
- Cada instalação requer ativação própria e token ativo.
- Sem token ativo, o sistema mantém o uso básico e não oferece os benefícios Premium.
- Instalar aplicativos por pendrive, quando suportado, não depende de Premium.
- O fluxo de token/contra-token é especificado com requisitos de segurança antes da implementação.

## Documentos relacionados

- [[planning/decisions/0002-politica-de-licenciamento]]
- [[planning/decisions/0004-adaptacao-hardware-e-implantacao]]
- [[planning/Next-Steps]]
