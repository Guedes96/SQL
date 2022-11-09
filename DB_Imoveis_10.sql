USE DBimoveis

/* 1. Escreva um trigger que realize a atualização do campo valor médio do Imóvel a cada nova oferta
cadastrada, alterada ou excluída. */

CREATE TRIGGER tr_AtualizaMediaImovel ON tbOferta
	FOR INSERT, UPDATE, DELETE
AS
	BEGIN
		DECLARE @cd_Imovel INT, @Media MONEY
		
		IF EXISTS (SELECT * FROM INSERTED)
			SET @cd_Imovel = (SELECT cd_Imovel FROM INSERTED)
		ELSE
			SET @cd_Imovel = (SELECT cd_Imovel FROM INSERTED)

		SET @Media = (SELECT AVG(vl_Oferta) FROM tbOferta WHERE cd_Imovel = @cd_Imovel)
		
		UPDATE tbImovel
			SET vl_MediaOferta = @Media
			WHERE cd_Imovel = @cd_Imovel
	END

-- 2. Escreva um trigger que não permita a alteração de dados na tabela Faixa_Imovel a sua exclusão. 

CREATE TRIGGER tr_BloqueioExclusao ON tbFaixaImovel
	INSTEAD OF DELETE
AS
	BEGIN
		DECLARE @Faixa VARCHAR (30)
		SELECT @Faixa = nm_Faixa FROM DELETED
		PRINT 'REGISTRO ' + @Faixa + ' NAO PODE SER EXCLUIDO'
	END

/* 3. Fazer um procedimento que no ato da inclusão de uma nova oferta, o banco atualize
automaticamente a quantidade de ofertas no campo qt_Ofertas da tabela Imóvel. */

CREATE TRIGGER tr_QuantOferta ON tbOferta
	FOR INSERT
AS
	BEGIN
		DECLARE @cd_Imovel INT, @Quant INT
		SET @cd_Imovel = (SELECT cd_Imovel FROM INSERTED)
		SELECT @Quant = (SELECT COUNT(*) FROM tbOferta WHERE cd_Imovel = @cd_Imovel)
		UPDATE tbImovel SET qt_Oferta = @Quant WHERE cd_Imovel = @cd_Imovel
	END

/* 4. No ato da gravação do contrato, o banco deverá gerar automaticamente os registros de mensalidades
do parcelamento com os Imóveis, mesmo em pagamento a vista, deverá gerar um registro. */

CREATE TRIGGER tr_RegistroMensal ON tbContrato
	FOR INSERT 
AS
	BEGIN
		DECLARE @Valor MONEY, @Contrato INT, @Parcela INT, @Vencimento DATETIME, @Cont INT
		SET @Contrato = (SELECT cd_Contrato FROM INSERTED)
		SET @Parcela = (SELECT qt_Parcela FROM INSERTED)
		SET @Valor = (SELECT vl_Contrato FROM INSERTED) / @Parcela
		SET @Vencimento = (SELECT dt_Contrato FROM INSERTED)
		SET @Cont = 0

		WHILE @Parcela > @Cont
			SET @Cont += 1
			INSERT INTO tbParcelas
				VALUES (@Contrato, @Cont, @Valor, DATEADD(M,@Cont,@Vencimento), NULL, 0)
	END

/* 5. Fazer um procedimento que no ato da alteração da data do pagamento de uma
parcela, o banco atualize automaticamente o valor da multa, caso existir atraso.
Calcular o valor da multa em 3% por dia de atraso. Caso a data de pagamento seja
nula, o banco deve zerar o valor da multa.*/

CREATE TRIGGER tr_CalculaMulta ON tbParcelas
	FOR UPDATE
AS
	BEGIN
		DECLARE @Valor MONEY, @Vencimento DATETIME, @Pagamento DATETIME, @Dias INT,
				@ValParcela MONEY, @Contrato INT, @Parcela INT
		SET @Vencimento = (SELECT dt_Vencimento FROM DELETED)
		SET @Pagamento = (SELECT dt_Pagamento FROM INSERTED)
		SET @Contrato = (SELECT cd_Contrato FROM INSERTED)
		SET @Parcela = (SELECT qt_Parcela FROM INSERTED)
		SET @Valor = 0

		IF @Pagamento > @Vencimento
			SET @ValParcela = (SELECT vl_Parcela FROM INSERTED)
			SET @Dias = DATEDIFF(Day,@Vencimento,@Pagamento)
			SET @Valor = @Dias * @ValParcela * 0.03

		UPDATE tbParcelas SET vl_Multa = @Valor 
			WHERE cd_Contrato = @Contrato AND
				  qt_Parcela = @Parcela
	END

/* 6. Fazer um procedimento para gerar uma tabela temporária (Inadimplentes)
informando o código do contrato, o número da parcela, a data de vencimento e o
valor a ser pago dos Imóveis que estão inadimplentes no mês anterior ao mês
corrente, para gerar a cobrança dos pagamentos em atraso. */

CREATE PROCEDURE sp_Inadimplentes
AS
	BEGIN
		DELETE FROM tbInadimplentes	
		DECLARE @Data DATETIME
		SET @Data = DATEADD(MONTH,-1,GETDATE())
		
		INSERT INTO tbInadimplentes
			SELECT C.cd_Imovel, P.qt_Parcela, P.dt_Vencimento, P.vl_Parcela
			FROM tbParcelas P, tbContrato C
			WHERE P.cd_Contrato = C.cd_Contrato AND
				  P.dt_Pagamento IS NULL AND
				  P.dt_Vencimento < @Data
	END