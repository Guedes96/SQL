USE DBimoveis

/* 1. Faça uma busca que mostre cd_Imovel, vl_Imovel e nm_Bairro, cujo código do
vendedor seja 3.*/

SELECT I.cd_Imovel, I.vl_Imovel, B.nm_Bairro, I.cd_Vendedor
	FROM tbImovel I INNER JOIN tbBairro B
		ON I.cd_Bairro = B.cd_Bairro AND
		   I.cd_Cidade = B.cd_Cidade AND
		   I.sg_Estado = B.sg_Estado
	WHERE I.cd_Vendedor = 3
	
-- 2. Faça uma busca que mostre todos os imóveis que tenham ofertas cadastradas.SELECT I.* 	FROM tbImovel I INNER JOIN tbOferta O		ON I.cd_Imovel = O.cd_Imovel	/* 3. Faça uma busca que mostre todos os imóveis e ofertas mesmo que não haja
ofertas cadastradas para o imóvel. */

SELECT I.*
	FROM tbImovel I LEFT JOIN tbOferta O
		ON I.cd_Imovel = O.cd_Imovel

/* 4. Faça uma busca que mostre os compradores e as respectivas ofertas realizadas
por eles. */SELECT	C.nm_Comprador, O.vl_Oferta 	FROM tbComprador C INNER JOIN tbOferta O		ON C.cd_Comprador = O.cd_Comprador/* 5. Faça a mesma busca, porém acrescentando os compradores que ainda não
fizeram ofertas para os imóveis. */SELECT C.nm_Comprador, O.vl_Oferta	FROM tbComprador C LEFT JOIN tbOferta O		ON C.cd_Comprador = O.cd_Comprador/* 6. Faça uma busca que mostre o endereço do imóvel, o bairro e nível de preço do
imóvel. */SELECT I.ds_Endereco, B.nm_Bairro, I.vl_Imovel, F.nm_Faixa	FROM tbImovel I, tbFaixaImovel F, tbBairro B	WHERE (I.vl_Imovel BETWEEN F.vl_Minimo AND F.vl_Maximo) AND		  I.sg_Estado = B.sg_Estado AND		  I.cd_Cidade = B.cd_Cidade AND		  I.cd_Bairro = B.cd_Bairro-- 7. Verifique a diferença de valores entre o maior e o menor imóvel da tabela.SELECT (MAX(vl_Imovel)-MIN(vl_Imovel)) DIFERENÇA	FROM tbImovel		/* 8. Mostre o código do vendedor e o menor valor do imóvel dele no cadastro. Exclua
da busca os valores de imóveis inferiores a 100 mil. */SELECT cd_Vendedor, MIN(vl_Imovel) MINIMO	FROM tbImovel 	WHERE vl_Imovel > 100000	GROUP BY cd_Vendedor/* 9. Mostre o código e o nome do comprador e a média do valor das ofertas e o
número de ofertas deste comprador. */

SELECT C.cd_Comprador, C.nm_Comprador, AVG(O.vl_Oferta) MEDIA, COUNT(*) QTDE_OFERTA
	FROM tbComprador C INNER JOIN tbOferta O
	ON C.cd_Comprador = O.cd_Comprador
	GROUP BY C.cd_Comprador, C.nm_Comprador