
USE DBimoveis

--Atividade 02--

/* 1. Criar a tabela relacionada anteriormente, utilizando uma instrução SQL sem
especificar as (chaves) restrições de integridade. */

CREATE TABLE tbIptuImovel (
	  
	  cd_Imovel INT NOT NULL
	, cd_Parcela INT NOT NULL
	, aa_Iptu INT NOT NULL
	, dt_Vencimento DATETIME
	, vl_Parcela MONEY
	, dt_Pago DATETIME
	, vl_Pago MONEY
	, vl_Multa MONEY
	, cd_Comprador INT 
)

/* 2. Altere a tabela de forma a incluir as restrições de integridades, usando
PK_Iptu para a restrição da chave primária. */

ALTER TABLE tbIptuImovel
	ADD CONSTRAINT PK_Iptu PRIMARY KEY (cd_Imovel, cd_Parcela)

/* 3. Crie um relacionamento entre a tabela IptuImovel e a tabela Comprador,
usando FK_Comprador para a restrição da chave estrangeira. */

ALTER TABLE tbIptuImovel
	ADD CONSTRAINT FK_Comprador FOREIGN KEY (cd_Comprador)
	REFERENCES tbComprador

/* 4. Adicionar uma coluna qt_NParcela do tipo número inteiro na tabela IptuImovel,
já criada e essa coluna deve aceitar números entre 1 a 12. */

ALTER TABLE tbIptuImovel
	ADD qt_Nparcela INT CONSTRAINT CK_qtNParcela CHECK( qt_NParcela BETWEEN 1 AND 12)

-- 5. Renomear a coluna vl_Pago para vl_Pagamento.

EXEC SP_RENAME 'tbIptuImovel.vl_Pago', 'vl_Pagamento'

-- 6. Renomear a tabela IptuImovel para IPTU_Imovel

EXEC SP_RENAME	'tbIptuImovel', 'tbIPTU_Imovel'

/* 7. Incluir uma restrição de nome CK_dt_Vencimento, na tabela de IPTU_Imovel
indicando que a coluna dt_Vencimento deve possuir no ano da data do
vencimento o mesmo ano indicado na coluna aa_Iptu. */

ALTER TABLE tbIPTU_Imovel
	ADD CONSTRAINT CK_dt_Vencimento CHECK (Year(dt_Vencimento) = aa_Iptu)

/* 8. Criar uma restrição na coluna vl_Pagamento para não receber valores inferior
ao valor da coluna vl_Parcela. */

ALTER TABLE tbIPTU_Imovel
	ADD CONSTRAINT CK_vl_Pago CHECK (vl_Pagamento >= vl_Parcela)

-- 9. Destrua a coluna qt_NParcela da tabela IPTU_Imovel

ALTER TABLE tbIPTU_Imovel
	DROP CONSTRAINT CK_qtNParcela

ALTER TABLE tbIptu_Imovel
	DROP COLUMN qt_NParcela

-- 10. Destrua a restrição da coluna dt_Vencimento

ALTER TABLE tbIPTU_Imovel
	DROP CONSTRAINT CK_dt_Vencimento

/* 11. Altere a chave primária da tabela IPTU_Imovel para incluir a coluna aa_Iptu na
composição da chave. (cd_Imovel, cd_Parcela, aa_Iptu) */ALTER TABLE tbIPTU_Imovel	DROP CONSTRAINT PK_IptuALTER TABLE tbIPTU_Imovel	ADD CONSTRAINT PK_Iptu PRIMARY KEY (cd_Imovel, cd_Parcela, aa_Iptu)-- 12. Apague a tabela IPTU_Imovel.DROP TABLE tbIPTU_Imovel