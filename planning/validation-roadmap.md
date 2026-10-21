---
title: Plano de validação técnica do ZupiOS
type: technical-plan
status: proposed
tags:
  - zupios
  - validacao
  - hardware
  - boot
---

# Plano de validação técnica do ZupiOS

## Objetivo

Separar a validação do sistema da investigação de hardware da Samsung UN40J6400AGXZD. A TV permanece como alvo experimental de compatibilidade; não é o único ambiente de desenvolvimento.

## Princípio de trabalho

Não escolher sistema-base, linguagem, runtime ou bootloader antes de definir requisitos e avaliar evidências. Toda prova deve declarar exatamente o que demonstrou e o que permanece desconhecido.

## Etapa 1 — Ambiente controlável

O ambiente de prototipagem atual é um contêiner Ubuntu x86_64 com QEMU. A máquina convidada usada na prova é configurada como `pc` (BIOS legado), CPU `qemu64` e 128 MiB de RAM. Esses são parâmetros do emulador, não características detectadas na TV nem requisitos finais do ZupiOS.

Critérios do ambiente:
- inicialização reproduzível e automatizável;
- logs de console acessíveis;
- artefatos temporários e restauração simples;
- testes repetíveis sem risco ao dispositivo físico.

## Etapa 2 — Prova mínima de inicialização

A prova em `tests/boot-poc/` monta uma imagem raw de 1.536 bytes com três setores. O setor inicial de 512 bytes contém a assinatura BIOS `55 aa`, lê o segundo setor via `int 13h` e transfere a execução para `0000:8000`. O segundo estágio carrega o terceiro setor em `0000:9000`, trata erro de leitura e transfere o controle ao payload. O payload independente emite um marcador no console de depuração e para a CPU.

### Contrato experimental do payload

- **Endereço de carga:** segmento:offset `0000:9000` (endereço físico `0x9000` em modo real).
- **Ponto de entrada:** `0000:9000`; o carregador faz salto distante para esse endereço.
- **Limite de tamanho:** exatamente um setor reservado, com máximo de 512 bytes. O teste de construção rejeita payload maior que esse limite.
- **Estado mínimo:** modo real BIOS de 16 bits; o payload não depende de stack, heap, interrupções ou serviços de sistema. O carregador inicializa `DS` e `ES` a zero e preserva o identificador de unidade BIOS em `DL` durante a leitura; o payload deve inicializar os segmentos de que precisar.
- **Falha de carga:** a leitura BIOS do setor 3 verifica o carry flag e emite `ZupiOS: falha ao carregar payload` antes de parar a CPU.
- **Evidência de sucesso:** o payload escreve `ZupiOS: payload minimo carregado e executado` no console de depuração do QEMU.

O carregador atual lê um setor fixo; não lê metadados, não suporta payloads maiores ou de tamanho variável e não define um formato executável. O endereço e o estado acima são apenas o contrato desta prova, não a arquitetura final de kernel.

Critérios cobertos pelo script:
- tamanho e assinatura do setor de boot;
- limite de 512 bytes para segundo estágio e payload;
- tamanho total da imagem e layout de três setores;
- transferência de controle ao payload, observada por marcador;
- caso positivo: marcador de execução do payload e timeout esperado após a parada da CPU;
- caso negativo com imagem truncada: marcador de falha de leitura e ausência do marcador do payload;
- execução repetida pelo verificador de repetibilidade.

### Resultado de validação local

**Resultado: aprovado — 5 de 5 execuções consecutivas.** A execução ocorreu no contêiner de desenvolvimento Ubuntu x86_64 do repositório, com GNU Binutils e QEMU 10.2.1. O verificador `bash tests/boot-poc/repeat.sh 5` terminou com código de saída 0; cada uma das cinco execuções aprovou os cenários positivo e negativo. Também foi executado `bash scripts/dev-check.sh`, concluído com código 0.

Evidências observadas em cada execução:
- imagem raw: 1.536 bytes; setor de boot: 512 bytes; assinatura: `55aa`;
- segundo estágio: 510 bytes; payload: 67 bytes de um máximo de 512;
- caso positivo: marcador `ZupiOS: payload minimo carregado e executado` e transferência de controle para `0000:9000`;
- caso negativo: marcador `ZupiOS: falha ao carregar payload` e ausência do marcador de execução do payload;
- máquina emulada: `pc`, BIOS legado, CPU `qemu64`, RAM 128 MiB; QEMU 10.2.1.

Esta evidência é de execução local equivalente, não um resultado do GitHub Actions. A ausência de um resultado hospedado não invalida o critério local alternativo, mas o estado do workflow remoto não deve ser presumido.

Esta prova não implementa kernel, drivers, sistema-base ou runtime, e não comprova compatibilidade com a Samsung. O teste só demonstra leitura e transferência de controle para um payload de um setor em BIOS legado no QEMU configurado; não valida hardware físico, boot alternativo, desempenho, drivers ou arquitetura final.

## Etapa 3 — Perfil da TV de referência

O perfil abaixo separa dados da etiqueta, informações publicadas pelo fabricante e aspectos internos ainda não verificados.

### Dados registrados

- **Modelo informado e identificado na etiqueta:** Samsung UN40J6400AGXZD.
- **Código de modelo da página de suporte:** UN40J6400AG; a página oficial identifica a família como Smart TV J6400 Series 6 de 40 polegadas Full HD.
- **Revisão física informada pela etiqueta:** Version No. TH02. Este identificador não deve ser interpretado como revisão de placa principal sem documentação específica.
- **Firmware instalado:** versão 1550.0, informado pelo usuário. A página de suporte da Samsung lista um pacote de atualização USB `T-HKMFUABC`, versão 1550.0, com data de 21/01/2021; a disponibilidade do pacote não prova, por si só, qual versão está instalada atualmente.
- **Manual oficial:** [Manual do usuário J6400-ZD, versão 02, em português](https://org.downloadcenter.samsung.com/downloadfile/ContentsFile.aspx?CDSite=UNI_BR&OriginYN=N&ModelType=N&ModelName=UN40J6400AG&CttFileID=6863041&CDCttType=EM&VPath=EM%2F201707%2F20170710124839509%2FJ6400-ZD_BN68-07048P-02-POR.pdf).
- **Página oficial de suporte e downloads:** [Samsung Brasil — UN40J6400AGXZD](https://www.samsung.com/br/support/model/UN40J6400AGXZD/).

### Dados ainda desconhecidos

- fabricante, modelo e revisão exatos da placa principal instalada;
- SoC, arquitetura de CPU, RAM e armazenamento interno confirmados para esta unidade;
- cadeia de boot efetiva e existência de mecanismos de verificação/assinatura;
- interfaces de depuração acessíveis e permissões necessárias;
- possibilidade de boot alternativo e método de recuperação validado.

As especificações comerciais e os documentos de suporte não confirmam esses detalhes internos. Não transferir informações de placas de variantes ou tamanhos diferentes para este aparelho sem uma fonte que corresponda à revisão física instalada.

## Etapa 4 — Portão de decisão para a TV

A investigação de execução nativa só avança quando houver:
- identificação confiável da placa e revisão instaladas;
- documentação específica para essa variante ou inspeção técnica qualificada;
- caminho de teste de baixo risco e método de recuperação comprovado;
- evidência de que o firmware permite o mecanismo de inicialização proposto.

Se esses requisitos não forem atendidos, manter a TV como alvo de estudo e compatibilidade externa. Não escrever firmware, alterar eMMC/SPI, executar procedimentos de serviço ou conectar adaptadores a pontos de teste com base em documentação de outra variante.

## Ferramenta auxiliar de investigação: REA

O [REA (Reverse Engineer Anything)](https://github.com/morluto/rea) foi identificado como ferramenta opcional de apoio, não como fonte de identificação da placa e nem como catálogo de esquemas elétricos. O projeto oferece análise local de firmware por meio de Binwalk e Unblob, desde que as ferramentas externas necessárias estejam instaladas e configuradas. A documentação do REA informa que a análise de firmware pode inspecionar regiões e extrair arquivos, sem exigir execução do firmware extraído; os resultados incluem evidências e limitações explícitas. Essa capacidade só é útil para o ZupiOS se um arquivo de firmware pertinente ao modelo e à variante for obtido de fonte confiável. Fonte: [README do REA](https://github.com/morluto/rea) e [guia de análise de firmware](https://github.com/morluto/rea/blob/main/docs/firmware-analysis.md).

### Resultado da pesquisa online (2026-10-21)

- A página oficial de suporte da [Samsung para UN40J6400AGXZD](https://www.samsung.com/br/support/model/UN40J6400AGXZD/) confirma a família/modelo comercial J6400, mas não publica ali um esquema de placa nem a identificação do SoC.
- Duas referências independentes de fornecedores de peças associam a placa principal **BN41-02353B** e os códigos de conjunto **BN94-08978U/BN94-08978V** aos modelos UN40J6400AGXZD, UN48J6400AGXZD e UN55J6400AGXZD: [Loja do Técnico](https://www.lojadotecnico.com/todos-produtos/placa-principal-bn41-02353b-) e [Comclick](https://www.comclick.com.br/placa-principal-bn41-02353b/bn94-08978u-tv-samsung-un40j6400ag-un48j6400ag-un55j6400ag). Um fórum técnico também lista BN41-02353B para UN40J6400AG e família de chassi UWK50: [Mundo Técnico](https://mundotecnico.info/viewtopic.php?t=5447).
- **Confiança atual:** indício moderado de que BN41-02353B é uma placa usada nesta família de modelos; não é confirmação da placa efetivamente instalada nesta unidade, nem prova de revisão exata ou SoC. Anúncios de peças e fóruns são fontes secundárias e podem agrupar variantes.
- A Samsung disponibiliza o pacote oficial T-HKMFUABC.zip, versão 1550.0, no centro de download da região argentina para o modelo base UN40J6400AG: [download oficial](https://downloadcenter.samsung.com/content/FM/202101/20210121172936194/T-HKMFUABC.zip). Uma requisição HTTP HEAD à URL oficial retornou status 200 e tamanho **1.218.546.461 bytes** (aprox. 1,13 GiB). O arquivo não foi baixado.
- O tamanho do pacote excede o limite documentado do REA para entradas de firmware (128 MiB). Portanto, não se deve enviar o ZIP completo ao REA na configuração documentada. Primeiro é necessário determinar se o pacote contém um arquivo interno menor e compatível com o limite, usando inspeção de metadados/listagem sem extrair o pacote inteiro. Não foi confirmado que o pacote seja analisável pelo REA nem que contenha dados suficientes para identificar o SoC.
- No ambiente de desenvolvimento consultado, os executáveis rea, binwalk e unblob não foram encontrados no PATH; nenhuma análise de firmware foi executada.

### Uso previsto no ZupiOS

1. Pesquisar primeiro fontes online confiáveis para o código exato do modelo, etiquetas, códigos da placa, manuais de serviço e imagens de firmware. Registrar URL, emissor, variante declarada, versão e hash do arquivo quando obtido.
2. Se houver um firmware adequado, preservar o original e calcular seu SHA-256 antes de analisar uma cópia. Usar o REA/Binwalk para inspecionar regiões e, se necessário, Unblob para extrair arquivos para um diretório novo. Não executar conteúdo extraído.
3. Comparar quaisquer códigos de placa ou referências encontradas com documentação independente e específica da variante. Referências de modelos parecidos ou nomes de partição, isoladamente, não confirmam a placa instalada.
4. Se não houver firmware confiável, usar pesquisa documental e, caso seja necessário e seguro, inspeção física qualificada da placa. A ausência de um arquivo adequado não impede a investigação e não autoriza inferências.

### Limites e segurança

- REA não identifica automaticamente a placa física dentro da TV e não substitui a leitura da etiqueta/serigrafia ou a inspeção da unidade.
- Uma imagem de firmware pode pertencer a outra variante ou revisão. A origem e a correspondência com o modelo precisam ser avaliadas antes de interpretar os resultados.
- Não baixar firmware de fonte duvidosa para uso na TV, não gravar imagens de teste, nem alterar eMMC/SPI/NVRAM. A análise deve ser offline e não destrutiva.
- A cadeia de boot, arquitetura do SoC, memória e caminho de recuperação só podem ser considerados confirmados por evidência específica e verificável; strings, assinaturas e regiões detectadas por Binwalk são indícios, não prova de comportamento.

## Etapa 5 — Análise documental de viabilidade nativa (ZUPI-003)

**Data da avaliação:** 2026-10-21  
**Resultado:** inconclusivo com as evidências disponíveis. Não foi demonstrado um caminho suportado, reproduzível e recuperável para executar o ZupiOS nativamente nesta TV.

### Evidências consideradas

- A identificação disponível corresponde à Samsung UN40J6400AGXZD, família J6400, com firmware 1550.0 informado pelo usuário e etiqueta Version No. TH02.
- O suporte público da Samsung fornece manual e pacote de atualização do firmware, mas esses materiais, por si sós, não documentam um mecanismo suportado para iniciar um sistema operacional alternativo.
- A referência de plataforma de software e a possível placa BN41-02353B são pistas secundárias da família/modelo; não confirmam a placa, o SoC, a arquitetura, a memória nem a cadeia de boot desta unidade.
- Não há evidência verificada de boot por USB/rede de código arbitrário, desbloqueio de bootloader, acesso de depuração autorizado ou método de restauração testado.
- A prova BIOS legado no QEMU não é transferível para a TV: arquitetura, firmware, carregador e periféricos físicos da unidade não foram confirmados.

### Avaliação de caminhos

| Caminho | Estado | Motivo |
| --- | --- | --- |
| Substituição nativa do firmware/OS | Não demonstrada; risco alto | Sem cadeia de boot confirmada, imagem compatível e recuperação validada. |
| Boot alternativo por USB ou rede | Desconhecido | Não há evidência específica de que firmware e hardware aceitem esse caminho. |
| Execução de software dentro do sistema original | Não avaliada de forma conclusiva | Requer identificar APIs, ambiente de aplicações e restrições de assinatura da plataforma instalada. |
| Desenvolvimento e testes em QEMU | Viável para a prova já existente | Valida somente o carregador BIOS legado e payload mínimo no perfil emulado documentado. |

### Decisão operacional

1. Não gravar firmware nem alterar eMMC/SPI/NVRAM; não executar procedimentos de serviço nem conectar interfaces a pontos de teste com base apenas em fontes de variantes semelhantes.
2. Antes de considerar ensaio físico, identificar por fonte específica ou inspeção qualificada a placa principal e o SoC desta unidade, confirmar a arquitetura e estudar a cadeia de boot.
3. Exigir método de recuperação compatível com esta revisão e evidência de que funciona antes de qualquer operação que possa impedir a inicialização original.
4. Enquanto essas condições não forem atendidas, manter a TV como alvo de investigação e não como plataforma confirmada para execução nativa. Continuar desenvolvimento independente em QEMU e ambiente host sem tratar isso como prova de compatibilidade física.

### O que falta para alterar o resultado

- identificação verificável da placa principal e revisão instalada;
- SoC/arquitetura, RAM e armazenamento confirmados para esta unidade;
- documentação específica da cadeia de boot e das verificações de assinatura;
- mecanismo de boot alternativo suportado ou comprovado sem risco indevido;
- recuperação original testada para a mesma variante.

Esta análise conclui a triagem documental, não a validação prática da execução nativa. O estado “inconclusivo” é deliberado: ausência de evidência não prova impossibilidade, mas também não justifica assumir viabilidade.

## Critério de conclusão desta fase

A prova mínima de payload em ambiente controlável foi demonstrada e repetida com sucesso. A identificação documental básica do aparelho e as fontes oficiais disponíveis estão registradas; a triagem documental de execução nativa foi concluída com resultado inconclusivo. Os detalhes internos não confirmados permanecem explicitamente desconhecidos. Nenhuma conclusão equivale a compatibilidade com a TV nem aprova a arquitetura final.

## Relação com outras notas

- [[planning/Next-Steps]]
- [[planning/decisions/0004-adaptacao-hardware-e-implantacao]]
- [[tests/boot-poc/README]]
