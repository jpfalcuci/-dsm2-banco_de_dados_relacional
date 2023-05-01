DROP DATABASE IF EXISTS Constraints;
CREATE DATABASE IF NOT EXISTS Constraints; -- postgresql e sqlserver não usam 'IF NOT EXISTS'
USE Constraints; -- postgresql não usa


CREATE TABLE Pets (
    id      INT AUTO_INCREMENT PRIMARY KEY,
    -- id      SERIAL PRIMARY KEY, -- postgresql
    -- id      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, -- postgresql
    -- id      INT IDENTITY PRIMARY KEY, -- sqlserver, padrão (1,1)
    nome    VARCHAR(60) NOT NULL,
    peso    DECIMAL(5,2) CHECK (peso>0)
)ENGINE=INNODB; -- postgresql e sqlserver não aceitam engine
-- postgresql aceita NUMERIC ao invés de DECIMAL


INSERT INTO Pets VALUES (NULL, 'Milady', 2.2);
INSERT INTO Pets VALUES (NULL, '', 1.5);
INSERT INTO Pets VALUES (NULL, '', 0); -- erro
INSERT INTO Pets VALUES ('Jade', 1.2); -- erro
-- INSERT INTO Pets (nome, peso) VALUES -- sqlserver precisa declarar os VALUES e remover o NULL
-- postgresql usa DEFAULT ao invés de NULL
-- mysql aceita valores com aspas duplas


CREATE TABLE Produtos (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    -- id          SERIAL PRIMARY KEY, -- postgresql
    -- id          INT IDENTITY PRIMARY KEY, -- sqlserver, padrão (1,1)
    nome        VARCHAR(60) NOT NULL UNIQUE,
    preco_custo DECIMAL(9,2),
    preco_venda DECIMAL(9,2),
    lucro       DECIMAL(9,2) AS (preco_venda - preco_custo),
    -- lucro       NUMERIC(9,2) GENERATED ALWAYS AS (preco_venda - preco_custo) STORED, -- postgresql; quando o valor precisa ser recalculado, usar VIRTUAL ao invés de STORED
    -- lucro       AS (preco_venda - preco_custo) PERSISTED, -- sqlserver; usa o tipo dos itens calculados; PERSISTED armazena o valor em disco e VIRTUAL o valor é recalculado na visualização
    CHECK(preco_custo < preco_venda)
)ENGINE=INNODB; -- postgresql e sqlserver não aceitam engine
-- postgresql aceita NUMERIC ao invés de DECIMAL


INSERT INTO Produtos (nome, preco_custo, preco_venda) VALUES ('Nome Produto', 28.5, 38.5);
-- mysql aceita valores com aspas duplas
