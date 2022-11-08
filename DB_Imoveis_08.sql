USE DBimoveis

/* 1. Faça uma lista de imóveis do mesmo bairro do imóvel 2. Exclua o imóvel 2 da sua
busca. */

SELECT cd_Imovel, cd_Bairro, cd_Cidade, sg_Estado
	FROM tbImovel
	WHERE cd_Bairro = (SELECT cd_Bairro FROM tbImovel WHERE cd_Imovel = 2) AND
		  cd_Cidade = (SELECT cd_Cidade FROM tbImovel WHERE cd_Imovel = 2) AND
		  sg_Estado = (SELECT sg_Estado FROM tbImovel WHERE cd_Imovel = 2) AND
		  cd_Imovel <> 2

/* 2. Faça uma lista que mostre todos os imóveis que custam mais que a média de
preço dos imóveis. */

SELECT cd_Imovel, vl_Imovel
	FROM tbImovel
	WHERE vl_Imovel > (SELECT AVG(vl_Imovel) FROM tbImovel)

/*  3. Faça uma lista com todos os imóveis com preço superior à média de preço dos
imóveis do mesmo bairro. */

SELECT cd_Imovel, vl_Imovel
	FROM tbImovel I
	WHERE vl_Imovel > (SELECT AVG(vl_Imovel) 
							FROM tbImovel 
							WHERE cd_Bairro = I.cd_Bairro AND
								  cd_Cidade = I.cd_Cidade AND
								  sg_Estado = I.sg_Estado)

/* 4. Faça uma lista dos imóveis com o maior preço agrupado por bairro, cujo maior
preço seja superior à média de preços dos imóveis. */

SELECT MAX(vl_Imovel) MAIOR, cd_Bairro, cd_Cidade, sg_Estado
	FROM tbImovel
	GROUP BY cd_Bairro, cd_Cidade, sg_Estado
	HAVING MAX(vl_Imovel) > (SELECT AVG(vl_Imovel) FROM tbImovel)
	 
/* 5. Faça uma lista com os imóveis que tem o preço igual ou menor preço de cada
vendedor. */

SELECT cd_Imovel, cd_Vendedor, vl_Imovel
	FROM tbImovel I
	WHERE vl_Imovel <= (SELECT MIN(vl_Imovel) 
							FROM tbImovel 
							WHERE cd_Vendedor = I.cd_Vendedor)
	
/* 6. Faça uma lista de todos os imóveis cujo Estado e Cidade sejam os mesmos do
vendedor 3, exceto os imóveis do vendedor 3. */

SELECT cd_Imovel, sg_Estado, cd_Cidade, cd_Vendedor
	FROM tbImovel
	WHERE sg_Estado = (SELECT sg_Estado FROM tbImovel WHERE cd_Vendedor = 3) AND
		  cd_Cidade = (SELECT cd_Cidade FROM tbImovel WHERE cd_Vendedor = 3) AND
		  cd_Vendedor <> 3