CREATE DATABASE lojaLegal;
USE lojaLegal;

CREATE TABLE caixa(
	dia DATE,
	saldo_inicial DECIMAL(10,2),
	saldo_final DECIMAL(10,2)
);

CREATE TABLE vendas(
	id INT PRIMARY KEY,
	dia DATE,
	valor DECIMAL(10,2)
);

INSERT INTO caixa VALUES ('2023-05-30', 100, 100);
SELECT * FROM caixa;


CREATE TRIGGER atualizaCaixa
AFTER INSERT ON vendas
FOR EACH ROW
BEGIN
	DECLARE valor DECIMAL(10,2);
	DECLARE dia DATE;
	SELECT NEW.dia, NEW.valor INTO dia, valor;
	UPDATE caixa SET saldo_final = saldo_final + valor
	WHERE dia = dia;
END;

INSERT INTO vendas VALUES (3, '2023-05-30', 20);

SELECT * FROM vendas;
SELECT * FROM caixa;

INSERT INTO vendas VALUES (2, '2023-05-30', 20);


CREATE TRIGGER ImpedirDeleteSemWhere
BEFORE DELETE ON vendas
FOR EACH ROW
BEGIN
	DECLARE rowCount INT;
	SELECT COUNT(*) INTO rowCount FROM vendas;
	IF rowCount <= 1 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido executar DELETE sem cláusula WHERE.';
	END IF;
END;


CREATE TRIGGER deleteSemWhere
BEFORE UPDATE, DELETE ON vendas
FOR EACH ROW
BEGIN
	DECLARE Linhas_Alteradas INT;
	DECLARE Linhas_Tabela INT;
	SELECT ROW_COUNT() INTO Linhas_Alteradas;
	SELECT SUM(TABLE_ROWS) INTO Linhas_Tabela
	FROM information_schema.tables
	WHERE table_schema = DATABASE() AND table_name = 'vendas';

	IF Linhas_Alteradas >= Linhas_Tabela THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Operações de DELETE e/ou UPDATE sem cláusula WHERE não são permitidas na tabela "vendas"';
	END IF;
END;

DELETE FROM vendas;



-- Exercícios

-- 1 - Crie uma tabela para armazenar dados de pessoas. Como restrição, ninguém pode ter idade negativa, nem idade maior que 200 anos. Gere mensagens de erro adequadas para cada situação.

CREATE TABLE pessoas (
  id INT PRIMARY KEY,
  nome VARCHAR(100),
  idade INT
);

CREATE TRIGGER idadeNegativa
BEFORE INSERT ON pessoas
FOR EACH ROW
BEGIN
  IF NEW.idade < 0 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A idade não pode ser negativa.';
  END IF;
END;

CREATE TRIGGER idadeMaior200
BEFORE INSERT ON pessoas
FOR EACH ROW
BEGIN
  IF NEW.idade > 200 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A idade não pode ser maior que 200 anos.';
  END IF;
END;


-- 2 - Crie um campo ultima_atualizacao que armazena a data e hora da última alteração de cada registro.

ALTER TABLE pessoas ADD ultima_atualizacao DATETIME;

CREATE TRIGGER atualizaUltimaAtualizacao
BEFORE UPDATE ON pessoas
FOR EACH ROW
BEGIN
	SET NEW.ultima_atualizacao = NOW();
END;


-- 3 - Crie uma tabela para log do banco de dados. Nessa tabela devem ser registrados metadados referentes a atividades no banco de dados como inserções, atualizações e deleções. Cada registro desta tabela deve conter o nome da tabela alterada, o nome do usuário logado, data e hora da atividade.

CREATE TABLE LogBancoDados (
	id INT AUTO_INCREMENT PRIMARY KEY,
	tabela_alterada NVARCHAR(100),
	usuario_logado NVARCHAR(100),
	data_hora_atividade DATETIME
);

CREATE TRIGGER tr_insere_log_insercao
AFTER INSERT ON nome_tabela
FOR EACH ROW
BEGIN
	INSERT INTO LogBancoDados (tabela_alterada, usuario_logado, data_hora_atividade)
	VALUES ('nome_tabela', CURRENT_USER(), NOW());
END;

CREATE TRIGGER tr_insere_log_atualizacao
AFTER UPDATE ON nome_tabela
FOR EACH ROW
BEGIN
	INSERT INTO LogBancoDados (tabela_alterada, usuario_logado, data_hora_atividade)
	VALUES ('nome_tabela', CURRENT_USER(), NOW());
END;

CREATE TRIGGER tr_insere_log_delecao
AFTER DELETE ON nome_tabela
FOR EACH ROW
BEGIN
	INSERT INTO LogBancoDados (tabela_alterada, usuario_logado, data_hora_atividade)
	VALUES ('nome_tabela', CURRENT_USER(), NOW());
END;


-- 4 - Crie uma tabela para armazenar dados de funcionários. Como restrição, ninguém pode ter salário inferior a R$ 12.000,00 e a jornada semanal deve estar entre 20 e 40 horas. Gere mensagens de erro adequadas para cada situação.

CREATE TABLE funcionarios (
  id INT PRIMARY KEY,
  nome VARCHAR(100),
  salario DECIMAL(10,2),
  jornada_semanal INT
);

CREATE TRIGGER restricoesFuncionarios
BEFORE INSERT ON funcionarios
FOR EACH ROW
BEGIN
	IF NEW.salario < 12000 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O salário não pode ser inferior a R$ 12.000,00.';
	END IF;

	IF NEW.jornada_semanal < 20 OR NEW.jornada_semanal > 40 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A jornada semanal deve estar entre 20 e 40 horas.';
	END IF;
END;
