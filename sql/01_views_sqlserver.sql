DROP DATABASE IF EXISTS Loja;
CREATE DATABASE Loja;
USE Loja;

CREATE TABLE marcas (
	marca_id        INT IDENTITY PRIMARY KEY, -- padrão (1,1)
	marca_nome 		VARCHAR(50) NOT NULL,
	marca_origem	VARCHAR(50)
);

CREATE TABLE produtos (
	prod_id                 INT IDENTITY PRIMARY KEY,
	prod_nome			    VARCHAR(50) NOT NULL,
	prod_qtd_estoque		INT NOT NULL DEFAULT 0,
	prod_estoque_min		INT NOT NULL DEFAULT 0,
	prod_data_fabricacao    DATETIME DEFAULT GETDATE(),
	prod_perecivel          BIT, -- valores 0 e 1
	prod_valor			    DECIMAL(10,2),
	marca_id				INT REFERENCES marcas(marca_id)
);

CREATE TABLE fornecedores (
	forn_id     INT IDENTITY PRIMARY KEY,
	forn_nome	VARCHAR(50) NOT NULL,
	forn_email	VARCHAR(50)
);

CREATE TABLE produto_fornecedor (
	id          INT IDENTITY PRIMARY KEY,
	prod_id	    INT NOT NULL REFERENCES produtos(prod_id),
	forn_id     INT NOT NULL REFERENCES fornecedores(forn_id)
);

INSERT INTO fornecedores(forn_nome, forn_email) VALUES
	('Los Pollos Hermanos'       ,'frig@pollos.com.mx'),
	('Umbrella Corporation'      ,'umbrella@umbrella.com.ca'),
	('UAC'                       ,'uac@uac.com.mars.dm'),
	('Huey Materiais Escolares'  ,'huey@duck.com.us'),
	('Dewey Materiais Escolares' ,'dewey@duck.com.us'),
	('Louie Materiais Escolares' ,'louie@duck.com.us'),
	('New Informática'           ,'ni@newinf.com.br'),
	('Meio Bit TI'               ,'meiobit@bitbit.com.br'),
	('Ze Faisca SA'              ,'ze@faisca.com.br'),
	('Facens'                    ,'facens@facens.com.br'),
	('Linux'                     ,'linux@linux.br')
;

INSERT INTO marcas (marca_nome, marca_origem) VALUES -- sqlserver precisa declarar os VALUES e remover o NULL
	('Faber Castel' , 'Brasil'),
	('Labra'		, 'Brasil'),
	('TOTVS'  	    , 'Brasil'),
	('Multilaser'	, 'Brasil'),
	('ORCACLE'		, 'EUA'),
	('IBM'			, 'EUA'),
	('Microsoft'	, 'EUA'),
	('HP'			, 'EUA'),
	('Apple'		, 'EUA'),
	('SAP'			, 'Alemanha'),
	('Lenovo'		, 'China'),
	('ASUS'		    , 'Taiwan'),
	('AOC'			, 'Taiwan'),
	('LG'			, 'Corea do Sul')
;

INSERT INTO produtos (prod_nome, prod_qtd_estoque, prod_estoque_min, prod_data_fabricacao, prod_perecivel, prod_valor, marca_id) VALUES
	('lapis'				, 4502, 100, '2016-3-3', 0, 002.5, 1),
	('lapis'				, 8800, 100, '2015-5-5', 0, 014.0, 2),
	('borracha'			    , 2907, 100, '2013-7-8', 0, 004.2, 1),
	('borracha'			    , 5408, 100, '2015-8-2', 0, 002.0, 2),
	('caderno'			    , 7004, 100, '2016-3-4', 0, 022.5, 1),
	('caneta'				, 8030, 100, '2013-2-4', 0, 011.0, 1),
	('ERP'				    , 0060, 100, '2016-5-7', 0, 937.5, 3),
	('ERP'				    , 3070, 100, '2014-6-5', 0, 472.0, 4),
	('ERP'				    , 2083, 100, '2015-8-4', 0, 252.0, 5),
	('Windows'			    , 5040, 100, '2012-9-2', 0, 532.0, 7),
	('IOS'				    , 6020, 100, '2014-3-3', 0, 756.5, 9),
	('teclado'			    , 7030, 100, '2016-5-8', 0, 412.5, 4),
	('teclado'			    , 0024, 100, '2013-4-7', 0, 172.5, 11),
	('teclado'			    , 9070, 100, '2015-5-4', 0, 192.0, 8),
	('mouse'				, 1303, 100, '2016-7-3', 0, 142.0, 4),
	('mouse'				, 3050, 100, '2013-9-2', 0, 122.5, 8),
	('mouse'				, 0007, 100, '2012-3-7', 0, 152.0, 7),
	('Pendrive'			    , 6070, 100, '2014-5-6', 0, 172.0, 4),
	('CD'					, 8080, 100, '2015-6-4', 0, 012.5, 4),
	('Monitor'				, 9040, 100, '2016-5-2', 0, 332.0, 8),
	('Monitor'				, 0001, 100, '2013-3-6', 0, 172.0, 11),
	('Monitor'			    , 2300, 100, '2015-2-5', 0, 312.5, 14),
	('Monitor'			    , 6620, 100, '2014-3-3', 0, 272.0, 6),
	('Joystick'			    , 0063, 100, '2014-5-7', 0, 152.0, 4),
	('Módulo de memória'	, 7230, 100, '2013-6-8', 0, 512.5, 6),
	('Módulo de memória'	, 9032, 100, '2013-7-8', 0, 612.0, 12),
	('Processador'		    , 4509, 100, '2016-8-6', 0, 282.5, 6),
	('Placa de Vídeo'		, 2408, 100, '2015-3-5', 0, 152.0, 6),
	('Placa de Vídeo'		, 0066, 100, '2012-2-3', 0, 612.5, 13),
	('Fonte de Energia'	    , 9044, 100, '2013-5-2', 0, 112.0, 4),
	('Fonte de Energia'	    , 4054, 100, '2014-7-3', 0, 012.5, 8),
	('HD externo'			, 0400, 100, '2016-8-4', 0, 412.5, 14),
	('mesa'				    , 0240, 100, '2014-4-8', 0, 632.5, NULL),
	('cadeira'			    , 0490, 100, '2012-3-7', 0, 342.0, NULL),
	('rack'				    , 0030, 100, '2013-2-6', 0, 262.0, NULL),
	('armario'			    , 0404, 100, '2012-5-4', 0, 412.5, NULL),
	('pera'				    , 0069, 100, '2014-7-6', 1 , 612.0, NULL),
	('maça'				    , 0020, 100, '2015-3-5', 1 , 716.8, NULL),
	('banana'				, 0081, 100, '2016-5-8', 1 , 512.0, NULL)
;

INSERT INTO produto_fornecedor (prod_id, forn_id) VALUES
	(1,1),
	(4,1)
;

SELECT TOP 10 prod_id, prod_nome, prod_valor -- sqlserver
	FROM produtos
	ORDER BY prod_valor DESC;

CREATE VIEW Top10MaisCaros AS
	SELECT TOP 10 prod_id, prod_nome, prod_valor -- sqlserver
	FROM produtos
	ORDER BY prod_valor DESC;

SELECT * FROM Top10MaisCaros;

CREATE VIEW produtos_marcas AS
	SELECT TOP 100 PERCENT -- sqlserver usa TOP 100% das linhas, para usar 'ORDER BY'
		prod_nome "Nome do Produto",
		marca_nome "Marca",
		prod_valor "Preço",
		prod_qtd_estoque "Estoque",
		marca_origem "Origem",
		CASE
			WHEN prod_perecivel = 0 THEN 'NÃO'
			WHEN prod_perecivel = 1 THEN 'SIM'
		END
		AS "Perecível"
	FROM
		produtos LEFT JOIN marcas
			ON produtos.marca_id = marcas.marca_id
	ORDER BY prod_nome; -- sqlserver só aceita 'ORDER BY' em VIEWS se usado junto com TOP, OFFSET ou FOR XML

SELECT * FROM produtos_marcas;

SELECT * FROM produtos_marcas WHERE "Preço" < 100;



-- Exercícios


-- Crie uma view que mostra todos os produtos e suas respectivas marcas

CREATE VIEW produtos_com_marcas AS
	SELECT TOP 100 PERCENT -- sqlserver usa TOP 100% das linhas, para usar 'ORDER BY'
		prod_nome "Nome do Produto",
		marca_nome "Marca",
		prod_qtd_estoque "Estoque",
		prod_estoque_min "Estoque mínimo",
		prod_data_fabricacao "Data de fabricação",
		CASE
			WHEN prod_perecivel = 0 THEN 'NÃO'
			WHEN prod_perecivel = 1 THEN 'SIM'
		END
		AS "Perecível",
		prod_valor "Valor"
	FROM
		produtos JOIN marcas
			ON produtos.marca_id = marcas.marca_id
	ORDER BY prod_nome; -- sqlserver só aceita 'ORDER BY' em VIEWS se usado junto com TOP, OFFSET ou FOR XML

SELECT * FROM produtos_com_marcas;


-- Crie uma view que mostra todos os produtos e seus respectivos fornecedores.

CREATE VIEW produtos_com_fornecedores AS
	SELECT TOP 100 PERCENT -- sqlserver usa TOP 100% das linhas, para usar 'ORDER BY'
		prod_nome "Nome",
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

CREATE VIEW produtos_com_fornecedores_e_marcas AS
	SELECT TOP 100 PERCENT -- sqlserver usa TOP 100% das linhas, para usar 'ORDER BY'
		p.prod_nome "Nome",
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

CREATE VIEW produtos_com_estoque_minimo AS
	SELECT TOP 100 PERCENT -- sqlserver usa TOP 100% das linhas, para usar 'ORDER BY'
		prod_nome "Nome",
		prod_qtd_estoque "Quantidade",
		prod_estoque_min "Estoque mínimo",
		prod_data_fabricacao "Data de fabricação",
		CASE
			WHEN prod_perecivel = 0 THEN 'NÃO'
			WHEN prod_perecivel = 1 THEN 'SIM'
		END
		AS "Perecível",
		prod_valor "Valor"
	FROM produtos
	WHERE prod_qtd_estoque < prod_estoque_min
	ORDER BY prod_qtd_estoque; -- sqlserver só aceita 'ORDER BY' em VIEWS se usado junto com TOP, OFFSET ou FOR XML

SELECT * FROM produtos_com_estoque_minimo;
