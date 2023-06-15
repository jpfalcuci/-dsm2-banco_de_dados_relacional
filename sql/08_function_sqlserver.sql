CREATE FUNCTION hello()
		RETURNS VARCHAR(30)
	BEGIN
		RETURN 'Hello World!';
	END;
GO;

SELECT dbo.hello();
GO;


CREATE FUNCTION helloPerson(@nome VARCHAR(30))
		RETURNS VARCHAR(30)
	BEGIN
		RETURN CONCAT('Hello ', nome, '!');
		RETURN CONCAT('Hello ', @nome, '!');
	END;
GO;

DROP FUNCTION IF EXISTS helloPerson;

SELECT dbo.helloPerson('João');
GO;


CREATE FUNCTION soma(@num1 INT, @num2 INT)
		RETURNS INT
	BEGIN
		RETURN num1 + num2;
		RETURN @num1 + @num2;
	END;
GO;

DROP FUNCTION IF EXISTS soma;

SELECT dbo.soma(5, 8);
GO;


SELECT dbo.helloPerson('João'), dbo.soma(4, 3);
GO;


CREATE DATABASE ProdutosLegais;
USE ProdutosLegais;

CREATE TABLE produtos(
	id              INT PRIMARY KEY IDENTITY,
	nome            VARCHAR(30),
	preco_custo     DECIMAL(9,2),
	preco_venda     DECIMAL(9,2)
);

INSERT INTO produtos (nome, preco_custo, preco_venda) VALUES
	('borracha', 10, 12),
	('caderno', 20, 27),
	('caneta', 1, 5),
	('ERP', 200, 350)
;


CREATE OR ALTER FUNCTION dbo.lucro(@produto INT)
	RETURNS DECIMAL(9,2)
AS
BEGIN
	DECLARE @custo DECIMAL(9,2);
	DECLARE @venda DECIMAL(9,2);
	DECLARE @lucro DECIMAL(9,2);

	SELECT @custo = preco_custo FROM produtos WHERE id = @produto;
	SELECT @venda = preco_venda FROM produtos WHERE id = @produto;

	SET @lucro = @venda - @custo;
	RETURN @lucro;
END;

DROP FUNCTION IF EXISTS lucro;

SELECT dbo.lucro(1), dbo.lucro(2), dbo.lucro(3), dbo.lucro(4);


SELECT UPPER('Fatec Franca SP');
SELECT LOWER('Fatec Franca SP');
SELECT LEN('Fatec Franca SP');
SELECT DATALENGTH(1234);
SELECT TRIM('  Fatec Franca SP     ');
SELECT REVERSE('Fatec Franca SP');
SELECT ROUND(5.1234,3);
SELECT DIFFERENCE('Teste', 'Teste');
SELECT LEFT('Fatec Franca', 3);
SELECT RIGHT('Fatec Franca', 3);
SELECT REPLACE('Fatec Franca SP', 'Franca', 'São Paulo');
SELECT REPLICATE('Fatec Franca SP', 5);
SELECT SPACE(10);
SELECT STUFF('Fatec Franca', 1, 5, 'Unifran');
SELECT SUBSTRING('Fatec Franca', 1, 3);         , mysql
SELECT UNICODE('Atlanta');



-- Exercícios: Utilize Stored Procedures e Functions para automatizar a inserção e seleção dos cursos.

USE Aula;
DROP database Universidade;

CREATE database Universidade;
USE Universidade;

CREATE TABLE Alunos (
	ra			INT				PRIMARY KEY,
	nome		VARCHAR(60)		NOT NULL,
	email		VARCHAR(80),
	endereco	VARCHAR(200)
);

CREATE TABLE Areas (
	id			INT 			PRIMARY KEY 	IDENTITY,
	nome		VARCHAR(60)		NOT NULL		UNIQUE,
	descricao	VARCHAR(200)
);

CREATE TABLE Cursos (
	id			INT 			PRIMARY KEY 	IDENTITY,
	nome		VARCHAR(60)		NOT NULL,
	carga_h		INT,
	area_id		INT,
	FOREIGN KEY (area_id) REFERENCES Areas(id)
);

CREATE TABLE Matriculas (
	id			INT				PRIMARY KEY		IDENTITY,
	data		date			NOT NULL,
	status		INT				NOT NULL,  --  1=Ativo, 2=Concluído -1=Trancado -2=Jubilado
	aluno_ra	INT,
	curso_id	INT,
	FOREIGN KEY (aluno_ra) REFERENCES Alunos(ra),
	FOREIGN KEY (curso_id) REFERENCES Cursos(id)
);

CREATE TABLE Professores (
	id			INT 			PRIMARY KEY 	IDENTITY,
	nome		VARCHAR(60)		NOT NULL,
	titulacao	VARCHAR(20)

);

CREATE TABLE Disciplinas (
	id			INT 			PRIMARY KEY 	IDENTITY,
	nome		VARCHAR(60)		NOT NULL,
	carga_h		INT,
	curso_id	INT,
	FOREIGN KEY (curso_id) REFERENCES Cursos(id)
);

CREATE TABLE Matricula_Disciplina (
	matr_id		INT,
	disc_id		INT,
	data		DATE,
	situacao	INT,	-- 0=Reprovado, 1=Aprovado
	FOREIGN KEY (matr_id) REFERENCES Matriculas(id),
	FOREIGN KEY (disc_id) REFERENCES Disciplinas(id)
);

CREATE TABLE Prof_Disciplina (
	id			INT 			PRIMARY KEY 	IDENTITY,
	ano			INT,
	semestre	INT,
	prof_id		INT,
	disc_id		INT,
	FOREIGN KEY (prof_id) REFERENCES Professores(id),
	FOREIGN KEY (disc_id) REFERENCES Disciplinas(id)
);
GO;


-- 1 – Crie uma função que ao inserir um aluno deve ter seu endereço de email gerado automaticamente no seguinte formato: nome.sobrenome@dominio.com

DECLARE @nome_completo AS VARCHAR(30), @primeiro_nome AS VARCHAR(30)
SET @primeiro_nome = (SELECT SUBSTRING('Marcio Maestrelo Funes', 1, CHARINDEX(' ', 'Marcio Maestrelo Funes' + ' ') - 1));
PRINT @primeiro_nome
GO;

CREATE FUNCTION criaEmailAluno(
	@primeiro_nome AS VARCHAR(30), 
	@ultimo_nome AS VARCHAR(30)
)
RETURNS VARCHAR(80) AS
BEGIN
	DECLARE @end_email AS VARCHAR(30);
	SET @end_email  = concat(@primeiro_nome, '.', @ultimo_nome, '@universidade.com.br');
	RETURN @end_email;
end
GO;

DECLARE @email VARCHAR(80)
SET @email = dbo.criaEmailAluno('ana', 'braga');

INSERT INTO Alunos values (1234, 'Ana Maria Braga', @email, 'Rua Globo 123');​
SELECT * FROM Alunos;
GO;

SELECT  Nome, 
	'Primeiro nome' = LEFT(Nome, CharIndex(' ', Nome) - 1),
	'Último nome'   = REVERSE(LEFT(REVERSE(Nome), CharIndex(' ', REVERSE(Nome)) - 1))
FROM Alunos

CREATE FUNCTION criaEmailAlunoTop(
	@nomeCompleto AS VARCHAR(30)
)
RETURNS VARCHAR(80) AS
BEGIN
	DECLARE @primeiro_nome AS VARCHAR(30), @ultimo_nome AS VARCHAR(30), @end_email AS VARCHAR(30);
	SET @primeiro_nome = LEFT(@nomeCompleto, CharIndex(' ', @nomeCompleto) - 1);
	SET @ultimo_nome = REVERSE(LEFT(REVERSE(@nomeCompleto), CharIndex(' ', REVERSE(@nomeCompleto)) - 1));
	SET @end_email  = concat(@primeiro_nome, '.', @ultimo_nome, '@universidade.com.br');
	RETURN @end_email;
END


-- 2 - Crie uma função que recebe o nome de um curso e sua área, em seguida retorna o id do curso.

CREATE FUNCTION ObterIdCurso(
	@nomeCurso VARCHAR(60), 
	@nomeArea VARCHAR(60)
)
RETURNS INT AS
BEGIN
    DECLARE @cursoId INT
    SELECT @cursoId = C.id
    FROM Cursos C INNER JOIN Areas A 
	ON C.area_id = A.id
    WHERE C.nome = @nomeCurso AND A.nome = @nomeArea
    RETURN @cursoId
END

INSERT INTO Areas (nome, descricao) VALUES
	('Ciências Exatas', 'Área que engloba disciplinas como Matemática, Física e Química'),
	('Ciências Humanas', 'Área que engloba disciplinas como História, Sociologia e Filosofia'),
	('Engenharia de Software', 360, (SELECT id FROM Areas WHERE nome = 'Ciências Exatas')),
	('Ciências Sociais', 300, (SELECT id FROM Areas WHERE nome = 'Ciências Humanas'))
;

SELECT * FROM Cursos;
SELECT * FROM Areas;

SELECT dbo.ObterIdCurso('Engenharia de Software', 'Ciências Exatas');

DECLARE @nomeCurso VARCHAR(60) = 'Engenharia de Software'
DECLARE @nomeArea VARCHAR(60) = 'Ciências Exatas'
DECLARE @cursoId INT
SELECT @cursoId = dbo.ObterIdCurso(@nomeCurso, @nomeArea)
PRINT @cursoId


-- 3 - Crie uma procedure que recebe o os dados do aluno e de um curso e faz sua matrícula. Caso o aluno já esteja matriculado em um curso, essa matrícula não pode ser realizada.

CREATE PROCEDURE RealizarMatricula
    @ra int,
    @nomeAluno VARCHAR(60),
    @email VARCHAR(80),
    @endereco VARCHAR(200),
    @nomeCurso VARCHAR(60)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Matriculas WHERE aluno_ra = @ra)
    BEGIN
        RAISERROR('O aluno já está matriculado em um curso.', 16, 1)
        RETURN
    END

    INSERT INTO Alunos (ra, nome, email, endereco)
    VALUES (@ra, @nomeAluno, @email, @endereco)

    DECLARE @cursoId int
    SELECT @cursoId = id FROM Cursos WHERE nome = @nomeCurso

    INSERT INTO Matriculas (data, status, aluno_ra, curso_id)
    VALUES (GETDATE(), 1, @ra, @cursoId)

    PRINT 'Matrícula realizada com sucesso.'
END

DECLARE @email VARCHAR(80)
SET @email = dbo.criaEmailAluno('silvio', 'santos');

EXEC RealizarMatricula 22, 'Silvio Santos', @email, 'Rua do SBT 34', 'Engenharia de Software';

SELECT * FROM 
Matriculas INNER JOIN Alunos ON Matriculas.aluno_ra = Alunos.ra;
