---
title: Backlog do ZupiOS
type: planning
status: active
tags:
  - zupios
  - backlog
---

# Backlog do ZupiOS

O backlog contém os próximos trabalhos verificáveis. Prioridades e estimativas serão adicionadas quando o escopo estiver definido.

## P0 — Decisões e descoberta

### ZUPI-001 — Identificar o hardware de referência
- **Estado:** concluído (perfil documental básico; detalhes internos do hardware permanecem desconhecidos)
- **Objetivo:** registrar modelo exato, revisão e versão de firmware do dispositivo inicial.
- **Critérios de aceite:**
  - [x] Modelo completo, identificador de revisão da etiqueta e versão de firmware registrados; firmware informado pelo usuário e identificação física distinguidos dos dados inferidos.
  - [x] Especificações publicamente documentadas ligadas a fontes verificáveis.
  - [x] Dados internos desconhecidos marcados como pendentes, sem suposições apresentadas como fatos.
- **Evidência:** a etiqueta foi registrada como UN40J6400AGXZD, Version No. TH02; firmware 1550.0 informado pelo usuário. A página oficial da [Samsung Brasil](https://www.samsung.com/br/support/model/UN40J6400AGXZD/) identifica o produto como UN40J6400AG, Smart TV J6400 Series 6 de 40 polegadas Full HD, e lista o pacote USB T-HKMFUABC versão 1550.0. A documentação e os limites do que se pode concluir estão em [[planning/validation-roadmap|plano de validação técnica]]. TH02 não é tratado como revisão confirmada da placa principal.
- **Limite:** a conclusão cobre identificação e documentação básica, não identifica SoC, RAM, armazenamento, placa principal, cadeia de boot nem viabilidade de execução nativa.

### ZUPI-002 — Definir requisitos de compatibilidade
- **Estado:** pendente
- **Objetivo:** decidir quais aplicações, recursos e comportamentos devem ser padronizados primeiro.
- **Dependência:** ZUPI-001.
- **Critérios de aceite:**
  - Casos de uso prioritários documentados.
  - Requisitos classificados por prioridade.
  - Itens fora do escopo inicial explicitamente identificados.

### ZUPI-003 — Validar viabilidade de execução nativa
- **Estado:** pendente
- **Objetivo:** determinar o caminho suportado e tecnicamente verificável para executar o ZupiOS no dispositivo de referência.
- **Dependência:** ZUPI-001.
- **Critérios de aceite:**
  - Evidências, restrições e riscos registrados.
  - Nenhuma alteração potencialmente destrutiva de firmware sem plano de recuperação validado.
  - Resultado registrado como viável, inviável com as evidências disponíveis ou inconclusivo.

### ZUPI-004 — Aprovar a arquitetura inicial
- **Estado:** bloqueado
- **Objetivo:** escolher a base do sistema, o runtime e as fronteiras entre SDK, serviços e hardware.
- **Dependência:** ZUPI-002 e ZUPI-003.
- **Critérios de aceite:**
  - Decisão arquitetural registrada com alternativas e justificativas.
  - Interfaces entre componentes identificadas.
  - Premissas ainda não validadas listadas.

## P1 — Prova técnica em ambiente controlável

### ZUPI-005 — Definir contrato de carregamento de payload mínimo
- **Estado:** concluído
- **Objetivo:** especificar e demonstrar em QEMU como o segundo estágio recebe e transfere controle a um payload mínimo, sem assumir ainda uma arquitetura final de kernel.
- **Dependência:** prova de boot BIOS legado em QEMU existente.
- **Critérios de aceite:**
  - [x] Contrato documentado para endereço de carga, limites de tamanho, ponto de entrada e estado mínimo da CPU/memória.
  - [x] O carregador valida ou limita o tamanho do payload e trata explicitamente falhas de leitura/carga.
  - [x] Uma prova reproduzível demonstra a transferência de controle ao payload e registra um marcador observável.
  - [x] O teste declara claramente o que não valida sobre hardware físico, drivers ou arquitetura final.
  - [x] Cinco execuções consecutivas aprovadas em ambiente equivalente com GNU Binutils e QEMU, incluindo caso positivo e falha de leitura induzida.
- **Evidência:** `bash tests/boot-poc/repeat.sh 5` terminou com código 0 em contêiner Ubuntu x86_64 com QEMU 10.2.1; 5/5 execuções aprovaram os casos positivo e negativo. `bash scripts/dev-check.sh` também terminou com código 0. O resultado é validação local; não afirma aprovação do workflow hospedado nem compatibilidade com a TV.
- **Fonte de procedimento e evidências:** [[planning/validation-roadmap|plano de validação técnica]] e [[tests/boot-poc/README|prova de boot em QEMU]].

## Fora do backlog de implementação por enquanto

Não iniciar launcher, marketplace ou serviços remotos antes de definir o caminho de execução no hardware e os requisitos prioritários.
