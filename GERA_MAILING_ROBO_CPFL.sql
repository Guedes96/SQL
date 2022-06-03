CREATE VIEW TELEFONES_ORDEM  
AS
SELECT 
ID_CLIENTE, NU_DDD, NU_TELEFONE, ROW_NUMBER() OVER( PARTITION BY ID_CLIENTE ORDER BY TP_PREFERENCIAL DESC, DT_INCLUSAO DESC, ID_TELEFONE DESC) AS ORDEM 
FROM TB_CLIENTE_TELEFONE
WHERE TP_HABILITADO = 1 

/*============================================================== MAILING PREVENTIVO DIA ======================================================================*/
CREATE VIEW GERA_MAILING_ROBO_CPFL AS

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
Join TB_CLIENTE B ON B.ID_CLIENTE = A.ID_CLIENTE
join TB_CONTRATO ct on ct.ID_CLIENTE = B.ID_CLIENTE
join TB_divida d on d.ID_contrato = ct.ID_Contrato
WHERE ID_DEPOSITO ='86'
GROUP BY NU_CPF_CNPJ, NM_NOME, NU_PRESTACAO, VL_DIVIDA, NM_CONTRATO_CEDENTE, B.ID_CLIENTE

/*============================================================== Consulta o Mailing ======================================================================*/

SELECT * FROM GERA_MAILING_ROBO_CPFL