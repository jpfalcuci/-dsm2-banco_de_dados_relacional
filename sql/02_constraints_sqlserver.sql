DROP DATABASE IF EXISTS Constraints;
CREATE DATABASE Constraints;
USE Constraints;

CREATE TABLE Pets (
	id      INT IDENTITY PRIMARY KEY,
	nome    VARCHAR(60) NOT NULL,
	peso    DECIMAL(5,2) CHECK (peso>0)
);

INSERT INTO Pets (nome, peso) VALUES ('Milady', 2.2);
INSERT INTO Pets (nome, peso) VALUES ('', 1.5);
INSERT INTO Pets (nome, peso) VALUES ('', 0); -- erro
INSERT INTO Pets (nome, peso) VALUES ('Jade', 1.2); -- erro

CREATE TABLE Produtos (
	id          INT IDENTITY PRIMARY KEY,
	nome        VARCHAR(60) NOT NULL UNIQUE,
	preco_custo DECIMAL(9,2),
	preco_venda DECIMAL(9,2),
	lucro       AS (preco_venda - preco_custo) PERSISTED,
		-- usa o tipo dos itens calculados; PERSISTED armazena o valor em disco e VIRTUAL o valor é recalculado na visualização
	CHECK(preco_custo < preco_venda)
);

INSERT INTO Produtos (nome, preco_custo, preco_venda) VALUES ('Nome Produto', 28.5, 38.5);
