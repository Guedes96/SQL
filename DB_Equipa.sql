
CREATE DATABASE DBequipa

USE DBequipa

CREATE TABLE tbEquipamento(
	  cd_Equipamento INT NOT NULL
	, ds_Equipamento VARCHAR(40)
)
CREATE TABLE tbFornecedor(
	  cd_Fornecedor INT NOT NULL
	, nm_Fornecedor VARCHAR(40)
	, nm_Matriz VARCHAR(40)
)
CREATE TABLE tbCusto(
	  cd_Fornecedor INT NOT NULL
	, cd_Equipamento INT NOT NULL
	, vl_Custo MONEY
)
ALTER TABLE tbEquipamento
	ADD CONSTRAINT PK_Equipamento PRIMARY KEY (cd_Equipamento)

ALTER TABLE tbFornecedor
	ADD CONSTRAINT PK_Fornecedor PRIMARY KEY (cd_Fornecedor)

INSERT INTO tbEquipamento
	VALUES (2000, 'Servidores Alpha')
		 , (3000, 'Servidores Intel')
		 , (4020, 'Placa de vídeo de 2GB')
		 , (4040, 'Placa de vídeo de 4GB')
		 , (4100, 'Placa bluetooth notebook')
		 , (4200, 'Placa bluetooth PC')
		 , (4300, 'Placa mãe Asus')
		 , (4400, 'Placa mãe pata Gamer')
		 , (4501, 'Placa de rede NE 2000')
		 , (4502, 'Placa de rede DEC 305')
		 , (4503, 'Placa de rede 3com')
		 , (4504, 'Placa de rede SMC')
		 , (5010, 'Hard Disk 1TB')
		 , (5020, 'Hard Disk 2TB')
		 , (5021, 'Hard Disk 1TB S2SI')
		 , (5040, 'Hard Disk 4TB')
		 , (6020, 'Pente de memória 8GB')

INSERT INTO	tbFornecedor
	VALUES (001, 'ISM', 'São Paulo')
		 , (002, 'M.A Informática', 'Rio de Janeiro')
		 , (003, 'Decatron', 'Rio de Janeiro')
		 , (004, 'S&S Systems', 'Santos')
		 , (005, 'Enterdata', 'Santos')
		 , (006, 'Sisgraph', 'São Paulo')
		 , (007, 'Digital', 'Rio de Janeiro')
		 , (008, 'NetDb', 'Santos')
		 , (009, 'CenterSoft', 'Santos')
		 , (010, 'TrTec', 'Campinas')

INSERT INTO  tbCusto
	VALUES (001, 5010, 130)
		 , (001, 4040, 100)
		 , (010, 4501, 60)
		 , (009, 4400, 200)
		 , (008, 4200, 230)
		 , (007, 2000, 80000)
		 , (006, 3000, 42000)
		 , (005, 4502, 150)
		 , (004, 4020, 90)
		 , (002, 4020, 85)
		 , (003, 2000, 65000)
		 , (001, 6020, 250)
		 , (004, 4100, 198)
		 , (005, 4100, 190)
		 , (008, 4504, 180)

-- Atividade --

/* 1. Escreva uma instrução em SQL para alterar a
tabela Custo de forma a incluir a chave primária
nomeando a restrição para PK_Custo e as chaves
estrangeiras, nomeando as restrições para
FK_Equipamento e FK_Fornecedor. */

ALTER TABLE tbCusto
	ADD CONSTRAINT PK_Custo PRIMARY KEY (cd_Fornecedor, cd_Equipamento)

ALTER TABLE tbCusto
	ADD CONSTRAINT FK_Fornecedor FOREIGN KEY (cd_Fornecedor)
	REFERENCES tbFornecedor

ALTER TABLE tbCusto
	ADD CONSTRAINT FK_Equipamento FOREIGN KEY (cd_Equipamento)
	REFERENCES tbEquipamento

/* 2. Crie uma instrução para adicionar a coluna
qt_Equipamento na tabela Custo, essa coluna
deve aceitar números inferior a 20. Depois
escreva outra instrução para remover a coluna
qt_Equipamento da tabela Custo. */

ALTER TABLE tbCusto
	ADD qt_Equipamento INT CONSTRAINT CK_Equipamento CHECK (qt_Equipamento < 20)

ALTER TABLE tbCusto
	DROP CONSTRAINT CK_Equipamento

ALTER TABLE tbCusto
	DROP COLUMN qt_Equipamento

-- 3. Renomear a coluna vl_Custo para vl_Equipamento.

EXEC SP_RENAME 'tbCusto.vl_Custo', 'vl_Equipamento'

/* 4. Criar um comando para excluir da tabela Custo,
os registros que possuem o código do fornecedor
maior igual a 5 e que possuem o valor maior que
150,00. */ 

DELETE FROM tbCusto
	WHERE cd_Fornecedor >= 5 AND vl_Equipamento > 150

/* 5. Alterar o valor dos equipamentos dos
fornecedores 001, 005 e 008 para um aumento de
13,80% somente os valores maiores que R$
120,00 e 15,20% para o valores menores iguais a
R$ 120,00. */

UPDATE tbCusto
	SET vl_Equipamento = vl_Equipamento * 1.138
	WHERE vl_Equipamento > 120

UPDATE tbCusto
	SET vl_Equipamento = vl_Equipamento * 1.152
	WHERE vl_Equipamento <= 120
	
/* 6. Apresente o comando para gerar uma listagem
com os códigos dos Equipamentos que possuem
ao menos dois Fornecedores, mostrando a
quantidade de Fornecedores por Equipamento. */

SELECT cd_Equipamento, COUNT(*) TOTAL
	FROM tbCusto
	GROUP BY cd_Equipamento
	HAVING COUNT(*) > 1

/* 7. Mostrar uma lista por código de fornecedor e a
média dos valores dos equipamentos que atende. */

SELECT cd_Fornecedor, AVG(vl_Equipamento) MEDIA
	FROM tbCusto
	GROUP BY cd_Fornecedor

/* 8. Mostrar uma consulta com os códigos e nomes
dos equipamentos que possuem no nome a
palavra “Hard Disk”. */ 

SELECT cd_Equipamento, ds_Equipamento
	FROM tbEquipamento
	WHERE ds_Equipamento LIKE '%Hard Disk%'

/* 9. Crie uma condição para a tabela Custo, onde o
não aceite valores menor que R$ 100,00. Utilize o
nome CK_vlEquipamento para a restrição. */ALTER TABLE tbCusto	ADD CONSTRAINT CK_Equipamento CHECK (vl_Equipamento >= 100)-- 10. Destrua a chave primária da tabela Custo.ALTER TABLE tbCusto	DROP CONSTRAINT FK_EquipamentoALTER TABLE tbCusto	DROP CONSTRAINT FK_FornecedorALTER TABLE tbCusto	DROP CONSTRAINT PK_Custo