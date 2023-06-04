DROP DATABASE IF EXISTS Alunos;
CREATE DATABASE Alunos;
USE Alunos;

CREATE TABLE Cidades (
	id          INT IDENTITY PRIMARY KEY,
	nome        VARCHAR(60),
	populacao   INT
);

CREATE TABLE Alunos (
	ra          INT IDENTITY PRIMARY KEY,
	nome        VARCHAR(60) NOT NULL,
	cidade_id   INT REFERENCES Cidades(id)
);

INSERT INTO Cidades (nome, populacao) VALUES
	('Patrosítio', 15000),
	('Sorocaba', 12000),
	('Tatuí', 7000),
	('São Paulo', 300000),
	('Itú', 5000)
;

INSERT INTO Alunos (nome, cidade_id) VALUES
	('Marie Curie', 3),
	('Alan Turing', 1),
	('Claude Shannon', 4),
	('Charles Darwin', 5),
	('Linn Margulis', 2)
;

SELECT *
	FROM Alunos JOIN Cidades
	ON Cidades.id = Alunos.cidade_id;


DROP DATABASE IF EXISTS Motoristas;
CREATE DATABASE Motoristas;
USE Motoristas;

CREATE TABLE Pessoa (
	ID_Pessoa	INT IDENTITY PRIMARY KEY,
	Nome		VARCHAR(255),
	Endereco	VARCHAR(255),
	Cidade		VARCHAR(255)
);

CREATE TABLE Carro (
	ID_Carro    INT IDENTITY PRIMARY KEY,
	Nome        VARCHAR(255),
	Marca       VARCHAR(255),
	ID_Pessoa   INT REFERENCES Pessoa(ID_Pessoa)
);

INSERT INTO Pessoa (Nome, Endereco, Cidade) VALUES
	('Marie Curie', 'Endereço 1', 'Patrosítio'),
	('Alan Turing', 'Endereço 2', 'Sorocaba'),
	('Claude Shannon', 'Endereço 3', 'Tatuí'),
	('Charles Darwin', 'Endereço 4', 'São Paulo'),
	('Linn Margulis', 'Endereço 5', 'Itú')
;

INSERT INTO Carro (Nome, Marca, ID_Pessoa) VALUES
	('Palio', 'Fiat', 2),
	('Gol', 'VW', 3),
	('Fusca', 'VW', 1),
	('HB20', 'Hyundai', 4)
;

SELECT *
	FROM Carro JOIN Pessoa
	ON Carro.ID_Pessoa = Pessoa.ID_Pessoa;
