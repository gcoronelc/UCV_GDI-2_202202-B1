
ALTER PROCEDURE DBO.USP_UCV_GPO_B_CREAR_CUENTA(
	@CLIENTE CHAR(5),
	@MONEDA CHAR(2),
	@IMPORTE MONEY,
	@CLAVE CHAR(6),
	@EMPLEADO CHAR(4),
	@CODIGO CHAR(8) OUT,
	@ESTADO INT OUT, 
	@MENSAJE VARCHAR(1000) OUT
) AS
BEGIN
	DECLARE @cont int, @sucursal char(3);
	SET @ESTADO = 1;
	SET @MENSAJE = 'Proceso ejecutado con exito.';
	BEGIN TRY 
		-- Inicia Tx
		BEGIN TRANSACTION; 
		-- Validar que el empleado exista.
		select @cont = count(1) from Empleado where chr_emplcodigo=@EMPLEADO;
		if(@cont=0)
		begin
			SET @ESTADO = -1;
			SET @MENSAJE = 'Codigo de empleado no existe.';
			THROW 51000, 'Empleado no existe.', 1;
		end;
		-- Validar que el empleado se encuentre laborando actualmente.
		select @cont = count(1) from asignado 
		where chr_emplcodigo=@EMPLEADO and dtt_asigfechabaja is null;
		if(@cont<>1)
		begin
			SET @ESTADO = -1;
			SET @MENSAJE = 'El empleado no labora en esta empresa..';
			THROW 51000, 'Empleado no esta laborando.', 1;
		end;
		-- Validar la moneda
		select @cont = count(1) from moneda where chr_monecodigo=@MONEDA;
		if(@cont<>1)
		begin
			SET @ESTADO = -1;
			SET @MENSAJE = 'La moneda es incorrecta.';
			THROW 51000, 'Moneda incorrecta.', 1;
		end;
		
		-- Generar codigo de la cuenta
		SELECT @sucursal=chr_sucucodigo FROM Asignado
		WHERE chr_emplcodigo=@EMPLEADO AND dtt_asigfechabaja IS NULL;
		UPDATE Sucursal SET int_sucucontcuenta = int_sucucontcuenta +1 
		WHERE chr_sucucodigo=@sucursal;
		SELECT @cont=int_sucucontcuenta FROM SUCURSAL WHERE chr_sucucodigo=@sucursal;
		SET @CODIGO = @sucursal + RIGHT(CONCAT('00000',@cont),5);
		PRINT 'CODIGO: ' + @CODIGO
		--Proceso
		INSERT INTO CUENTA(chr_cuencodigo,chr_monecodigo,chr_sucucodigo,
			chr_emplcreacuenta,chr_cliecodigo,dec_cuensaldo,dtt_cuenfechacreacion,
			vch_cuenestado,int_cuencontmov,chr_cuenclave)
		VALUES(@CODIGO,@MONEDA,@sucursal,@EMPLEADO,@CLIENTE,@IMPORTE,GETDATE(),'ACTIVO',1,@CLAVE);
		INSERT INTO MOVIMIENTO(chr_cuencodigo,int_movinumero,dtt_movifecha,chr_emplcodigo,
			chr_tipocodigo,dec_moviimporte)
		VALUES(@CODIGO,1,getdate(),@EMPLEADO,'001',@IMPORTE);
		-- Confirma Tx
		COMMIT TRANSACTION; 
	END TRY 
	BEGIN CATCH 
		if(@ESTADO=1)
		begin
			set @ESTADO = -1;
			set @MENSAJE = 'Error en el proceso, intentelo nuevamente.';
		end;
		print ERROR_MESSAGE();
		ROLLBACK TRANSACTION; 
	END CATCH;
END;
GO



-- Prueba: Codigo de moneda no existe
DECLARE @CODIGO CHAR(8), @ESTADO INT,@MENSAJE VARCHAR(1000);
EXEC USP_CREAR_CUENTA '00014','08',7800.0,'123456','0007',
	@CODIGO OUT, @ESTADO OUT, @MENSAJE OUT;
PRINT 'CODIGO: ' + @CODIGO;
PRINT CONCAT('ESTADO: ',@ESTADO);
PRINT CONCAT('MENSAJE: ', @MENSAJE);
GO

-- Prueba: Codigo de empleado no labora actualmente
DECLARE @CODIGO CHAR(8), @ESTADO INT,@MENSAJE VARCHAR(1000);
EXEC USP_CREAR_CUENTA '00014','01',7800.0,'123456','0003',
	@CODIGO OUT, @ESTADO OUT, @MENSAJE OUT;
PRINT 'CODIGO: ' + @CODIGO;
PRINT CONCAT('ESTADO: ',@ESTADO);
PRINT CONCAT('MENSAJE: ', @MENSAJE);
GO


-- Prueba: Codigo de empleado no existe
DECLARE @CODIGO CHAR(8), @ESTADO INT,@MENSAJE VARCHAR(1000);
EXEC USP_UCV_GPO_B_CREAR_CUENTA '00014','01',7800.0,'123456','0999',
	@CODIGO OUT, @ESTADO OUT, @MENSAJE OUT;
PRINT 'CODIGO: ' + @CODIGO;
PRINT CONCAT('ESTADO: ',@ESTADO);
PRINT CONCAT('MENSAJE: ', @MENSAJE);
GO


-- Prueba ok
DECLARE @CODIGO CHAR(8), @ESTADO INT,@MENSAJE VARCHAR(1000);
EXEC USP_CREAR_CUENTA '00014','01',7800.0,'123456','0005',
	@CODIGO OUT, @ESTADO OUT, @MENSAJE OUT;
PRINT 'CODIGO: ' + @CODIGO;
PRINT CONCAT('ESTADO: ',@ESTADO);
PRINT CONCAT('MENSAJE: ', @MENSAJE);
GO



