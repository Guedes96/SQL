USE DBimoveis

/* 1. Fa�a uma lista de im�veis do mesmo bairro do im�vel 2. Exclua o im�vel 2 da sua
busca. */

SELECT cd_Imovel, cd_Bairro, cd_Cidade, sg_Estado
	FROM tbImovel
	WHERE cd_Bairro = (SELECT cd_Bairro FROM tbImovel WHERE cd_Imovel = 2) AND
		  cd_Cidade = (SELECT cd_Cidade FROM tbImovel WHERE cd_Imovel = 2) AND
		  sg_Estado = (SELECT sg_Estado FROM tbImovel WHERE cd_Imovel = 2) AND
		  cd_Imovel <> 2

/* 2. Fa�a uma lista que mostre todos os im�veis que custam mais que a m�dia de
pre�o dos im�veis. */

SELECT cd_Imovel, vl_Imovel
	FROM tbImovel
	WHERE vl_Imovel > (SELECT AVG(vl_Imovel) FROM tbImovel)

/*  3. Fa�a uma lista com todos os im�veis com pre�o superior � m�dia de pre�o dos
im�veis do mesmo bairro. */

SELECT cd_Imovel, vl_Imovel
	FROM tbImovel I
	WHERE vl_Imovel > (SELECT AVG(vl_Imovel) 
							FROM tbImovel 
							WHERE cd_Bairro = I.cd_Bairro AND
								  cd_Cidade = I.cd_Cidade AND
								  sg_Estado = I.sg_Estado)

/* 4. Fa�a uma lista dos im�veis com o maior pre�o agrupado por bairro, cujo maior
pre�o seja superior � m�dia de pre�os dos im�veis. */

SELECT MAX(vl_Imovel) MAIOR, cd_Bairro, cd_Cidade, sg_Estado
	FROM tbImovel
	GROUP BY cd_Bairro, cd_Cidade, sg_Estado
	HAVING MAX(vl_Imovel) > (SELECT AVG(vl_Imovel) FROM tbImovel)
	 
/* 5. Fa�a uma lista com os im�veis que tem o pre�o igual ou menor pre�o de cada
vendedor. */

SELECT cd_Imovel, cd_Vendedor, vl_Imovel
	FROM tbImovel I
	WHERE vl_Imovel <= (SELECT MIN(vl_Imovel) 
							FROM tbImovel 
							WHERE cd_Vendedor = I.cd_Vendedor)
	
/* 6. Fa�a uma lista de todos os im�veis cujo Estado e Cidade sejam os mesmos do
vendedor 3, exceto os im�veis do vendedor 3. */

SELECT cd_Imovel, sg_Estado, cd_Cidade, cd_Vendedor
	FROM tbImovel
	WHERE sg_Estado = (SELECT sg_Estado FROM tbImovel WHERE cd_Vendedor = 3) AND
		  cd_Cidade = (SELECT cd_Cidade FROM tbImovel WHERE cd_Vendedor = 3) AND
		  cd_Vendedor <> 3