/*
ENUNCIADO
--------------------------------------------------------------
Se necesita saber el importe de las ventas de cada producto y 
que porcentaje representa del total de las ventas.
Base de datos: Northwind
El modelo del resultado es el siguiente:
- NOMBRE DEL PRODUCTO 
- IMPORTE DE VENTAS 
- PORCENTAJE DEL TOTAL
*/


/*
1. Analizar cada requerimiento.

Se solicita el importe de las ventas por producto, para luego 
encontrar que porcente representa este valor del importe total
de todas las ventas.
*/

/*
2. Identificar los datos que debe tener el reporte.

Estos son los campos:
-------------------------------------
- NOMBRE DEL PRODUCTO 
- IMPORTE DE VENTAS 
- IMPORTE TOTAL DE LAS VENTAS
- PORCENTAJE DEL TOTAL
*/

/*
3. Identificar las tablas de donde obtendrá los datos.

- Products
- [Order Details]

*/

/*
4. Elaborar la consulta.
*/

WITH
t1 as (
	select ProductID, sum(UnitPrice*Quantity) ImporteVentas
	from Northwind..[Order Details]
	group by ProductID),
t2 as (select sum(ImporteVentas) TotalVentas from t1)
select p.ProductName, t1.ImporteVentas, t2.TotalVentas,
	cast(t1.ImporteVentas*100.0/t2.TotalVentas as numeric(10,2)) Porcentaje
from Northwind..Products p
join t1 on p.ProductID = t1.ProductID
cross join t2
order by p.ProductID;
go


-- Juan Milla

with v1 as(select ProductID,sum(UnitPrice*Quantity) ImporteVentas, TOTALVENTAS=(select sum(UnitPrice*Quantity) TotalVentas from [Order Details])from [Order Details]group by ProductID)select OD.ProductID,OD.ProductID,v1.ImporteVentas,Porcentaje=round(((v1.ImporteVentas*100)/v1.TOTALVENTAS),3) from [Order Details] as ODinner join v1 on v1.ProductID=OD.ProductIDgroup by  OD.ProductID,v1.ImporteVentas,v1.TOTALVENTASorder by OD.ProductID




/*
5. Verificar su resultado

Se realizo en el Excel.
*/



