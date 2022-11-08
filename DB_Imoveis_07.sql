USE DBimoveis

/* 1. Fa�a uma busca que mostre cd_Imovel, vl_Imovel e nm_Bairro, cujo c�digo do
vendedor seja 3.*/

SELECT I.cd_Imovel, I.vl_Imovel, B.nm_Bairro, I.cd_Vendedor
	FROM tbImovel I INNER JOIN tbBairro B
		ON I.cd_Bairro = B.cd_Bairro AND
		   I.cd_Cidade = B.cd_Cidade AND
		   I.sg_Estado = B.sg_Estado
	WHERE I.cd_Vendedor = 3
	
-- 2. Fa�a uma busca que mostre todos os im�veis que tenham ofertas cadastradas.
ofertas cadastradas para o im�vel. */

SELECT I.*
	FROM tbImovel I LEFT JOIN tbOferta O
		ON I.cd_Imovel = O.cd_Imovel

/* 4. Fa�a uma busca que mostre os compradores e as respectivas ofertas realizadas
por eles. */
fizeram ofertas para os im�veis. */
im�vel. */
da busca os valores de im�veis inferiores a 100 mil. */
n�mero de ofertas deste comprador. */

SELECT C.cd_Comprador, C.nm_Comprador, AVG(O.vl_Oferta) MEDIA, COUNT(*) QTDE_OFERTA
	FROM tbComprador C INNER JOIN tbOferta O
	ON C.cd_Comprador = O.cd_Comprador
	GROUP BY C.cd_Comprador, C.nm_Comprador