---
title: Requisitos de desempenho e leveza do ZupiOS
type: product-specification
status: draft
tags:
  - zupios
  - desempenho
  - requisitos
---

# Requisitos de desempenho e leveza do ZupiOS

## Estado e finalidade

Este documento estabelece a direção de produto e o método para definir metas de desempenho. É a fonte de verdade para leveza, responsividade e eficiência de recursos. Os números-alvo permanecem pendentes até existir um ambiente de referência reproduzível e perfis de hardware caracterizados. O ZupiOS ainda não possui resultados de desempenho medidos em uma implementação funcional.

## Objetivo de produto

O ZupiOS deve ser uma alternativa especialmente leve para Smart TVs compatíveis cujo sistema atual apresente lentidão. A vantagem precisa ser perceptível em tarefas comuns, mensurável em testes e sustentável durante uso prolongado. Não basta reduzir o tamanho da imagem de instalação: o sistema em execução deve usar recursos com parcimônia e manter a interface responsiva.

Leveza é requisito central de arquitetura e produto, junto com compatibilidade, segurança e confiabilidade. Não deve ser tratada apenas como uma rodada de otimização posterior.

## Dimensões obrigatórias

- **Memória:** baixo consumo de RAM em repouso e durante navegação; limitar caches e recursos gráficos; recuperar recursos quando aplicações encerram; detectar vazamentos e crescimento contínuo.
- **CPU e atividade em segundo plano:** evitar polling frequente, tarefas residentes sem benefício direto, atualizações inesperadas durante interação e trabalho duplicado entre serviços.
- **Armazenamento:** reduzir tamanho do sistema-base, dependências, dados temporários e escritas desnecessárias; separar componentes essenciais dos opcionais.
- **Responsividade:** priorizar entrada do controle remoto e feedback visual; impedir que inicialização de aplicação, rede ou tarefas de manutenção bloqueiem a interface principal.
- **Inicialização e recuperação:** medir separadamente o tempo até a primeira imagem, a interface navegável e a disponibilidade das funções principais; evitar serviços no caminho crítico sem justificativa.
- **Gráficos:** preferir composição simples, dimensões de recursos adequadas à tela, animações curtas e dispensáveis e efeitos que possam ser desativados em perfis limitados. Evitar renderização quando o conteúdo não muda.
- **Mídia:** usar decodificação por hardware somente quando a capacidade for detectada e validada; evitar conversões e cópias desnecessárias; não prometer suporte a codecs sem evidência.
- **Estabilidade sustentada:** testar sessões prolongadas, alternância de aplicações, pressão de memória e falhas; a performance não pode degradar progressivamente.

## Regras de arquitetura a avaliar

1. Manter o núcleo mínimo; instalar ou ativar componentes opcionais apenas quando suportados e necessários.
2. Definir fronteiras e ciclo de vida claros para serviços, aplicações, caches e recursos gráficos.
3. Tornar observáveis o consumo por componente, o tempo de resposta e as falhas sem exigir telemetria remota. Qualquer coleta externa futura deve ser opcional, minimizada e documentada.
4. Evitar dependências pesadas sem benefício mensurável; comparar alternativas por custo em execução, tamanho, manutenção e compatibilidade.
5. Preservar uma interface de TV legível e utilizável por controle remoto sem exigir fundos animados, transparências, blur ou transições complexas.
6. Permitir perfis de recursos que adaptem resolução de assets, animações, caches e funcionalidades às capacidades verificadas, sem fragmentar desnecessariamente o comportamento público do sistema.
7. Não sacrificar segurança, isolamento, recuperação ou integridade para obter números menores. Toda redução deve ser avaliada contra esses requisitos.

Essas regras orientam a análise; não selecionam kernel, sistema-base, runtime, linguagem ou tecnologia gráfica.

## Protocolo de medição

Comparações devem registrar modelo e revisão do hardware quando conhecidos, firmware, versão do sistema, método de instalação, resolução, estado da rede, aplicações e serviços ativos e condições iniciais do ensaio. Usar o mesmo roteiro de ações em todas as execuções. Para uma primeira linha de base, coletar pelo menos 10 amostras por cenário para tempos de inicialização e pelo menos 30 amostras de resposta a entradas para estimar mediana e percentis; se o ambiente não permitir amostragem automática ou sincronizada, documentar essa limitação e não apresentar precisão inexistente. Publicar mediana, dispersão e valores extremos relevantes; distinguir inicializações frias e aquecidas e resultados com e sem rede. Para estabilidade sustentada, definir e registrar a duração do ensaio e o perfil de carga antes de executá-lo.

Medir pelo menos:

- tempo até primeira imagem, tela inicial navegável e disponibilidade das funções principais;
- latência do controle remoto até feedback visual, incluindo percentis altos quando houver instrumentação suficiente;
- RAM em repouso, após navegação, com aplicação aberta e após seu encerramento;
- CPU em repouso e durante tarefas representativas;
- espaço ocupado pela instalação e crescimento de dados temporários;
- fluidez de navegação e taxa de quadros quando mensurável;
- estabilidade de sessão prolongada, falhas, reinícios e crescimento de memória;
- reprodução de mídia por perfil, distinguindo decodificação por hardware/software e limitações do dispositivo.

Comparar com o sistema original somente quando for possível realizar tarefas equivalentes no mesmo aparelho e controlar as condições. Se isso não for possível, identificar a comparação como não equivalente. Não extrapolar resultados de QEMU para TVs físicas.

## Aplicação inicial do protocolo no ambiente disponível

O primeiro ambiente executável disponível é a prova mínima de boot em QEMU descrita em [[planning/validation-roadmap|plano de validação técnica]] e [[tests/boot-poc/README|prova de boot em QEMU]]. Ela pode ser usada para verificar a repetibilidade do procedimento e, com `tests/boot-poc/capture_marker.py`, medir o tempo do próprio teste até o marcador de payload. **Não** representa o tempo de boot do ZupiOS, tempo até uma interface navegável, latência de controle remoto ou consumo de um sistema operacional em execução: ainda não existe kernel nem interface funcional no ambiente convidado.

Para registrar uma primeira medição de ferramenta/ensaio sem confundi-la com desempenho do produto:

1. Registrar commit, sistema host/contêiner, versões de QEMU e GNU Binutils, configuração da máquina convidada, comando exato e estado da carga do host.
2. Fazer uma execução de aquecimento separada e pelo menos 10 execuções cronometradas, mantendo configuração e comando constantes. Se qualquer execução falhar, preservar a falha e os logs; não descartá-la como outlier sem causa identificada.
3. Usar `tests/boot-poc/capture_marker.py`, que mede com relógio monotônico do host o intervalo entre o início do processo QEMU e a detecção do marcador. Registrar o valor `MARKER_ELAPSED_SECONDS`, código de saída e eventuais timeouts; reportar o cenário negativo em separado. O capturador encerra o QEMU ao detectar o marcador, evitando usar o limite de cinco segundos como duração do ensaio.
4. Guardar valores brutos por execução e resumir mediana, mínimo, máximo e dispersão. Informar que a medida inclui overhead de host/emulador e depende do mecanismo de captura do marcador.
5. Não atribuir RAM/CPU medidas no host ao consumo do sistema convidado. Consumo do guest só pode ser reportado quando houver uma medição específica, com ferramenta, unidade e fronteira de medição documentadas.

Essas medições caracterizam apenas o ensaio e sua infraestrutura. A linha de base de desempenho do produto e a definição de metas numéricas continuam bloqueadas até existir um sistema executável com funções observáveis e um perfil de referência declarado.

## Definição de metas numéricas

As metas de tempo, RAM, CPU, armazenamento e fluidez serão estabelecidas após:

1. selecionar um ambiente de referência executável e instrumentável;
2. caracterizar ao menos um perfil de hardware com evidências suficientes;
3. registrar uma linha de base do ambiente e das tarefas;
4. verificar a viabilidade técnica das metas e o impacto em segurança e compatibilidade.

Cada meta aprovada deverá indicar métrica, unidade, cenário, condições, método, número de repetições e critério de aprovação. Até lá, números específicos seriam arbitrários e não devem ser apresentados como compromisso do produto.

## Critérios de aceite futuros

- Existe uma linha de base reproduzível por perfil suportado e um relatório versionado.
- Cada meta numérica possui método de medição e critério de aprovação explícitos.
- Testes cobrem repouso, navegação, abertura/encerramento de aplicações, mídia suportada e sessão prolongada.
- O sistema demonstra que tarefas em segundo plano não prejudicam indevidamente a interação principal.
- Regressões de desempenho são detectáveis em testes automatizados ou procedimentos repetíveis.
- Alegações públicas de superioridade são sustentadas por resultados equivalentes, não por estimativas ou resultados exclusivos de emulador.

## Relação com outros documentos

- [[planning/compatibility-requirements|Requisitos de compatibilidade]]: prioridades funcionais e requisitos não funcionais gerais.
- [[docs/product/Visao-geral|Visão geral do produto]]: posicionamento e princípios de produto.
- [[docs/architecture/README|Estado da arquitetura]]: decisões técnicas ainda pendentes.
- [[planning/Backlog|Backlog]] e [[planning/Roadmap|Roadmap]]: tarefas, dependências e marcos; não duplicar aqui o planejamento.
