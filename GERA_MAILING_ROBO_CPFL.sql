USE easycollector
/*============================================================== CRIAR VIEW TELEFONE_ORDEM ======================================================================*/
CREATE VIEW TELEFONES_ORDEM  
AS
SELECT 
ID_CLIENTE, NU_DDD, NU_TELEFONE, ROW_NUMBER() OVER( PARTITION BY ID_CLIENTE ORDER BY TP_PREFERENCIAL DESC, DT_INCLUSAO DESC, ID_TELEFONE DESC) AS ORDEM 
FROM TB_CLIENTE_TELEFONE
WHERE TP_HABILITADO = 1 

/*============================================================== MAILING PREVENTIVO DIA ======================================================================*/
--DROP TRABLE ##ORDENA_MAILING
--CREATE VIEW GERA_MAILING_ROBO_CPFL AS
SELECT DISTINCT  
	'237' as CodigoCampanha,
	NU_CPF_CNPJ as CodigoCliente,
	'1' as TelefoneTipo,
	MAX(CASE 
		   WHEN A.ORDEM = 1 THEN CONVERT(varchar, A.NU_DDD)
		   ELSE ' '
		   END) AS DDD_01,
	MAX(CASE 
		   WHEN A.ORDEM = 1 THEN CONVERT(varchar, A.NU_TELEFONE)
		   ELSE ' '
		   END) AS TELEFONE_01,
	'' as RamalAgendamento,
	'' as DataAgendamento,
	NM_NOME,
	CONCAT(
		NU_PRESTACAO,',',
		VL_DIVIDA,',',
		RIGHT(NM_CONTRATO_CEDENTE, 10),',',
		B.ID_CLIENTE) AS [NUMERODEPARCELAS,VALORDIVIDA,NUMEROINSTALACAO,IDCON]
--INTO ##ORDENA_MAILING
FROM TELEFONES_ORDEM A
	JOIN TB_CLIENTE B ON B.ID_CLIENTE = A.ID_CLIENTE
	JOIN TB_CONTRATO CT ON CT.ID_CLIENTE = B.ID_CLIENTE
	JOIN TB_divida D ON d.ID_contrato = CT.ID_Contrato
WHERE ID_DEPOSITO ='86'
GROUP BY NU_CPF_CNPJ, NM_NOME, NU_PRESTACAO, VL_DIVIDA, NM_CONTRATO_CEDENTE, B.ID_CLIENTE

/*============================================================== Consulta o Mailing ======================================================================*/
SELECT * FROM GERA_MAILING_ROBO_CPFL