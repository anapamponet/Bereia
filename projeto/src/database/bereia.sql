-- ============================================================
-- Bereia — script do banco de dados (MySQL)
-- Gerado a partir do DER: banco-de-dados/der.mwb
-- Tabelas do DER: usuario, livro, tentativa_questionario, resposta_questionario
-- ============================================================

CREATE DATABASE IF NOT EXISTS bereia
  DEFAULT CHARACTER SET utf8mb4;

USE bereia;

CREATE TABLE IF NOT EXISTS usuario (
  idusuario INT NOT NULL AUTO_INCREMENT,
  nome      VARCHAR(100),
  email     VARCHAR(150),
  senha     VARCHAR(255),
  PRIMARY KEY (idusuario)
);

CREATE TABLE IF NOT EXISTS livro (
  idlivro INT NOT NULL AUTO_INCREMENT,
  nome    VARCHAR(45),
  PRIMARY KEY (idlivro)
);

-- Igual ao DER: chave primária composta (idtentativa, fkusuario)
-- e uma única FK desenhada (fkusuario -> usuario.idusuario).
CREATE TABLE IF NOT EXISTS tentativa_questionario (
  idtentativa            INT NOT NULL AUTO_INCREMENT,
  idusuario              INT,
  idlivro                INT,
  pontuacao              INT,
  datarealizacao         DATETIME,
  tentativa_questionario VARCHAR(45),
  fkusuario              INT NOT NULL,
  PRIMARY KEY (idtentativa, fkusuario),
  INDEX fk_tentativa_questionario_usuario_idx (fkusuario),
  CONSTRAINT fk_tentativa_questionario_usuario
    FOREIGN KEY (fkusuario) REFERENCES usuario (idusuario)
    ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS resposta_questionario (
  idresposta           INT NOT NULL AUTO_INCREMENT,
  idtentativa          INT,
  numeroquestao        INT,
  alternativaescolhida CHAR(1),
  correta              TINYINT,
  PRIMARY KEY (idresposta)
);

-- Os nove livros do projeto (mesma ordem do protótipo)
INSERT INTO livro (nome) VALUES
  ('Mateus'),
  ('Marcos'),
  ('Lucas'),
  ('João'),
  ('Gênesis'),
  ('Levítico'),
  ('Romanos'),
  ('Gálatas'),
  ('Hebreus');

-- ------------------------------------------------------------
-- OPCIONAL (não está no DER): ligações que o DER não desenhou.
-- Se quiser integridade total, atualize o DER e descomente:
--
-- ALTER TABLE tentativa_questionario
--   ADD CONSTRAINT fk_tentativa_livro
--   FOREIGN KEY (idlivro) REFERENCES livro (idlivro);
--
-- ALTER TABLE resposta_questionario
--   ADD CONSTRAINT fk_resposta_tentativa
--   FOREIGN KEY (idtentativa) REFERENCES tentativa_questionario (idtentativa);
-- ------------------------------------------------------------
