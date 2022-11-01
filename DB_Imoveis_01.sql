
USE DBimoveis

--Atividade 01--

/* 1. Altere a tabela de forma a incluir as restrições para que o preenchimento
seja obrigatório nas colunas vl_Oferta na tabela Oferta e nm_Comprador na
tabela Comprador. */

ALTER TABLE tbOferta
	ALTER COLUMN vl_Oferta MONEY NOT NULL

ALTER TABLE tbComprador
	ALTER COLUMN nm_Comprador VARCHAR(20) NOT NULL

/* 2. Altere a tabela de forma a incluir as restrições de integridades, usando
PK_Imovel para a restrição da chave primária na tabela Imóvel. */

ALTER TABLE tbOferta
	DROP CONSTRAINT FK__tbOferta__cd_Imo__48CFD27E

ALTER TABLE tbImovel
	DROP CONSTRAINT PK__tbImovel__54ED318D3E8060A2

ALTER TABLE tbImovel
	ADD CONSTRAINT PK_Imovel PRIMARY KEY (cd_Imovel)

ALTER TABLE tbOferta
	ADD CONSTRAINT FK_Imovel FOREIGN KEY (cd_Imovel)
	REFERENCES tbImovel

/* 3. Adicionar uma coluna qt_Parcelas do tipo número inteiro na tabela Oferta,
já criada e essa coluna deve aceitar números maiores que 1, usando o
nome CK_qtParcela para a restrição. */

ALTER TABLE tbOferta
	ADD qt_Parcela INT CONSTRAINT CK_qtParcela CHECK (qt_Parcela > 1)

-- 4. Renomear a coluna qt_Parcelas para qt_Parcelamento

ALTER TABLE tbOferta
	DROP CONSTRAINT CK_qtParcela

EXEC SP_RENAME 'tbOferta.qt_Parcela', 'qt_Parcelamento'

ALTER TABLE tbOferta
	ADD CONSTRAINT CK_Parcelamento CHECK (qt_Parcelamento BETWEEN 1 AND 10)

-- 5. Renomear a tabela Faixa_Imovel para Faixa_Valor

EXEC SP_RENAME 'tbFaixaImovel', 'tbFaixaValor'

/* 6. Incluir uma restrição de nome CK_dtOferta, na tabela de Oferta indicando
que a coluna dt_Oferta deve possuir no ano da data da Oferta o mesmo
ano da data do sistema. */

ALTER TABLE tbOferta
	ADD CONSTRAINT CK_dtOferta CHECK (Year(dt_Oferta) = Year(GetDate()))

/* 7. Incluir uma restrição de nome CK_qtAreaUtil, na tabela de Imovel indicando
que a coluna qt_AreaUtil deve ser menor ou igual a coluna qt_AreaTotal. */

ALTER TABLE tbImovel
	ADD CONSTRAINT CK_qtAreaUtil CHECK (qt_AreaUtil <= qt_AreaTotal)

-- 8. Destrua a coluna qt_Parcelamento da tabela Oferta

ALTER TABLE tbOferta
	DROP CONSTRAINT CK_Parcelamento

ALTER TABLE tbOferta
	DROP COLUMN qt_parcelamento
 	
-- 9. Destrua a restrição da coluna qt_AreaUtil da tabela Imóvel.

ALTER TABLE tbImovel
	DROP CONSTRAINT CK_qtAreaUtil
