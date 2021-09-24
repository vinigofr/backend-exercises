-- Manipulação de strings.

-- Converte texto para UPPERCASE
SELECT UPPER('String');  
SELECT UCASE('String');

-- Converte texto para lowercase
SELECT LOWER('String');
SELECT LCASE('String');

-- REPLACE, recebe três parâmetros:
-- 1. String a ser modificada
-- 2. String 'alvo'
-- 3. String substituta.
-- Substitui as ocorrências de uma substring em uma string
SELECT REPLACE('Oi, eu sou uma string', 'string', 'cadeia de caracteres');
-- Saída: 'Oi, eu sou uma cadeia de caracteres'

-- Retorna a parte da esquerda de uma string de acordo com um índice específico que começa em 1.
SELECT LEFT('Oi, eu sou uma string', 3);
-- Saída: 'Oi,'
SELECT LEFT('Oi, eu sou uma string', 4);
-- Saída: 'Oi, '

-- Retorna a parte da direita de uma string de acordo com um índice específico que começa em 1.
SELECT RIGTH('Oi, eu sou uma string', 6);
-- Saída: 'String'

-- Exibe o tamano de uma string
SELECT LENGTH('Oi, eu sou uma string');

-- Extrai parte de uma string de acordo com o índice de um caractere inicial
-- e a quantidade de caracteres a extrair
SELECT SUBSTRING('Oi, eu sou uma string', 5, 2);

-- Se a quantidade de caracteres a extrair não for definida,
-- então a string será extraída do índice inicial definido, até o seu final
SELECT SUBSTRING('Oi, eu sou uma string', 5);

-- Agora, vamos fixar os aprendizados com alguns desafios:
-- Faça uma query que exiba a palavra 'trybe' em CAIXA ALTA.
SELECT UPPER('trybe');
-- Faça uma query que transforme a frase 'Você já ouviu falar do DuckDuckGo?' em 'Você já ouviu falar do Google?'.
SELECT REPLACE('Você já ouviu falar do DuckDuckGo?', 'DuckDuckGo', 'Google');
-- Utilizando uma query , encontre quantos caracteres temos em 'Uma frase qualquer' .
SELECT LENGTH('Uma frase qualquer');
-- Extraia e retorne a palavra "JavaScript" da frase 'A linguagem JavaScript está entre as mais usadas'.
SELECT SUBSTRING('A linguagem JavaScript está entre as mais usadas', 13, 10);
-- Por fim, padronize a string 'RUA NORTE 1500, SÃO PAULO, BRASIL' para que suas informações estejam todas em caixa baixa.
SELECT LOWER('RUA NORTE 1500, SÃO PAULO, BRASIL');

----------------------------------------------------------------------

-- Utilizando situações condicionais em MySQL
-- Para utilizar situações condicionais, é necessário utilizar o comando IF.
-- O comando IF recebe três parâmetros:
-- 1. Condição
-- 2. Resultado caso a condição seja verdadeira
-- 3. Resultado caso a condição seja falsa
-- Sintaxe:
SELECT IF(condicao, valor_se_verdadeiro, valor_se_falso);

SELECT IF(idade >= 18, 'Maior de idade', 'Menor de Idade')
FROM pessoas;

SELECT IF(aberto, 'Entrada permitida', 'Entrada não permitida')
FROM estabelecimentos;

-- Exemplo utilizando o banco sakila:
SELECT first_name, IF(active, 'Cliente Ativo', 'Cliente Inativo') AS status
FROM sakila.customer
LIMIT 20;

-- Sintaxe utilizando o CASE:
-- Sintaxe:
SELECT CASE
  WHEN condicao THEN valor
  ELSE valor padrao
END;

-- Exemplo:
SELECT
    nome,
    nivel_acesso,
    CASE
        WHEN nivel_acesso = 1 THEN 'Nível de acesso 1'
        WHEN nivel_acesso = 2 THEN 'Nível de acesso 2'
        WHEN nivel_acesso = 3 THEN 'Nível de acesso 3'
        ELSE 'Usuário sem acesso'
    END AS nivel_acesso
FROM permissoes_usuario;

-- Exemplo utilizando a tabela sakila.film:
SELECT
    first_name,
    email,
    CASE
        WHEN email = 'MARY.SMITH@sakilacustomer.org' THEN 'Cliente de baixo valor'
        WHEN email = 'PATRICIA.JOHNSON@sakilacustomer.org' THEN 'Cliente de médio valor'
        WHEN email = 'LINDA.WILLIAMS@sakilacustomer.org' THEN 'Cliente de alto valor'
        ELSE 'não classificado'
    END AS valor
FROM sakila.customer
LIMIT 10;

-- Exercício:
-- Usando o IF na tabela sakila.film , exiba o id do filme,
-- o título e uma coluna extra chamada 'conheço o filme?',
-- em que deve-se avaliar se o nome do filme é ' ACE GOLDFINGER '.
-- Caso seja, exiba "Já assisti a esse filme". Caso contrário, exiba
-- "Não conheço o filme". Não esqueça de usar um alias para renomear 
-- a coluna da condicional.
select * from sakila.film;

SELECT film_id, title,
IF(title LIKE '%ACE GOLDFINGER%', 'Sim', 'Não')
AS 'Conheço esse filme?' FROM sakila.film;

-- Usando o CASE na tabela sakila.film, exiba o título, a classificação
-- indicativa ( rating ) e uma coluna extra que vamos chamar de 'público-alvo',
-- em que classificaremos o filme de acordo com as seguintes siglas:

-- G: "Livre para todos";
-- PG: "Não recomendado para menores de 10 anos";
-- PG-13: "Não recomendado para menores de 13 anos";
-- R: "Não recomendado para menores de 17 anos";
-- Se não cair em nenhuma das classificações anteriores: "Proibido para menores de idade".
SELECT title, rating,
  CASE
    WHEN rating = 'G' THEN 'Livre para todos os públicos'
    WHEN rating = 'PG' THEN 'Não recomendado para menores de 10 anos'
    WHEN rating = 'PG-13' THEN 'Não recomendado para menores de 13 anos'
    WHEN rating = 'R' THEN 'Não recomendado para menores de 17 anos'
  ELSE 'Sem classificação indicativa'
  END AS 'Classificações'
 FROM sakila.film;

-- Funções matemáticas MySQL.
SELECT 5 + 5;
SELECT 5 - 5;
SELECT 5 * 5;
SELECT 5 / 5;
-- Funções matemáticas para obter novos dados.
SELECT rental_duration + rental_rate FROM sakila.film LIMIT 10;
SELECT rental_duration - rental_rate FROM sakila.film LIMIT 10;
SELECT rental_duration / rental_rate FROM sakila.film LIMIT 10;
SELECT rental_duration * rental_rate FROM sakila.film LIMIT 10;
-- Divisão que obtem o valor inteiro
SELECT 10 DIV 3; -- 3
SELECT 10 DIV 2; -- 5
SELECT 14 DIV 3; -- 4
SELECT 13 DIV 2; -- 6
-- Capturando o resto
SELECT 10 MOD 3; -- 1
SELECT 10 MOD 2; -- 0
SELECT 14 MOD 3; -- 2
SELECT 13 MOD 2; -- 1
SELECT 10.5 MOD 2; -- 0.5, ou seja, 2 + 2 + 2 + 2 + 2 = 10, restando 0.5

-- Monte uma query usando o MOD juntamente com o IF para descobrir se o 
-- valor 15 é par ou ímpar. Chame essa coluna de 'Par ou Ímpar' , onde ela 
-- pode dizer 'Par' ou 'Ímpar'.
SELECT IF (15 MOD 2 = 0, 'Par', 'Impar') AS 'Par ou Ímpar';

-- Temos uma sala de cinema que comporta 220 pessoas. Quantos grupos 
-- completos de 12 pessoas podemos levar ao cinema sem que ninguém fique 
-- de fora?
SELECT 220 DIV 12;
-- Utilizando o resultado anterior, responda à seguinte pergunta: temos lugares sobrando? Se sim, quantos?
SELECT 220 MOD 12;

-- Arredondando valores no MySQL
-- Podemos omitir ou especificar quantas casas decimais queremos
SELECT ROUND(10.4925); -- 10
SELECT ROUND(10.5136); -- 11
SELECT ROUND(-10.5136); -- -11
SELECT ROUND(10.4925, 2); -- 10.49
SELECT ROUND(10.4925, 3); -- 10.493

-- Arredondando para cima:
SELECT CEIL(10.51); -- 11
SELECT CEIL(10.49); -- 11
SELECT CEIL(10.2); -- 11

-- Arredondando para baixo:
SELECT FLOOR(10.51); -- 10
SELECT FLOOR(10.49); -- 10
SELECT FLOOR(10.2); -- 10

-- Exponenciação: ou poência de
SELECT POW(2, 2); -- 4

-- Raiz Quadrada de:
SELECT SQRT(9); -- 3
SELECT SQRT(16); -- 4

-- Números aleatórios:
-- Para gerar um valor aleatório entre 0 e 1:
SELECT RAND();

-- Para gerar um valor entre 7 e 13:
SELECT ROUND(7 + (RAND() * 6));

-- Monte uma query que gere um valor entre 15 e 20.
SELECT ROUND(15 + (RAND() * 5));

-- Monte uma query que exiba o valor arredondado de 15.7515971 com uma precisão de 5 casas decimais.
SELECT ROUND(15.7515971, 5);

-- Estamos com uma média de 39.494 de vendas de camisas por mês. Qual é o valor aproximado para baixo dessa média?
SELECT FLOOR(39.494);
-- Temos uma taxa de inscrição de 85.234% no curso de fotografia para iniciantes. Qual é o valor aproximado para cima dessa média?
SELECT CEIL(85.234);

-- Outros métodos para consulta de datas.
SELECT CURRENT_DATE(); -- YYYY-MM-DD
SELECT NOW(); -- YYYY-MM-DD HH:MM:SS

-- Também é possível calcular a diferença de dias e minutos.
-- A primeira data é 30 dias depois da segunda, retorna um inteiro
SELECT DATEDIFF('2020-01-31', '2020-01-01');

-- A primeira data é 30 dias antes da segunda, retorna um inteiro
SELECT DATEDIFF('2020-01-01', '2020-01-31');

-- Há 1 hora de diferença entre os horários, o resultado vem no formado HH:MM:SS
SELECT TIMEDIFF('08:30:10', '09:30:10');

-- Para fixar:
-- Monte uma query que exiba a diferença de dias entre '2030-01-20' e hoje.
SELECT DATEDIFF('2030-01-20', '2021-08-24'); -- 3071

-- Monte uma query exiba a diferença de horas entre '10:25:45' e '11:00:00'.
SELECT TIMEDIFF('10:25:45', '11:00:00'); -- 3071

-- Funções de agragação, AVG , MIN , MAX , SUM e COUNT
-- Usando a coluna replacement_cost (valor de substituição) vamos encontrar:
SELECT AVG(replacement_cost) FROM sakila.film; -- 19.984000 (Média entre todos registros)
SELECT MIN(replacement_cost) FROM sakila.film; -- 9.99 (Menor valor encontrado)
SELECT MAX(replacement_cost) FROM sakila.film; -- 29.99 (Maior valor encontrado)
SELECT SUM(replacement_cost) FROM sakila.film; -- 19984.00 (Soma de todos registros)
SELECT COUNT(replacement_cost) FROM sakila.film; -- 1000 registros encontrados (Quantidade)

-- Exercício:
-- A média de duração dos filmes e dê o nome da coluna de 'Média de Duração';
SELECT AVG(length) AS 'Média de Duração' FROM sakila.film;
-- A duração mínima dos filmes como 'Duração Mínima';
SELECT MIN(length) AS 'Duração Mínima' FROM sakila.film;
-- A duração máxima dos filmes como 'Duração Máxima';
SELECT MAX(length) AS 'Duração Máxima' FROM sakila.film;
-- A soma de todas as durações como 'Tempo de Exibição Total';
SELECT SUM(length) AS 'Tempo de Exibição Total' FROM sakila.film;
-- E finalmente, a quantidade total de filmes cadastrados na tabela sakila.film como 'Filmes Registrados'.
SELECT COUNT(*) AS 'Filmes Registrados' FROM sakila.film;

-- Exibindo e filtrando dados de forma agrupada com GROUP BY e HAVING
-- Sintaxe do GROUP BY:
SELECT coluna(s) FROM tabela
GROUP BY coluna(s);

-- Uma das formas como podemos utilizar o GROUP BY é agrupar os registros
-- pelo valor de uma coluna, exibindo apenas um registro de cada valor,
-- como é feito com a coluna first_name a seguir.
SELECT first_name FROM sakila.actor
GROUP BY first_name;

-- Vale lembrar que o GROUP BY remove todos os dados cujos valores são iguais,
-- retornando apenas nomes distintos.
-- Como dito, o GROUP BY removerá duplicações, retornando apenas um valor da coluna usada no agrupamento.
--
-- Utilizando GROUP BY em conjunto com diversas funções de agregação, usando sakilka.
-- Média de duração de filmes agrupados por classificação indicativa
SELECT rating, AVG(length)
FROM sakila.film
GROUP BY rating;

-- Valor mínimo de substituição dos filmes agrupados por classificação indicativa
SELECT rating, MIN(replacement_cost)
FROM sakila.film
GROUP BY rating;

-- Valor máximo de substituição dos filmes agrupados por classificação indicativa
SELECT rating, MAX(replacement_cost)
FROM sakila.film
GROUP BY rating;

-- Custo total de substituição de filmes agrupados por classificação indicativa
SELECT rating, SUM(replacement_cost)
FROM sakila.film
GROUP by rating;

-- Prática de GROUP BY:
-- 1. Monte uma query que exiba a quantidade de clientes cadastrados na
-- tabela sakila.customer que estão ativos e a quantidade que estão inativos.
SELECT active, COUNT(active)
FROM sakila.customer
GROUP BY active;

-- Monte uma query para a tabela sakila.customer que exiba a quantidade de
-- clientes ativos e inativos por loja. Os resultados devem conter o ID da
-- loja, o status dos clientes (ativos ou inativos) e a quantidade de clientes por status.
SELECT store_id, active, COUNT(active)
FROM sakila.customer 
GROUP BY active, store_id;

-- Monte uma query que exiba a média de duração de locação por classificação
-- indicativa ( rating ) dos filmes cadastrados na tabela sakila.film. 
-- Os resultados devem ser agrupados pela classificação indicativa e ordenados
-- da maior média para a menor.
SELECT rating, AVG(`length`)
FROM sakila.film GROUP BY rating
ORDER BY rating DESC;

-- Monte uma query para a tabela sakila.address que exiba o nome do distrito
-- e a quantidade de endereços registrados nele. Os resultados devem ser
-- ordenados da maior quantidade para a menor.
SELECT district, COUNT(district)
FROM sakila.address GROUP BY district
ORDER BY district DESC;

-- Utilizando o HAVING:

--SELECT first_name, COUNT(*)
FROM sakila.actor
GROUP BY first_name
HAVING COUNT(*) > 2;

-- Ou, melhor ainda, usando o AS para dar nomes às colunas de agregação,
-- melhorando a leitura do resultado
SELECT first_name, COUNT(*) AS nomes_cadastrados
FROM sakila.actor
GROUP BY first_name
HAVING nomes_cadastrados > 2;

-- Observação: o alias não funciona com strings para o HAVING,
-- então use o underline ("_") para separar palavras
-- Ou seja, o exemplo abaixo não vai funcionar
SELECT first_name, COUNT(*) AS 'nomes cadastrados'
FROM sakila.actor
GROUP BY first_name
HAVING 'nomes cadastrados' > 2;