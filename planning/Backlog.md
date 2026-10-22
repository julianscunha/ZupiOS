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
- **Estado:** concluído — baseline v1.0 aprovada em 2026-10-21
- **Objetivo:** decidir quais aplicações, recursos e comportamentos devem ser padronizados primeiro.
- **Dependência:** ZUPI-001.
- **Critérios de aceite:**
  - [x] Casos de uso iniciais documentados e agrupados por prioridade.
  - [x] Requisitos de compatibilidade classificados por prioridade.
  - [x] Itens fora do escopo inicial identificados explicitamente.
  - [x] Proposta revisada e baseline v1.0 aprovada pelo mantenedor.
  - [x] Baseline define P0/P1/P2, prioriza mídia/streaming e depois utilitários, e prioriza aplicações próprias do SDK antes de prometer compatibilidade com terceiros.
  - [x] Questão da divisão de recursos gratuitos/Premium permanece explicitamente aberta.
- **Fonte de verdade:** [[planning/compatibility-requirements|Requisitos de compatibilidade do ZupiOS]] (baseline aprovada v1.0).

### ZUPI-003 — Validar viabilidade de execução nativa
- **Estado:** análise documental concluída — resultado inconclusivo; execução nativa não demonstrada
- **Objetivo:** determinar o caminho suportado e tecnicamente verificável para executar o ZupiOS no dispositivo de referência.
- **Dependência:** ZUPI-001.
- **Critérios de aceite:**
  - [x] Evidências, restrições e riscos documentais registrados em [[planning/validation-roadmap|plano de validação técnica]].
  - [x] Nenhuma alteração potencialmente destrutiva de firmware executada; não existe plano de recuperação validado.
  - [x] Resultado registrado como inconclusivo: não há caminho suportado de execução nativa demonstrado com as evidências disponíveis.
- **Limite:** a análise documental não substitui inspeção qualificada da placa, identificação do SoC ou ensaio de boot seguro. A execução nativa continua não autorizada tecnicamente até que o portão de decisão do plano de validação seja satisfeito.

### ZUPI-004 — Aprovar a arquitetura inicial
- **Estado:** bloqueado
- **Objetivo:** escolher a base do sistema, o runtime e as fronteiras entre SDK, serviços e hardware.
- **Dependência:** ZUPI-002 e ZUPI-003.
- **Critérios de aceite:**
  - Decisão arquitetural registrada com alternativas e justificativas.
  - Interfaces entre componentes identificadas.
  - Premissas ainda não validadas listadas.

### ZUPI-007 — Definir orçamento de desempenho e método de medição
- **Estado:** em andamento — protocolo inicial e caracterização temporal do ensaio QEMU documentados; linha de base do produto pendente
- **Objetivo:** tornar leveza, responsividade e eficiência de recursos requisitos verificáveis, sem definir metas numéricas arbitrárias antes de caracterizar um ambiente de referência.
- **Dependência:** baseline ZUPI-002; pode avançar em paralelo à definição de arquitetura e à direção visual.
- **Fonte de verdade:** [[docs/product/requisitos-de-desempenho|Requisitos de desempenho e leveza]].
- **Critérios de aceite:**
  - Métricas de inicialização, latência de entrada, RAM, CPU, armazenamento, fluidez e estabilidade sustentada definidas com métodos repetíveis.
  - Linha de base registrada para um perfil de referência executável; comparação com o sistema original somente sob condições equivalentes.
  - Metas numéricas propostas com evidências, cenários, repetições e critérios de aprovação, após caracterização do hardware.
  - Custos de processos em segundo plano, componentes opcionais e recursos gráficos considerados nas decisões arquiteturais.
  - Limites de QEMU e de perfis ainda não validados explicitamente registrados.
- **Progresso:** captura do marcador com relógio monotônico implementada; uma execução de aquecimento e 10 execuções medidas passaram em QEMU, com valores brutos, mediana, mínimo e máximo registrados em [[planning/validation-roadmap|plano de validação técnica]]. Isso caracteriza apenas o ensaio emulado; ainda não há kernel/interface nem linha de base de desempenho do produto.

### ZUPI-006 — Definir a direção visual e o modelo de interação para TV
- **Estado:** em andamento — fluxos prioritários testados no navegador; inspeção visual, conteúdo longo/localização e validação em TV/controle físico ainda pendentes
- **Fonte de verdade:** [[docs/product/direcao-visual-e-interacao|Direção visual e modelo de interação]].
- **Objetivo:** estabelecer princípios visuais e de interação próprios para televisão antes de implementar a interface principal, sem antecipar tecnologia gráfica nem amarrar o design a um único modelo.
- **Dependência:** baseline ZUPI-002; pode avançar em paralelo à investigação de hardware ZUPI-003 e à decisão de arquitetura ZUPI-004.
- **Escopo inicial:** navegação por controle remoto e foco visível; hierarquia e densidade de conteúdo a distância; identidade visual, tipografia, escala, cores e estados; comportamento responsivo a diferentes resoluções/capacidades; estados de inicialização, instalação, atualização, erro e recuperação; acessibilidade e localização; limites entre linguagem visual comum e adaptações por perfil de dispositivo. A interface também deve respeitar o orçamento de recursos e não depender de animações, efeitos ou serviços residentes caros para permanecer utilizável.
- **Critérios de aceite:**
  - [x] Protótipo exploratório autocontido cobre Home, Aplicações, Configurações, Mídia, falha de abertura e recuperação conceitual; instruções e limites estão em [[prototypes/tv-ui/README|protótipo de interface de TV]].
  - [x] Princípios de design e interação documentados em uma única fonte de verdade, sem duplicar requisitos de compatibilidade existentes.
  - [x] Fluxos prioritários representados no protótipo: Home, abrir aplicação, falha de abertura, retorno, configurações, indisponibilidade e recuperação conceitual.
  - [x] Modelo de navegação por controle remoto definido, incluindo foco, seleção, retorno e tratamento de elementos indisponíveis.
  - [x] Direção visual demonstrada por um conjunto pequeno de telas/fluxos representativos e revisável antes da implementação.
  - [x] Regras de adaptação e limites de acessibilidade documentados, separando invariantes de variações permitidas.
  - [x] Decisões que dependem de resolução, aceleração gráfica ou hardware específico identificadas como pendentes, não presumidas.
- **Progresso da revisão (2026-10-21):** a suíte `node --test tests/ui-prototype-navigation.test.cjs` passou em 13/13 testes, incluindo cobertura para todos os atalhos oferecidos. Uma sessão real do Microsoft Edge headless controlada pelo Chrome DevTools Protocol percorreu foco inicial, setas, Enter, Esc, Configurações, estado sem rede, falha de abertura/tentar novamente, alternância de perfil/avatar e navegação espacial entre o seletor de perfil do cabeçalho e os controles da Home; todos os asserts passaram. A revisão identificou e corrigiu uma lacuna: o seletor de perfil estava fora da lista de alvos da navegação por setas. A mesma revisão funcional detectou que os atalhos Música e Fotos podiam ser adicionados sem ação associada; ambos agora abrem o reprodutor demonstrativo existente. Na medição programática de viewport, 1920×1080 apresentou documento de 1920×1080 sem overflow horizontal; 1280×600 apresentou largura de documento de 1265 px, altura de conteúdo de 732 px e sem overflow horizontal, indicando rolagem vertical em viewport baixa. Os nove botões foram detectados e reportados dentro da área visível na tela inicial nos dois tamanhos. As capturas iniciais foram regeneradas em `.artifacts/tv-ui/`. Em seguida, foi feita inspeção visual de boot, seletor de perfil, Home e edição do perfil em 1920×1080 e 1280×600: a tela de boot mostra apenas a marca; o seletor usa cartões grandes; a Home mantém os destinos principais e o avatar; a edição preserva o foco visual e rolagem vertical em 1280×600 sem overflow horizontal. O PIN de perfil protegido deve ser exigido tanto no login quanto ao abrir a edição pelo avatar; o fluxo foi ajustado para exigir desbloqueio antes da edição. Um teste adicional de nome de perfil longo passou em 1920×1080 e 1280×600: o nome quebrou em várias linhas sem provocar overflow horizontal, e permaneceu dentro da largura do viewport. A revisão visual de navegador não substitui validação com controle remoto/TV físicos nem uma troca real de idioma; o protótipo permanece fixo em pt-BR. ZUPI-006 segue em andamento até revisão do mantenedor e validação em hardware representativo.

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
