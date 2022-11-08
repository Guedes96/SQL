USE DBimoveis

/* 1. Fa�a uma busca que mostre cd_Imovel, vl_Imovel e nm_Bairro, cujo c�digo do
vendedor seja 3.*/

SELECT I.cd_Imovel, I.vl_Imovel, B.nm_Bairro, I.cd_Vendedor
	FROM tbImovel I INNER JOIN tbBairro B
		ON I.cd_Bairro = B.cd_Bairro AND
		   I.cd_Cidade = B.cd_Cidade AND
		   I.sg_Estado = B.sg_Estado
	WHERE I.cd_Vendedor = 3
	
-- 2. Fa�a uma busca que mostre todos os im�veis que tenham ofertas cadastradas.SELECT I.* 	FROM tbImovel I INNER JOIN tbOferta O		ON I.cd_Imovel = O.cd_Imovel	/* 3. Fa�a uma busca que mostre todos os im�veis e ofertas mesmo que n�o haja
ofertas cadastradas para o im�vel. */

SELECT I.*
	FROM tbImovel I LEFT JOIN tbOferta O
		ON I.cd_Imovel = O.cd_Imovel

/* 4. Fa�a uma busca que mostre os compradores e as respectivas ofertas realizadas
por eles. */SELECT	C.nm_Comprador, O.vl_Oferta 	FROM tbComprador C INNER JOIN tbOferta O		ON C.cd_Comprador = O.cd_Comprador/* 5. Fa�a a mesma busca, por�m acrescentando os compradores que ainda n�o
fizeram ofertas para os im�veis. */SELECT C.nm_Comprador, O.vl_Oferta	FROM tbComprador C LEFT JOIN tbOferta O		ON C.cd_Comprador = O.cd_Comprador/* 6. Fa�a uma busca que mostre o endere�o do im�vel, o bairro e n�vel de pre�o do
im�vel. */SELECT I.ds_Endereco, B.nm_Bairro, I.vl_Imovel, F.nm_Faixa	FROM tbImovel I, tbFaixaImovel F, tbBairro B	WHERE (I.vl_Imovel BETWEEN F.vl_Minimo AND F.vl_Maximo) AND		  I.sg_Estado = B.sg_Estado AND		  I.cd_Cidade = B.cd_Cidade AND		  I.cd_Bairro = B.cd_Bairro-- 7. Verifique a diferen�a de valores entre o maior e o menor im�vel da tabela.SELECT (MAX(vl_Imovel)-MIN(vl_Imovel)) DIFEREN�A	FROM tbImovel		/* 8. Mostre o c�digo do vendedor e o menor valor do im�vel dele no cadastro. Exclua
da busca os valores de im�veis inferiores a 100 mil. */SELECT cd_Vendedor, MIN(vl_Imovel) MINIMO	FROM tbImovel 	WHERE vl_Imovel > 100000	GROUP BY cd_Vendedor/* 9. Mostre o c�digo e o nome do comprador e a m�dia do valor das ofertas e o
n�mero de ofertas deste comprador. */

SELECT C.cd_Comprador, C.nm_Comprador, AVG(O.vl_Oferta) MEDIA, COUNT(*) QTDE_OFERTA
	FROM tbComprador C INNER JOIN tbOferta O
	ON C.cd_Comprador = O.cd_Comprador
	GROUP BY C.cd_Comprador, C.nm_Comprador