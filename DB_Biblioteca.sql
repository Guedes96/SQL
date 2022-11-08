
CREATE DATABASE DBbiblioteca

USE DBbiblioteca

-- Tabelas --

CREATE TABLE tbAssunto(
	sg_Assunto char(01) not null,
	ds_Assunto varchar(40))

CREATE TABLE tbEditora(
	cd_Editora int not null,
	nm_Editora varchar(40))

CREATE TABLE tbAutor(
	cd_Autor int not null,
	nm_Autor varchar(40),
	ds_EnderecoAutor varchar(50))

CREATE TABLE tbLivro(
	cd_Livro int not null,
	nm_Titulo varchar(30),
	vl_Livro money,
	dt_Lancamento datetime,
	sg_Assunto char(01),
	cd_Editora int)

-- Chaves Primarias --

ALTER TABLE tbAssunto
	ADD CONSTRAINT PK_tbAssunto PRIMARY KEY (sg_Assunto)

ALTER TABLE tbEditora
	ADD CONSTRAINT PK_tbEditora PRIMARY KEY (cd_Editora)

ALTER TABLE tbAutor
	ADD CONSTRAINT PK_tbAutor PRIMARY KEY (cd_Autor)

ALTER TABLE tbLivro
	ADD CONSTRAINT PK_tbLivro PRIMARY KEY (cd_Livro)

-- Chaves Estrangeiras --

ALTER TABLE tbLivro
	ADD CONSTRAINT FK_sg_Assunto FOREIGN KEY (sg_Assunto)
	REFERENCES tbAssunto

ALTER TABLE tbLivro
	ADD CONSTRAINT FK_cd_Editora FOREIGN KEY (cd_Editora)
	REFERENCES tbEditora

-- Registros --

INSERT INTO tbAssunto
	VALUES ('D','DRAMA')
		 , ('A','AVENTURA')
		 , ('C','COMEDIA')

INSERT INTO tbEditora
	VALUES (1,'ERICA')
		 , (2,'CAMPUS')

INSERT INTO tbAutor
	VALUES (1,'MARIA DA SILVA','RUA DO GRITO, 45')
		 , (2,'ANDRE CARDOSO','AV. DA SAUDADE,325')
		 , (3,'TATIANA SOUZA','AV. BRASIL, 4011')		
		 , (4,'MARCO ANDRADE','RUA DO IMPERADOR, 778')

INSERT INTO tbLivro (cd_Livro, nm_Titulo, cd_Editora, sg_Assunto, vl_Livro)
	VALUES (1,'MAR EM FURIA',1,'D',65.00)
		 , (2,'O AEROPORTO',2,'A',30.00)
		 , (3,'EINSTEN',2,'D',4.50)
		 , (4,'MAR SEM FIM',1,'A',58.00)

-- Atividade -- 

/* 1. Criar a tabela Autor_Livro do relacionamento N para N, utilizando uma
instrução SQL sem especificar as (chaves) restrições de integridade.
Depois altere a tabela de forma a incluir a chave primária nomeando a
restrição para PK_AutorLivro e as chaves estrangeiras, nomeando as
restrições para FK_Autor e FK_Livro. */

CREATE TABLE tbAutorLivro(
	cd_Livro INT NOT NULL,
	cd_Autor INT NOT NULL,
)
ALTER TABLE tbAutorLivro
	ADD CONSTRAINT PK_AutorLivro PRIMARY KEY (cd_Livro, cd_Autor)

ALTER TABLE tbAutorLivro
	ADD CONSTRAINT FK_cd_Livro FOREIGN KEY (cd_Livro)
	REFERENCES tbLivro
	ON DELETE CASCADE 

ALTER TABLE tbAutorLivro
	ADD CONSTRAINT FK_cd_Autor FOREIGN KEY (cd_Autor)
	REFERENCES tbAutor
	ON DELETE CASCADE

INSERT INTO tbAutorLivro
	VALUES (1, 3)
		 , (1, 2)
		 , (2, 1)
		 , (3, 4)
		 , (4, 2)
		 , (4, 3)

/* 2. Crie uma instrução para adicionar a coluna qt_Edicao na tabela Livro, essa
coluna deve aceitar números inferior a 20. Depois escreva outra instrução
para remover a coluna qt_Edicao da tabela Livro. */

ALTER TABLE tbLivro
	ADD qt_Edicao INT CONSTRAINT CK_qtEdicao CHECK (qt_Edicao < 20)

ALTER TABLE tbLivro
	DROP CONSTRAINT CK_qtEdicao

ALTER TABLE tbLivro
	DROP COLUMN qt_Edicao

-- 3. Renomear a coluna vl_Livro para vl_VolumeLivro.

EXEC SP_RENAME 'tbLivro.vl_livro', 'vl_VolumeLivro'

/* 4. Criar um comando para excluir da tabela Livros aqueles que possuem o
código maior ou igual a 2, que possuem o preço maior que 50,00 e já foram
lançados. */

DELETE FROM tbLivro
	WHERE cd_Livro >= 2 AND vl_VolumeLivro > 50 AND dt_Lancamento IS NULL

/* 5. Atualizar para zero o valor de todos o Livros onde a data de lançamento for
nula ou onde seu valor atual for inferior a 5,00. */

UPDATE tbLivro
	SET vl_VolumeLivro = 0
	WHERE dt_Lancamento IS NULL OR vl_VolumeLivro < 5

/* 6. Apresente o comando para gerar uma listagem dos códigos dos livros que
possuem ao menos dois autores.*/

SELECT cd_Livro, COUNT(*) CONTAGEM
	FROM tbAutorLivro
	GROUP BY cd_Livro
	HAVING COUNT(*) > 1

/* 7. Escreva o comando para apresentar o preço médio dos livros por código de
editora. Considere somente aqueles que custam mais de 45,00. */

SELECT cd_Editora, AVG(vl_VolumeLivro) MEDIA
	FROM tbLivro
	WHERE vl_VolumeLivro > 45
	GROUP BY cd_Editora

/* 8. Apresente o código do livro, o nome do livro, o nome do assunto de cada
livro e o valor do livro, onde o valor seja diferente de zero e o assunto igual
a “D” ou “A”. */

SELECT L.cd_Livro, L.nm_Titulo, A.ds_Assunto, L.vl_VolumeLivro
	FROM tbLivro L INNER JOIN tbAssunto A
	ON L.sg_Assunto = A.sg_Assunto
	WHERE A.sg_Assunto IN ('D', 'A') AND L.vl_VolumeLivro <> 0

