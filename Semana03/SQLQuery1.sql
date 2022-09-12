
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

/*
Cantidad de empleados por departamento y que porcente representa del total.
*/

alter function dbo.fn_empleados()
returns table
as
return
with
v1 as (select count(1) total from empleado),
v2 as (
	select iddepartamento, count(1) empleados
	from empleado
	group by iddepartamento)
select v2.*, v2.empleados*100.0/v1.total porcentaje
from v1 cross join v2;
go


select * from dbo.fn_empleados();
go

/*
Se necesita saber cuál es el producto más solicitado en cada ciudad, se debe mostrar los empates.
Se debe considerar la ciudad de reparto, columna Orders.ShipCity.
*/

WITH
v1 as (
	select o.ShipCity, od.ProductID, sum(od.Quantity) cantidad
	from Northwind..Orders o
	join Northwind..[Order Details] od 
	on o.OrderID = od.OrderID
	group by o.ShipCity, od.ProductID),
v2 as (
	select ShipCity, max(cantidad) mayor 
	from v1
	group by ShipCity)
select v1.*
from v1 join v2 
on v1.ShipCity=v2.ShipCity and v1.cantidad = v2.mayor
order by 1,2;
go

/*
Función de tabla de múltiples instrucciones
*/

ALTER FUNCTION dbo.fn_catalogo ( ) 
RETURNS @tabla TABLE ( 
	codigo int identity(1,1) primary key not null, 
	nombre varchar(50) not null, 
	precioCosto money not null, 
	porcGanancia decimal(5,2) not null,
	precioVenta money not null default 0)
AS 
BEGIN 
	-- Datos
	INSERT INTO @tabla(nombre,precioCosto,porcGanancia) values('Televisor', 1500.00, 0.40); 
	INSERT INTO @tabla(nombre,precioCosto,porcGanancia) values('Refrigeradora', 1450.00,0.60); 
	INSERT INTO @tabla(nombre,precioCosto,porcGanancia) values('Lavadora', 1350.00,0.58); 
	-- Precio de venta
	update @tabla
	set precioVenta = precioCosto * (1+porcGanancia);
	RETURN; 
END; 
GO 

SELECT * FROM dbo.fn_catalogo(); 
GO
