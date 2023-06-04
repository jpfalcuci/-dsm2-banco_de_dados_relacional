DROP DATABASE IF EXISTS Constraints;
CREATE DATABASE Constraints;

CREATE TABLE Pets (
	id      SERIAL PRIMARY KEY,
	-- id      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY(10,2), -- especificar valores iniciais e incremental; padrão (1,1)
	nome    VARCHAR(60) NOT NULL,
	peso    DECIMAL(5,2) CHECK (peso>0)
);

INSERT INTO Pets VALUES (DEFAULT, 'Milady', 2.2);
INSERT INTO Pets VALUES (DEFAULT, '', 1.5);
INSERT INTO Pets VALUES (DEFAULT, '', 0); -- erro
INSERT INTO Pets VALUES ('Jade', 1.2); -- erro

CREATE TABLE Produtos (
	id          SERIAL PRIMARY KEY,
	nome        VARCHAR(60) NOT NULL UNIQUE,
	preco_custo DECIMAL(9,2),
	preco_venda DECIMAL(9,2),
	lucro       DECIMAL(9,2) GENERATED ALWAYS AS (preco_venda - preco_custo) STORED,
		-- quando o valor precisa ser recalculado, usar VIRTUAL ao invés de STORED
	CHECK(preco_custo < preco_venda)
);

INSERT INTO Produtos (nome, preco_custo, preco_venda) VALUES ('Nome Produto', 28.5, 38.5);
