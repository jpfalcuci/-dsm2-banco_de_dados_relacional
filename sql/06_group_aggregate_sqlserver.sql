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
SELECT TOP 5 * FROM Animais;
SELECT TOP 50 PERCENT * FROM Animais;


DROP DATABASE IF EXISTS Empresa;
CREATE DATABASE Empresa;
USE Empresa;

CREATE TABLE marcas (
	marca_id		INT				IDENTITY			PRIMARY KEY,
	nome_marca		VARCHAR(50)		NOT NULL,
	origem			VARCHAR(50)
);

CREATE TABLE produtos (
	prod_id			INT				IDENTITY			PRIMARY KEY,
	nome_prod		VARCHAR(50)		NOT NULL,
	qtd_estoque		INT				NOT NULL 			DEFAULT 0,
	estoque_mim		INT 			NOT NULL			DEFAULT 0,
	data_fabricacao	DATETIME		DEFAULT GETDATE(),
	perecivel		BIT, -- valores 0 e 1
	valor			DECIMAL(10,2),
	marca_id		INT				REFERENCES marcas(marca_id)
);

CREATE TABLE fornecedores (
	forn_id			INT				IDENTITY			PRIMARY KEY,
	nome_forn		VARCHAR(50)		NOT NULL,
	email			VARCHAR(50)
);

CREATE TABLE produto_fornecedor (
	prod_id			INT				NOT NULL	REFERENCES produtos(prod_id),
	forn_id			INT				NOT NULL	REFERENCES fornecedores(forn_id),
	PRIMARY KEY (prod_id, forn_id)
);

INSERT INTO fornecedores(nome_forn, email) VALUES
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

INSERT INTO marcas (nome_marca, origem) VALUES
	('Faber Castel'		, 'Brasil'),
	('Labra'			, 'Brasil'),
	('TOTVS'  			, 'Brasil'),
	('Multilaser'		, 'Brasil'),
	('ORCACLE'			, 'EUA'),
	('IBM'				, 'EUA'),
	('Microsoft'		, 'EUA'),
	('HP'				, 'EUA'),
	('Apple'			, 'EUA'),
	('SAP'				, 'Alemanha'),
	('Lenovo'			, 'China'),
	('ASUS'				, 'Taiwan'),
	('AOC'				, 'Taiwan'),
	('LG'				, 'Corea do Sul')
;

INSERT INTO produtos (nome_prod, qtd_estoque, estoque_mim, data_fabricacao, perecivel, valor, marca_id) VALUES
	('lapis'				, 4502, 100, '2016-3-3', 0, 002.5, 1),
	('lapis'				, 8800, 100, '2015-5-5', 0, 014.0, 2),
	('borracha'				, 2907, 100, '2013-7-8', 0, 004.2, 1),
	('borracha'				, 5408, 100, '2015-8-2', 0, 002.0, 2),
	('caderno'				, 7004, 100, '2016-3-4', 0, 022.5, 1),
	('caneta'				, 8030, 100, '2013-2-4', 0, 011.0, 1),
	('ERP'					, 0060, 100, '2016-5-7', 0, 937.5, 3),
	('ERP'					, 3070, 100, '2014-6-5', 0, 472.0, 4),
	('ERP'					, 2083, 100, '2015-8-4', 0, 252.0, 5),
	('Windows'				, 5040, 100, '2012-9-2', 0, 532.0, 7),
	('IOS'					, 6020, 100, '2014-3-3', 0, 756.5, 9),
	('teclado'				, 7030, 100, '2016-5-8', 0, 412.5, 4),
	('teclado'				, 0024, 100, '2013-4-7', 0, 172.5, 11),
	('teclado'				, 9070, 100, '2015-5-4', 0, 192.0, 8),
	('mouse'				, 1303, 100, '2016-7-3', 0, 142.0, 4),
	('mouse'				, 3050, 100, '2013-9-2', 0, 122.5, 8),
	('mouse'				, 0007, 100, '2012-3-7', 0, 152.0, 7),
	('Pendrive'				, 6070, 100, '2014-5-6', 0, 172.0, 4),
	('CD'					, 8080, 100, '2015-6-4', 0, 012.5, 4),
	('Monitor'				, 9040, 100, '2016-5-2', 0, 332.0, 8),
	('Monitor'				, 0001, 100, '2013-3-6', 0, 172.0, 11),
	('Monitor'				, 2300, 100, '2015-2-5', 0, 312.5, 14),
	('Monitor'				, 6620, 100, '2014-3-3', 0, 272.0, 6),
	('Joystick'				, 0063, 100, '2014-5-7', 0, 152.0, 4),
	('Módulo de memória'	, 7230, 100, '2013-6-8', 0, 512.5, 6),
	('Módulo de memória'	, 9032, 100, '2013-7-8', 0, 612.0, 12),
	('Processador'			, 4509, 100, '2016-8-6', 0, 282.5, 6),
	('Placa de Vídeo'		, 2408, 100, '2015-3-5', 0, 152.0, 6),
	('Placa de Vídeo'		, 0066, 100, '2012-2-3', 0, 612.5, 13),
	('Fonte de Energia'		, 9044, 100, '2013-5-2', 0, 112.0, 4),
	('Fonte de Energia'		, 4054, 100, '2014-7-3', 0, 012.5, 8),
	('HD externo'			, 0400, 100, '2016-8-4', 0, 412.5, 14),
	('mesa'					, 0240, 100, '2014-4-8', 0, 632.5, NULL),
	('cadeira'				, 0490, 100, '2012-3-7', 0, 342.0, NULL),
	('rack'					, 0030, 100, '2013-2-6', 0, 262.0, NULL),
	('armario'				, 0404, 100, '2012-5-4', 0, 412.5, NULL),
	('pera'					, 0069, 100, '2014-7-6', 1 , 612.0, NULL),
	('maça'					, 0020, 100, '2015-3-5', 1 , 716.8, NULL),
	('banana'				, 0081, 100, '2016-5-8', 1 , 512.0, NULL)
;

INSERT INTO produto_fornecedor VALUES
	(1,1),
	(4,1)
;



-- Exercícios


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
		WHEN perecivel = 0 THEN 'Não perecível'
		WHEN perecivel = 1 THEN 'Perecível'
	END
	AS Perecível
	FROM produtos
	GROUP BY perecivel;


-- Selecione a média dos preços dos produtos agrupados pelo nome do produto.
SELECT nome_prod AS Produto, ROUND(AVG(valor), 2) AS "Preço médio"
	FROM produtos
	GROUP BY nome_prod;


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
		GROUP BY m.origem;
