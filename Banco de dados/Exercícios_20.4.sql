-- Tabela vazia ? Vamos resolver isso ae! INSERT na prática
-- Inserindo dados em uma coluna específica:
INSERT INTO nome_da_tabela (coluna1, coluna2)
VALUES ('valor_coluna1', 'valor_coluna2');

-- Caso mais de algum valor precise ser inserido, a seperação
-- ocorrerá por vírgulas.
INSERT INTO nome_da_tabela (coluna1, coluna2) VALUES
('valor_coluna1', 'valor_coluna2'),
('valor2_coluna1', 'valor_2_coluna2'),
('valor3_coluna1', 'valor_3_coluna2');

-- Ignorando linhas existentes com o IGNORE
-- Basicamente, ele serve para IGNORAR problemas, como linhas iguais, por exemplo.
-- Considerando a seguinte tabela
----------------------
-- |  id | name      |
-- |  1  | Nissim    |
-- |  2  | Garrison  |
-- |  3  | Benjamin  |
-- |  4  | Gloria    |
----------------------

INSERT IGNORE INTO pessoas (id, name) VALUES
(4,'Gloria'), -- Sem o IGNORE, essa linha geraria um erro e o INSERT não continuaria.
(5,'Amanda');

-- Pesquisando agora, você verá que a informação duplicada não foi inserida.
-- Porém os dados corretos foram inseridos com sucesso.
SELECT * FROM pessoas;

----------------------
-- |  id | name      |
-- |  1  | Nissim    |
-- |  2  | Garrison  |
-- |  3  | Benjamin  |
-- |  4  | Gloria    |
-- |  5  | Amanda    |
----------------------

--------------------------

-- Inserindo valores em colunas com o auto_increment, será N+1.
INSERT INTO sakila.actor (first_name, last_name)
VALUES('Marcelo','Santos');
-- Ta script acima tem como primeira coluna, actor_id, porém, o auto_increment está ativo.
-- Tal coluna pode ser omitida no INSERT.

--------------------------

-- Inserindo dados de outra tabela com o INSERT SELECT
-- É possível inserir dados a partir de outra tabela usando INSERT INTO SELECT
INSERT INTO tabelaA (coluna1, coluna2)
    SELECT tabelaB.coluna1, tabelaB.coluna2
    FROM tabelaB
    WHERE tabelaB.nome_da_coluna <> 'algumValor'
    ORDER BY tabelaB.coluna_de_ordenacao;

--É possível usar também SELECT * FROM e copiar todos os dados de 
-- todas as colunas de uma tabela para outra, mas nessa situação a 
-- tabelaA e a tabelaB precisam obrigatoriamente possuir a mesma quantidade
-- de colunas, e os tipos de dados das colunas correspondentes devem ser iguais.

-- Outro exemplo;
INSERT INTO sakila.actor (first_name, last_name)
  SELECT first_name, last_name FROM sakila.staff;

-- Atividade de fixação
--1 Insira um novo funcionário na tabela sakila.staff.
INSERT INTO sakila.staff 
(first_name, last_name, address_id, email, store_id, active, username, password)
VALUES 
('Vinicius', 'Gouveia', 2, 'hahaha.com.br', 1, 1, 'vinigofr', 'password');
--2 Feito o exercício anterior, vamos agora para o nível 2. Insira dois funcionários novos em apenas uma query.
INSERT INTO sakila.staff 
(first_name, last_name, address_id, email, store_id, active, username, password)
VALUES 
('Augusto', 'Almeida', 2, 'hahaha.com.br', 1, 1, 'vinigofr', 'password'),
('Junior', 'Mizerable', 2, 'hahaha.com.br', 1, 1, 'vinigofr', 'password');
--3 Selecione os cinco primeiros nomes e sobrenomes da tabela sakila.customer
-- e cadastre essas pessoas como atores na tabela sakila.actor.
INSERT INTO sakila.actor (first_name, last_name)
SELECT first_name, last_name FROM sakila.customer
LIMIT 5;
--4 Cadastre três categorias de uma vez só na tabela sakila.category.
SELECT * FROM sakila.category;
SELECT * FROM sakila.customer;

INSERT INTO sakila.category (name)
VALUES ('CatA'), ('CatB'), ('CatB');
--5 Cadastre uma nova loja na tabela sakila.store.
USE sakila;
SELECT * from store;

INSERT INTO store (manager_staff_id, address_id)
VALUES (3, 3);
