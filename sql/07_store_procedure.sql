CREATE TABLE lucro (
    lucro_id        INT AUTO_INCREMENT PRIMARY KEY,
    -- lucro_id        SERIAL PRIMARY KEY, --postgresql
    -- lucro_id        INT IDENTITY PRIMARY KEY, -- sqlserver
    nome_produto    VARCHAR(50),
    lucro_produto   DECIMAL(10,2)
);

-- mysql
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


-- sql server
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


-- postgresql
CREATE OR REPLACE FUNCTION novoProduto(
    nomeProduto VARCHAR(50),
    qtdEstoque INT,
    data_fabricacao DATE,
    perecivel BOOLEAN,
    valor DECIMAL(10,2)
)
RETURNS VOID AS $$
DECLARE
    estoqueMin INT;
    lucro DECIMAL(10,2);
    minhaMarca INT;
BEGIN
    estoqueMin := 50;
    lucro := valor + 10;
    minhaMarca := (SELECT marca_id FROM marcas WHERE nome_marca = 'Faber Castel');

    INSERT INTO produtos
        VALUES (DEFAULT, nomeProduto, qtdEstoque, estoqueMin, data_fabricacao, perecivel, valor, minhaMarca);

    INSERT INTO lucro
		VALUES (DEFAULT, nomeProduto, lucro);
END; $$ LANGUAGE plpgsql;

SELECT novoProduto('Lápis phyno', 10, '2023-05-28', FALSE, 10.5);

SELECT * FROM produtos WHERE nome_prod LIKE 'Lápis phyno';
SELECT * FROM lucro;



-- EXERCÍCIOS

-- 1. Crie uma SP que exibe o preço médio dos produtos.

CREATE PROCEDURE averagePrice() -- mysql
CREATE PROCEDURE averagePrice   -- sqlserver
AS -- sqlserver
    BEGIN
        SELECT ROUND(AVG(p.valor), 2) AS "Preço médio" FROM produtos p;
    END;

GO -- sqlserver: marca o final de um lote de comandos e instrui a executar todos os comandos anteriores até o momento.

DROP PROCEDURE IF EXISTS averagePrice;
GO -- sqlserver

CALL averagePrice();    -- mysql
EXEC averagePrice;      -- sqlserver

-- postgresql
CREATE OR REPLACE FUNCTION averagePrice()
    RETURNS TABLE (Preco_medio DECIMAL)
AS $$
    BEGIN
	    RETURN QUERY
	    SELECT ROUND(AVG(p.valor), 2) AS "Preço médio" FROM produtos p;
    END; $$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS averagePrice();

SELECT averagePrice() AS "Preço médio";




-- 2. Crie uma SP que ao passar uma marca como parâmetro retorna todos os produtos daquela marca.
CREATE PROCEDURE brandProduct(marca VARCHAR(50))    -- mysql
CREATE PROCEDURE brandProduct                       -- sqlserver
	@marca VARCHAR(50)  -- sqlserver                          
AS  -- sqlserver
    BEGIN
        SELECT p.nome_prod AS Produto, m.nome_marca AS Marca
        FROM produtos p
        JOIN marcas m ON p.marca_id = m.marca_id
        WHERE m.nome_marca LIKE marca;      -- mysql
        WHERE m.nome_marca LIKE @marca;     -- sqlserver
    END
GO -- sqlserver

DROP PROCEDURE IF EXISTS brandProduct;
GO -- sqlserver

-- mysql
CALL brandProduct("faber castel");
CALL brandProduct("totvs");
CALL brandProduct("lg");
CALL brandProduct("microsoft");

-- sqlserver
EXEC brandProduct 'faber castel';
EXEC brandProduct 'totvs';
EXEC brandProduct 'lg';
EXEC brandProduct 'microsoft';

-- postgresql
CREATE OR REPLACE FUNCTION brandProduct(p_marca VARCHAR(50))
    RETURNS TABLE (Produto VARCHAR(50), Marca VARCHAR(50))
AS $$
BEGIN
    RETURN QUERY
    SELECT p.nome_prod, m.nome_marca
    FROM produtos p
    JOIN marcas m ON p.marca_id = m.marca_id
    WHERE m.nome_marca ILIKE p_marca;
END; $$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS brandProduct();

SELECT * FROM brandProduct('faber castel');
SELECT * FROM brandProduct('totvs');
SELECT * FROM brandProduct('lg');
SELECT * FROM brandProduct('microsoft');


-- 3.Crie uma SP que receba dois valores (um menor e outro maior) como parâmetro e retorne todos os produtos com a quantidade dentro do intervalo dos dois valores fornecidos como parâmetros.

CREATE PROCEDURE productAmount(min INT, max INT)    -- mysql
CREATE PROCEDURE productAmount                      -- sqlserver
	@min INT,   -- sqlserver
	@max INT    -- sqlserver
AS  -- sqlserver
    BEGIN
        SELECT nome_prod AS Produto, qtd_estoque AS "Em estoque"
        FROM produtos
        WHERE qtd_estoque BETWEEN min AND max;      -- mysql
        WHERE qtd_estoque BETWEEN @min AND @max;    -- sqlserver
    END
GO -- sqlserver

DROP PROCEDURE IF EXISTS productAmount;
GO -- sqlserver

CALL productAmount(1000, 4000);     -- mysql
EXEC productAmount 1000, 4000;      -- sqlserver

-- postgresql
CREATE OR REPLACE FUNCTION productAmount(min_value INT, max_value INT)
    RETURNS TABLE (produto VARCHAR(50), em_estoque INT)
AS $$
BEGIN
    RETURN QUERY
    SELECT nome_prod, qtd_estoque
    FROM produtos
    WHERE qtd_estoque BETWEEN min_value AND max_value;
END; $$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS productAmount(INT, INT);

SELECT * FROM productAmount(1000, 4000);



-- 4.Crie uma SP onde após um novo registro na tabela produto_fornecedor for criado, ele exibe o nome do produto e o nome do fornecedor que acabou de ser registrado.

CREATE PROCEDURE productSupplier(idProd INT, idForn INT)    -- mysql
CREATE PROCEDURE productSupplier                            -- sqlserver
	@idProd INT,    -- sqlserver
	@idForn INT     -- sqlserver
AS  -- sqlserver
    BEGIN
        INSERT INTO produto_fornecedor VALUES (idProd, idForn);     -- mysql
        INSERT INTO produto_fornecedor VALUES (@idProd, @idForn);   -- sqlserver
        
        SELECT p.nome_prod AS Produto, f.nome_forn AS Fornecedor
        FROM produtos p
        JOIN produto_fornecedor pf ON p.prod_id = pf.prod_id
        JOIN fornecedores f ON pf.forn_id = f.forn_id
        WHERE p.prod_id = idProd;   -- mysql
        WHERE p.prod_id = @idProd;  -- sqlserver
    END
GO -- sqlserver

DROP PROCEDURE IF EXISTS productSupplier;
GO -- sqlserver

CALL productSupplier(7, 7);     -- mysql
EXEC productSupplier 7, 7;      -- sqlserver

-- postgresql
CREATE OR REPLACE FUNCTION productSupplier(id_prod INT, id_forn INT)
	RETURNS TABLE (produto VARCHAR(50), fornecedor VARCHAR(50))
AS $$
BEGIN
	INSERT INTO produto_fornecedor (prod_id, forn_id)
	    VALUES (id_prod, id_forn);
  
	RETURN QUERY
	SELECT p.nome_prod, f.nome_forn
	FROM produtos p
	JOIN produto_fornecedor pf ON p.prod_id = pf.prod_id
	JOIN fornecedores f ON pf.forn_id = f.forn_id
	WHERE p.prod_id = id_prod;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS productSupplier(INT, INT);

SELECT * FROM productSupplier(7, 7);



-- 5.Crie uma SP que receba como parâmetro o nome de um fornecedor e insira automaticamente o nome do fornecedor e um e-mail no formato nome_fornecedor@nome_fornecedor.com.br na tabela fornecedores.

-- mysql
CREATE PROCEDURE insertSupplier(fornName VARCHAR(50))
    BEGIN
        DECLARE fornEmail VARCHAR(50);
        SET fornEmail = CONCAT(REPLACE(LOWER(fornName), ' ', ''), '@', REPLACE(LOWER(fornName), ' ', ''), '.com.br');
        INSERT INTO fornecedores (nome_forn, email) VALUES (fornName, fornEmail);

        SELECT CONCAT('Usuário ', fornName, ' inserido com o email ', fornEmail) AS Mensagem;
    END
GO -- sqlserver

-- sqlserver
CREATE PROCEDURE insertSupplier
	@fornName VARCHAR(50)
AS
	BEGIN
		DECLARE @fornEmail VARCHAR(50);
		SET @fornEmail = CONCAT(REPLACE(LOWER(@fornName), ' ', ''), '@', REPLACE(LOWER(@fornName), ' ', ''), '.com.br');
		INSERT INTO fornecedores (nome_forn, email) VALUES (@fornName, @fornEmail);
		
		SELECT CONCAT('Usuário ', @fornName, ' inserido com o email ', @fornEmail) AS Mensagem;
	END;
GO -- sqlserver

DROP PROCEDURE IF EXISTS insertSupplier;
GO -- sqlserver

CALL insertSupplier('Walter White');    -- mysql
EXEC insertSupplier 'Walter White';     -- sqlserver

-- postgresql
CREATE OR REPLACE FUNCTION insertSupplier(forn_name VARCHAR(50))
    RETURNS TABLE (mensagem TEXT)
AS $$
DECLARE
    forn_email VARCHAR(50);
BEGIN
    forn_email := CONCAT(REPLACE(LOWER(forn_name), ' ', ''), '@', REPLACE(LOWER(forn_name), ' ', ''), '.com.br');
  
    INSERT INTO fornecedores (nome_forn, email)
        VALUES (forn_name, forn_email);
  
    RETURN QUERY
    SELECT CONCAT('Usuário ', forn_name, ' inserido com o email ', forn_email) AS mensagem;
END; $$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS insertSupplier(VARCHAR);

SELECT * FROM insertSupplier('Walter White');
