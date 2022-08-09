

CREATE DATABASE vendasJoao
GO
/*=================================================== Criação e atribuição de PK nas tabelas ===================================================*/
IF OBJECT_ID('tbVenda','u') IS NOT NULL DROP TABLE tbVenda
CREATE TABLE tbVenda (
	  cdVendas INT NOT NULL
	, dtVenda DATETIME NOT NULL
	, vlTotal MONEY NOT NULL
)
GO
IF OBJECT_ID('tbVendaProduto','u') IS NOT NULL DROP TABLE tbVendaProduto
CREATE TABLE tbVendaProduto (
	  cdVenda INT NOT NULL
	, cdProduto INT NOT NULL
	, qtVendida INT
)
GO
IF OBJECT_ID('tbProduto','u') IS NOT NULL DROP TABLE tbProduto
CREATE TABLE tbProduto (
	  cdProduto INT NOT NULL
	, dsProduto VARCHAR(40) NOT NULL
	, vlProduto MONEY
)
GO
ALTER TABLE tbVenda
	ADD PRIMARY KEY (cdVenda)
GO
ALTER TABLE tbVendaProduto
	  ADD FOREIGN KEY (cdVenda)
	  REFERENCES tbVenda
GO
ALTER TABLE tbVendaProduto
	  ADD FOREIGN KEY (cdProduto)
	  REFERENCES tbProduto
GO
ALTER TABLE tbProduto
	ADD PRIMARY KEY (cdProduto)