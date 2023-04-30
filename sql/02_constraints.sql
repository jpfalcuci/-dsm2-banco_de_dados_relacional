CREATE TABLE Pets (
    id      INT PRIMARY KEY AUTO_INCREMENT,
    nome    VARCHAR(60) NOT NULL,
    peso    DECIMAL(5,2) CHECK (peso>0)
)engine=InnoDB;

INSERT INTO Pets VALUES (null, "Milady", 2.2);
INSERT INTO Pets VALUES (null, "", 1.5);
INSERT INTO Pets VALUES (null, "", 0);
INSERT INTO Pets VALUES ("Jade", 1.2);


CREATE TABLE Produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL UNIQUE,
    preco_custo DECIMAL(9,2),
    preco_venda DECIMAL(9,2),
    lucro DECIMAL(9,2) AS (preco_venda - preco_custo),
    CHECK(preco_custo < preco_venda)
)engine=INNODB;

INSERT INTO Produtos (id, nome, preco_custo, preco_venda) VALUES (null, "Nome Produto", 28.5, 38.5);
