
ALTER PROCEDURE USP_REG_MATRICULA
(
	@CUR_ID INT,
	@ALU_ID INT,
	@MAT_PRECIO MONEY,
	@MAT_CUOTAS INT,
	@ESTADO INT OUT
)
AS
BEGIN
	-- VARIABLES
	DECLARE @CONT INT, @CUR_PRECIO INT, @DISPONIBLES INT;
	-- PROCESO
	SET @ESTADO = 0;
	BEGIN TRY 
		-- Inicia la Tx
		BEGIN TRANSACTION; 
		-- Validar curso
		SELECT @CONT = COUNT(1) FROM CURSO WHERE CUR_ID=@CUR_ID;
		if(@CONT=0)
		begin
			set @ESTADO= 2;
			THROW 51000, 'No existe el curso.', 1;
		end;
		-- Validar alumno
		SELECT @CONT = COUNT(1) FROM ALUMNO WHERE ALU_ID=@ALU_ID;
		if(@CONT=0)
		begin
			set @ESTADO= 3;
			THROW 51000, 'No existe el alumno.', 1;
		end;
		-- Matricula ya existe
		SELECT @CONT = COUNT(1) FROM MATRICULA 
		WHERE cur_id=@CUR_ID AND ALU_ID=@ALU_ID;
		if(@CONT=1)
		begin
			set @ESTADO= 4;
			THROW 51000, 'Matricula ya existe.', 1;
		end;
		-- Validar cantidad de cuotas
		if(@MAT_CUOTAS<=0 OR @MAT_CUOTAS>3)
		begin
			set @ESTADO= 5;
			THROW 51000, 'Nro. de cuotas fuera de rango.', 1;
		end;
		-- Datos del curso
		SELECT @CUR_PRECIO=cur_precio, @DISPONIBLES=cur_vacantes-cur_matriculados
		FROM CURSO WHERE cur_id = @CUR_ID;
		-- Verificar vacantes disponibles
		if(@DISPONIBLES<=0)
		begin
			set @ESTADO= 6;
			THROW 51000, 'No hay vacantes disponibles.', 1;
		end;
		-- Validar precio
		IF(@MAT_PRECIO<@CUR_PRECIO*0.5 OR @MAT_PRECIO>@CUR_PRECIO)
		BEGIN
			set @ESTADO= 7;
			THROW 51000, 'Precio esta fuera de rango.', 1;
		END
		IF(@MAT_CUOTAS=1 AND @MAT_PRECIO<>@CUR_PRECIO)
		BEGIN
			set @ESTADO= 7;
			THROW 51000, 'El precio debe ser igual al precio de lista.', 1;
		END;
		-- Transacción
		INSERT INTO MATRICULA(cur_id,alu_id,mat_fecha,mat_precio,mat_cuotas)
		VALUES(@CUR_ID,@ALU_ID,GETDATE(),@MAT_PRECIO,@MAT_CUOTAS);
		UPDATE CURSO
		SET cur_matriculados = cur_matriculados + 1
		WHERE cur_id = @CUR_ID;
		-- Confirma la Tx
		COMMIT TRANSACTION; 
	END TRY 
	BEGIN CATCH 
		-- Cancela la Tx
		print(ERROR_MESSAGE());
		ROLLBACK TRANSACTION;
		if(@ESTADO=0) set @ESTADO=1;
	END CATCH;
END;
GO

select * from curso;
select * from matricula where cur_id=1;
GO

-- Proceso ok
DECLARE @ESTADO INT;
EXEC USP_REG_MATRICULA 1, 10, 1000, 1, @ESTADO OUT;
PRINT 'ESTADO: ' + CAST(@ESTADO AS VARCHAR(20));
GO


-- A 2 cuota
DECLARE @ESTADO INT;
EXEC USP_REG_MATRICULA 1, 7, 200, 2, @ESTADO OUT;
PRINT 'ESTADO: ' + CAST(@ESTADO AS VARCHAR(20));
GO

-- A 1 cuota
DECLARE @ESTADO INT;
EXEC USP_REG_MATRICULA 1, 8, 500, 2, @ESTADO OUT;
PRINT 'ESTADO: ' + CAST(@ESTADO AS VARCHAR(20));
GO

-- Nro de cuotas fuera de rango
DECLARE @ESTADO INT;
EXEC USP_REG_MATRICULA 1, 7, 99999, 100, @ESTADO OUT;
PRINT 'ESTADO: ' + CAST(@ESTADO AS VARCHAR(20));
GO

-- Matricula ya existe
DECLARE @ESTADO INT;
EXEC USP_REG_MATRICULA 1, 4, 99999, 100, @ESTADO OUT;
PRINT 'ESTADO: ' + CAST(@ESTADO AS VARCHAR(20));
GO

-- Alumno no existe
DECLARE @ESTADO INT;
EXEC USP_REG_MATRICULA 1, 111, 99999, 100, @ESTADO OUT;
PRINT 'ESTADO: ' + CAST(@ESTADO AS VARCHAR(20));
GO

-- Curso no existe
DECLARE @ESTADO INT;
EXEC USP_REG_MATRICULA 999, 1, 99999, 100, @ESTADO OUT;
PRINT 'ESTADO: ' + CAST(@ESTADO AS VARCHAR(20));
GO


