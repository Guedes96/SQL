USE DBimoveis

-- Atividade 2--

/* 1. Liste o total de ofertas por comprador de 2008 a 2009, mostrando o total geral na
consulta */

SELECT cd_Comprador, SUM(vl_Oferta) TOTAL
	FROM tbOferta
	WHERE YEAR(dt_Oferta) BETWEEN 2008 AND 2009
	GROUP BY cd_Comprador WITH ROLLUP

/* 2. Liste o valor médio de todos os Imóveis por bairro, somente do estado de São
Paulo e coloque o resultado em ordem decrescente de valor. */

SELECT cd_Bairro, cd_Cidade, sg_Estado, AVG(vl_Imovel) MEDIA
	FROM tbImovel
	GROUP BY cd_Bairro, sg_Estado, cd_Cidade
	HAVING sg_Estado = 'SP'
	ORDER BY MEDIA DESC

-- 3. Liste o maior valor de imóvel por vendedor, somente para os vendedores 1 e 2.

SELECT cd_Vendedor, MAX(vl_Imovel) MAIOR
	FROM tbImovel
	GROUP BY cd_Vendedor
	HAVING cd_Vendedor IN (1, 2)

/* 4. Mostre a quantidade de imóveis cujo preço de venda seja inferior a 150 mil por
Estado e a área total inferior a 300. */

SELECT sg_Estado, COUNT(*) TOTAL
	FROM tbImovel
	WHERE qt_AreaTotal < 300 AND vl_Imovel < 150000
	GROUP BY sg_Estado
	
/* 5. Escreva o comando para apresentar o preço médio dos Imóveis por código de
vendedor. Considere somente aqueles que custam mais de 100000 e o valor
médio não ultrapasse 200000. */

SELECT cd_Vendedor, AVG(vl_Imovel) MEDIA
	FROM tbImovel
	WHERE vl_Imovel > 100000
	GROUP BY cd_Vendedor
	HAVING AVG(vl_Imovel) < 200000
	
/* 6. Apresente o preço máximo, o preço mínimo e o preço médio dos Imóveis cujos os
estados são “SP”, “RJ” ou “MG” por código de Cidade, colocar em ordem
crescente de estado. */

SELECT cd_Cidade, sg_Estado, MAX(vl_Imovel) MAIOR, MIN(vl_Imovel) MENOR, AVG(vl_Imovel) MEDIA 
	FROM tbImovel
	WHERE sg_Estado IN ('SP', 'RJ', 'MG')
	GROUP BY cd_Cidade, sg_Estado
	ORDER BY sg_Estado
	
/* 7. Escreva o comando para apresentar o preço médio das ofertas por comprador,
somente para as ofertas feitas em janeiro de 2009 */

SELECT cd_Comprador, AVG(vl_Oferta)
	FROM tbOferta
	WHERE YEAR(dt_Oferta) = 2009 AND MONTH(dt_Oferta) = 01
	GROUP BY cd_Comprador

/* 8. Mostre soma das ofertas por mês, somente o ano de 2009, cujo valor esteja entre
100 mil e 250 mil. */

SELECT MONTH(dt_Oferta) MES, SUM(vl_Oferta) SOMA
	FROM tbOferta
	WHERE YEAR(dt_Oferta) = 2009 AND vl_Oferta BETWEEN 100000 AND 250000
	GROUP BY MONTH(dt_Oferta)
