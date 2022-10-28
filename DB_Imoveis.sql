
CREATE DATABASE DBimoveis

USE DBimoveis

--------CRIAR TABELAS----------

CREATE TABLE tbVendedor (
	 
	  cd_Vendedor INT NOT NULL
	, nm_Vendedor VARCHAR(40) NULL
	, ds_Endereco VARCHAR(40) NULL
	, cd_CPF VARCHAR(11) NULL
	, nm_Cidade VARCHAR(20) NULL
	, nm_Bairro VARCHAR(20) NULL
	, sg_Estado CHAR(2) NULL
	, cd_Telefone VARCHAR(20) NULL
	, ds_Email VARCHAR(80) NULL
)

CREATE TABLE tbImovel (
	  
	  cd_Imovel INT NOT NULL
	, cd_Vendedor INT NULL
	, cd_Bairro INT NULL
	, cd_Cidade INT NULL
	, sg_Estado CHAR(2) NULL
	, ds_Endereco VARCHAR(40) NULL
	, qt_AreaUtil DECIMAL(10,2) NULL
	, qt_AreaTotal DECIMAL(10,2) NULL
	, ds_Imovel VARCHAR(300) NULL
	, vl_Imovel MONEY NULL
	, qt_Oferta INT NULL
	, ic_Vendido CHAR(1) NULL
	, dt_Lancto DATETIME NULL
	, qt_ImovelIndicado INT NULL
)

CREATE TABLE tbEstado (

	  sg_Estado CHAR(02) NOT NULL
	, nm_Estado VARCHAR(20) NULL
)

CREATE TABLE tbCidade (

	  cd_Cidade INT NOT NULL
	, sg_Estado CHAR(2) NOT NULL
	, nm_Cidade VARCHAR(20) NULL
)

CREATE TABLE tbBairro (

	  cd_Bairro INT NOT NULL
	, cd_Cidade INT NOT NULL
	, sg_Estado CHAR(2) NOT NULL
	, nm_Bairro VARCHAR(20) NULL
)

CREATE TABLE tbFaixaImovel (
	  
	  cd_Faixa INT NOT NULL
	, nm_Faixa VARCHAR(30) NULL
	, vl_Maixmo MONEY NULL
	, vl_Minimo MONEY NULL
)

CREATE TABLE tbOferta (

	  cd_Comprador INT NOT NULL
	, cd_Imovel INT NOT NULL
	, vl_Oferta MONEY NULL
	, dt_Oferta DATETIME NULL
)

CREATE TABLE tbComprador (
	  cd_Comprador INT NOT NULL
	, nm_Comprador VARCHAR(20) NULL
	, ds_Endereco VARCHAR(20) NULL
	, cd_CPF VARCHAR(11) NULL
	, nm_Cidade VARCHAR(20) NULL
	, nm_Bairro VARCHAR(20) NULL
	, sg_Estado CHAR(2) NULL
	, cd_Telefone VARCHAR(20) NULL
	, ds_Email VARCHAR(20) NULL
)

-------- CHAVES PRIMARIAS ----------

ALTER TABLE tbVendedor
	ADD PRIMARY KEY (cd_Vendedor)

ALTER TABLE tbImovel
	ADD PRIMARY KEY (cd_Imovel)

ALTER TABLE tbEstado
	ADD PRIMARY KEY (sg_Estado)

ALTER TABLE tbCidade
	ADD PRIMARY KEY (cd_Cidade, sg_Estado)

ALTER TABLE tbBairro
	ADD PRIMARY KEY (cd_Bairro, cd_Cidade, sg_Estado)

ALTER TABLE tbFaixaImovel
	ADD PRIMARY KEY (cd_Faixa)

ALTER TABLE tbOferta
	ADD PRIMARY KEY (cd_Comprador, cd_Imovel)

ALTER TABLE tbComprador
	ADD PRIMARY KEY (cd_Comprador)

-------- CHAVES ESTRANGEIRAS ----------

ALTER TABLE tbImovel
	ADD FOREIGN KEY (cd_Vendedor)
	REFERENCES tbVendedor

ALTER TABLE tbImovel
	ADD FOREIGN KEY (cd_Bairro, cd_Cidade, sg_Estado)
	REFERENCES tbBairro

ALTER TABLE tbCidade
	ADD FOREIGN KEY (sg_Estado)
	REFERENCES tbEstado

ALTER TABLE tbBairro
	ADD FOREIGN KEY (cd_Cidade, sg_Estado)
	REFERENCES tbCidade

ALTER TABLE tbOferta
	ADD FOREIGN KEY (cd_Imovel)
	REFERENCES tbImovel

ALTER TABLE tbOferta
	ADD FOREIGN KEY (cd_Comprador)
	REFERENCES tbComprador