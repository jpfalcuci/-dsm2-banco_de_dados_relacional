CREATE FUNCTION hello()
        RETURNS VARCHAR(30)
        DETERMINISTIC   -- mysql
        NO SQL          -- mysql
    BEGIN
        RETURN 'Hello World!';
    END;
GO; -- sqlserver

SELECT hello();
SELECT dbo.hello();     -- sqlserver
GO; -- sqlserver

--postgresql
CREATE OR REPLACE FUNCTION hello()
    RETURNS VARCHAR(30)
LANGUAGE plpgsql
AS $$
    BEGIN
        RETURN 'Hello World!';
    END; $$;

SELECT hello();


CREATE FUNCTION helloPerson(nome VARCHAR(30))
CREATE FUNCTION helloPerson(@nome VARCHAR(30))  -- sqlserver
        RETURNS VARCHAR(30)
        DETERMINISTIC   -- mysql
        NO SQL          -- mysql
    BEGIN
        RETURN CONCAT('Hello ', nome, '!');
        RETURN CONCAT('Hello ', @nome, '!');    -- sqlserver
    END;
GO; -- sqlserver

DROP FUNCTION IF EXISTS helloPerson;

SELECT helloPerson('João');

SELECT dbo.helloPerson('João');     -- sqlserver
GO; -- sqlserver

-- postgresql
CREATE OR REPLACE FUNCTION helloPerson(nome VARCHAR(30))
    RETURNS VARCHAR(30)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN CONCAT('Hello ', nome, '!');
END; $$;

DROP FUNCTION IF EXISTS helloPerson;

SELECT helloPerson('João');


CREATE FUNCTION soma(num1 INT, num2 INT)
CREATE FUNCTION soma(@num1 INT, @num2 INT)  -- sqlserver
        RETURNS INT
        DETERMINISTIC   -- mysql
        NO SQL          -- mysql
    BEGIN
        RETURN num1 + num2;
        RETURN @num1 + @num2;   -- sqlserver
    END;
GO; -- sqlserver

DROP FUNCTION IF EXISTS soma;

SELECT soma(5, 8);
SELECT dbo.soma(5, 8);      -- sqlserver
GO; -- sqlserver

-- postgresql
CREATE OR REPLACE FUNCTION soma(num1 INT, num2 INT)
    RETURNS INT
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN num1 + num2;
END; $$;

DROP FUNCTION IF EXISTS soma;

SELECT soma(5, 8);


SELECT helloPerson('João'), soma(4, 3);             -- mysql, postgresql
SELECT dbo.helloPerson('João'), dbo.soma(4, 3);     -- sqlserver
GO; -- sqlserver



CREATE DATABASE ProdutosLegais;
USE ProdutosLegais;

CREATE TABLE produtos(
    id              INT PRIMARY KEY AUTO_INCREMENT,     -- mysql
    -- id              INT PRIMARY KEY IDENTITY,           -- sqlserver
    -- id              SERIAL PRIMARY KEY,                 -- postgresql
    nome            VARCHAR(30),
    preco_custo     DECIMAL(9,2),
    preco_venda     DECIMAL(9,2)
);

INSERT INTO produtos (nome, preco_custo, preco_venda) VALUES
    ('borracha', 10, 12),
    ('caderno', 20, 27),
    ('caneta', 1, 5),
    ('ERP', 200, 350)
;



CREATE FUNCTION lucro(produto INT)                  -- mysql
CREATE OR ALTER FUNCTION dbo.lucro(@produto INT)    -- sqlserver
CREATE OR REPLACE FUNCTION lucro(produto INT)       -- postgresql
    RETURNS DECIMAL(9,2)
    DETERMINISTIC       -- mysql
    READS SQL DATA      -- mysql
AS      -- sqlserver

-- postgresql
LANGUAGE plpgsql
AS $$
DECLARE
    custo DECIMAL(9,2);
    venda DECIMAL(9,2);
    lucro DECIMAL(9,2);

BEGIN
    -- mysql
    DECLARE custo DECIMAL(9,2);
    DECLARE venda DECIMAL(9,2);
    DECLARE lucro DECIMAL(9,2);

    SELECT preco_custo INTO custo FROM produtos WHERE id = produto;
    SELECT preco_venda INTO venda FROM produtos WHERE id = produto;

    SET lucro = venda - custo;
    RETURN lucro;

    -- sqlserver
    DECLARE @custo DECIMAL(9,2);
    DECLARE @venda DECIMAL(9,2);
    DECLARE @lucro DECIMAL(9,2);

    SELECT @custo = preco_custo FROM produtos WHERE id = @produto;
    SELECT @venda = preco_venda FROM produtos WHERE id = @produto;

    SET @lucro = @venda - @custo;
    RETURN @lucro;

    -- postgresql
    SELECT preco_custo INTO custo FROM produtos WHERE id = produto;
    SELECT preco_venda INTO venda FROM produtos WHERE id = produto;
    
    lucro := venda - custo;
    
    RETURN lucro;
END;
END; $$;    -- postgresql

DROP FUNCTION IF EXISTS lucro;

-- mysql, postgresql
SELECT lucro(1), lucro(2), lucro(3), lucro(4);

-- sqlserver
SELECT dbo.lucro(1), dbo.lucro(2), dbo.lucro(3), dbo.lucro(4);



SELECT UPPER('Fatec Franca SP');
SELECT LOWER('Fatec Franca SP');

SELECT LEN('Fatec Franca SP');          -- sqlserver
SELECT LENGTH('Fatec Franca SP');       -- mysql, postgresql

SELECT DATALENGTH(1234);                -- sqlserver
SELECT LENGTH(CONVERT(1234, CHAR));     -- mysql
SELECT LENGTH(CAST(1234 AS VARCHAR));   -- postgresql

SELECT TRIM('  Fatec Franca SP     ');

SELECT REVERSE('Fatec Franca SP');                                  -- sqlserver
SELECT STRING_AGG(SUBSTRING('Fatec Franca SP', n, 1), '')
    FROM GENERATE_SERIES(LENGTH('Fatec Franca SP'), 1, -1) AS n;    -- postgresql

SELECT ROUND(5.1234,3);

SELECT DIFFERENCE('Teste', 'Teste');    -- sqlserver

SELECT LEFT('Fatec Franca', 3);
SELECT RIGHT('Fatec Franca', 3);
SELECT REPLACE('Fatec Franca SP', 'Franca', 'São Paulo');

SELECT REPLICATE('Fatec Franca SP', 5);                             -- sqlserver
SELECT REPEAT('Fatec Franca SP', 5);                                -- mysql
SELECT STRING_AGG('Fatec Franca SP', '' ORDER BY generate_series)
    FROM generate_series(1, 5);                                     -- postgresql

SELECT SPACE(10);           -- sqlserver
SELECT REPEAT(' ', 10);     -- mysql, postgresql

SELECT STUFF('Fatec Franca', 1, 5, 'Unifran');              -- sqlserver
SELECT CONCAT('Unifran', SUBSTRING('Fatec Franca', 6));     -- mysql, postgresql

SELECT SUBSTRING('Fatec Franca', 1, 3);         -- sqlserver, mysql
SELECT SUBSTRING('Fatec Franca' FROM 1 FOR 3);  -- postgresql

SELECT UNICODE('Atlanta');                  -- sqlserver
SELECT ORD('Atlanta');                      -- mysql
SELECT ASCII(SUBSTRING('Atlanta', 1, 1));   -- postgresql
