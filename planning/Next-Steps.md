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
- [[planning/decisions/0004-adaptacao-hardware-e-implantacao|Decisão 0004 — Adaptação ao hardware e à implantação]]: implantação flexível, detecção de capacidades, alternativas de boot, instalação remota iniciada pelo site oficial quando o dispositivo permitir, tentativa de recuperação local/externa/rede e opção permanente “Restaurar sistema original” nas configurações do ZupiOS. Recuperação depende do dispositivo e não é garantida.

## Pendências conhecidas

- Identificar o modelo exato da TV de referência.
- Definir requisitos de compatibilidade a partir do hardware real.
- Avaliar viabilidade de execução nativa e, depois, estabelecer a arquitetura sem presumir sistema-base, runtime, linguagem ou bootloader.
- Definir a licença jurídica final e revisar as implicações de distribuição de imagens de sistemas originais.
- Detalhar privacidade, consentimento, minimização e retenção para telemetria futura.

## Próxima decisão em andamento

**Definir a política de detecção e seleção de drivers durante a instalação.**

Proposta a confirmar: detectar automaticamente o hardware e suas capacidades, selecionar drivers específicos somente quando houver compatibilidade verificada, usar drivers genéricos compatíveis como fallback e oferecer escolha manual quando a detecção falhar, houver alternativas relevantes ou o usuário quiser intervir. Não assumir que marca/modelo, por si só, garantem compatibilidade.

Depois dessa decisão, identificar a marca e o modelo exatos da TV de referência para validar as opções com hardware real.

## Instruções para continuidade

1. Leia este documento e a decisão relacionada antes de retomar.
2. Trabalhe uma decisão por vez e confirme premissas com o usuário antes de desenvolver planos extensos.
3. Quando uma decisão for aprovada, atualize o documento arquitetural/ADR correspondente e este arquivo.
4. Atualize índices e links Obsidian quando criar documentos.
5. Não declare implementação concluída quando houver apenas uma decisão ou requisito documentado.
6. Ao salvar alterações, faça commit no Git e informe o link do commit e dos arquivos alterados.
