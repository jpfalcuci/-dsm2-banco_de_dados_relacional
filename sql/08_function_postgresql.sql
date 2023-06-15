CREATE OR REPLACE FUNCTION hello()
	RETURNS VARCHAR(30)
LANGUAGE plpgsql
AS $$
	BEGIN
		RETURN 'Hello World!';
	END; $$;

SELECT hello();


CREATE OR REPLACE FUNCTION helloPerson(nome VARCHAR(30))
	RETURNS VARCHAR(30)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN CONCAT('Hello ', nome, '!');
END; $$;

DROP FUNCTION IF EXISTS helloPerson;

SELECT helloPerson('João');


CREATE OR REPLACE FUNCTION soma(num1 INT, num2 INT)
	RETURNS INT
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN num1 + num2;
END; $$;

DROP FUNCTION IF EXISTS soma;

SELECT soma(5, 8);


SELECT helloPerson('João'), soma(4, 3);


CREATE DATABASE ProdutosLegais;
USE ProdutosLegais;

CREATE TABLE produtos(
	id              SERIAL PRIMARY KEY,
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


CREATE OR REPLACE FUNCTION lucro(produto INT)
	RETURNS DECIMAL(9,2)
LANGUAGE plpgsql
AS $$
DECLARE
	custo DECIMAL(9,2);
	venda DECIMAL(9,2);
	lucro DECIMAL(9,2);
BEGIN
	SELECT preco_custo INTO custo FROM produtos WHERE id = produto;
	SELECT preco_venda INTO venda FROM produtos WHERE id = produto;
	lucro := venda - custo;
	RETURN lucro;
END; $$;

DROP FUNCTION IF EXISTS lucro;


SELECT lucro(1), lucro(2), lucro(3), lucro(4);


SELECT UPPER('Fatec Franca SP');
SELECT LOWER('Fatec Franca SP');
SELECT LENGTH('Fatec Franca SP');
SELECT LENGTH(CAST(1234 AS VARCHAR));
SELECT TRIM('  Fatec Franca SP     ');
SELECT STRING_AGG(SUBSTRING('Fatec Franca SP', n, 1), '')
	FROM GENERATE_SERIES(LENGTH('Fatec Franca SP'), 1, -1) AS n;
SELECT ROUND(5.1234,3);
SELECT LEFT('Fatec Franca', 3);
SELECT RIGHT('Fatec Franca', 3);
SELECT REPLACE('Fatec Franca SP', 'Franca', 'São Paulo');
SELECT STRING_AGG('Fatec Franca SP', '' ORDER BY generate_series)
	FROM generate_series(1, 5);
SELECT REPEAT(' ', 10);
SELECT CONCAT('Unifran', SUBSTRING('Fatec Franca', 6));
SELECT SUBSTRING('Fatec Franca' FROM 1 FOR 3);
SELECT ASCII(SUBSTRING('Atlanta', 1, 1));



-- Exercícios: Utilize Stored Procedures e Functions para automatizar a inserção e seleção dos cursos.

CREATE DATABASE Universidade;
\c Universidade

CREATE TABLE Alunos (
	ra			INT				PRIMARY KEY,
	nome		VARCHAR(60)		NOT NULL,
	email		VARCHAR(80),
	endereco	VARCHAR(200)
);

CREATE TABLE Areas (
	id			SERIAL			PRIMARY KEY,
	nome		VARCHAR(60)		NOT NULL		UNIQUE,
	descricao	VARCHAR(200)
);

CREATE TABLE Cursos (
	id			SERIAL			PRIMARY KEY,
	nome		VARCHAR(60)		NOT NULL,
	carga_h		INT,
	area_id		INT,
	FOREIGN KEY (area_id) REFERENCES Areas(id)
);

CREATE TABLE Matriculas (
	id			SERIAL			PRIMARY KEY,
	data		DATE			NOT NULL,
	status		INT				NOT NULL,  --  1=Ativo, 2=Concluído -1=Trancado -2=Jubilado
	aluno_ra	INT,
	curso_id	INT,
	FOREIGN KEY (aluno_ra) REFERENCES Alunos(ra),
	FOREIGN KEY (curso_id) REFERENCES Cursos(id)
);

CREATE TABLE Professores (
	id			SERIAL			PRIMARY KEY,
	nome		VARCHAR(60)		NOT NULL,
	titulacao	VARCHAR(20)
);

CREATE TABLE Disciplinas (
	id			SERIAL			PRIMARY KEY,
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
	id			SERIAL			PRIMARY KEY,
	ano			INT,
	semestre	INT,
	prof_id		INT,
	disc_id		INT,
	FOREIGN KEY (prof_id) REFERENCES Professores(id),
	FOREIGN KEY (disc_id) REFERENCES Disciplinas(id)
);



-- 1 – Crie uma função que ao inserir um aluno deve ter seu endereço de email gerado automaticamente no seguinte formato: nome.sobrenome@dominio.com

CREATE OR REPLACE FUNCTION criarEmail(
	nome		VARCHAR(60),
	sobrenome	VARCHAR(60)
)
	RETURNS VARCHAR(80)
AS $$
DECLARE 
	email VARCHAR(80);
BEGIN
	SET email = CONCAT(REPLACE(LOWER(nome), ' ', ''), '.', REPLACE(LOWER(sobrenome), ' ', ''), '@dominio.com');
	RETURN email;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION inserirAluno(
	ra          INT,
	nome        VARCHAR(60),
	sobrenome   VARCHAR(60),
	endereco    VARCHAR(200)
)
	RETURNS VARCHAR(80)
AS $$
DECLARE
	email VARCHAR(80);
BEGIN
	email := criarEmail(nome, sobrenome);
	INSERT INTO Alunos VALUES(ra, nome, email, endereco);
	RETURN email;
END;
$$ LANGUAGE plpgsql;

SELECT inserirAluno(666, 'Joao Paulo', 'Falcuci', 'Rua dos bobos, nº 0');


-- 2 - Crie uma função que recebe o nome de um curso e sua área, em seguida retorna o id do curso.

INSERT INTO Areas VALUES
	(DEFAULT, 'Biológicas', 'Descrição da área de biológicas'),
	(DEFAULT, 'Humanas', 'Descrição da área de humanas'),
	(DEFAULT, 'Exatas', 'Descrição da área de exatas'),
	(DEFAULT, 'Tecnológicas', 'Descrição da área de tecnologia')
;

INSERT INTO Cursos VALUES
	(DEFAULT, 'Curso 01', 240, 2),
	(DEFAULT, 'Curso 02', 240, 1),
	(DEFAULT, 'Curso 03', 240, 4),
	(DEFAULT, 'Curso 04', 240, 1),
	(DEFAULT, 'Curso 05', 240, 3),
	(DEFAULT, 'Curso 06', 240, 2),
	(DEFAULT, 'Curso 07', 240, 1),
	(DEFAULT, 'Curso 08', 240, 3),
	(DEFAULT, 'Curso 09', 240, 4),
	(DEFAULT, 'Curso 10', 240, 2)
;

CREATE OR REPLACE FUNCTION buscaIdCurso(
	curso       VARCHAR(30),
	area        VARCHAR(30)
)
	RETURNS INT
AS $$
DECLARE
	id_curso INT;
BEGIN
	SELECT c.id INTO id_curso
		FROM Cursos c JOIN Areas a ON c.area_id = a.id
		WHERE c.nome ILIKE curso AND a.nome ILIKE area;

	RETURN id_curso;
END;
$$ LANGUAGE plpgsql;

SELECT buscaIdCurso('curso 03', 'tecnologicas');

DROP FUNCTION IF EXISTS buscaIdCurso;


-- 3 - Crie uma procedure que recebe o os dados do aluno e de um curso e faz sua matrícula. Caso o aluno já esteja matriculado em um curso, essa matrícula não pode ser realizada.

CREATE OR REPLACE PROCEDURE realizarMatricula(
	IN ra INT,
	IN nome VARCHAR(60),
	IN sobrenome VARCHAR(60),
	IN endereco VARCHAR(200),
	IN nomeCurso VARCHAR(60)
)
LANGUAGE plpgsql
AS $$
DECLARE
	email VARCHAR(80);
	cursoId INT;
	matriculasCount INT;
BEGIN
	email := criarEmail(nome, sobrenome);

	SELECT COUNT(*) INTO matriculasCount FROM Matriculas WHERE aluno_ra = ra;

	IF matriculasCount > 0 THEN
		RAISE EXCEPTION 'O aluno já está matriculado em um curso.';
	ELSE
		INSERT INTO Alunos (ra, nome, email, endereco)
		VALUES (ra, nome, email, endereco);

		SELECT id INTO cursoId FROM Cursos WHERE nome = nomeCurso;

		IF cursoId IS NULL THEN
			RAISE EXCEPTION 'Curso inválido.';
		ELSE
			INSERT INTO Matriculas (data, status, aluno_ra, curso_id)
			VALUES (CURRENT_DATE, 1, ra, cursoId);

			RAISE NOTICE 'Matrícula realizada com sucesso.';
		END IF;
	END IF;
END;
$$;

CALL realizarMatricula(18, 'Silvio', 'Santos', 'Rua do SBT 34', 'Curso 02');

SELECT * FROM Matriculas
INNER JOIN Alunos ON Matriculas.aluno_ra = Alunos.ra;
