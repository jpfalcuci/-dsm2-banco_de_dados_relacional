DROP DATABASE IF EXISTS Constraints;
CREATE DATABASE IF NOT EXISTS Constraints;
USE Constraints;

CREATE TABLE Pets (
	id      INT AUTO_INCREMENT PRIMARY KEY,
	nome    VARCHAR(60) NOT NULL,
	peso    DECIMAL(5,2) CHECK (peso>0)
)ENGINE=INNODB;

INSERT INTO Pets VALUES (NULL, 'Milady', 2.2);
INSERT INTO Pets VALUES (NULL, '', 1.5);
INSERT INTO Pets VALUES (NULL, '', 0); -- erro
INSERT INTO Pets VALUES ('Jade', 1.2); -- erro
-- mysql aceita valores com aspas duplas

CREATE TABLE Produtos (
	id          INT AUTO_INCREMENT PRIMARY KEY,
	nome        VARCHAR(60) NOT NULL UNIQUE,
	preco_custo DECIMAL(9,2),
	preco_venda DECIMAL(9,2),
	lucro       DECIMAL(9,2) AS (preco_venda - preco_custo),
	CHECK(preco_custo < preco_venda)
)ENGINE=INNODB;

INSERT INTO Produtos (nome, preco_custo, preco_venda) VALUES ('Nome Produto', 28.5, 38.5);
-- mysql aceita valores com aspas duplas
