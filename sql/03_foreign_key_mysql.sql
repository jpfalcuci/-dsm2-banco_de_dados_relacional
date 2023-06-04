DROP DATABASE IF EXISTS Alunos;
CREATE DATABASE IF NOT EXISTS Alunos;
USE Alunos;

CREATE TABLE Cidades (
	id          INT AUTO_INCREMENT PRIMARY KEY,
	nome        VARCHAR(60),
	populacao   INT
) AUTO_INCREMENT = 100, INCREMENT BY 2; -- personalizar valor inicial e de incremento

CREATE TABLE Alunos (
	ra          INT AUTO_INCREMENT PRIMARY KEY,
	nome        VARCHAR(60) NOT NULL,
	cidade_id   INT REFERENCES Cidades(id)
) AUTO_INCREMENT = 100, INCREMENT BY 2; -- personalizar valor inicial e de incremento

INSERT INTO Cidades VALUES
	(NULL, 'Patrosítio', 15000),
	(NULL, 'Sorocaba', 12000),
	(NULL, 'Tatuí', 7000),
	(NULL, 'São Paulo', 300000),
	(NULL, 'Itú', 5000)
;

INSERT INTO Alunos VALUES
	(NULL, 'Marie Curie', 3),
	(NULL, 'Alan Turing', 1),
	(NULL, 'Claude Shannon', 4),
	(NULL, 'Charles Darwin', 5),
	(NULL, 'Linn Margulis', 2)
;

SELECT *
	FROM Alunos JOIN Cidades
	ON Cidades.id = Alunos.cidade_id;


DROP DATABASE IF EXISTS Motoristas;
CREATE DATABASE IF NOT EXISTS Motoristas;
USE Motoristas;

CREATE TABLE Pessoa (
	ID_Pessoa   INT AUTO_INCREMENT PRIMARY KEY,
	Nome        VARCHAR(255),
	Endereco    VARCHAR(255),
	Cidade      VARCHAR(255)
);

CREATE TABLE Carro (
	ID_Carro    INT AUTO_INCREMENT PRIMARY KEY,
	Nome        VARCHAR(255),
	Marca       VARCHAR(255),
	ID_Pessoa   INT REFERENCES Pessoa(ID_Pessoa)
);

INSERT INTO Pessoa VALUES
	(NULL, 'Marie Curie', 'Endereço 1', 'Patrosítio'),
	(NULL, 'Alan Turing', 'Endereço 2', 'Sorocaba'),
	(NULL, 'Claude Shannon', 'Endereço 3', 'Tatuí'),
	(NULL, 'Charles Darwin', 'Endereço 4', 'São Paulo'),
	(NULL, 'Linn Margulis', 'Endereço 5', 'Itú')
;

INSERT INTO Carro VALUES
	(NULL, 'Palio', 'Fiat', 2),
	(NULL, 'Gol', 'VW', 3),
	(NULL, 'Fusca', 'VW', 1),
	(NULL, 'HB20', 'Hyundai', 4)
;

SELECT *
	FROM Carro JOIN Pessoa
	ON Carro.ID_Pessoa = Pessoa.ID_Pessoa;
