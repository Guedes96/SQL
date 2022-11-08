USE DBimoveis

-- Stored Procedure

/* 1. Escreva uma procedure que receba um valor percentual como parâmetro e
aplique um desconto no valor do Imóvel somente nos Imóveis do estado de São
Paulo. */

CREATE PROCEDURE sp_DescontoSP
	@Pct DECIMAL(4,2) 
AS
	DECLARE @Valor MONEY
	SET @Valor = 1 - (@Pct/100)
	UPDATE tbImovel
		SET vl_Imovel = vl_Imovel * @Pct
		WHERE sg_Estado = 'SP'
	
/* 2. Criar uma stored procedure que informe se o preço de um determinado Imóvel é
maior, menor ou igual a média do preço de venda de todos os Imóveis. */


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

/* 3. Crie uma SP que, passando o código do Vendedor e a sigla de Estado como
parâmetro, mostre a quantidade de Imóveis que ele vendeu apenas no Estado
informado. Verificar se o código do vendedor existe no banco.*/

CREATE PROCEDURE sp_VendaPorEstado
	@cd_Vendedor INT, @sg_Estado CHAR(2)
AS
	IF EXISTS (SELECT cd_Vendedor FROM tbVendedor WHERE cd_Vendedor = @cd_Vendedor)
		SELECT COUNT(*) QUANTIDADE FROM tbImovel WHERE cd_Vendedor = @cd_Vendedor AND
				  									   sg_Estado = @sg_Estado AND
													   ic_Vendido = 'S'
	ELSE
		PRINT ('Vendedor nao cadastrado')

/* 4. Altere o procedimento anterior para retornar um parâmetro com a quantidade de
vendas do Vendedor. */

CREATE PROCEDURE sp_VendaPorVendedor
	@cd_Vendedor INT, @sg_Estado CHAR(2), @Quant INT OUTPUT
AS
	IF EXISTS (SELECT cd_vendedor FROM tbVendedor WHERE cd_Vendedor = @cd_Vendedor)
		SELECT COUNT(*) QUANTIDADE FROM tbImovel WHERE cd_Vendedor = @cd_Vendedor AND
				  									   sg_Estado = @sg_Estado AND
													   ic_Vendido = 'S'
	ELSE
		PRINT ('Vendedor nao cadastrado')

DECLARE @Qt INT
EXEC sp_VendaPorVendedor 1, 'SP', @Qt OUTPUT
SELECT @Qt

/* 5. Escreva uma procedure que calcule a média dos valores das ofertas de cada
imóvel e salve esta média no registro do imóvel. */

CREATE PROCEDURE sp_MediaOferta
AS
	UPDATE tbImovel SET vl_MediaOferta = Media
	FROM tbImovel I INNER JOIN (SELECT cd_Imovel, AVG(vl_Oferta) Media FROM tbOferta GROUP BY cd_Imovel) O
	ON I.cd_Imovel = O.cd_Imovel

-- Functions

/* 1. Escreva uma função que receba o código do Imóvel como parâmetro e retorne a
quantidade de ofertas recebidas de todos os imóveis mesmo que não tenha oferta
cadastrada, mostrando zero na quantidade. */

CREATE FUNCTION MostraOferta (@cdImovel INT)
RETURNS INT
AS
	BEGIN
		DECLARE @Quant INT
		SET @Quant = (SELECT COUNT(*) FROM tbOferta WHERE cd_Imovel = @cdImovel)
		RETURN (@Quant)
	END
		
/* 2. Escreva uma função que receba o código do Imóvel como parâmetro e mostre o
nome do comprador que fez a última oferta. */

CREATE FUNCTION MostraNMcomprador (@cdImovel INT)
RETURNS VARCHAR(20)
AS
	BEGIN
		DECLARE @Nome VARCHAR(20)
		SET @Nome = (SELECT C.nm_Comprador 
						FROM tbComprador C INNER JOIN tbOferta O
						ON C.cd_Comprador = O.cd_Comprador
						WHERE O.cd_Imovel = @cdImovel AND
							  O.dt_Oferta = (SELECT MAX(dt_Oferta)
												FROM tbOferta
												WHERE cd_Imovel = @cdImovel))
		RETURN(@Nome)
	END


