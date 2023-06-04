DROP DATABASE IF EXISTS Loja;
CREATE DATABASE Loja;

CREATE TABLE marcas (
	marca_id        SERIAL PRIMARY KEY,
	-- marca_id        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY(10,2), -- especificar valores iniciais e incremental; padrão (1,1)
	marca_nome 		VARCHAR(50) NOT NULL,
	marca_origem	VARCHAR(50)
);

CREATE TABLE produtos (
	prod_id                 SERIAL PRIMARY KEY,
	prod_nome			    VARCHAR(50) NOT NULL,
	prod_qtd_estoque		INT NOT NULL DEFAULT 0,
	prod_estoque_min		INT NOT NULL DEFAULT 0,
	prod_data_fabricacao    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	prod_perecivel		    BOOLEAN,
	prod_valor			    DECIMAL(10,2),
	marca_id				INT REFERENCES marcas(marca_id)
);

CREATE TABLE fornecedores (
	forn_id     SERIAL PRIMARY KEY,
	forn_nome	VARCHAR(50) NOT NULL,
	forn_email	VARCHAR(50)
);

CREATE TABLE produto_fornecedor (
	id          SERIAL PRIMARY KEY,
	prod_id	    INT NOT NULL REFERENCES produtos(prod_id),
	forn_id     INT NOT NULL REFERENCES fornecedores(forn_id)
);

INSERT INTO fornecedores VALUES
	(DEFAULT, 'Los Pollos Hermanos'       ,'frig@pollos.com.mx'),
	(DEFAULT, 'Umbrella Corporation'      ,'umbrella@umbrella.com.ca'),
	(DEFAULT, 'UAC'                       ,'uac@uac.com.mars.dm'),
	(DEFAULT, 'Huey Materiais Escolares'  ,'huey@duck.com.us'),
	(DEFAULT, 'Dewey Materiais Escolares' ,'dewey@duck.com.us'),
	(DEFAULT, 'Louie Materiais Escolares' ,'louie@duck.com.us'),
	(DEFAULT, 'New Informática'           ,'ni@newinf.com.br'),
	(DEFAULT, 'Meio Bit TI'               ,'meiobit@bitbit.com.br'),
	(DEFAULT, 'Ze Faisca SA'              ,'ze@faisca.com.br'),
	(DEFAULT, 'Facens'                    ,'facens@facens.com.br'),
	(DEFAULT, 'Linux'                     ,'linux@linux.br')
;

INSERT INTO marcas VALUES
	(DEFAULT, 'Faber Castel'    , 'Brasil'),
	(DEFAULT, 'Labra'		    , 'Brasil'),
	(DEFAULT, 'TOTVS'  	        , 'Brasil'),
	(DEFAULT, 'Multilaser'	    , 'Brasil'),
	(DEFAULT, 'ORCACLE'		    , 'EUA'),
	(DEFAULT, 'IBM'			    , 'EUA'),
	(DEFAULT, 'Microsoft'	    , 'EUA'),
	(DEFAULT, 'HP'			    , 'EUA'),
	(DEFAULT, 'Apple'		    , 'EUA'),
	(DEFAULT, 'SAP'			    , 'Alemanha'),
	(DEFAULT, 'Lenovo'		    , 'China'),
	(DEFAULT, 'ASUS'		    , 'Taiwan'),
	(DEFAULT, 'AOC'			    , 'Taiwan'),
	(DEFAULT, 'LG'			    , 'Corea do Sul')
;

INSERT INTO produtos VALUES
	(DEFAULT, 'lapis'				, 4502, 100, '2016-3-3', false, 002.5, 1),
	(DEFAULT, 'lapis'				, 8800, 100, '2015-5-5', false, 014.0, 2),
	(DEFAULT, 'borracha'			, 2907, 100, '2013-7-8', false, 004.2, 1),
	(DEFAULT, 'borracha'			, 5408, 100, '2015-8-2', false, 002.0, 2),
	(DEFAULT, 'caderno'			    , 7004, 100, '2016-3-4', false, 022.5, 1),
	(DEFAULT, 'caneta'				, 8030, 100, '2013-2-4', false, 011.0, 1),
	(DEFAULT, 'ERP'				    , 0060, 100, '2016-5-7', false, 937.5, 3),
	(DEFAULT, 'ERP'				    , 3070, 100, '2014-6-5', false, 472.0, 4),
	(DEFAULT, 'ERP'				    , 2083, 100, '2015-8-4', false, 252.0, 5),
	(DEFAULT, 'Windows'			    , 5040, 100, '2012-9-2', false, 532.0, 7),
	(DEFAULT, 'IOS'				    , 6020, 100, '2014-3-3', false, 756.5, 9),
	(DEFAULT, 'teclado'			    , 7030, 100, '2016-5-8', false, 412.5, 4),
	(DEFAULT, 'teclado'			    , 0024, 100, '2013-4-7', false, 172.5, 11),
	(DEFAULT, 'teclado'			    , 9070, 100, '2015-5-4', false, 192.0, 8),
	(DEFAULT, 'mouse'				, 1303, 100, '2016-7-3', false, 142.0, 4),
	(DEFAULT, 'mouse'				, 3050, 100, '2013-9-2', false, 122.5, 8),
	(DEFAULT, 'mouse'				, 0007, 100, '2012-3-7', false, 152.0, 7),
	(DEFAULT, 'Pendrive'			, 6070, 100, '2014-5-6', false, 172.0, 4),
	(DEFAULT, 'CD'					, 8080, 100, '2015-6-4', false, 012.5, 4),
	(DEFAULT, 'Monitor'			    , 9040, 100, '2016-5-2', false, 332.0, 8),
	(DEFAULT, 'Monitor'			    , 0001, 100, '2013-3-6', false, 172.0, 11),
	(DEFAULT, 'Monitor'			    , 2300, 100, '2015-2-5', false, 312.5, 14),
	(DEFAULT, 'Monitor'			    , 6620, 100, '2014-3-3', false, 272.0, 6),
	(DEFAULT, 'Joystick'			, 0063, 100, '2014-5-7', false, 152.0, 4),
	(DEFAULT, 'Módulo de memória'	, 7230, 100, '2013-6-8', false, 512.5, 6),
	(DEFAULT, 'Módulo de memória'	, 9032, 100, '2013-7-8', false, 612.0, 12),
	(DEFAULT, 'Processador'		    , 4509, 100, '2016-8-6', false, 282.5, 6),
	(DEFAULT, 'Placa de Vídeo'		, 2408, 100, '2015-3-5', false, 152.0, 6),
	(DEFAULT, 'Placa de Vídeo'		, 0066, 100, '2012-2-3', false, 612.5, 13),
	(DEFAULT, 'Fonte de Energia'	, 9044, 100, '2013-5-2', false, 112.0, 4),
	(DEFAULT, 'Fonte de Energia'	, 4054, 100, '2014-7-3', false, 012.5, 8),
	(DEFAULT, 'HD externo'			, 0400, 100, '2016-8-4', false, 412.5, 14),
	(DEFAULT, 'mesa'				, 0240, 100, '2014-4-8', false, 632.5, NULL),
	(DEFAULT, 'cadeira'			    , 0490, 100, '2012-3-7', false, 342.0, NULL),
	(DEFAULT, 'rack'				, 0030, 100, '2013-2-6', false, 262.0, NULL),
	(DEFAULT, 'armario'			    , 0404, 100, '2012-5-4', false, 412.5, NULL),
	(DEFAULT, 'pera'				, 0069, 100, '2014-7-6', true , 612.0, NULL),
	(DEFAULT, 'maça'				, 0020, 100, '2015-3-5', true , 716.8, NULL),
	(DEFAULT, 'banana'				, 0081, 100, '2016-5-8', true , 512.0, NULL)
;

INSERT INTO produto_fornecedor VALUES
	(DEFAULT, 1,1),
	(DEFAULT, 4,1)
;

SELECT prod_id, prod_nome, prod_valor
	FROM produtos
	ORDER BY prod_valor DESC
	LIMIT 10;

CREATE VIEW Top10MaisCaros AS
	SELECT prod_id, prod_nome, prod_valor
	FROM produtos
	ORDER BY prod_valor DESC
	LIMIT 10;

SELECT * FROM Top10MaisCaros;

CREATE OR REPLACE VIEW produtos_marcas AS
	SELECT
		prod_nome "Nome do Produto", -- aspas duplas obrigatórias
		marca_nome "Marca",
		prod_valor "Preço",
		prod_qtd_estoque "Estoque",
		marca_origem "Origem",
		CASE
			WHEN prod_perecivel = false THEN 'NÃO'
			WHEN prod_perecivel = true THEN 'SIM'
		END
		AS "Perecível"
	FROM
		produtos LEFT JOIN marcas
			ON produtos.marca_id = marcas.marca_id
	ORDER BY prod_nome;

SELECT * FROM produtos_marcas;

SELECT * FROM produtos_marcas WHERE "Preço" < 100;



-- Exercícios


-- Crie uma view que mostra todos os produtos e suas respectivas marcas

CREATE OR REPLACE VIEW produtos_com_marcas AS
	SELECT
		prod_nome "Nome do Produto", -- aspas duplas obrigatórias
		marca_nome "Marca",
		prod_qtd_estoque "Estoque",
		prod_estoque_min "Estoque mínimo",
		prod_data_fabricacao "Data de fabricação",
		CASE
			WHEN prod_perecivel = false THEN 'NÃO'
			WHEN prod_perecivel = true THEN 'SIM'
		END
		AS "Perecível",
		prod_valor "Valor"
	FROM
		produtos JOIN marcas
			ON produtos.marca_id = marcas.marca_id
	ORDER BY prod_nome;

SELECT * FROM produtos_com_marcas;


-- Crie uma view que mostra todos os produtos e seus respectivos fornecedores.

CREATE OR REPLACE VIEW produtos_com_fornecedores AS
	SELECT
		prod_nome "Nome", -- aspas duplas obrigatórias
		forn_nome "Fornecedor",
		forn_email "E-mail fornecedor"
	FROM produtos
		JOIN produto_fornecedor
			ON produtos.prod_id = produto_fornecedor.prod_id
		JOIN fornecedores
			ON produto_fornecedor.forn_id = fornecedores.forn_id
	ORDER BY prod_nome;

SELECT * FROM produtos_com_fornecedores;


-- Crie uma view que mostra todos os produtos e seus respectivos fornecedores e marcas.

CREATE OR REPLACE VIEW produtos_com_fornecedores_e_marcas AS
	SELECT
		p.prod_nome "Nome", -- aspas duplas obrigatórias
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
	ORDER BY prod_nome;

SELECT * FROM produtos_com_fornecedores_e_marcas;


-- Crie uma view que mostra todos os produtos com estoque abaixo do mínimo.

CREATE OR REPLACE VIEW produtos_com_estoque_minimo AS
	SELECT
		prod_nome "Nome", -- aspas duplas obrigatórias
		prod_qtd_estoque "Quantidade",
		prod_estoque_min "Estoque mínimo",
		prod_data_fabricacao "Data de fabricação",
		CASE
			WHEN prod_perecivel = false THEN 'NÃO'
			WHEN prod_perecivel = true THEN 'SIM'
		END
		AS "Perecível",
		prod_valor "Valor"
	FROM produtos
	WHERE prod_qtd_estoque < prod_estoque_min
	ORDER BY prod_qtd_estoque;

SELECT * FROM produtos_com_estoque_minimo;
