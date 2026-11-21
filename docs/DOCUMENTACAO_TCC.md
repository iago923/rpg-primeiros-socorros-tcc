# RPG Primeiros Socorros — documentação da ampliação

## Estado desta entrega

**Versão executável em validação, ainda não homologada como entrega final.** A referência
aprovada permanece na Área de Trabalho. A cópia de desenvolvimento está em
`projeto_ampliado`. A campanha foi concluída por teste automatizado dentro do GameMaker;
a campanha manual completa ainda está pendente.

Em 20/09/2026, `Windows PackageZip` retornou erro de autorização 0000002A.
Depois, `Windows Run` compilou e executou normalmente. Não é correto tratar aquele
erro de exportação como bloqueio de todos os testes. Consulte `RELATORIO_TESTES.md`.

## Objetivo e requisitos

A ampliação mantém a escola e a campanha existente, acrescentando organização de
materiais, decisões educativas, leitura sem pressão temporal e persistência local.
São requisitos não funcionais: ausência de dados pessoais, funcionamento local,
preservação de geometria, controle de entrada modal, operações atômicas e relato
honesto de validação. A matriz de acompanhamento está em `README.md`.

## Arquitetura implementada

| Recurso | Responsabilidade |
|---|---|
| `obj_game/Create_0` | Estado persistente, listas, fontes e pedido inicial de configurações |
| `obj_game/Step_1` | Entrada da interface, timeout e autosave em estado seguro |
| `obj_game/Other_62` | Resposta HTTP, confirmação de escrita e restauração |
| `obj_game/Draw_64` | Menu, HUD e painéis unificados |
| `obj_game/CleanUp_0` | Liberação de listas e fontes pelo proprietário |
| `scr_tcc_model` | Catálogo, transações em memória, progresso, snapshots e HTTP |
| `scr_tcc_ensino` | Cinco assuntos, páginas, escolhas, feedback e desfechos |
| `scr_tcc_ui` | Interface, foco, comandos e conversão do mouse para GUI |
| `scr_tcc_camera` | Limites visuais, câmera e ocultação opaca |
| `obj_room_manager` | Portas existentes; câmera; dois personagens de apoio novos |
| `obj_profesora` | Progressão narrativa já existente, com marcos únicos |
| `obj_treinamento` | Liga as cinco estações às atividades educativas |
| Quatro `obj_aluno_*` | Iniciam as decisões por ocorrência, sem os antigos testes de reflexo |
| `obj_kit` | Ponto de organização/reposição na enfermaria |
| `obj_livro` | Leitura contextual na sala, sem retirar o livro |
| `obj_npc_ajudante` | Diálogo, rotina curta validada pela colisão, espera pelo jogador |
| `obj_audio` | Volumes independentes para trilha e efeitos |
| `Servidor.cs` | HTTP local, validação, transações SQL, slots e recuperação |

Fluxo: entrada → painel/atividade → estado GML → snapshot estável → HTTP local →
serviço C# → transação SQLite → confirmação assíncrona. O desenho da GUI não grava
no banco. Funções de colisão e todos os arquivos de rooms e sprites foram preservados.

## Inventário com listas reais

O código utiliza `ds_list_create`, não somente um array com aparência de inventário.
`global.bolsa` tem capacidade 8 e `global.armario`, 24. Entradas contêm `item_id`,
`quantity`, `slot` e `state`. O catálogo é separado e define usos e empilhamento.

Trecho real do controlador:

```gml
global.bolsa=ds_list_create();global.armario=ds_list_create();owns_tcc=true;
```

Trecho real da operação de adição:

```gml
function tcc_adicionar(_list,_id,_n,_cap){var a=tcc_adicionar_array(tcc_lista_array(_list),_id,_n,_cap);if(is_undefined(a))return false;tcc_lista_commit(_list,a);return true;}
```

Os arrays aqui são cópias temporárias para simular uma transação. Só depois da
validação seus valores substituem os da lista principal. Uma tentativa que excede
a capacidade não altera a lista original.

Operações: quantidade, espaço, adicionar, remover, consumir conforme uso permitido,
reorganizar, transferir e abrir kit. O kit é removido na cópia temporária antes da
verificação do conteúdo. Contém 2 pares de luvas, 2 gazes e 1 cobertura. O estojo é
um recipiente, não um tratamento. Conhecimento fica em `global.aprendizagem`, fora
dos slots. Material reutilizável não é removido pela operação de consumo.

As duas listas pertencem exclusivamente a `obj_game`, que é persistente. Instâncias
duplicadas se destroem antes de criar listas. `tcc_reset` esvazia listas existentes;
`CleanUp_0` destrói apenas as criadas pelo proprietário. Structs das entradas são
gerenciadas pelo runtime. O teste de ausência de vazamento dentro da engine ainda
precisa ser executado.

## Banco e modelo de dados

SQLite real, arquivo `partidas.sqlite3`. O JSON é o formato de comunicação e snapshot,
não é apresentado como substituto de um banco. Tabelas relacionais são preenchidas
na mesma transação e podem ser consultadas para a apresentação acadêmica.

| Tabela | Chave e relação | Campos relevantes |
|---|---|---|
| partidas | PK slot, 1 a 3 | versão, capítulo, segundos, data, room, x/y, direção, snapshot, checksum |
| inventario | PK partida+recipiente+slot; FK partida | item_id, quantidade positiva, estado |
| progresso | PK partida+objetivo_id; FK partida | estado do objetivo único |
| aprendizagem | PK partida+conteudo_id; FK partida | lido e compreensão/prática registrada |
| mundo | PK partida+flag_id; FK partida | flags narrativas e estado necessário |
| configuracoes | PK id=1 | preferências globais de áudio/texto/efeitos |
| recuperacao | PK slot | snapshot anterior íntegro e checksum |

Cardinalidades: uma partida tem muitos materiais, objetivos, assuntos e flags;
cada um pertence a uma partida. Cada slot tem no máximo uma cópia recuperável.
Configurações não pertencem a uma partida.

`schema.sql` cria o esquema versão 1. Banco vazio/versão 0 é inicializado; versão
futura é recusada antes de alterar tabelas. Ainda não há migração de uma versão de
save anterior do jogo: a referência não possuía saves.

Gravação usa `BEGIN IMMEDIATE`, validação de dados, parâmetros `?`, `COMMIT` ou
`ROLLBACK`. Snapshot e tabelas nunca são confirmados parcialmente. A cópia anterior
íntegra é mantida; um registro corrompido não substitui a cópia válida. Checksum detecta
alteração/corrupção do snapshot, mas não é mecanismo de autenticação ou criptografia.

Exemplos de consultas reais sobre as tabelas:

```sql
SELECT slot, capitulo, segundos, atualizado FROM partidas ORDER BY slot;
SELECT recipiente, slot, item_id, quantidade FROM inventario
 WHERE partida = 1 ORDER BY recipiente, slot;
SELECT objetivo_id, estado FROM progresso WHERE partida = 1;
SELECT conteudo_id, estado FROM aprendizagem WHERE partida = 1;
PRAGMA integrity_check;
```

GameMaker usa `http_request` e o evento Async HTTP, não uma extensão SQLite nativa.
O serviço escuta somente `127.0.0.1:19827`, sem CORS, requer POST e um cabeçalho de
cliente. Isso evita chamadas comuns originadas de páginas web, mas não protege
contra outro programa malicioso do mesmo usuário. Não coleta dados clínicos/pessoais.

Rotas: `/settings`, `/health`, `/slots`, `/save`, `/load`, `/recover`. Há somente uma
requisição pendente por vez. O jogador só recebe “Salvo” depois de resposta positiva.
Falha preserva o estado em memória; nova tentativa automática tem intervalo de 30 s.

Salvar manual fica na pausa; autosave acontece após mudança relevante e fechamento
de diálogos. Durante uma atividade, o save é recusado. Fechar durante um atendimento
retoma o último checkpoint anterior, com o inventário anterior ao consumo. A perda
de progresso ainda não salvo não é evitada por esse modelo e deve ser comunicada.

## Instalação e dependências

- GameMaker IDE declarado no projeto: 2024.14.4.222; runtime instalado: 2024.14.4.268.
- Alvo: Windows x64 VM. Linux/macOS/web não foram implementados para o serviço.
- C# compilado com .NET Framework `csc.exe` 4.8.9221.0.
- SQLite do Windows: `winsqlite3.dll` 3.51.1 observado nesta máquina.
- Serviço usa apenas bibliotecas do Windows/.NET. Não distribui DLLs do Windows.
- SQLite upstream é domínio público; componentes Windows/.NET seguem as licenças
  do sistema. Não foi atribuída nova licença aos sprites ou ao jogo original.
- Node e Python são ferramentas de teste, não dependências do jogador.

`datafiles/servico/Servidor.exe` e `schema.sql` estão incluídos na cópia do projeto.
Para testar, execute o serviço e depois o jogo pelo IDE. O inicializador alternativo
é `expansao/iniciar.ps1`. O banco normal fica em `%LOCALAPPDATA%/RPGPrimeirosSocorros`.
Não é necessário internet para salvar. Em outro computador, leve o projeto completo
e o serviço, não apenas o `.yyp`. O empacotamento do executável do jogo ainda não foi
validado; a exportação PackageZip ainda retornou erro de autorização.

Nunito Sans acompanha os arquivos incluídos com a licença OFL. A instância Medium
é derivada da fonte variável oficial, com peso 500. O jogador não precisa instalar
fontes. FontTools foi usado somente na preparação desse recurso.

## Câmera, apresentação e colisões

O mundo não foi reposicionado. `scr_escola` permanece byte a byte igual à referência.
Os limites de `tcc_limites_visuais` são somente recortes de apresentação e precisam
de revisão visual no runtime. A câmera continua 640×360, viewport 1280×720. Eixos de
salas menores são centralizados; eixos maiores acompanham o player com limite.

Transformação no viewport: `tela_x=(mundo_x-camera_x)*2`, análoga para y. A GUI usa
1280×720 independentemente da câmera. Mouse: `device_mouse_x_to_gui` e
`device_mouse_y_to_gui`. Não são utilizadas coordenadas GUI para colisão do mundo.

Cobertura preta é desenhada depois dos mapas: fora dos limites visuais dos interiores
e sobre as áreas internas no hub. Portas, fachadas e colisões existentes não foram
apagadas. A comparação foi feita com o sprite original; ainda faltam capturas de cada
porta no jogo, letterboxing e redimensionamento. Transições mantêm o cooldown existente.

## Estratégia pedagógica e narrativa

Ana introduz a preparação. Cinco estações abrem leitura e decisões; quatro ocorrências
usam o mesmo mecanismo. Rafa oferece apoio; Bia e um funcionário utilizam recursos
existentes em posições novas conferidas pelo teste de colisão do código. Rotinas são
curtas, param diante do jogador e durante diálogo, e armazenam ID e posição.

As decisões têm feedback individual e repetição; apertar mais rápido não gera pontos.
A cobertura da queimadura só é consumida na confirmação correta. Ajuda de um NPC é
alternativa válida se não houver material. Não há “usar kit para curar”.

Assuntos lidos e compreensão revisada são estados distintos. Relê-los não concede XP
infinito. Campanha utiliza 11 IDs principais fixos; opcionais não entram no denominador.
O progresso não é rotulado como competência médica. Fontes e limites em `FONTES.md`.

## Testes executados e não executados

Executados: testes reais do serviço SQLite, fechamento/reabertura do processo, testes
de lógica extraídos do GML com adaptação sintática e verificações estruturais. Logs
em `teste_*.log`. O adaptador usa arrays JS para simular ds_list e **não demonstra**
compilação GML, gerenciamento real de handles, física, áudio ou GUI.

Também executados: build VM, comunicação HTTP no jogo, criar slot, restaurar após
reiniciar o Runner e campanha automatizada completa, usando os eventos reais de
movimento e interação. Inspeção manual de menu, introdução e treinamento.
Continuam pendentes campanha manual completa, revisão visual de todas as salas e
testes em diferentes resoluções. A ampliação não deve ser chamada de finalizada.

## Pendências reais, sem redução silenciosa de escopo

1. Validar a exportação do executável; compilação e execução VM já funcionaram.
2. Capturar todas as salas e revisar recortes/oclusão, escalas, input e fontes no jogo.
3. Jogar a campanha inteira, fazer saves em cada marco e restaurar após fechar o jogo.
4. Ampliar as rotinas dos NPCs além do trajeto curto atual; orientação visual e piscadas
   com frames próprios ainda não foram criadas. Sprites originais foram preservados.
5. Aprofundar storytelling entre ocorrências e variedade de puzzles de ordenação;
   atualmente são decisões sequenciais com alternativas, não um editor livre de sequência.
6. Enriquecer opcionais com estados intermediários e diálogos posteriores. O catálogo
   já contém as 11 missões principais e quatro opcionais, com requisitos e recompensas.
7. Refinar ícones individuais dos materiais: os recursos atuais são reaproveitados.
8. Ampliar acessibilidade: fontes maiores já têm opção; texto é instantâneo. Ainda não
   há controle de velocidade de digitação nem remapeamento; três slots são fixos no código.
9. Testar manualmente a confirmação de saída implementada, falhas de save durante
   saída, repetição de restore inválido e feedback de carregamento.
10. Revisão profissional do conteúdo, protocolos e estatística na apresentação.
11. Capturas comparativas da referência: hashes/posições registrados; baseline jogável
    não foi capturado nesta sessão. Não confundir as capturas da ampliação com baseline.

## Roteiro de apresentação e aceite (a executar)

1. Abrir o serviço e o jogo; demonstrar Novo jogo sem sobrescrita silenciosa.
2. Conferir introdução única, secretaria, oito portas e retorno ao corredor.
3. Abrir bolsa, ocupar oito slots, tentar um kit sem espaço e conferir estado intacto.
4. Na enfermaria, transferir materiais; abrir kit quando couber; consultar guia com bolsa cheia.
5. Ler manual, errar uma decisão, ler a explicação e concluir o treinamento.
6. Concluir os quatro casos, mostrar ajuda quando falta cobertura e consumo único.
7. Conversar novamente e reler livro: XP não pode repetir por desbloqueio já concluído.
8. Salvar; fechar serviço e jogo; reabrir e comparar room, posição, materiais, leitura e missão.
9. Mostrar as tabelas SQLite e os três slots sem compartilhar estado.
10. Parar o serviço e tentar salvar: a interface não pode mostrar sucesso.
11. Completar 11 objetivos principais; mostrar o dado brasileiro com fonte, não como
    estimativa de mortes evitáveis pelo jogo. Reler o encerramento e fontes.
12. Repetir em 960×540, 1280×720, tela cheia e outra proporção; verificar foco/mouse,
    exterior preto, portas e ausência de textos fora do painel.
