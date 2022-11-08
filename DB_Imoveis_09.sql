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
informado. Verificar se o c�digo do vendedor existe no banco. */CREATE PROCEDURE sp_VendaPorEstado	@cd_Vendedor INT, @sg_Estado CHAR(2)AS	IF EXISTS (SELECT cd_Vendedor FROM tbVendedor WHERE cd_Vendedor = @cd_Vendedor)		SELECT COUNT(*) QUANTIDADE FROM tbImovel WHERE cd_Vendedor = @cd_Vendedor AND				  									   sg_Estado = @sg_Estado AND													   ic_Vendido = 'S'	ELSE		PRINT ('Vendedor nao cadastrado')/* 4. Altere o procedimento anterior para retornar um par�metro com a quantidade de
vendas do Vendedor. */CREATE PROCEDURE sp_VendaPorVendedor	@cd_Vendedor INT, @sg_Estado CHAR(2), @Quant INT OUTPUTAS	IF EXISTS (SELECT cd_vendedor FROM tbVendedor WHERE cd_Vendedor = @cd_Vendedor)		SELECT COUNT(*) QUANTIDADE FROM tbImovel WHERE cd_Vendedor = @cd_Vendedor AND				  									   sg_Estado = @sg_Estado AND													   ic_Vendido = 'S'	ELSE		PRINT ('Vendedor nao cadastrado')DECLARE @Qt INTEXEC sp_VendaPorVendedor 1, 'SP', @Qt OUTPUTSELECT @Qt/* 5. Escreva uma procedure que calcule a m�dia dos valores das ofertas de cada
im�vel e salve esta m�dia no registro do im�vel. */CREATE PROCEDURE sp_MediaOfertaAS	UPDATE tbImovel SET vl_MediaOferta = Media	FROM tbImovel I INNER JOIN (SELECT cd_Imovel, AVG(vl_Oferta) Media FROM tbOferta GROUP BY cd_Imovel) O	ON I.cd_Imovel = O.cd_Imovel-- Functions/* 1. Escreva uma fun��o que receba o c�digo do Im�vel como par�metro e retorne a
quantidade de ofertas recebidas de todos os im�veis mesmo que n�o tenha oferta
cadastrada, mostrando zero na quantidade. */CREATE FUNCTION MostraOferta (@cdImovel INT)RETURNS INTAS	BEGIN		DECLARE @Quant INT		SET @Quant = (SELECT COUNT(*) FROM tbOferta WHERE cd_Imovel = @cdImovel)		RETURN (@Quant)	END		/* 2. Escreva uma fun��o que receba o c�digo do Im�vel como par�metro e mostre o
nome do comprador que fez a �ltima oferta. */CREATE FUNCTION MostraNMcomprador (@cdImovel INT)RETURNS VARCHAR(20)AS	BEGIN		DECLARE @Nome VARCHAR(20)		SET @Nome = (SELECT C.nm_Comprador 						FROM tbComprador C INNER JOIN tbOferta O						ON C.cd_Comprador = O.cd_Comprador						WHERE O.cd_Imovel = @cdImovel AND							  O.dt_Oferta = (SELECT MAX(dt_Oferta)												FROM tbOferta												WHERE cd_Imovel = @cdImovel))		RETURN(@Nome)	END