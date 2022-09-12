
CREATE FUNCTION dbo.fn_suma 
( @num1 int, @num2 int ) 
RETURNS int 
AS BEGIN 
	DECLARE @suma int;
	SET @suma = @num1 + @num2; 
	RETURN @suma; 
END; 
GO

select dbo.fn_suma (8, 16);
go


/*
Ejercicio:
Hacer una funcion para calular el mayor valor de 5 elementos.
*/

create function dbo.fn_mayvalo(@num1 int,@num2 int,@num3 int,@num4 int,@num5 int)RETURNS int AS BEGIN 	DECLARE @NumMay int;	SET @NumMay = IIF(@num1>@num2,@num1,@num2);	SET @NumMay = IIF(@NumMay>@num3,@NumMay,@num3);	SET @NumMay = IIF(@NumMay>@num4,@NumMay,@num4);	SET @NumMay = IIF(@NumMay>@num5,@NumMay,@num5);	RETURN @NumMay; END; GO

/*
Ejercicio
Hacer una función para calcular el factorial de un número;
*/

create function dbo.fn_factorial(@num int)RETURNS int AS BEGIN 	DECLARE @Fact int;	SET @Fact=1	while(@num>0)	BEGIN       SET @Fact=@Fact*@num;        SET @num=@num-1;    END;	RETURN @Fact; END;
GO

create function dbo.Fact_Recu (@value int)returns intas begin	declare @resut int;	if( @value = 0 )		set @resut = 1;	else 		set @resut = @value * dbo.Fact_Recu(@Value - 1);	return @resut;endgo

/*
FUNCIONES DE TABLA EN LINEA
sentencia select con parametros - vistas parametrizadas
*/

USE RH; 
GO 

ALTER FUNCTION dbo.fn_empleados ( @p_dpto int ) 
RETURNS TABLE 
AS RETURN (
	SELECT idempleado, apellido, nombre 
	FROM dbo.empleado 
	WHERE iddepartamento = @p_dpto 
);
GO 

SELECT * FROM dbo.fn_empleados(102); 
GO










