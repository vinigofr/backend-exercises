-- Este arquivo refere-se ao conteúdo do dia 22.3
-- que trata sobre a transformação de ideias em um
-- modelo de banco de dados.

-- Habilidades que foram adquiridas:
-- Clonar tabelas existentes;
-- Lidar com VIEWs;
-- Alterar tabelas existentes;
-- Deletar uma tabela;
-- Usar um INDEX.

-- Clonando tabelas existentes
-- O método abaixo copia apenas a estrutura
-- Sintaxe:
USE [BANCO]
CREATE TABLE nome_para_nova_tabela LIKE tabela_a_ser_clonada;
-- Caso de uso:
CREATE TABLE actor_clone LIKE sakila.actor;
-- Mais um caso de uso:
-- Caso o banco de dados não seja especificado, a nova tabela
-- será inserida no banco de dados que está em uso.
-- Sendo assim, é importante sempre usar o comando USE [banco]
USE nome_do_banco_de_dados;
CREATE TABLE nome_para_nova_tabela LIKE tabela_a_ser_clonada;


-- Lidando com VIEWs:
-- Esse método cria uma tabela temporária no próprio banco de dados
-- Essa tabela pode ser consultada como uma tabela normal
-- Ela é criada a partir de uma QUERY SQL

-- Além disso um VIEW permite:
-- Ter uma tabela que pode ser usada em relatórios;
-- Ter uma tabela para usar como base para montar novas queries;
-- Reduzir a necessidade de recriar queries utilizadas com frequência.

-- Caso de uso:
-- Defina em qual banco a view será criada
USE nome_do_banco_de_dados;
-- Comando para criar a view
CREATE VIEW nome_da_view AS query;

-- Um exemplo de uso
-- Suponha que a gerência quer ter uma maneira simples para sempre saber
-- quem são os top 10 clientes que mais compram com a empresa.
-- Pode-se criar uma view para resolver isso!
CREATE VIEW top_10_customers AS
    SELECT c.customer_id, c.first_name, SUM(p.amount) AS total_amount_spent
    FROM sakila.payment p
    INNER JOIN sakila.customer c ON p.customer_id = c.customer_id
    GROUP BY customer_id
    ORDER BY total_amount_spent DESC
    LIMIT 10;

-- Para acessar, basta acessar com um SELECT
SELECT * FROM top_10_customers;

-- Para excluir uma VIEW, basta executar o comando
DROP VIEW nome_da_view;

-- Conteúdo sobre ALTER TABLE