# RPG Primeiros Socorros

Jogo educativo em português sobre primeiros socorros em situações do cotidiano escolar. O projeto foi desenvolvido no GameMaker para o TCC.

## Jogar

Jogue no navegador: [RPG Primeiros Socorros](https://iago923.github.io/rpg-primeiros-socorros-tcc/).

Codigo-fonte: [repositorio publico no GitHub](https://github.com/iago923/rpg-primeiros-socorros-tcc). A versao web publicada esta em [`docs/`](docs/).

Use as setas ou **WASD** para andar. **E** interage, **Espaço** avança diálogos e atividades, **I** abre a bolsa, **J** mostra as tarefas e **G** abre o guia. Em algumas atividades, use as teclas numéricas indicadas na tela. Também há controles de toque em telas compatíveis.

## Arquivos

- `docs/`: versão HTML5 do jogo, pronta para hospedagem estática pelo GitHub Pages.
- `game/`: projeto-fonte editável do GameMaker (`RPG Primeiros Socorros.yyp`).
- `backend/`: código e esquema do serviço SQLite usado na versão Windows.
- `docs/FONTES.md`: referências clínicas, estatísticas e técnicas, limites educativos e créditos da fonte.
- `docs/DOCUMENTACAO_TCC.md`: documentação da arquitetura e do desenvolvimento.
- `docs/RELATORIO_TESTES.md`: resultados e limitações dos testes registrados.

## Salvar progresso

Na versão de navegador, o progresso fica armazenado localmente no próprio navegador e dispositivo. Não é necessário criar conta. Limpar os dados do site ou trocar de navegador/dispositivo pode apagar ou deixar o progresso inacessível. A versão Windows usa o serviço local incluído no projeto.

## Verificação desta publicação

Build HTML5 compilado no GameMaker 2024.14.4.268. Foram verificados no navegador: abertura do menu, criação de slot, introdução, movimento do personagem e identificação do progresso salvo no dispositivo. A campanha completa não foi percorrida manualmente no navegador; o relatório de testes registra os testes automatizados da versão Windows e seus limites.

## Créditos

Desenvolvimento: Iago Camargo Franca. Colaboração/documentação: Guilherme Dominguez Rodrigues, Breno Silva de Carvalho e Gabriel Oliveira Rosa. Referências e créditos completos estão em [`docs/FONTES.md`](docs/FONTES.md).

O jogo é um recurso educativo e não substitui treinamento certificado, orientação profissional ou atendimento de emergência. As situações são fictícias e o jogo não aciona o SAMU.

## Como abrir o projeto-fonte

1. Instale o GameMaker e abra `game/RPG Primeiros Socorros.yyp`.
2. Para editar ou compilar, selecione a plataforma desejada no GameMaker.
3. Para a versão de navegador já compilada, use os arquivos da pasta `docs/`.

