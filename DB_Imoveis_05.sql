USE DBimoveis

-- Atividade 01--

/* 1. Liste todas as linhas e os campos cd_Vendedor, nm_Vendedor e ds_Email da
tabela VENDEDOR em ordem alfabética decrescente. */SELECT cd_Vendedor, nm_Vendedor, ds_Email	FROM tbVendedor	ORDER BY nm_Vendedor DESC/* 2. Liste as colunas cd_Imovel, cd_Vendedor e vl_Imovel de todos os imóveis do
vendedor 2. */

SELECT cd_Imovel, cd_Vendedor, vl_Imovel
	FROM tbImovel
	WHERE cd_Vendedor = 2

/* 3. Liste as colunas cd_Imovel, cd_Vendedor, vl_Imovel e sg_Estado dos imóveis cujo
preço de venda seja inferior a 150 mil e sejam do Estado do RJ. */SELECT cd_Imovel, cd_Vendedor, vl_Imovel, sg_Estado	FROM tbImovel	WHERE vl_Imovel < 150000 AND  sg_Estado = 'RJ'/* 4. Liste as colunas cd_Imovel, cd_Vendedor, vl_Imovel e sg_Estado dos imóveis cujo
preço de venda seja inferior a 150 mil e o vendedor não seja 2. */SELECT cd_Imovel, cd_Vendedor, vl_Imovel, sg_Estado	FROM tbImovel	WHERE vl_Imovel < 150000 AND cd_Vendedor <> 2/* 5. Liste as colunas cd_Comprador, nm_Comprador, ds_Endereco e sg_Estado da
tabela COMPRADOR em que o Estado seja nulo. */SELECT cd_Comprador, nm_Comprador, ds_Endereco, sg_Estado	FROM tbComprador	WHERE sg_Estado IS NULL-- 6. Liste todas as ofertas cujo valor esteja entre 100 mil e 150 mil.*/

SELECT * 
	FROM tbOferta
	WHERE vl_Oferta BETWEEN 100000 AND 150000

-- 7. Liste todos os vendedores que tenham a letra A na segunda posição do nome */

SELECT nm_Vendedor	
	FROM tbVendedor
	WHERE nm_Vendedor LIKE '_A%'

-- 8.Liste todas as linhas e os campos cd_Comprador, nm_Comprador e ds_Email da tabela COMPRADOR

SELECT cd_Comprador, nm_Comprador, ds_Email
	FROM tbComprador

/* 9. Liste todas as ofertas cujo imóvel seja 2 ou 3 e o valor da oferta seja maior que 130 mil,
em ordem decrescente de data. */

SELECT *
	FROM tbOferta
	WHERE cd_Imovel IN (2,3) AND vl_Oferta > 130000
	ORDER BY dt_Oferta DESC

/* 10. Liste todos os imóveis cujo preço de venda esteja entre 110 mil e 200 mil ou seja do
vendedor 1 em ordem de área útil. */

SELECT *
	FROM tbImovel
	WHERE (vl_Imovel BETWEEN 110000 AND 200000) OR cd_Vendedor = 1
	ORDER BY qt_AreaUtil

--11. Mostre o maior, o menor, o total e a média de preço de venda dos imóveis.

SELECT MAX(vl_Imovel) MAIOR, MIN(vl_Imovel) MENOR, SUM(vl_Imovel) TOTAL, AVG(vl_Imovel) MEDIA
	FROM tbImovel

--12. Modifique o comando anterior para que sejam mostrados os mesmos índices por bairro.

SELECT sg_Estado, cd_Bairro, cd_Cidade, MAX(vl_Imovel) MAIOR, MIN(vl_Imovel) MENOR, SUM(vl_Imovel) TOTAL, AVG(vl_Imovel) MEDIA
	FROM tbImovel
	GROUP BY sg_Estado, cd_Bairro, cd_Cidade

--13. Faça uma busca que retorne o total de ofertas realizadas nos anos de 2008, 2009 e 2010.

SELECT COUNT(vl_Oferta) TOTAL 
	FROM tbOferta
	WHERE YEAR(dt_Oferta) BETWEEN 2008 AND 2010

