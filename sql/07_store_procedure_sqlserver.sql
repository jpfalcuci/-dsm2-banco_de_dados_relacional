CREATE TABLE lucro (
	lucro_id        INT IDENTITY PRIMARY KEY,
	nome_produto    VARCHAR(50),
	lucro_produto   DECIMAL(10,2)
);

CREATE PROCEDURE novoProduto
	@nomeProduto varchar(50),
	@qtdEstoque int,
	@data_fabricacao date,
	@perecivel bit,
	@valor decimal(10,2)
AS
	DECLARE @estoqueMin AS int,
			@lucro AS decimal(10,2),
			@minhaMarca AS int;
	SET @estoqueMin = 50;
	SET @lucro = @valor + 10;
	SET @minhaMarca = (SELECT m.marca_id
						FROM marcas m
						WHERE m.nome_marca = 'Faber Castel');
	INSERT INTO produtos (nome_prod, qtd_estoque, estoque_mim, data_fabricacao, perecivel, valor, marca_id)
		VALUES (@nomeProduto, @qtdEstoque, @estoqueMin, @data_fabricacao, @perecivel, @valor, @minhaMarca);

	INSERT INTO lucro (nome_produto, lucro_produto)
		VALUES (@nomeProduto, @lucro);

EXEC novoProduto 'Lápis phyno', 10, '2023-05-28', 0, 10.5;

SELECT * FROM produtos WHERE nome_prod LIKE 'Lápis phyno';
SELECT * FROM lucro;



-- Exercícios


-- 1. Crie uma SP que exibe o preço médio dos produtos.

DROP PROCEDURE IF EXISTS averagePrice;
GO

CREATE PROCEDURE averagePrice
AS
	BEGIN
		SELECT ROUND(AVG(p.valor), 2) AS "Preço médio" FROM produtos p;
	END;
GO -- marca o final de um lote de comandos e instrui a executar todos os comandos anteriores até o momento.

EXEC averagePrice;


-- 2. Crie uma SP que ao passar uma marca como parâmetro retorna todos os produtos daquela marca.

DROP PROCEDURE IF EXISTS brandProduct;
GO

CREATE PROCEDURE brandProduct
	@marca VARCHAR(50)
AS
	BEGIN
		SELECT p.nome_prod AS Produto, m.nome_marca AS Marca
		FROM produtos p
		JOIN marcas m ON p.marca_id = m.marca_id
		WHERE m.nome_marca LIKE @marca;
	END
GO

EXEC brandProduct 'faber castel';
EXEC brandProduct 'totvs';
EXEC brandProduct 'lg';
EXEC brandProduct 'microsoft';


-- 3.Crie uma SP que receba dois valores (um menor e outro maior) como parâmetro e retorne todos os produtos com a quantidade dentro do intervalo dos dois valores fornecidos como parâmetros.

DROP PROCEDURE IF EXISTS productAmount;
GO

CREATE PROCEDURE productAmount
	@min INT,
	@max INT
AS
	BEGIN
		SELECT nome_prod AS Produto, qtd_estoque AS "Em estoque"
		FROM produtos
		WHERE qtd_estoque BETWEEN @min AND @max;
	END
GO

EXEC productAmount 1000, 4000;


-- 4.Crie uma SP onde após um novo registro na tabela produto_fornecedor for criado, ele exibe o nome do produto e o nome do fornecedor que acabou de ser registrado.

DROP PROCEDURE IF EXISTS productSupplier;
GO

CREATE PROCEDURE productSupplier
	@idProd INT,
	@idForn INT
AS
	BEGIN
		INSERT INTO produto_fornecedor VALUES (@idProd, @idForn);

		SELECT p.nome_prod AS Produto, f.nome_forn AS Fornecedor
		FROM produtos p
		JOIN produto_fornecedor pf ON p.prod_id = pf.prod_id
		JOIN fornecedores f ON pf.forn_id = f.forn_id
		WHERE p.prod_id = @idProd;
	END
GO

EXEC productSupplier 7, 7;


-- 5.Crie uma SP que receba como parâmetro o nome de um fornecedor e insira automaticamente o nome do fornecedor e um e-mail no formato nome_fornecedor@nome_fornecedor.com.br na tabela fornecedores.

DROP PROCEDURE IF EXISTS insertSupplier;
GO

CREATE PROCEDURE insertSupplier
	@fornName VARCHAR(50)
AS
	BEGIN
		DECLARE @fornEmail VARCHAR(50);
		SET @fornEmail = CONCAT(REPLACE(LOWER(@fornName), ' ', ''), '@', REPLACE(LOWER(@fornName), ' ', ''), '.com.br');
		INSERT INTO fornecedores (nome_forn, email) VALUES (@fornName, @fornEmail);

		SELECT CONCAT('Usuário ', @fornName, ' inserido com o email ', @fornEmail) AS Mensagem;
	END;
GO

EXEC insertSupplier 'Walter White';
