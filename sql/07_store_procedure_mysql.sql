CREATE TABLE lucro (
	lucro_id        INT AUTO_INCREMENT PRIMARY KEY,
	nome_produto    VARCHAR(50),
	lucro_produto   DECIMAL(10,2)
);

CREATE PROCEDURE novoProduto(
	IN nomeProduto VARCHAR(50),
	IN qtdEstoque INT,
	IN data_fabricacao DATE,
	IN perecivel TINYINT,
	IN valor DECIMAL(10,2)
)
BEGIN
	DECLARE estoqueMin INT;
	DECLARE lucro DECIMAL(10,2);
	DECLARE minhaMarca INT;

	SET estoqueMin = 50;
	SET lucro = valor + 10;
	SET minhaMarca = (SELECT marca_id FROM marcas WHERE nome_marca = 'Faber Castel');

	INSERT INTO produtos
		VALUES (NULL, nomeProduto, qtdEstoque, estoqueMin, data_fabricacao, perecivel, valor, minhaMarca);

	INSERT INTO lucro
	VALUES (NULL, nomeProduto, lucro);
END;

CALL novoProduto('Lápis phyno', 10, '2023-05-28', 0, 10.5);

SELECT * FROM produtos WHERE nome_prod LIKE 'Lápis phyno';
SELECT * FROM lucro;



-- Exercícios


-- 1. Crie uma SP que exibe o preço médio dos produtos.

DROP PROCEDURE IF EXISTS averagePrice;

CREATE PROCEDURE averagePrice()
BEGIN
	SELECT ROUND(AVG(p.valor), 2) AS "Preço médio" FROM produtos p;
END;

CALL averagePrice();


-- 2. Crie uma SP que ao passar uma marca como parâmetro retorna todos os produtos daquela marca.

DROP PROCEDURE IF EXISTS brandProduct;

CREATE PROCEDURE brandProduct(marca VARCHAR(50))
BEGIN
	SELECT p.nome_prod AS Produto, m.nome_marca AS Marca
	FROM produtos p
	JOIN marcas m ON p.marca_id = m.marca_id
	WHERE m.nome_marca LIKE marca;
END

CALL brandProduct("faber castel");
CALL brandProduct("totvs");
CALL brandProduct("lg");
CALL brandProduct("microsoft");


-- 3.Crie uma SP que receba dois valores (um menor e outro maior) como parâmetro e retorne todos os produtos com a quantidade dentro do intervalo dos dois valores fornecidos como parâmetros.

DROP PROCEDURE IF EXISTS productAmount;

CREATE PROCEDURE productAmount(min INT, max INT)
BEGIN
	SELECT nome_prod AS Produto, qtd_estoque AS "Em estoque"
	FROM produtos
	WHERE qtd_estoque BETWEEN min AND max;
END

CALL productAmount(1000, 4000);


-- 4.Crie uma SP onde após um novo registro na tabela produto_fornecedor for criado, ele exibe o nome do produto e o nome do fornecedor que acabou de ser registrado.

DROP PROCEDURE IF EXISTS productSupplier;

CREATE PROCEDURE productSupplier(idProd INT, idForn INT)
BEGIN
	INSERT INTO produto_fornecedor VALUES (idProd, idForn);

	SELECT p.nome_prod AS Produto, f.nome_forn AS Fornecedor
	FROM produtos p
	JOIN produto_fornecedor pf ON p.prod_id = pf.prod_id
	JOIN fornecedores f ON pf.forn_id = f.forn_id
	WHERE p.prod_id = idProd;
END

CALL productSupplier(7, 7);


-- 5.Crie uma SP que receba como parâmetro o nome de um fornecedor e insira automaticamente o nome do fornecedor e um e-mail no formato nome_fornecedor@nome_fornecedor.com.br na tabela fornecedores.

DROP PROCEDURE IF EXISTS insertSupplier;

CREATE PROCEDURE insertSupplier(fornName VARCHAR(50))
BEGIN
	DECLARE fornEmail VARCHAR(50);
	SET fornEmail = CONCAT(REPLACE(LOWER(fornName), ' ', ''), '@', REPLACE(LOWER(fornName), ' ', ''), '.com.br');
	INSERT INTO fornecedores (nome_forn, email) VALUES (fornName, fornEmail);

	SELECT CONCAT('Usuário ', fornName, ' inserido com o email ', fornEmail) AS Mensagem;
END

CALL insertSupplier('Walter White');
