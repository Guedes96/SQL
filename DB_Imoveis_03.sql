
USE DBimoveis

--Atividade 01--

-- 1. Inclua linhas na tabela ESTADO:

INSERT INTO tbEstado
	VALUES ('SP', 'SÃO  PAULO')
		 , ('RJ', 'RIO DE JANEIRO')
		  
-- 2. Inclua linhas na tabela CIDADE:

INSERT INTO tbCidade
	VALUES  (1, 'SP', 'SAO PAULO')
	      , (2, 'SP', 'SANTO ANDRE')
		  , (3, 'SP', 'CAMPINAS')
		  , (1, 'RJ', 'RIO DE JANEIRO')
		  , (2, 'RJ', 'NITEROI')

-- 3. Inclua linhas na tabela BAIRRO:

INSERT INTO tbBairro
	VALUES  (1, 1, 'SP', 'JARDINS')
		  , (2, 1, 'SP', 'MORUMBI')
		  , (3, 1, 'SP', 'AEROPORTO')
		  , (1, 1, 'RJ', 'AEROPORTO')
		  , (2, 1, 'RJ', 'NITEROI')

-- 4. Inclua linhas na tabela VENDEDOR:

INSERT INTO tbVendedor(cd_Vendedor, nm_Vendedor,ds_Endereco,ds_Email)
	VALUES  (1, 'MARIA DA SILVA', 'RUA DO GRITO, 45', 'msilva@nova.com')
		  , (2, 'MARCO ANDRADE', 'AV. DA SAUDADE,325', 'mandrade@nova.com')
		  , (3, 'ANDRE CARDOSO', 'AV. BRASIL, 401', 'acardoso@nova.com')
		  , (4, 'TATIANA SOUZA', 'RUA DO IMPERADOR, 778', 'tsouza@nova.com') 

-- 5. Inclua linhas na tabela IMOVEL:

INSERT INTO tbImovel(cd_Imovel,cd_Vendedor,cd_Bairro,cd_Cidade,sg_Estado,ds_Endereco,qt_AreaUtil,qt_AreaTotal,vl_Imovel)
	VALUES  (1, 1, 1, 1, 'SP', 'AL. TIETE, 3304/101', 250, 400, 180000)
          , (2, 1, 2, 1, 'SP', 'AV. MORUMBI, 2230', 150, 250, 135000)
	      , (3, 2, 1, 1, 'RJ', 'R. GAL. OSORIO, 445/34', 250, 400, 185000)
	      , (4, 2, 2, 1, 'RJ', 'R. D. PEDRO I, 882', 120, 200, 110000)
  	      , (5, 3, 3, 1, 'SP', 'AV. RUBENS BERTA, 2355', 110, 200, 95000)
	      , (6, 4, 1, 1, 'RJ', 'R. GETULIO VARGAS, 552', 200, 300, 99000)

-- 6. Inclua linhas na tabela COMPRADOR:

INSERT INTO tbComprador(cd_Comprador,nm_Comprador,ds_Endereco,ds_Email)
	VALUES  (1, 'EMMANUEL ANTUNES', 'R. SARAIVA, 452', 'eantunes@nova.com')
		  , (2, 'JOANA PEREIRA', 'AV PROTUGAL, 52', 'jpereira@nova.com')
		  , (3, 'RONALDO CAMPELO', 'R. ESTADOS UNIDOS', 'rcampelo@nova.com')
		  , (4, 'MANFRED AUGUSTO', 'AV. BRASIL,351', 'maugusto@nova.com')

-- 7. Inclua linhas na tabela OFERTA:

INSERT INTO tbOferta
	VALUES  (1, 1, 170000, '10-01-09')
	      , (1, 3, 180000, '10-01-09')
		  , (2, 2, 135000, '15-01-09')
		  , (2, 4, 100000, '15-02-09')
		  , (3, 1, 160000, '05-01-09')
		  , (3, 2, 140000, '20-02-09')

-- 8. Inclua linhas na tabela FAIXA_IMOVEL:

INSERT INTO tbFaixaImovel
	VALUES (1,'BAIXO',0,105000)
		 , (2,'MEDIO',105001,180000)
		 , (3,'ALTO',180001,999999)
		 

