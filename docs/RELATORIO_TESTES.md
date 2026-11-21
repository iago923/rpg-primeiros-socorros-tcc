# Evidências de testes — 20/09/2026

## Aprovados neste ambiente

- 14 testes de lógica: catálogo de missões/requisitos, empilhamento, dados inválidos, capacidade, rollback do kit,
  capacidade após remoção do pacote, remoção sem negativo, reutilizáveis, transferência,
  reorganização, XP único/campanha, todos os casos educativos, erro sem avanço e
  consumo idempotente/apoio. **Adaptador de sintaxe, não runtime GameMaker.**
- 8 testes no serviço C# real e SQLite em disco: saúde, 3 slots/tabelas, validação
  atômica, confirmação de sobrescrita, backup, falha de escrita com bloqueio exclusivo,
  checksum inválido/recuperação e configurações.
- Serviço encerrado e reaberto: slot 2 retornou exatamente o mesmo objeto persistido.
- 146 arquivos protegidos (rooms, sprites e script de geometria) iguais por SHA-256.
- 83 recursos do projeto existem; eventos registrados têm arquivos; delimitadores
  e referências das funções novas passaram na análise estrutural.

Logs: `teste_logica.log`, `teste_banco.log`, `teste_reinicio.log`,
`teste_estrutura.log` e `teste_gml_estrutura.log`. Repetição: `rodar_testes.ps1`.

## Compilação e execução reais

`Windows Run` compilou e executou a ampliação no runtime 2024.14.4.268.
O erro 0000002A ocorreu em `Windows PackageZip`; não impediu o teste por Run.
Foram corrigidos ternários aninhados, profundidade da GUI fora da faixa de desenho,
fontes ausentes e a interação da Bia que interceptava a estação de avaliação.

Inspeção manual no jogo: menu, novo slot, entrada na escola, introdução com acentos,
carregar a partida após reiniciar o Runner e diálogo da Bia no treinamento.
A fonte Nunito Sans passou a acompanhar o projeto sob licença OFL.

Campanha automatizada no próprio GameMaker: do novo jogo ao encerramento, 100%,
27 mudanças de room e 9.649 frames. Log: `teste_campanha_runtime.log`.
O slot 3 foi consultado no serviço: missão 12, finalizado verdadeiro, 11 objetivos
principais e inventário com cobertura consumida. Esse banco é exclusivo de QA.

O teste usa uma cópia em `qa_project`, troca a leitura do teclado por entradas
programadas e percorre uma rota sobre as colisões reais. Não teleporta o player nem
pula estados da campanha. Reduz a velocidade apenas para parar exatamente nos
pontos da rota. Aciona as mesmas ações de interface e os eventos de interação.
**Não equivale a alguém jogar manualmente toda a campanha.**

## Aceite ainda aberto

Campanha manual completa, avaliação de todas as animações/NPCs, inspeção visual de
cada porta com oclusão, enquadramento por room, áudio, resoluções e comparação com
a referência. A exportação PackageZip ainda não está validada. O teste automatizado
não substitui esses aceites nem a revisão profissional do conteúdo educativo.
