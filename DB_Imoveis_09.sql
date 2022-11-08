USE DBimoveis

-- Stored Procedure

/* 1. Escreva uma procedure que receba um valor percentual como par�metro e
aplique um desconto no valor do Im�vel somente nos Im�veis do estado de S�o
Paulo. */

CREATE PROCEDURE sp_DescontoSP
	@Pct DECIMAL(4,2) 
AS
	DECLARE @Valor MONEY
	SET @Valor = 1 - (@Pct/100)
	UPDATE tbImovel
		SET vl_Imovel = vl_Imovel * @Pct
		WHERE sg_Estado = 'SP'
	
/* 2. Criar uma stored procedure que informe se o pre�o de um determinado Im�vel �
maior, menor ou igual a m�dia do pre�o de venda de todos os Im�veis. */


CREATE PROCEDURE sp_CheckValor
	@cd_Imovel INT
AS
	DECLARE @Media MONEY
	SELECT @Media = AVG(vl_Imovel) FROM tbImovel
	IF (SELECT vl_Imovel FROM tbImovel 
			WHERE cd_Imovel = @cd_Imovel) < @Media
			PRINT 'Preco menor que a media'
	ELSE
		IF (SELECT vl_Imovel FROM tbImovel) > @Media
			PRINT 'Preco maior que a media'
		ELSE
			PRINT 'Preco igual a media'

/* 3. Crie uma SP que, passando o c�digo do Vendedor e a sigla de Estado como
par�metro, mostre a quantidade de Im�veis que ele vendeu apenas no Estado
informado. Verificar se o c�digo do vendedor existe no banco. */
vendas do Vendedor. */
im�vel e salve esta m�dia no registro do im�vel. */
quantidade de ofertas recebidas de todos os im�veis mesmo que n�o tenha oferta
cadastrada, mostrando zero na quantidade. */
nome do comprador que fez a �ltima oferta. */