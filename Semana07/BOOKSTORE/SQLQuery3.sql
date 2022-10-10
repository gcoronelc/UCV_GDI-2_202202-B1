-- Diseño
/*
create procedure usp_venta
(
	@cliente varchar(150),
	@idpublicacion char(8),
	@cantidad int,
	@idempleado int,
	@idventa int out,
	@estado int out
)
as
*/

-- Implementación

ALTER PROCEDURE USP_VENTA
(
	@CLIENTE VARCHAR(150),
	@IDPUBLICACION CHAR(8),
	@CANTIDAD INT,
	@IDEMPLEADO INT,
	@IDVENTA INT OUT,
	@ESTADO INT OUT
)
AS
	DECLARE @PORCDCTO DECIMAL(5,2),    @PRECIO MONEY,       @DCTO MONEY,
	        @SUBTOTAL MONEY,           @IMPUESTO MONEY,     @TOTAL MONEY,
			@CONT INT,                 @STOCK INT;
BEGIN
	SET @ESTADO = 0;
	BEGIN TRY 
		-- Paso 1: Inicio
		BEGIN TRANSACTION;
		-- Paso 2: Verificar el código de la publicación
		SELECT @CONT = COUNT(1) FROM PUBLICACION
		WHERE idpublicacion=@IDPUBLICACION;
		IF(@CONT=0) 
		BEGIN
			SET @ESTADO = 2;
			THROW 51000, 'No existe la publicación.', 1;
		END;
		-- Paso 3: Verificar el código del empleado
		-- Paso 4: Validar cantidad
		IF(@CANTIDAD<=0)
		BEGIN
			SET @ESTADO = 4;
			THROW 51000, 'La cantidad debe ser positiva.', 1;
		END;
		-- Paso 5: Verificar stock
		SELECT @STOCK = stock FROM PUBLICACION
		WHERE idpublicacion = @IDPUBLICACION;
		IF(@CANTIDAD>@STOCK)
		BEGIN
			SET @ESTADO = 3;
			THROW 51000, 'Stock insuficiente.', 1;
		END;
		-- Paso 6: Calcular venta
		SELECT @PORCDCTO = porcentaje FROM PROMOCION
		WHERE @CANTIDAD>= cantmin AND @CANTIDAD<=cantmax;
		SELECT @PRECIO = PRECIO FROM PUBLICACION
		WHERE idpublicacion = @IDPUBLICACION;
		SET @DCTO = @PRECIO * @CANTIDAD * @PORCDCTO;
		SET @TOTAL = @PRECIO * @CANTIDAD - @DCTO;
		SET @SUBTOTAL = @TOTAL / 1.18;
		SET @IMPUESTO = @TOTAL - @SUBTOTAL;
		-- Paso 7: Generar número de venta
		SELECT @IDVENTA = CAST(valor as int) + 1 FROM CONTROL
		WHERE parametro='VENTA';
		UPDATE CONTROL SET valor = CAST(@IDVENTA AS VARCHAR(20))
		WHERE parametro='VENTA';
		-- Paso 8: Registrar venta
		INSERT INTO VENTA(idventa,cliente,fecha,idempleado,idpublicacion,
			cantidad,precio, dcto, subtotal,impuesto,total) 
		VALUES(@IDVENTA,@CLIENTE,GETDATE(),@IDEMPLEADO,@IDPUBLICACION,
			@CANTIDAD,@PRECIO,@DCTO,@SUBTOTAL,@IMPUESTO,@TOTAL);
		-- Paso 9: Actualizar stock
		UPDATE PUBLICACION
		SET stock = stock - @CANTIDAD
		WHERE idpublicacion = @IDPUBLICACION;
		-- Paso 10
		COMMIT TRANSACTION; 
	END TRY 
	BEGIN CATCH 
		IF(@ESTADO=0) SET @ESTADO = 1;
		ROLLBACK TRANSACTION;
	END CATCH;
END;
GO

DECLARE @IDVENTA INT, @ESTADO INT;
EXEC USP_VENTA 'Gustavo','LIB00002',-10,4,@IDVENTA out, @ESTADO out;
PRINT 'IDVENTA: ' + CAST(@IDVENTA AS VARCHAR(20));
PRINT 'ESTADO: ' + CAST(@ESTADO AS VARCHAR(20));
GO


SELECT * FROM PROMOCION;
SELECT * FROM CONTROL;
SELECT * FROM VENTA ORDER BY 1 DESC;
SELECT * FROM PUBLICACION;