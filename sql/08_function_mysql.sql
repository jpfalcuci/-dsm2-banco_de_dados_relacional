CREATE FUNCTION hello()
		RETURNS VARCHAR(30)
		DETERMINISTIC
		NO SQL
	BEGIN
		RETURN 'Hello World!';
	END;

SELECT hello();


CREATE FUNCTION helloPerson(nome VARCHAR(30))
		RETURNS VARCHAR(30)
		DETERMINISTIC
		NO SQL
	BEGIN
		RETURN CONCAT('Hello ', nome, '!');
	END;

DROP FUNCTION IF EXISTS helloPerson;

SELECT helloPerson('João');


CREATE FUNCTION soma(num1 INT, num2 INT)
		RETURNS INT
		DETERMINISTIC
		NO SQL
	BEGIN
		RETURN num1 + num2;
	END;

DROP FUNCTION IF EXISTS soma;

SELECT soma(5, 8);


SELECT helloPerson('João'), soma(4, 3);


CREATE DATABASE ProdutosLegais;
USE ProdutosLegais;

CREATE TABLE produtos(
	id              INT PRIMARY KEY AUTO_INCREMENT,
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


CREATE FUNCTION lucro(produto INT)
	RETURNS DECIMAL(9,2)
	DETERMINISTIC
	READS SQL DATA
BEGIN
	DECLARE custo DECIMAL(9,2);
	DECLARE venda DECIMAL(9,2);
	DECLARE lucro DECIMAL(9,2);

	SELECT preco_custo INTO custo FROM produtos WHERE id = produto;
	SELECT preco_venda INTO venda FROM produtos WHERE id = produto;

	SET lucro = venda - custo;
	RETURN lucro;
END;

DROP FUNCTION IF EXISTS lucro;

SELECT lucro(1), lucro(2), lucro(3), lucro(4);


SELECT UPPER('Fatec Franca SP');
SELECT LOWER('Fatec Franca SP');
SELECT LENGTH('Fatec Franca SP');
SELECT LENGTH(CONVERT(1234, CHAR));
SELECT TRIM('  Fatec Franca SP     ');
SELECT ROUND(5.1234,3);
SELECT LEFT('Fatec Franca', 3);
SELECT RIGHT('Fatec Franca', 3);
SELECT REPLACE('Fatec Franca SP', 'Franca', 'São Paulo');
SELECT REPEAT('Fatec Franca SP', 5);
SELECT REPEAT(' ', 10);
SELECT CONCAT('Unifran', SUBSTRING('Fatec Franca', 6));
SELECT SUBSTRING('Fatec Franca', 1, 3);
SELECT ORD('Atlanta');



-- Exercícios: Utilize Stored Procedures e Functions para automatizar a inserção e seleção dos cursos.

CREATE DATABASE Universidade;
USE Universidade;

CREATE TABLE Alunos (
	ra			INT				PRIMARY KEY,
	nome		VARCHAR(60)		NOT NULL,
	email		VARCHAR(80),
	endereco	VARCHAR(200)
);

CREATE TABLE Areas (
	id			INT 			PRIMARY KEY 	AUTO_INCREMENT,
	nome		VARCHAR(60)		NOT NULL		UNIQUE,
	descricao	VARCHAR(200)
);

CREATE TABLE Cursos (
	id			INT 			PRIMARY KEY 	AUTO_INCREMENT,
	nome		VARCHAR(60)		NOT NULL,
	carga_h		INT,
	area_id		INT,
	FOREIGN KEY (area_id) references Areas(id)
);

CREATE TABLE Matriculas (
	id			INT				PRIMARY KEY		AUTO_INCREMENT,
	data		DATE			NOT NULL,
	status		INT				NOT NULL,  --  1=Ativo, 2=Concluído -1=Trancado -2=Jubilado
	aluno_ra	INT,
	curso_id	INT,
	FOREIGN KEY (aluno_ra) REFERENCES Alunos(ra),
	FOREIGN KEY (curso_id) REFERENCES Cursos(id)
);

CREATE TABLE Professores (
	id			INT 			PRIMARY KEY 	AUTO_INCREMENT,
	nome		VARCHAR(60)		NOT NULL,
	titulacao	VARCHAR(20)
);

CREATE TABLE Disciplinas (
	id			INT 			PRIMARY KEY 	AUTO_INCREMENT,
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
	id			INT 			PRIMARY KEY 	AUTO_INCREMENT,
	ano			INT,
	semestre	INT,
	prof_id		INT,
	disc_id		INT,
	FOREIGN KEY (prof_id) REFERENCES Professores(id),
	FOREIGN KEY (disc_id) REFERENCES Disciplinas(id)
);



-- 1 – Crie uma função que ao inserir um aluno deve ter seu endereço de email gerado automaticamente no seguinte formato: nome.sobrenome@dominio.com

CREATE FUNCTION criarEmail(
	nome        VARCHAR(60),
	sobrenome   VARCHAR(60)
)
	RETURNS VARCHAR(80)
	DETERMINISTIC
	READS SQL DATA
BEGIN
	DECLARE email VARCHAR(80);
	SET email = CONCAT(REPLACE(LOWER(nome), ' ', ''), '.', REPLACE(LOWER(sobrenome), ' ', ''), '@fatec.com');
	RETURN email;
END;

DROP FUNCTION IF EXISTS criarEmail;

CREATE FUNCTION inserirAluno(
	ra          INT,
	nome        VARCHAR(60),
	sobrenome   VARCHAR(60),
	endereco    VARCHAR(200)
)
	RETURNS VARCHAR(80)
	DETERMINISTIC
	READS SQL DATA
BEGIN
	DECLARE email VARCHAR(80);
	SET email = criarEmail(nome, sobrenome);
	INSERT INTO Alunos VALUES(ra, nome, email, endereco);
	RETURN email;
END;

SELECT inserirAluno(666, 'Joao Paulo', 'Falcuci', 'Rua dos bobos, nº 0');

DROP FUNCTION IF EXISTS inserirAluno;


-- 2 - Crie uma função que recebe o nome de um curso e sua área, em seguida retorna o id do curso.

INSERT INTO Areas VALUES
	(NULL, "Biológicas", "Descrição da área de biológicas"),
	(NULL, "Humanas", "Descrição da área de humanas"),
	(NULL, "Exatas", "Descrição da área de exatas"),
	(NULL, "Tecnológicas", "Descrição da área de tecnologia")
;

INSERT INTO Cursos VALUES
	(NULL, "Curso 01", 240, 2),
	(NULL, "Curso 02", 240, 1),
	(NULL, "Curso 03", 240, 4),
	(NULL, "Curso 04", 240, 1),
	(NULL, "Curso 05", 240, 3),
	(NULL, "Curso 06", 240, 2),
	(NULL, "Curso 07", 240, 1),
	(NULL, "Curso 08", 240, 3),
	(NULL, "Curso 09", 240, 4),
	(NULL, "Curso 10", 240, 2)
;

CREATE FUNCTION buscaIdCurso(
	curso       VARCHAR(30),
	area        VARCHAR(30)
)
	RETURNS INT
	DETERMINISTIC
	NO SQL
BEGIN
	DECLARE id_curso INT;
	SELECT c.id INTO id_curso
		FROM Cursos c JOIN Areas a ON c.area_id = a.id
		WHERE c.nome LIKE curso AND a.nome LIKE area;

	RETURN id_curso;
END;

SELECT buscaIdCurso("curso 03", "tecnologicas");

DROP FUNCTION IF EXISTS buscaIdCurso;


-- 3 - Crie uma procedure que recebe o os dados do aluno e de um curso e faz sua matrícula. Caso o aluno já esteja matriculado em um curso, essa matrícula não pode ser realizada.

CREATE PROCEDURE realizarMatricula(
	IN ra INT,
	IN nome VARCHAR(60),
	IN sobrenome VARCHAR(60),
	IN endereco VARCHAR(200),
	IN nomeCurso VARCHAR(60)
)
BEGIN
	DECLARE email VARCHAR(80);
	DECLARE cursoId INT;

	SET email = criarEmail(nome, sobrenome);

	SELECT COUNT(*) INTO @matriculasCount FROM Matriculas WHERE aluno_ra = ra;

	IF @matriculasCount > 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O aluno já está matriculado em um curso.';
	ELSE
		INSERT INTO Alunos (ra, nome, email, endereco)
		VALUES (ra, nome, email, endereco);

		SELECT id INTO cursoId FROM Cursos WHERE nome = nomeCurso;

		IF cursoId IS NULL THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Curso inválido.';
		ELSE
			INSERT INTO Matriculas (data, status, aluno_ra, curso_id)
			VALUES (CURDATE(), 1, ra, cursoId);

			SELECT 'Matrícula realizada com sucesso.' AS Message;
		END IF;
	END IF;
END;

DROP PROCEDURE IF EXISTS realizarMatricula;

CALL realizarMatricula(18, 'Silvio', 'Santos', 'Rua do SBT 34', 'Curso 02');

SELECT * FROM Matriculas
INNER JOIN Alunos ON Matriculas.aluno_ra = Alunos.ra;
