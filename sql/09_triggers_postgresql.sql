CREATE DATABASE lojaLegal;
\c lojaLegal;

CREATE TABLE caixa(
	dia	DATE,
	saldo_inicial DECIMAL(10,2),
	saldo_final DECIMAL(10,2)
);

CREATE TABLE vendas(
	id SERIAL PRIMARY KEY,
	dia DATE,
	valor DECIMAL(10,2)
);

INSERT INTO caixa VALUES ('2023-05-30', 100, 100);
SELECT * FROM caixa;

CREATE OR REPLACE FUNCTION atualizaCaixa()
RETURNS TRIGGER AS $$
BEGIN
	UPDATE caixa SET saldo_final = saldo_final + NEW.valor
	WHERE dia = NEW.dia;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER atualizaCaixaTrigger
AFTER INSERT ON vendas
FOR EACH ROW
EXECUTE FUNCTION atualizaCaixa();

INSERT INTO vendas (id, dia, valor) VALUES (3, '2023-05-30', 20);

SELECT * FROM vendas;
SELECT * FROM caixa;

INSERT INTO vendas (id, dia, valor) VALUES (2, '2023-05-30', 20);

CREATE OR REPLACE FUNCTION impedirDeleteSemWhere()
RETURNS TRIGGER AS $$
DECLARE
	rowCount INT;
BEGIN
	SELECT COUNT(*) INTO rowCount FROM vendas;
	IF rowCount <= 1 THEN
		RAISE EXCEPTION 'Não é permitido executar DELETE sem cláusula WHERE.';
	END IF;
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER impedirDeleteSemWhereTrigger
BEFORE DELETE ON vendas
FOR EACH ROW
EXECUTE FUNCTION impedirDeleteSemWhere();

CREATE OR REPLACE FUNCTION impedirDeleteUpdateSemWhere()
RETURNS TRIGGER AS $$
DECLARE
	linhasAlteradas INT = TG_NARGS;
	linhasTabela INT;
BEGIN
	SELECT SUM(row_count) INTO linhasTabela
	FROM pg_stats
	WHERE tablename = 'vendas' AND (indexrelid <= 1);

	IF (linhasAlteradas >= linhasTabela) THEN
		RAISE EXCEPTION 'Operações de DELETE e/ou UPDATE sem cláusula WHERE não são permitidas na tabela "vendas"';
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER impedirDeleteUpdateSemWhereTrigger
BEFORE UPDATE OR DELETE ON vendas
FOR EACH ROW
EXECUTE FUNCTION impedirDeleteUpdateSemWhere();

DELETE FROM vendas;


-- Exercícios

-- 1 - Crie uma tabela para armazenar dados de pessoas. Como restrição, ninguém pode ter idade negativa, nem idade maior que 200 anos. Gere mensagens de erro adequadas para cada situação.

CREATE TABLE pessoas (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100),
	idade INT
);

CREATE OR REPLACE FUNCTION checkIdadeNegativa()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.idade < 0 THEN
		RAISE EXCEPTION 'A idade não pode ser negativa.';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER idadeNegativa
BEFORE INSERT ON pessoas
FOR EACH ROW
EXECUTE FUNCTION checkIdadeNegativa();

CREATE OR REPLACE FUNCTION checkIdadeMaior200()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.idade > 200 THEN
		RAISE EXCEPTION 'A idade não pode ser maior que 200 anos.';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER idadeMaior200
BEFORE INSERT ON pessoas
FOR EACH ROW
EXECUTE FUNCTION checkIdadeMaior200();


-- 2 - Crie um campo ultima_atualizacao que armazena a data e hora da última alteração de cada registro.

ALTER TABLE pessoas ADD COLUMN ultima_atualizacao TIMESTAMP;

CREATE OR REPLACE FUNCTION atualizaUltimaAtualizacao()
RETURNS TRIGGER AS $$
BEGIN
	NEW.ultima_atualizacao := NOW();
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER atualizaUltimaAtualizacaoTrigger
BEFORE UPDATE ON pessoas
FOR EACH ROW
EXECUTE FUNCTION atualizaUltimaAtualizacao();


-- 3 - Crie uma tabela para log do banco de dados. Nessa tabela devem ser registrados metadados referentes a atividades no banco de dados como inserções, atualizações e deleções. Cada registro desta tabela deve conter o nome da tabela alterada, o nome do usuário logado, data e hora da atividade.

CREATE TABLE LogBancoDados (
	id SERIAL PRIMARY KEY,
	tabela_alterada VARCHAR(100),
	usuario_logado VARCHAR(100),
	data_hora_atividade TIMESTAMP
);

CREATE OR REPLACE FUNCTION insere_log_insercao()
RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO LogBancoDados (tabela_alterada, usuario_logado, data_hora_atividade)
	VALUES (TG_TABLE_NAME, current_user, current_timestamp);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_insere_log_insercao
AFTER INSERT ON nome_tabela
FOR EACH ROW
EXECUTE FUNCTION insere_log_insercao();

CREATE OR REPLACE FUNCTION insere_log_atualizacao()
RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO LogBancoDados (tabela_alterada, usuario_logado, data_hora_atividade)
	VALUES (TG_TABLE_NAME, current_user, current_timestamp);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_insere_log_atualizacao
AFTER UPDATE ON nome_tabela
FOR EACH ROW
EXECUTE FUNCTION insere_log_atualizacao();

CREATE OR REPLACE FUNCTION insere_log_delecao()
RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO LogBancoDados (tabela_alterada, usuario_logado, data_hora_atividade)
	VALUES (TG_TABLE_NAME, current_user, current_timestamp);
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_insere_log_delecao
AFTER DELETE ON nome_tabela
FOR EACH ROW
EXECUTE FUNCTION insere_log_delecao();


-- 4 - Crie uma tabela para armazenar dados de funcionários. Como restrição, ninguém pode ter salário inferior a R$ 12.000,00 e a jornada semanal deve estar entre 20 e 40 horas. Gere mensagens de erro adequadas para cada situação.

CREATE TABLE funcionarios (
  id INT PRIMARY KEY,
  nome VARCHAR(100),
  salario DECIMAL(10,2),
  jornada_semanal INT
);

CREATE OR REPLACE FUNCTION restricoesFuncionarios()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.salario < 12000 THEN
		RAISE EXCEPTION 'O salário não pode ser inferior a R$ 12.000,00.';
	END IF;

	IF NEW.jornada_semanal < 20 OR NEW.jornada_semanal > 40 THEN
		RAISE EXCEPTION 'A jornada semanal deve estar entre 20 e 40 horas.';
	END IF;

	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER restricoesFuncionariosTrigger
BEFORE INSERT ON funcionarios
FOR EACH ROW
EXECUTE FUNCTION restricoesFuncionarios();
