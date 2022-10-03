/*
INDICADORES PARA LAS CONSULTAS
-----------------------------------------
 - Cantidad de lecturas l�gicas
 - El tiempo de respuesta
 - Fragmentaci�n de los �ndices.

Se debe tomar en cuenta que los datos se guardan en paginas.
El tama�o de una pagina es 8Kb

Lecturas logicas: 100 ==> Se ha leido 100 paginas de datos

tama�ano de la data: 100*8Kb = 800Kb
Supongamos que son 50 concurrentes
Tama�o total: 800*50 Kb = 40000Kb = 39Mb

PARAMETRO: Factor de rrelleno (FILLFACTOR)
------------------------------------------------

Indice FILLFACTOR=100% y son 500 paginas.
Si cambias el FILLFACTOR=50% ==> serian 1000 paginas
Se recomienda un FILLFACTOR de 80% para evitar divisiones de p�ginas.

*/

set statistics io on;
set statistics time on

SELECT * FROM Northwind..Customers
WHERE City='Madrid';




