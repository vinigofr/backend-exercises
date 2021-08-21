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

--------------------------
-- O UPDATE permite alterar valores de uma tabela com base em alguma condição!
-- exemplo:
-- 1 Seleção da tabela a ser atualizada:
UPDATE sakila.staff
-- 2 Parâmetro para adição, selecionando a coluna
SET first_name = 'Rannveig'
-- 3 Parâmetro condincional, selecionando coluna
WHERE first_name = 'Ravein';
-- importantíssimo aplicar o WHERE para não alterar a tabela inteira!

-- Uma curiosidade sobre o UPDATE e o DELETE no MySQL Server é que, por padrão, 
-- existe uma configuração chamada safe updates mode que só vai te permitir executá-los 
-- caso eles incluam quais IDs devem ser modificados. Então, caso você tente fazer 
-- a query abaixo, ela não funcionaria por não incluir o ID.

-- Para evitar essa restrição, rode o seguinte comando em uma janela de query dentro 
-- do MySQL Workbench sempre que abri-lo para desabilitar essa funcionalidade, antes de 
-- executar seus comandos de UPDATE ou DELETE :
SET SQL_SAFE_UPDATES = 0;

-- Tá, mas e pra atualizar mais de uma coluna?
UPDATE sakila.staff
SET first_name = 'Rannveig', last_name = 'Jordan'
WHERE staff_id = 4;

-- Pode-se também fazer um update em massa, isso evita gasto desnecessário de dados e não
-- sobrecarrega o servidor
-- Opção 1 - Incluindo a lista de condições fixas
UPDATE sakila.actor
SET first_name = 'JOE'
WHERE actor_id IN (1,2,3);

-- Opção 2 - Especificando como cada entrada será alterada individualmente
UPDATE sakila.actor
SET first_name = (
CASE actor_id 
    WHEN 1 THEN 'JOE' -- se actor_id = 1, alterar first_name para 'JOE'
    WHEN 2 THEN 'DAVIS' -- se actor_id = 2, alterar first_name para 'DAVIS'
    WHEN 3 THEN 'CAROLINE' -- se actor_id = 3, alterar first_name para 'CAROLINE'
      ELSE first_name -- em todos os outros casos, mantém-se o first_name
END);

-- Fazendo UPDATE de forma sequencial, pera, pera.... Mas o que isso significa?
-- Se o comando ORDER BY for usado juntamente com o UPDATE , os resultados serão alterados na ordem em que forem encontrados.
-- Se o comando LIMIT for usado em conjunto com o UPDATE , um limite será imposto na quantidade de resultados que podem ser alterados.
-- Caso contrário, todos os resultados que satisfizerem a condição serão atualizados.
-- Exemplo:
UPDATE nome_da_tabela
SET coluna1 = valor1, coluna2 = valor2
[WHERE condições]
[ORDER BY expressao [ ASC | DESC ]]
[LIMIT quantidade_resultados];

-- Exemplo prático:
UPDATE sakila.staff
SET password = 'FavorResetarSuaSenha123'
WHERE active = 1
ORDER BY last_update
LIMIT 2;

--------------------------

-- Atividade de UPDATE
-- 1. Atualize o primeiro nome de todas as pessoas da tabela sakila.actor que possuem o primeiro nome "JULIA" para "JULES".
UPDATE sakila.actor
SET first_name = 'JULES'
WHERE first_name = 'JULIA';

-- 2. Foi exigido que a categoria "Sci-Fi" seja alterada para "Science Fiction".
UPDATE sakila.category
SET name = 'Science Fiction'
WHERE name = 'Sci-Fi';
-- Atualize o valor do aluguel para $25 de todos os filmes com duração maior que 100 minutos e que possuem a
--classificações "G" , "PG" ou "PG-13" e um custo de substituição maior que $20.
UPDATE sakila.film
SET replacement_cost = 25
WHERE `length` > 100 AND rating IN ('PG', 'PG-13', 'G');

-- Foi determinado pelo setor financeiro que haverá um reajuste em todos os 
-- preços dos filmes, com base em sua duração. Para todos os filmes com duração 
-- entre 0 e 100, o valor do aluguel passará a ser $10,00, e o aluguel dos filmes
-- com duração acima de 100 passará a ser de $20,00.
UPDATE sakila.film
SET rental_rate = (
	CASE WHEN LENGTH <= 100 THEN 10
    WHEN LENGTH > 100 THEN 20
    ELSE rental_rate
    END);
