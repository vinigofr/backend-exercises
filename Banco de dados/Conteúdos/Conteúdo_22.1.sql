-- Existem alguns passos a serem seguidos durante a modelagem e criação de um banco de dados. Um fluxo bastante comum nesse processo consiste em:
-- 1. Identificar as entidades , atributos e relacionamentos com base na descrição do problema;
-- 2. Construir um diagrama entidade-relacionamento para representar as entidades encontradas no passo 1;
-- 3. Criar um banco de dados para conter suas tabelas;
-- 4. Criar e modelar tabelas tendo o diagrama do passo 2 como base.

-- Entidades: São uma representação de algo do mundo real dentro do banco de dados. Elas normalmente englobam toda uma ideia e são armazenadas em formato de tabelas em um banco de dados.
-- EX:
-- Entidade 1: `Álbum`;
-- Entidade 2: `Artista`;
-- Entidade 3: `Estilo Musical`;
-- Entidade 4: `Canção`.

-- Atributos: Os atributos são tudo aquilo que pode ser usado para descrever algo. Por exemplo, uma entidade pessoa pode ter nome, altura, peso e idade.3
-- EX:
-- Álbum: `album_id`, `titulo`, `preco`, `estilo_id` e `artista_id`;
-- Artista: `artista_id` e `nome`;
-- Estilo Musical: `estilo_id` e `nome`;
-- Canção: `cancao_id`, `nome` e `album_id`.

-- Relacionamentos: Os relacionamentos servem para representar como uma entidade deve estar ligada com outra(s) no banco de dados. Há três tipos de relacionamentos possíveis em um banco de dados
-- Relacionamentos 1:1, 1:n, n:1, n:n

-- CHAR(10) = Ocupa um tamanho fixo e não variável.
-- VARCHAR(10) = Tamanho fixo setado, porém caso seja ocupado menos do que foi estipulado, ele ocupará apenas aquele espaço.
 
-- TINYINT = 0 a 255 UNSIGNED todos POSITIVOS OU SIGNED DE -128 a 127
-- UNSIGNED = Permite armazenar valores somente positivos.
-- UNSIGNED = Permite armazenar ambos

-- DECIMAL = Permite definir quaantidade máxima e precisão (5,2) = 199,99
-- FLOAT/REAL = Tem a precisão de uma casa decimal. 10,9

-- DOUBLE - Tem a precisão de duas casas decimai. EX: 49,90

-- Todos os valores temporais já conhecidos em blocos anteriores.

---------------------------

-- Sobre FOREIGN KEYS e PRIMARY KEYS
-- Um exemplo de criação de tabela e colunas se dá como o seguinte exemplo:
-- FOREIGN KEYS: Uma chave estrangeira é uma coluna ou grupo de colunas em uma tabela que identifica unicamente
-- uma linha em outra tabela

CREATE TABLE nome (
  nome_coluna tipo_de_dado PRIMARY KEY
  nome_coluna tipo_de_dados...  
)

-- Quando é necessária a criação de duas chaves primárias em uma tabela, faremos isso usando CHAVES PRIMÁRIAS COMPOSTAS.
-- A sintaxe é a seguinte:
    DROP SCHEMA IF EXISTS Brasil;
    CREATE SCHEMA Brasil;
    USE Brasil;

    CREATE TABLE cidades(
        cidade VARCHAR(100) NOT NULL,
        estado VARCHAR(10) NOT NULL,
        populacao INTEGER,
        CONSTRAINT PRIMARY KEY(cidade, estado)
    );

    INSERT INTO cidades(cidade, estado, populacao)
    VALUES('Rio Claro','SP',185421),
          ('Rio Claro','RJ',17216);

-- Na linha 60, passamos como parâmetro para o CONSTRAINT PRIMARY KEY duas colunas. Se for passado apenas uma
-- será retornado um erro, devido à primeira coluna não poder receber dados duplicados.

-- Sintaxe para fazer referências de chaves estrangeiras:
 CREATE TABLE filme_ator(
        AtorId INTEGER,
        FilmeId INTEGER,
        CONSTRAINT PRIMARY KEY(AtorId, FilmeId),
        FOREIGN KEY (AtorId) REFERENCES Actor (Atorid),
        FOREIGN KEY (FilmeId) REFERENCES Filme (Filmeid)
    );
