USE DBequipa

/* 1. Relação de todos os códigos dos equipamentos e
o valor unitário maior que R$ 100,00 e menor que
R$ 200,00. Informar nome do fornecedor e
descrição do equipamento. */

SELECT F.nm_Fornecedor, E.ds_Equipamento, C.cd_Equipamento, C.vl_Equipamento
	FROM tbFornecedor F, tbEquipamento E, tbCusto C
	WHERE F.cd_Fornecedor = C.cd_Fornecedor AND C.cd_Equipamento = E.cd_Equipamento 
		AND C.vl_Equipamento BETWEEN 100 AND 200

/* 2. Apresente o comando para gerar uma listagem
com os nomes dos Equipamentos que possuem
ao menos dois Fornecedores. */

SELECT C.cd_Fornecedor, COUNT(*) TOTAL
	FROM tbEquipamento E INNER JOIN tbCusto C 
		ON E.cd_Equipamento = C.cd_Equipamento
	GROUP BY C.cd_Fornecedor
	HAVING COUNT(*) > 1

/* 3. Mostrar uma lista por nome de fornecedor e a
média dos valores dos equipamentos que atende. */

SELECT F.nm_Fornecedor, AVG(C.vl_Equipamento) MEDIA
	FROM tbFornecedor F INNER JOIN tbCusto C
		ON F.cd_Fornecedor = C.cd_Fornecedor
	GROUP BY F.nm_Fornecedor

/* 4. Mostrar uma consulta com os códigos dos
equipamentos que possuem a matriz do
Fornecedor em Santos e São Paulo e os nomes
dos fornecedores que os fornecem. */

SELECT C.cd_Equipamento, F.nm_Fornecedor, F.nm_Matriz
	FROM tbCusto C INNER JOIN tbFornecedor F 
		ON C.cd_Fornecedor = F.cd_Fornecedor
	WHERE F.nm_Matriz IN ('São Paulo', 'Santos')