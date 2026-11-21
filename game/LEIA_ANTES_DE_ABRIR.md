# Versão de integração, ainda não homologada

O projeto original aprovado em `Desktop/TCC/RPG Primeiros Socorros` não foi substituído.

Esta cópia contém a ampliação em andamento. O serviço SQLite e o jogo foram compilados
e executados. A campanha passou em teste automatizado no próprio GameMaker.
Não use esta cópia na apresentação sem completar os testes de jogo.

## Para retomar a validação

1. Abra o GameMaker normalmente e entre em sua conta, se solicitado.
2. Abra `RPG Primeiros Socorros.yyp` desta pasta, não uma cópia antiga.
3. Execute `datafiles/servico/Servidor.exe`. É um serviço local sem janela.
4. Execute o jogo pelo GameMaker. No menu, Novo jogo permite escolher um dos três slots.
5. Siga o roteiro de aceite em `expansao/DOCUMENTACAO_TCC.md`, na pasta de trabalho.

Requisitos do serviço: Windows 10/11 x64, .NET Framework 4.x e `winsqlite3.dll` do Windows.
Não exige Python, Node, internet, login de jogador ou servidor remoto para salvar.
O banco normal fica em `%LOCALAPPDATA%/RPGPrimeirosSocorros/partidas.sqlite3`.
Não apague esse arquivo para atualizar o jogo. O banco usado nos testes é separado.

Os fontes C#, esquema, testes, referências e relatório estão na pasta `expansao`.
A campanha manual completa, revisão visual em todas as salas/resoluções e exportação
do executável ainda precisam de aceite. O projeto original continua preservado.
