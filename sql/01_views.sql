DROP DATABASE IF EXISTS Loja;
CREATE DATABASE IF NOT EXISTS Loja; -- postgresql e sqlserver não usam 'IF NOT EXISTS'
USE Loja; -- postgresql não usa


CREATE TABLE marcas (
    marca_id 		INT AUTO_INCREMENT PRIMARY KEY,
    -- marca_id        SERIAL PRIMARY KEY, -- postgresql => quando o valor inicial e o incremento são 1
    -- marca_id        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY(10,2), -- postgresql => especificar valores iniciais e incremental; padrão (1,1)
    -- marca_id        INT IDENTITY PRIMARY KEY, -- sqlserver, padrão (1,1)
    marca_nome 		VARCHAR(50) NOT NULL,
    marca_origem	VARCHAR(50)
) AUTO_INCREMENT = 10, INCREMENT BY 2; -- mysql, personalizar valor inicial e de incremento


CREATE TABLE produtos (
    prod_id			        INT AUTO_INCREMENT PRIMARY KEY,
    -- prod_id                 SERIAL PRIMARY KEY, -- postgresql
    -- prod_id                 INT IDENTITY PRIMARY KEY, -- sqlserver, padrão (1,1)
    prod_nome			    VARCHAR(50) NOT NULL,
    prod_qtd_estoque		INT NOT NULL DEFAULT 0,
    prod_estoque_min		INT NOT NULL DEFAULT 0,
    prod_data_fabricacao	TIMESTAMP DEFAULT now(),
    -- prod_data_fabricacao    TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- posgresql
    -- prod_data_fabricacao    DATETIME DEFAULT GETDATE(), -- sqlserver
    prod_perecivel		    BOOLEAN, -- valores false e true
    -- prod_perecivel          BIT, -- sqlserver, valores 0 e 1
    prod_valor			    DECIMAL(10,2),
    marca_id				INT REFERENCES marcas(marca_id)
);
-- postgresql aceita NUMERIC ao invés de DECIMAL


CREATE TABLE fornecedores (
    forn_id		INT AUTO_INCREMENT PRIMARY KEY,
    -- forn_id     SERIAL PRIMARY KEY, -- postgresql
    -- forn_id     INT IDENTITY PRIMARY KEY, -- sqlserver, padrão (1,1)
    forn_nome	VARCHAR(50) NOT NULL,
    forn_email	VARCHAR(50)
);


CREATE TABLE produto_fornecedor (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    -- id          SERIAL PRIMARY KEY, -- postgresql
    -- id          INT IDENTITY PRIMARY KEY, -- sqlserver, padrão (1,1)
    prod_id	    INT NOT NULL REFERENCES produtos(prod_id),
    forn_id     INT NOT NULL REFERENCES fornecedores(forn_id)
);


INSERT INTO fornecedores VALUES
-- INSERT INTO fornecedores(forn_nome, forn_email) VALUES -- sqlserver precisa declarar os VALUES e remover o NULL
    -- postgresql usa DEFAULT ao invés de NULL
    -- mysql aceita valores com aspas duplas
    (NULL, 'Los Pollos Hermanos'       ,'frig@pollos.com.mx'),
    (NULL, 'Umbrella Corporation'      ,'umbrella@umbrella.com.ca'),
    (NULL, 'UAC'                       ,'uac@uac.com.mars.dm'),
    (NULL, 'Huey Materiais Escolares'  ,'huey@duck.com.us'),
    (NULL, 'Dewey Materiais Escolares' ,'dewey@duck.com.us'),
    (NULL, 'Louie Materiais Escolares' ,'louie@duck.com.us'),
    (NULL, 'New Informática'           ,'ni@newinf.com.br'),
    (NULL, 'Meio Bit TI'               ,'meiobit@bitbit.com.br'),
    (NULL, 'Ze Faisca SA'              ,'ze@faisca.com.br'),
    (NULL, 'Facens'                    ,'facens@facens.com.br'),
    (NULL, 'Linux'                     ,'linux@linux.br')
;


INSERT INTO marcas VALUES
-- INSERT INTO marcas (marca_nome, marca_origem) VALUES -- sqlserver precisa declarar os VALUES e remover o NULL
    -- postgresql usa DEFAULT ao invés de NULL
    -- mysql aceita valores com aspas duplas
    (NULL, 'Faber Castel'   , 'Brasil'),
    (NULL, 'Labra'		    , 'Brasil'),
    (NULL, 'TOTVS'  	    , 'Brasil'),
    (NULL, 'Multilaser'	    , 'Brasil'),
    (NULL, 'ORCACLE'		, 'EUA'),
    (NULL, 'IBM'			, 'EUA'),
    (NULL, 'Microsoft'	    , 'EUA'),
    (NULL, 'HP'			    , 'EUA'),
    (NULL, 'Apple'		    , 'EUA'),
    (NULL, 'SAP'			, 'Alemanha'),
    (NULL, 'Lenovo'		    , 'China'),
    (NULL, 'ASUS'		    , 'Taiwan'),
    (NULL, 'AOC'			, 'Taiwan'),
    (NULL, 'LG'			    , 'Corea do Sul')
;


INSERT INTO produtos VALUES
-- INSERT INTO produtos (prod_nome, prod_qtd_estoque, prod_estoque_min, prod_data_fabricacao, prod_perecivel, prod_valor, marca_id) VALUES -- sqlserver precisa declarar os VALUES e remover o NULL
    -- postgresql usa DEFAULT ao invés de NULL
    -- mysql aceita valores com aspas duplas
    -- sqlserver usa 0 e 1 ao invés de false e true
    (NULL, 'lapis'				, 4502, 100, '2016-3-3', false, 002.5, 1),
    (NULL, 'lapis'				, 8800, 100, '2015-5-5', false, 014.0, 2),
    (NULL, 'borracha'			, 2907, 100, '2013-7-8', false, 004.2, 1),
    (NULL, 'borracha'			, 5408, 100, '2015-8-2', false, 002.0, 2),
    (NULL, 'caderno'			, 7004, 100, '2016-3-4', false, 022.5, 1),
    (NULL, 'caneta'				, 8030, 100, '2013-2-4', false, 011.0, 1),
    (NULL, 'ERP'				, 0060, 100, '2016-5-7', false, 937.5, 3),
    (NULL, 'ERP'				, 3070, 100, '2014-6-5', false, 472.0, 4),
    (NULL, 'ERP'				, 2083, 100, '2015-8-4', false, 252.0, 5),
    (NULL, 'Windows'			, 5040, 100, '2012-9-2', false, 532.0, 7),
    (NULL, 'IOS'				, 6020, 100, '2014-3-3', false, 756.5, 9),
    (NULL, 'teclado'			, 7030, 100, '2016-5-8', false, 412.5, 4),
    (NULL, 'teclado'			, 0024, 100, '2013-4-7', false, 172.5, 11),
    (NULL, 'teclado'			, 9070, 100, '2015-5-4', false, 192.0, 8),
    (NULL, 'mouse'				, 1303, 100, '2016-7-3', false, 142.0, 4),
    (NULL, 'mouse'				, 3050, 100, '2013-9-2', false, 122.5, 8),
    (NULL, 'mouse'				, 0007, 100, '2012-3-7', false, 152.0, 7),
    (NULL, 'Pendrive'			, 6070, 100, '2014-5-6', false, 172.0, 4),
    (NULL, 'CD'					, 8080, 100, '2015-6-4', false, 012.5, 4),
    (NULL, 'Monitor'			, 9040, 100, '2016-5-2', false, 332.0, 8),
    (NULL, 'Monitor'			, 0001, 100, '2013-3-6', false, 172.0, 11),
    (NULL, 'Monitor'			, 2300, 100, '2015-2-5', false, 312.5, 14),
    (NULL, 'Monitor'			, 6620, 100, '2014-3-3', false, 272.0, 6),
    (NULL, 'Joystick'			, 0063, 100, '2014-5-7', false, 152.0, 4),
    (NULL, 'Módulo de memória'	, 7230, 100, '2013-6-8', false, 512.5, 6),
    (NULL, 'Módulo de memória'	, 9032, 100, '2013-7-8', false, 612.0, 12),
    (NULL, 'Processador'		, 4509, 100, '2016-8-6', false, 282.5, 6),
    (NULL, 'Placa de Vídeo'		, 2408, 100, '2015-3-5', false, 152.0, 6),
    (NULL, 'Placa de Vídeo'		, 0066, 100, '2012-2-3', false, 612.5, 13),
    (NULL, 'Fonte de Energia'	, 9044, 100, '2013-5-2', false, 112.0, 4),
    (NULL, 'Fonte de Energia'	, 4054, 100, '2014-7-3', false, 012.5, 8),
    (NULL, 'HD externo'			, 0400, 100, '2016-8-4', false, 412.5, 14),
    (NULL, 'mesa'				, 0240, 100, '2014-4-8', false, 632.5, NULL),
    (NULL, 'cadeira'			, 0490, 100, '2012-3-7', false, 342.0, NULL),
    (NULL, 'rack'				, 0030, 100, '2013-2-6', false, 262.0, NULL),
    (NULL, 'armario'			, 0404, 100, '2012-5-4', false, 412.5, NULL),
    (NULL, 'pera'				, 0069, 100, '2014-7-6', true , 612.0, NULL),
    (NULL, 'maça'				, 0020, 100, '2015-3-5', true , 716.8, NULL),
    (NULL, 'banana'				, 0081, 100, '2016-5-8', true , 512.0, NULL)
;


INSERT INTO produto_fornecedor VALUES
-- INSERT INTO produto_fornecedor (prod_id, forn_id) VALUES -- sqlserver precisa declarar os VALUES e remover o NULL
    -- postgresql usa DEFAULT ao invés de NULL
    (NULL, 1,1),
    (NULL, 4,1)
;


SELECT prod_id, prod_nome, prod_valor
-- SELECT TOP 10 prod_id, prod_nome, prod_valor -- sqlserver
    FROM produtos
    ORDER BY prod_valor DESC
    LIMIT 10; -- sqlserver usa TOP junto do SELECT

CREATE VIEW Top10MaisCaros AS
    SELECT prod_id, prod_nome, prod_valor
    -- SELECT TOP 10 prod_id, prod_nome, prod_valor -- sqlserver
    FROM produtos
    ORDER BY prod_valor DESC
    LIMIT 10; -- sqlserver usa TOP junto do SELECT

SELECT * FROM Top10MaisCaros;


CREATE OR REPLACE VIEW produtos_marcas AS -- sqlserver não aceita 'OR REPLACE'
    SELECT
    -- SELECT TOP 100 PERCENT -- sqlserver usa TOP 100% das linhas, para usar 'ORDER BY'
        prod_nome "Nome do Produto", -- aspas duplas obrigatórias no postgresql
        marca_nome "Marca",
        prod_valor "Preço",
        prod_qtd_estoque "Estoque",
        marca_origem "Origem",
        CASE
            -- sqlserver usa 0 e 1 ao invés de false e true
            WHEN prod_perecivel = false THEN 'NÃO'
            WHEN prod_perecivel = true THEN 'SIM'
        END
        AS "Perecível" -- 'AS' é opcional no mysql
    FROM
        produtos LEFT JOIN marcas
            ON produtos.marca_id = marcas.marca_id
    ORDER BY prod_nome; -- sqlserver só aceita 'ORDER BY' em VIEWS se usado junto com TOP, OFFSET ou FOR XML

SELECT * FROM produtos_marcas;

SELECT * FROM produtos_marcas WHERE "Preço" < 100; --mysql aceita "Preço" sem aspas



-- Exercícios


-- Crie uma view que mostra todos os produtos e suas respectivas marcas

CREATE OR REPLACE VIEW produtos_com_marcas AS -- sqlserver não aceita 'OR REPLACE'
    SELECT 
    -- SELECT TOP 100 PERCENT -- sqlserver usa TOP 100% das linhas, para usar 'ORDER BY'
        prod_nome "Nome do Produto", -- aspas duplas obrigatórias no postgresql p/ nome das colunas
        marca_nome "Marca",
        prod_qtd_estoque "Estoque",
        prod_estoque_min "Estoque mínimo",
        prod_data_fabricacao "Data de fabricação",
        CASE
            -- sqlserver usa 0 e 1 ao invés de false e true
            WHEN prod_perecivel = false THEN 'NÃO'
            WHEN prod_perecivel = true THEN 'SIM'
        END
        AS "Perecível", -- 'AS' é opcional no mysql
        prod_valor "Valor"
    FROM 
        produtos JOIN marcas
            ON produtos.marca_id = marcas.marca_id
    ORDER BY prod_nome; -- sqlserver só aceita 'ORDER BY' em VIEWS se usado junto com TOP, OFFSET ou FOR XML

SELECT * FROM produtos_com_marcas;


-- Crie uma view que mostra todos os produtos e seus respectivos fornecedores.

CREATE OR REPLACE VIEW produtos_com_fornecedores AS -- sqlserver não aceita 'OR REPLACE'
    SELECT
    -- SELECT TOP 100 PERCENT -- sqlserver usa TOP 100% das linhas, para usar 'ORDER BY'
        prod_nome "Nome", -- aspas duplas obrigatórias no postgresql p/ nome das colunas
        forn_nome "Fornecedor",
        forn_email "E-mail fornecedor"
    FROM produtos
        JOIN produto_fornecedor
            ON produtos.prod_id = produto_fornecedor.prod_id
        JOIN fornecedores
            ON produto_fornecedor.forn_id = fornecedores.forn_id
    ORDER BY prod_nome; -- sqlserver só aceita 'ORDER BY' em VIEWS se usado junto com TOP, OFFSET ou FOR XML

SELECT * FROM produtos_com_fornecedores;


-- Crie uma view que mostra todos os produtos e seus respectivos fornecedores e marcas.

CREATE OR REPLACE VIEW produtos_com_fornecedores_e_marcas AS -- sqlserver não aceita 'OR REPLACE'
    SELECT
    -- SELECT TOP 100 PERCENT -- sqlserver usa TOP 100% das linhas, para usar 'ORDER BY'
        p.prod_nome "Nome", -- aspas duplas obrigatórias no postgresql p/ nome das colunas
        m.marca_nome "Marca",
        f.forn_nome "Fornecedor",
        f.forn_email "E-mail fornecedor"
    FROM produtos p
        JOIN produto_fornecedor pf
            ON p.prod_id = pf.prod_id
        JOIN fornecedores f
            ON pf.forn_id = f.forn_id
        JOIN marcas m 
            ON p.marca_id = m.marca_id
    ORDER BY prod_nome; -- sqlserver só aceita 'ORDER BY' em VIEWS se usado junto com TOP, OFFSET ou FOR XML

SELECT * FROM produtos_com_fornecedores_e_marcas;


-- Crie uma view que mostra todos os produtos com estoque abaixo do mínimo.


CREATE OR REPLACE VIEW produtos_com_estoque_minimo AS -- sqlserver não aceita 'OR REPLACE'
    SELECT 
    -- SELECT TOP 100 PERCENT -- sqlserver usa TOP 100% das linhas, para usar 'ORDER BY'
        prod_nome "Nome", -- aspas duplas obrigatórias no postgresql p/ nome das colunas
        prod_qtd_estoque "Quantidade",
        prod_estoque_min "Estoque mínimo",
        prod_data_fabricacao "Data de fabricação",
        CASE
            -- sqlserver usa 0 e 1 ao invés de false e true
            WHEN prod_perecivel = false THEN 'NÃO'
            WHEN prod_perecivel = true THEN 'SIM'
        END
        AS "Perecível", -- 'AS' é opcional no mysql
        prod_valor "Valor"
    FROM produtos
    WHERE prod_qtd_estoque < prod_estoque_min
    ORDER BY prod_qtd_estoque; -- sqlserver só aceita 'ORDER BY' em VIEWS se usado junto com TOP, OFFSET ou FOR XML

SELECT * FROM produtos_com_estoque_minimo;
