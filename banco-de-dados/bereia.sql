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

ALTER TABLE tentativa_questionario
  ADD CONSTRAINT fk_tentativa_livro
  FOREIGN KEY (idlivro) REFERENCES livro (idlivro);

ALTER TABLE resposta_questionario
  ADD CONSTRAINT fk_resposta_tentativa
  FOREIGN KEY (idtentativa) REFERENCES tentativa_questionario (idtentativa);

SELECT * FROM usuario;
SELECT * FROM livro;
SELECT * FROM tentativa_questionario;
SELECT * FROM resposta_questionario;

-- só os dados públicos do usuário (sem a senha)
SELECT idusuario, nome, email FROM usuario;

-- livros em ordem alfabética
SELECT nome FROM livro ORDER BY nome;

-- livros que começam com G
SELECT nome FROM livro WHERE nome LIKE 'G%';

-- tentativas de cada usuário, com nome e livro
SELECT u.nome AS usuario, l.nome AS livro, t.pontuacao, t.datarealizacao
FROM tentativa_questionario t
JOIN usuario u ON u.idusuario = t.fkusuario
JOIN livro l ON l.idlivro = t.idlivro
ORDER BY t.datarealizacao DESC;

-- respostas de uma tentativa, com a questão e se acertou
SELECT r.numeroquestao, r.alternativaescolhida,
       IF(r.correta = 1, 'Acertou', 'Errou') AS resultado
FROM resposta_questionario r
WHERE r.idtentativa = 1
ORDER BY r.numeroquestao;

-- todos os livros, mesmo os que o usuário ainda não respondeu
SELECT l.nome, COUNT(t.idtentativa) AS tentativas
FROM livro l
LEFT JOIN tentativa_questionario t
       ON t.idlivro = l.idlivro AND t.fkusuario = 1
GROUP BY l.idlivro, l.nome;

-- quantos usuários cadastrados
SELECT COUNT(*) AS total_usuarios FROM usuario;

-- média, maior e menor pontuação por livro
SELECT l.nome, AVG(t.pontuacao) AS media, MAX(t.pontuacao) AS maior, MIN(t.pontuacao) AS menor
FROM tentativa_questionario t
JOIN livro l ON l.idlivro = t.idlivro
GROUP BY l.nome;

-- total de questões acertadas e erradas por usuário
SELECT u.nome, SUM(r.correta) AS acertos, COUNT(*) - SUM(r.correta) AS erros
FROM resposta_questionario r
JOIN tentativa_questionario t ON t.idtentativa = r.idtentativa
JOIN usuario u ON u.idusuario = t.fkusuario
GROUP BY u.nome;

-- aproveitamento (%) por usuário
SELECT u.nome, ROUND(SUM(r.correta) / COUNT(*) * 100) AS aproveitamento
FROM resposta_questionario r
JOIN tentativa_questionario t ON t.idtentativa = r.idtentativa
JOIN usuario u ON u.idusuario = t.fkusuario
GROUP BY u.nome;

-- livro com mais tentativas
SELECT l.nome, COUNT(*) AS tentativas
FROM tentativa_questionario t
JOIN livro l ON l.idlivro = t.idlivro
GROUP BY l.nome
ORDER BY tentativas DESC
LIMIT 1;

-- usuários que nunca fizeram questionário
SELECT nome, email FROM usuario
WHERE idusuario NOT IN (SELECT fkusuario FROM tentativa_questionario);

-- tentativas acima da média geral
SELECT * FROM tentativa_questionario
WHERE pontuacao > (SELECT AVG(pontuacao) FROM tentativa_questionario);

-- questões mais erradas (número da questão)
SELECT numeroquestao, COUNT(*) AS erros
FROM resposta_questionario
WHERE correta = 0
GROUP BY numeroquestao
ORDER BY erros DESC;
