DROP DATABASE IF EXISTS Alunos;
CREATE DATABASE IF NOT EXISTS Alunos;
USE Alunos;


CREATE TABLE Cidades (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60),
    populacao INT
) engine=INNODB;


CREATE TABLE Alunos (
    ra INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    cidade_id INT,
    FOREIGN KEY(cidade_id) REFERENCES Cidades(id)
);


INSERT INTO Cidades VALUES
    (null, 'Patrosítio', 15000),
    (null, 'Sorocaba', 12000),
    (null, 'Tatuí', 7000),
    (null, 'São Paulo', 300000),
    (null, 'Itú', 5000)
;


INSERT INTO Alunos VALUES
    (1, 'Marie Curie', 3),
    (2, 'Alan Turing', 1),
    (3, 'Claude Shannon', 4),
    (4, 'Charles Darwin', 5),
    (5, 'Linn Margulis', 2)
;


SELECT *
    FROM Alunos JOIN Cidades
    ON Cidades.id = Alunos.cidade_id;



DROP DATABASE IF EXISTS Motoristas;
CREATE DATABASE IF NOT EXISTS Motoristas;
USE Motoristas;


CREATE TABLE Pessoa (
    ID_Pessoa INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(255),
    Endereco VARCHAR(255),
    Cidade VARCHAR(255)
);


CREATE TABLE Carro (
    ID_Carro INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(255),
    Marca VARCHAR(255),
    ID_Pessoa INT,
    FOREIGN KEY (ID_Pessoa) REFERENCES Pessoa(ID_Pessoa)
);


INSERT INTO Pessoa VALUES
    (null, 'Marie Curie', 'Endereço 1', 'Patrosítio'),
    (null, 'Alan Turing', 'Endereço 2', 'Sorocaba'),
    (null, 'Claude Shannon', 'Endereço 3', 'Tatuí'),
    (null, 'Charles Darwin', 'Endereço 4', 'São Paulo'),
    (null, 'Linn Margulis', 'Endereço 5', 'Itú')
;


INSERT INTO Carro VALUES
    (null, 'Palio', 'Fiat', 2),
    (null, 'Gol', 'VW', 3),
    (null, 'Fusca', 'VW', 1),
    (null, 'HB20', 'Hyundai', 4)
;


SELECT *
    FROM Carro JOIN Pessoa
    ON Carro.ID_Pessoa = Pessoa.ID_Pessoa;
