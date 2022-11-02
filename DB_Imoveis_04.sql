USE DBimoveis

--Atividade 02--

-- 1. Aumente o pre�o de vendas dos im�veis em 12%

UPDATE tbImovel
	SET vl_Imovel = vl_Imovel * 1.12

-- 2. Abaixe o pre�o de venda dos im�veis do vendedor 1 em 5%

UPDATE tbImovel
	SET vl_Imovel = vl_Imovel * 0.95
	WHERE cd_Vendedor = 1

-- 3. Altere o endere�o do comprador 3 para R. ANAN�S, 45 e o estado para RJ

UPDATE tbComprador
	SET ds_Endereco = 'R. ANANAS, 45', sg_Estado = 'RJ' 
	WHERE cd_Comprador = 3

-- 4. Altere a oferta do comprador 2 no im�vel 4 para 101.000

UPDATE tbOferta
	SET vl_Oferta = 101000
	WHERE cd_Comprador = 2 AND cd_Imovel = 4

-- 5. Exclua a oferta do comprador 3 no im�vel 1

DELETE FROM tbOferta
	WHERE cd_Comprador = 3 AND cd_Imovel = 1

/* 6. Altere a tabela de forma a incluir as restri��es de integridades, usando
PK_Imovel para a restri��o da chave prim�ria na tabela Im�vel. */

ALTER TABLE tbOferta
	DROP CONSTRAINT FK__Oferta__cd_Imove__3C69FB99

ALTER TABLE tbImovel
	DROP CONSTRAINT PK__Imovel__54ED318D8BE4FCA1

ALTER TABLE tbImovel
	ADD CONSTRAINT PK_Imovel PRIMARY KEY (cd_Imovel)

ALTER TABLE tbOferta
	ADD CONSTRAINT FK_Imovel FOREIGN KEY (cd_Imovel)
REFERENCES tbImovel

/* 7. Adicionar uma coluna qt_Parcelas do tipo n�mero inteiro na tabela Oferta,
j� criada e essa coluna deve aceitar n�meros maiores que 1, usando o nome
CK_qtParcela para a restri��o. */

ALTER TABLE tbOferta
	ADD qt_Parcela INT CONSTRAINT CK_qtParcela CHECK (qt_Parcela  > 1)

-- 8. Destrua a coluna qt_Parcelas da tabela Oferta

ALTER TABLE tbOferta
	DROP CONSTRAINT CK_qtParcela

ALTER TABLE tbOferta
	DROP COLUMN qt_Parcela


