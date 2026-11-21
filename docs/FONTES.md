# Fontes e limites educativos

Consulta: 20/09/2026. Conteúdo preparado para revisão profissional; nenhuma revisão
médica ou estudo de eficácia pedagógica foi realizado.

## Referências clínicas

| ID | Publicação, versão e público | Aplicação no código |
|---|---|---|
| MS-SAMU | [Ministério da Saúde, SAMU 192](https://www.gov.br/saude/pt-br/composicao/saes/samu-192), página pública consultada; sem ano de edição identificado | Pedido de ajuda e comunicação; público brasileiro geral |
| AHA-2025 | [Adult Basic Life Support](https://cpr.heart.org/en/resuscitation-science/cpr-and-ecc-guidelines/adult-basic-life-support), diretriz 2025, adulto | Reconhecimento e sequência de decisão sobre engasgo em adulto de 18 anos |
| AHA-2024 | [AHA / American Red Cross First Aid](https://cpr.heart.org/en/resuscitation-science/2024-first-aid-guidelines), 2024, seções 5.1, 9.4 e 9.8 | Posicionamento, suspeita de trauma e queimadura; recomendações de primeiros socorros para leigos |
| MS-QUEIMADURAS | [BVS/MS, Queimaduras](https://bvsms.saude.gov.br/bvs/dicas/54queimaduras.html), elaboração maio/2004, divulgação para população | Contraindicações gerais; não adotado seu tempo específico de resfriamento |
| AL-QUEIMADURAS | [Secretaria de Saúde de Alagoas, Queimadura](https://cidadao.saude.al.gov.br/saude-para-voce/primeiros-socorros/queimadura/), página pública sem ano identificado | Proteção limpa sem aderência, evitar produtos caseiros e tecido aderido |

Todos os quatro casos da ficção foram delimitados a adultos de 18 anos. O jogo não
ensina protocolos de lactentes nem extrapola números adultos para crianças.

Diferença resolvida: a orientação antiga de apenas compressões abdominais encontrada
na divulgação sobre engasgo não foi combinada com a atualização da AHA de 2025.
A sequência citada no conteúdo e na pergunta é a mesma. Não há animação que pretenda
ensinar força, localização exata das mãos, profundidade ou execução motora.

O resfriamento não possui duração numérica no minigame, evitando misturar tempos
entre publicações. A atividade avalia a seleção do recurso, não o cumprimento de
um tratamento abreviado. A condição respiratória deve ser reavaliada; a chamada
de ajuda no jogo é fictícia, sem ligação telefônica real.

Revisar com profissional: redação de cada caso, limites da orientação de posicionamento,
alternativas e explicações, atualização de fontes, termos de consentimento e apresentação.

## Estatística do encerramento

Fonte primária aberta e tabela textual conferida: [Ministério da Saúde, Saúde Brasil
2023, versão preliminar, capítulo 13, Tabela 1, página 303 do documento](https://www.gov.br/saude/pt-br/centrais-de-conteudo/publicacoes/svsa/analise-de-situacao-de-saude/saude-brasil-2023-analise-da-situacao-de-saude-com-enfoque-nas-criancas-brasileiras-versao-preliminar/@@download/file/preliminar%20SAU%CC%81DE%20BRASIL%202023_7nov23.pdf).

- Valor: **112 óbitos por quedas**, Brasil, 2021, crianças de 0 a 9 anos.
- Unidade: óbitos registrados no SIM, não atendimentos nem internações.
- Indicador: frequência absoluta de mortes por quedas no recorte do estudo.
- A mesma tabela apresenta 1.895 óbitos no total de causas acidentais do recorte.
- O jogo usa apenas o valor de quedas e identifica faixa etária, ano e território.
- Não atribui esses óbitos à falta de primeiros socorros, nem promete redução por jogar.
- A estatística infantil é separada explicitamente da faixa adulta dos casos jogáveis.
- Tentativa de captura da página PDF pela ferramenta falhou; a tabela foi lida no texto
  integral da publicação. Não foi produzida captura falsa.

## Referências de interface

- [Inventário de Stardew Valley](https://wiki.stardewvalley.net/Inventory): separação de
  bolsa, quantidades e organização. Referência visual/organizacional, não fonte de código.
- [Terraria: melhorias de interface](https://terraria.org/news/terraria-1-3-user-interface-upgrades):
  contraste, realce de seleção e contadores legíveis.
- Decisão original para a escola: painéis claros, contorno verde, botões com foco visível,
  texto sem digitação obrigatória e pausas de leitura. Nenhum recurso desses jogos foi copiado.

## Referências técnicas

- [GameMaker, http_request](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asynchronous_Functions/HTTP/http_request.htm): retorno assíncrono, identificação de pedido e evento HTTP.
- [SQLite, parâmetros](https://sqlite.org/c3ref/bind_blob.html): consultas com parâmetros vinculados.
- [SQLite, transações](https://sqlite.org/transactional.html): atomicidade das alterações.
- [Microsoft, SQLite no Windows](https://learn.microsoft.com/en-us/windows/uwp/data-access/sqlite-databases): biblioteca SQLite incluída nas versões suportadas do Windows.

O serviço usa a API nativa do SQLite via C#, não a biblioteca Microsoft.Data.Sqlite
do exemplo Microsoft. Essa adaptação foi testada neste Windows; GameMaker não é
apresentado como possuindo SQLite nativo.
# Fonte da interface

Nunito Sans, autores do projeto Nunito Sans; distribuição oficial no repositório
[Google Fonts](https://github.com/google/fonts/tree/main/ofl/nunitosans).
Licença SIL Open Font License 1.1 incluída em `datafiles/fontes/OFL.txt`.
A instância Medium foi produzida com peso 500 para não depender de fonte instalada.
