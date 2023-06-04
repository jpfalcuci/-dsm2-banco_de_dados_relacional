DROP DATABASE IF EXISTS PetShop;
CREATE DATABASE PetShop;
USE PetShop;

CREATE TABLE Especies (
	id              INT IDENTITY PRIMARY KEY,
	nome            VARCHAR(50) UNIQUE NOT NULL,
	alimentacao     VARCHAR(20)
);

CREATE TABLE Animais (
	id              INT IDENTITY PRIMARY KEY,
	nome            VARCHAR(50) NOT NULL,
	data_nasc       DATE NOT NULL,
	peso            DECIMAL(10,2) CHECK (peso > 0),
	cor             VARCHAR(50),
	especie_id      INT REFERENCES Especies(id)
);

INSERT INTO Especies (nome, alimentacao) VALUES
	('gato'       , 'carnívoro'),
	('cachorro'   , 'carnívoro'),
	('morcego'    , 'onívoro'),
	('rato'       , 'onívoro'),
	('ramister'   , 'herbívoro'),
	('baleia'     , 'carnívoro'),
	('sardinha'   , 'herbívoro'),
	('bacalhau'   , 'herbívoro'),
	('tubarão'    , 'carnívoro'),
	('lambari'    , 'herbívoro'),
	('corvina'    , 'herbívoro'),
	('iguana'     , 'herbívoro'),
	('camaleão'   , 'herbívoro'),
	('lagarto'    , 'herbívoro'),
	('cobra'      , 'carnívoro'),
	('cacatua'    , 'herbívoro'),
	('pardal'     , 'onívoro'),
	('bentevi'    , 'herbívoro'),
	('canario'    , 'herbívoro'),
	('virus'      , NULL),
	('bactéria'   , NULL)
;

INSERT INTO Especies (nome) VALUES
	('barata'),
	('carcará'),
	('polvo'),
	('nautilus')
;

INSERT INTO Animais (nome, data_nasc, peso, cor, especie_id) VALUES
	('ágata'          , '2015-4-9', 13.9, 'branco' , 1),
	('félix'          , '2016-6-6', 14.3, 'preto'  , 1),
	('tom'            , '2013-2-8', 11.2, 'azul'   , 1),
	('garfield'       , '2015-7-6', 17.1, 'laranja', 1),
	('frajola'        , '2013-8-1', 13.7, 'preto'  , 1),
	('manda-chuva'    , '2012-2-3', 12.3, 'amarelo' , 1),
	('snowball'       , '2014-4-6', 13.2, 'preto' , 1),
	('ágata'          , '2015-8-3', 11.9, 'azul'  , 1),
	('ágata'          , '2016-3-4', 18.6, 'roxo'  , 1),
	('gato de botas'  , '2012-12-10', 11.6, 'amarelo', 1),
	('bola de pelo'   , '2020-4-6', 11.6, 'amarelo', 2),
	('milu'           , '2013-2-4', 17.9, 'branco'  , 2),
	('pluto'          , '2012-1-3', 12.3, 'amarelo' , 2),
	('pateta'         , '2015-5-1', 17.7, 'preto'   , 2),
	('snoopy'         , '2013-7-2', 18.2, 'branco'  , 2),
	('bidu'           , '2012-9-8', 12.4, 'azul'    , 2),
	('dum dum'        , '2015-4-6', 11.2, 'laranja' , 2),
	('muttley'        , '2011-2-3', 14.3, 'laranja' , 2),
	('scooby'         , '2012-1-2', 19.9, 'marrom'  , 2),
	('rufus'          , '2014-4-5', 19.7, 'branco'  , 2),
	('costelinha'     , '2016-5-2', 13.4, 'branco'  , 2),
	('coragem'        , '2013-7-8', 12.2, 'vermelho', 2),
	('jake'           , '2012-2-7', 11.6, 'vermelho', 2),
	('k900'           , '2012-11-25', 11.6, 'amarelo', 2),
	('gato de botas'  , '2012-11-25', 11.6, 'amarelo', 2),
	('jerry'          , '2010-2-4', 06.6, 'laranja', 4),
	('ligeirinho'     , '2011-5-3', 04.4, 'amarelo', 4),
	('mikey'          , '2012-7-1', 02.2, 'preto'  , 4),
	('minie'          , '2013-9-3', 03.2, 'preta'  , 4),
	('topo gigio'     , '2016-6-8', 05.5, 'amarelo', 4),
	('bafo de onça'   , '2016-6-8', 05.5, 'amarelo', NULL),
	('susan murphy'   , '2016-6-8', 05.5, 'amarelo', NULL),
	('insectosauro'   , '2016-6-8', 05.5, 'amarelo', NULL),
	('gallaxhar'      , '2016-6-8', 05.5, 'amarelo', NULL),
	('hathaway'       , '2016-6-8', 05.5, 'amarelo', NULL),
	('tutubarão'      , '2010-2-6', 101.9, 'branca' , 9),
	('prof. pardal'   , '2012-4-4', 1.7, 'amarelo', 17),
	('mobie'          , '2014-5-2', 5069.4, 'branca' , 6),
	('batman'         , '2013-7-1', 96.1, 'preto'  , 3),
	('milady'         , '2015-4-9', 3.9, 'mesclada' , 5),
	('jade'           , '2015-4-9', 2.9, 'mesclada' , 5)
;


SELECT Animais.nome "Nome do animal", Especies.nome "Espécie"
	FROM Animais JOIN Especies
		ON Animais.especie_id = Especies.id;

SELECT Animais.nome "Nome do animal", Especies.nome "Espécie"
	FROM Animais LEFT JOIN Especies
		ON Animais.especie_id = Especies.id;

SELECT Animais.nome "Nome do animal", Especies.nome "Espécie"
	FROM Animais RIGHT JOIN Especies
		ON Animais.especie_id = Especies.id;



-- Exercícios


-- Selecione o nome e a espécie de todos os animais
SELECT a.nome "Nome do animal", e.nome "Espécie"
	FROM Animais a LEFT JOIN Especies e
		ON a.especie_id = e.id;


-- Selecione todos os gatos laranja
SELECT a.nome "Nome do animal", a.cor "Cor", e.nome "Espécie"
	FROM Animais a LEFT JOIN Especies e
		ON a.especie_id = e.id
	WHERE a.cor = 'laranja'
	AND e.nome = 'gato';


-- Selecione todos os cachorros da cor amarelo
SELECT a.nome "Nome do animal", a.cor "Cor", e.nome "Espécie"
	FROM Animais a LEFT JOIN Especies e
		ON a.especie_id = e.id
	WHERE a.cor = 'amarelo'
	AND e.nome = 'cachorro';


-- Selecione todos os animais aquáticos que pesam mais que 70 Kg
SELECT a.nome "Nome do animal", a.peso "Peso", e.nome "Espécie"
	FROM Animais a LEFT JOIN Especies e
		ON a.especie_id = e.id
	WHERE a.peso > 70
	AND e.nome IN ('baleia', 'sardinha', 'bacalhau', 'tubarão', 'lambari', 'corvina');


-- Selecione todos os herbívoro ordenados pelos mais pesados
SELECT a.nome "Nome do animal", a.peso "Peso", e.alimentacao "Alimentação"
	FROM Animais a LEFT JOIN Especies e
		ON a.especie_id = e.id
	WHERE e.alimentacao = 'herbívoro'
	ORDER BY a.peso DESC;


-- Selecione todos os carnívoro que são pretos e brancos
SELECT a.nome "Nome do animal", a.cor "Cor", e.alimentacao "Alimentação"
	FROM Animais a LEFT JOIN Especies e
		ON a.especie_id = e.id
	WHERE e.alimentacao = 'carnívoro'
	AND (a.cor LIKE 'branc%' OR a.cor LIKE 'pret%');


-- Selecione todos os onívoros que nasceram antes de 2013
SELECT a.nome "Nome do animal", a.data_nasc "Data de nascimento", e.alimentacao "Alimentação"
	FROM Animais a LEFT JOIN Especies e
		ON a.especie_id = e.id
	WHERE e.alimentacao = 'onívoro'
	AND YEAR(a.data_nasc) < 2013;
		-- alternativa:
	AND a.data_nasc < '2013-01-01';


-- Selecione todos os mamiferos que pesam mais que 10 quilos e são marrons ou azul
SELECT a.nome "Nome do animal", a.peso "Peso", a.cor "Cor", e.nome "Espécie"
	FROM Animais a LEFT JOIN Especies e
		ON a.especie_id = e.id
	WHERE e.nome IN ('gato', 'cachorro', 'morcego', 'rato', 'ramister', 'baleia')
	AND a.peso > 10
	AND a.cor IN ('azul', 'marrom');


-- (Desafio) Selecione a quantidade total de animais
SELECT COUNT(*) AS Total FROM Animais;


-- (Desafio) Se somarmos os peso de todos os gatos, qual será o resultado?
SELECT SUM(a.peso) AS Total
	FROM Animais a LEFT JOIN Especies e
		ON a.especie_id = e.id
	WHERE e.nome = 'gato';
