DROP DATABASE IF EXISTS Alunos;
CREATE DATABASE Alunos;

CREATE TABLE Cidades (
	id          SERIAL PRIMARY KEY,
	nome        VARCHAR(60),
	populacao   INT
);

CREATE TABLE Alunos (
	ra          SERIAL PRIMARY KEY,
	nome        VARCHAR(60) NOT NULL,
	cidade_id   INT REFERENCES Cidades(id)
);

INSERT INTO Cidades VALUES
	(DEFAULT, 'Patrosítio', 15000),
	(DEFAULT, 'Sorocaba', 12000),
	(DEFAULT, 'Tatuí', 7000),
	(DEFAULT, 'São Paulo', 300000),
	(DEFAULT, 'Itú', 5000)
;

INSERT INTO Alunos VALUES
	(DEFAULT, 'Marie Curie', 3),
	(DEFAULT, 'Alan Turing', 1),
	(DEFAULT, 'Claude Shannon', 4),
	(DEFAULT, 'Charles Darwin', 5),
	(DEFAULT, 'Linn Margulis', 2)
;

SELECT *
	FROM Alunos JOIN Cidades
	ON Cidades.id = Alunos.cidade_id;


DROP DATABASE IF EXISTS Motoristas;
CREATE DATABASE Motoristas;

CREATE TABLE Pessoa (
	ID_Pessoa   SERIAL PRIMARY KEY,
	Nome        VARCHAR(255),
	Endereco    VARCHAR(255),
	Cidade      VARCHAR(255)
);

CREATE TABLE Carro (
	ID_Carro    SERIAL PRIMARY KEY,
	Nome        VARCHAR(255),
	Marca       VARCHAR(255),
	ID_Pessoa   INT REFERENCES Pessoa(ID_Pessoa)
);

INSERT INTO Pessoa VALUES
	(DEFAULT, 'Marie Curie', 'Endereço 1', 'Patrosítio'),
	(DEFAULT, 'Alan Turing', 'Endereço 2', 'Sorocaba'),
	(DEFAULT, 'Claude Shannon', 'Endereço 3', 'Tatuí'),
	(DEFAULT, 'Charles Darwin', 'Endereço 4', 'São Paulo'),
	(DEFAULT, 'Linn Margulis', 'Endereço 5', 'Itú')
;

INSERT INTO Carro VALUES
	(DEFAULT, 'Palio', 'Fiat', 2),
	(DEFAULT, 'Gol', 'VW', 3),
	(DEFAULT, 'Fusca', 'VW', 1),
	(DEFAULT, 'HB20', 'Hyundai', 4)
;

SELECT *
	FROM Carro JOIN Pessoa
	ON Carro.ID_Pessoa = Pessoa.ID_Pessoa;
