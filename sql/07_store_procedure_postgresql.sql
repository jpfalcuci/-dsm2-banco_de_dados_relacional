CREATE TABLE lucro (
	lucro_id        SERIAL PRIMARY KEY,
	nome_produto    VARCHAR(50),
	lucro_produto   DECIMAL(10,2)
);

CREATE OR REPLACE FUNCTION novoProduto(
	nomeProduto VARCHAR(50),
	qtdEstoque INT,
	data_fabricacao DATE,
	perecivel BOOLEAN,
	valor DECIMAL(10,2)
)
RETURNS VOID AS $$
DECLARE
	estoqueMin INT;
	lucro DECIMAL(10,2);
	minhaMarca INT;
BEGIN
	estoqueMin := 50;
	lucro := valor + 10;
	minhaMarca := (SELECT marca_id FROM marcas WHERE nome_marca = 'Faber Castel');

	INSERT INTO produtos
		VALUES (DEFAULT, nomeProduto, qtdEstoque, estoqueMin, data_fabricacao, perecivel, valor, minhaMarca);

	INSERT INTO lucro
		VALUES (DEFAULT, nomeProduto, lucro);
END; $$ LANGUAGE plpgsql;

SELECT novoProduto('Lápis phyno', 10, '2023-05-28', FALSE, 10.5);

SELECT * FROM produtos WHERE nome_prod LIKE 'Lápis phyno';
SELECT * FROM lucro;



-- Exercícios


-- 1. Crie uma SP que exibe o preço médio dos produtos.

DROP FUNCTION IF EXISTS averagePrice();

CREATE OR REPLACE FUNCTION averagePrice()
	RETURNS TABLE (Preco_medio DECIMAL)
AS $$
	BEGIN
		RETURN QUERY
		SELECT ROUND(AVG(p.valor), 2) AS "Preço médio" FROM produtos p;
	END; $$ LANGUAGE plpgsql;

SELECT averagePrice() AS "Preço médio";


-- 2. Crie uma SP que ao passar uma marca como parâmetro retorna todos os produtos daquela marca.

DROP FUNCTION IF EXISTS brandProduct();

CREATE OR REPLACE FUNCTION brandProduct(p_marca VARCHAR(50))
	RETURNS TABLE (Produto VARCHAR(50), Marca VARCHAR(50))
AS $$
BEGIN
	RETURN QUERY
	SELECT p.nome_prod, m.nome_marca
	FROM produtos p
	JOIN marcas m ON p.marca_id = m.marca_id
	WHERE m.nome_marca ILIKE p_marca;
END; $$ LANGUAGE plpgsql;

SELECT * FROM brandProduct('faber castel');
SELECT * FROM brandProduct('totvs');
SELECT * FROM brandProduct('lg');
SELECT * FROM brandProduct('microsoft');


-- 3.Crie uma SP que receba dois valores (um menor e outro maior) como parâmetro e retorne todos os produtos com a quantidade dentro do intervalo dos dois valores fornecidos como parâmetros.

DROP FUNCTION IF EXISTS productAmount(INT, INT);

CREATE OR REPLACE FUNCTION productAmount(min_value INT, max_value INT)
	RETURNS TABLE (produto VARCHAR(50), em_estoque INT)
AS $$
BEGIN
	RETURN QUERY
	SELECT nome_prod, qtd_estoque
	FROM produtos
	WHERE qtd_estoque BETWEEN min_value AND max_value;
END; $$ LANGUAGE plpgsql;

SELECT * FROM productAmount(1000, 4000);


-- 4.Crie uma SP onde após um novo registro na tabela produto_fornecedor for criado, ele exibe o nome do produto e o nome do fornecedor que acabou de ser registrado.

DROP FUNCTION IF EXISTS productSupplier(INT, INT);

CREATE OR REPLACE FUNCTION productSupplier(id_prod INT, id_forn INT)
	RETURNS TABLE (produto VARCHAR(50), fornecedor VARCHAR(50))
AS $$
BEGIN
	INSERT INTO produto_fornecedor (prod_id, forn_id)
		VALUES (id_prod, id_forn);

	RETURN QUERY
	SELECT p.nome_prod, f.nome_forn
	FROM produtos p
	JOIN produto_fornecedor pf ON p.prod_id = pf.prod_id
	JOIN fornecedores f ON pf.forn_id = f.forn_id
	WHERE p.prod_id = id_prod;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM productSupplier(7, 7);


-- 5.Crie uma SP que receba como parâmetro o nome de um fornecedor e insira automaticamente o nome do fornecedor e um e-mail no formato nome_fornecedor@nome_fornecedor.com.br na tabela fornecedores.

DROP FUNCTION IF EXISTS insertSupplier(VARCHAR);

CREATE OR REPLACE FUNCTION insertSupplier(forn_name VARCHAR(50))
	RETURNS TABLE (mensagem TEXT)
AS $$
DECLARE
	forn_email VARCHAR(50);
BEGIN
	forn_email := CONCAT(REPLACE(LOWER(forn_name), ' ', ''), '@', REPLACE(LOWER(forn_name), ' ', ''), '.com.br');

	INSERT INTO fornecedores (nome_forn, email) VALUES (forn_name, forn_email);

	RETURN QUERY
	SELECT CONCAT('Usuário ', forn_name, ' inserido com o email ', forn_email) AS mensagem;
END; $$ LANGUAGE plpgsql;

SELECT * FROM insertSupplier('Walter White');
