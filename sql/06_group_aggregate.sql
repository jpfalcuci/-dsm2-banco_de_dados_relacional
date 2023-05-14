-- mostra todos os valores em 'cor'
SELECT cor FROM Animais 
    GROUP BY cor 
    ORDER BY cor ASC;  -- valores únicos em 'cor'


-- quantos IDs estão associados a cada 'cor'
SELECT cor, COUNT(ID) AS quantidade FROM Animais
    GROUP BY cor 
    ORDER BY cor;


-- média de peso, por cores
SELECT cor, AVG(peso) AS media_peso FROM Animais
    GROUP BY cor
    ORDER BY cor;


-- somente média de peso > 15
SELECT cor, AVG(peso) FROM Animais
    GROUP BY cor
    HAVING AVG(peso) > 15;


-- soma de pesos por cor, ordenados
SELECT cor, SUM(peso) FROM Animais
    GROUP BY cor
    ORDER BY SUM(peso) DESC;


-- soma de pesos por nome (?), ordenados
SELECT nome, SUM(peso) FROM Animais
    GROUP BY nome
    ORDER BY SUM(peso) DESC;


-- menor e maior peso
SELECT MIN(peso) AS menor_peso FROM Animais;
SELECT MAX(peso) AS maior_peso FROM Animais;


-- seleção de uma faixa
SELECT * FROM Animais LIMIT 5;
SELECT TOP 5 * FROM Animais;            -- sqlserver
SELECT TOP 50 PERCENT * FROM Animais;   -- sqlserver



DROP DATABASE IF EXISTS Empresa;
CREATE DATABASE Empresa;
USE Empresa;

CREATE TABLE marcas (
	marca_id		INT 			AUTO_INCREMENT		PRIMARY KEY,
	-- marca_id		SERIAL			PRIMARY KEY, 						--postgresql
    -- marca_id		INT				IDENTITY			PRIMARY KEY,	-- sqlserver
	nome_marca		VARCHAR(50)		NOT NULL,			
	origem			VARCHAR(50)		
);

CREATE TABLE produtos (
	prod_id			INT 			AUTO_INCREMENT 		PRIMARY KEY,
	-- prod_id			SERIAL			PRIMARY KEY, 						--postgresql
    -- prod_id			INT				IDENTITY			PRIMARY KEY,	-- sqlserver
	nome_prod		VARCHAR(50)		NOT NULL,
	qtd_estoque		INT				NOT NULL 			DEFAULT 0,
	estoque_mim		INT 			NOT NULL			DEFAULT 0,
	data_fabricacao	TIMESTAMP 		DEFAULT NOW(),
	-- data_fabricacao	TIMESTAMP		DEFAULT CURRENT_TIMESTAMP, -- posgresql
    -- data_fabricacao	DATETIME		DEFAULT GETDATE(), -- sqlserver
	perecivel		BOOLEAN,
	-- perecivel		BIT, -- sqlserver, valores 0 e 1
	valor			DECIMAL(10,2),
	marca_id		INT				REFERENCES marcas(marca_id)
);
-- postgresql aceita NUMERIC ao invés de DECIMAL

CREATE TABLE fornecedores (
	forn_id			INT 			AUTO_INCREMENT 		PRIMARY KEY,
	-- forn_id			SERIAL			PRIMARY KEY, 						--postgresql
    -- forn_id			INT				IDENTITY			PRIMARY KEY,	-- sqlserver
	nome_forn		VARCHAR(50)		NOT NULL,
	email			VARCHAR(50)		
);

CREATE TABLE produto_fornecedor (
	prod_id			INT				NOT NULL	REFERENCES produtos(prod_id),
	forn_id			INT				NOT NULL	REFERENCES fornecedores(forn_id),
	PRIMARY KEY (prod_id, forn_id)
);

INSERT INTO fornecedores VALUES
-- INSERT INTO fornecedores(nome_forn, email) VALUES -- sqlserver, remover o NULL
    -- postgresql usa DEFAULT ao invés de NULL
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
-- INSERT INTO marcas (nome_marca, origem) VALUES -- sqlserver, remover o NULL
	-- postgresql usa DEFAULT ao invés de NULL
	(NULL, 'Faber Castel'	, 'Brasil'),
	(NULL, 'Labra'			, 'Brasil'),
	(NULL, 'TOTVS'  		, 'Brasil'),
	(NULL, 'Multilaser'		, 'Brasil'),
	(NULL, 'ORCACLE'		, 'EUA'),
	(NULL, 'IBM'			, 'EUA'),
	(NULL, 'Microsoft'		, 'EUA'),
	(NULL, 'HP'				, 'EUA'),
	(NULL, 'Apple'			, 'EUA'),
	(NULL, 'SAP'			, 'Alemanha'),
	(NULL, 'Lenovo'			, 'China'),
	(NULL, 'ASUS'			, 'Taiwan'),
	(NULL, 'AOC'			, 'Taiwan'),
	(NULL, 'LG'				, 'Corea do Sul')
;

INSERT INTO produtos VALUES
-- INSERT INTO produtos (nome_prod, qtd_estoque, estoque_mim, data_fabricacao, perecivel, valor, marca_id) VALUES -- sqlserver, remover o NULL
	-- sqlserver usa 0 e 1 ao invés de false e true
	-- postgresql usa DEFAULT ao invés de NULL
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
	(NULL, 'mesa'				, 0240, 100, '2014-4-8', false, 632.5, null),
	(NULL, 'cadeira'			, 0490, 100, '2012-3-7', false, 342.0, null),
	(NULL, 'rack'				, 0030, 100, '2013-2-6', false, 262.0, null),
	(NULL, 'armario'			, 0404, 100, '2012-5-4', false, 412.5, null),
	(NULL, 'pera'				, 0069, 100, '2014-7-6', true , 612.0, null),
	(NULL, 'maça'				, 0020, 100, '2015-3-5', true , 716.8, null),
	(NULL, 'banana'				, 0081, 100, '2016-5-8', true , 512.0, null)
;

INSERT INTO produto_fornecedor VALUES
	(1,1),
	(4,1)
;


-- Selecione quantos produtos cada marca possui.
SELECT m.nome_marca AS Marca, COUNT(p.marca_id) AS Qtd
    FROM produtos p JOIN marcas m
    	ON m.marca_id = p.marca_id
    GROUP BY m.nome_marca
    ORDER BY Qtd DESC;


-- Selecione o preço médio dos produtos de cada marca.
SELECT m.nome_marca AS Marca, ROUND(AVG(p.valor), 2) AS "Média de preço"
    FROM produtos p JOIN marcas m
    	ON m.marca_id = p.marca_id
    GROUP BY m.nome_marca
    ORDER BY AVG(p.valor);


-- Selecione a média dos preços e total em estoque dos produtos agrupados por marca.
SELECT m.nome_marca AS Marca, SUM(p.qtd_estoque) AS Estoque, ROUND(AVG(p.valor), 2) AS "Média de preço"
    FROM produtos p JOIN marcas m
    	ON m.marca_id = p.marca_id
    GROUP BY m.nome_marca
    ORDER BY Estoque DESC;


-- Selecione quantos produtos estão cadastrados.
SELECT COUNT(prod_id) AS "Total de produtos"
	FROM produtos;


-- Selecione o preço médio dos produtos.
SELECT ROUND(AVG(valor), 2) AS "Preço médio"
	FROM produtos;


-- Selecione a média dos preços dos produtos em 2 grupos: perecíveis e não perecíveis.
SELECT ROUND(AVG(valor), 2) AS "Preço médio",
	CASE
		-- sqlserver usa 0 e 1 ao invés de false e true
		WHEN perecivel = false THEN 'Não perecível'
		WHEN perecivel = true THEN 'Perecível'
	END
	AS Perecível
	FROM produtos
	GROUP BY Perecível;
	-- GROUP BY perecivel; -- sqlserver


-- Selecione a média dos preços dos produtos agrupados pelo nome do produto.
SELECT nome_prod AS Produto, ROUND(AVG(valor), 2) AS "Preço médio"
	FROM produtos
	GROUP BY Produto;
	-- GROUP BY nome_prod;  -- sqlserver


-- Selecione a média dos preços e total em estoque dos produtos.
SELECT ROUND(AVG(valor), 2) AS "Preço médio", COUNT(prod_id) AS "Total de produtos"
	FROM produtos;


-- Selecione o nome, marca e quantidade em estoque do produto mais caro.
SELECT p.nome_prod AS Produto, m.nome_marca AS Marca, p.qtd_estoque AS Estoque, p.valor AS Valor
	FROM produtos p 
		JOIN marcas m ON m.marca_id = p.marca_id
    	JOIN (SELECT MAX(valor) AS Maior FROM produtos) mv ON mv.Maior = Valor;


-- Selecione os produtos com preço acima da média.
SELECT p.nome_prod AS Produto, m.nome_marca AS Marca, p.qtd_estoque AS Estoque, p.valor AS Valor
	FROM produtos p 
		JOIN marcas m ON m.marca_id = p.marca_id
    	JOIN (SELECT AVG(valor) AS Média FROM produtos) mv ON Valor > mv.Média
    	ORDER BY Valor;


-- Selecione a quantidade de produtos de cada nacionalidade.
SELECT m.origem AS Nacionalidade, COUNT(m.origem) AS Qtd
	FROM produtos p JOIN marcas m 
		ON m.marca_id = p.marca_id
		GROUP BY Nacionalidade;
		-- GROUP BY m.origem; -- sqlserver
