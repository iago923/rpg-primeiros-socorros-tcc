PRAGMA foreign_keys=ON;
CREATE TABLE IF NOT EXISTS partidas (
 slot INTEGER PRIMARY KEY CHECK(slot BETWEEN 1 AND 3),
 versao INTEGER NOT NULL CHECK(versao=1),
 capitulo INTEGER NOT NULL, segundos REAL NOT NULL CHECK(segundos>=0),
 atualizado TEXT NOT NULL, room_id TEXT NOT NULL,
 x REAL NOT NULL, y REAL NOT NULL, facing TEXT NOT NULL,
 snapshot TEXT NOT NULL, checksum TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS inventario (
 partida INTEGER NOT NULL REFERENCES partidas(slot) ON DELETE CASCADE,
 recipiente TEXT NOT NULL CHECK(recipiente IN ('bolsa','armario')),
 slot INTEGER NOT NULL CHECK(slot>=0), item_id TEXT NOT NULL,
 quantidade INTEGER NOT NULL CHECK(quantidade>0 AND quantidade<=20), estado TEXT NOT NULL,
 PRIMARY KEY(partida,recipiente,slot)
);
CREATE TABLE IF NOT EXISTS progresso (
 partida INTEGER NOT NULL REFERENCES partidas(slot) ON DELETE CASCADE,
 objetivo_id TEXT NOT NULL, estado TEXT NOT NULL,
 PRIMARY KEY(partida,objetivo_id)
);
CREATE TABLE IF NOT EXISTS aprendizagem (
 partida INTEGER NOT NULL REFERENCES partidas(slot) ON DELETE CASCADE,
 conteudo_id TEXT NOT NULL, estado TEXT NOT NULL,
 PRIMARY KEY(partida,conteudo_id)
);
CREATE TABLE IF NOT EXISTS mundo (
 partida INTEGER NOT NULL REFERENCES partidas(slot) ON DELETE CASCADE,
 flag_id TEXT NOT NULL, valor TEXT NOT NULL,
 PRIMARY KEY(partida,flag_id)
);
CREATE TABLE IF NOT EXISTS configuracoes (id INTEGER PRIMARY KEY CHECK(id=1), dados TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS recuperacao (slot INTEGER PRIMARY KEY, snapshot TEXT NOT NULL, checksum TEXT NOT NULL);
PRAGMA user_version=1;
