
CREATE DATABASE DBteste

USE DBteste

--------CRIAR TABELAS----------

CREATE TABLE tbVenda (
	
	  cd_Venda INT NOT NULL
	, dt_Venda DATETIME
	, vl_Total MONEY
)

CREATE TABLE tbProduto (
	  
	  cd_Produto INT NOT NULL
	, ds_Produto VARCHAR(40)
	, vl_Produto MONEY
)

CREATE TABLE tbVendaProduto (
	  cd_Venda INT NOT NULL
	, cd_Produto INT NOT NULL
	, qt_Vendida INT
)

-------- CHAVES PRIMARIAS ----------

ALTER TABLE tbVenda 
	 ADD PRIMARY KEY (cd_Venda)

ALTER TABLE tbProduto
	 ADD PRIMARY KEY (cd_Produto)

ALTER TABLE tbVendaProduto
	 ADD PRIMARY KEY (cd_Venda, cd_Produto)

-------- CHAVES ESTRANGEIRAS ----------

ALTER TABLE tbVendaProduto
	 ADD FOREIGN KEY (cd_Venda)
	 REFERENCES tbVenda
	
ALTER TABLE tbVendaProduto
	 ADD FOREIGN KEY (cd_produto)
	 REFERENCES tbProduto
