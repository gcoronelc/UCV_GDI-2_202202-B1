/*
Buscar clientes por ciudad.
*/
/*
1. Analizar del requerimiento.

La busqueda debe hacerse por las primeras letras de la ciudad.
Por ejemplo, para buscar los clientes de la ciudad de Chiclayo
se debe ingresar: CHI%
De esta manera se busca los clientes de toda ciudad que su 
nombre inicia con CHI.
*/

/*
2. Diseñar una solución.

Para tener consultas mas rapidas se debe crear un indice en la tabla
CUSTOMERS con la columna CITY.

*/

/*
3. Implementar la solución.

CREATE INDEX IDX_CUSTOMERS_CITY ON CUSTOMERS(CITY);

*/
/*
4. Verificar su funcionamiento.
 
*/

USE NORTHWIND;
GO

set statistics io on;
set statistics time on

CREATE INDEX IDX_CUSTOMERS_CITY ON CUSTOMERS(CITY);

SELECT * FROM Customers WHERE CITY = 'Graz';


5. Recoger evidencias.
6. Elaborar informe que incluya conclusiones y recomendaciones.