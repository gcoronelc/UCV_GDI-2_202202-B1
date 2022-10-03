/*
INDICADORES PARA LAS CONSULTAS
-----------------------------------------
 - Cantidad de lecturas lógicas
 - El tiempo de respuesta
 - Fragmentación de los índices.

Se debe tomar en cuenta que los datos se guardan en paginas.
El tamaño de una pagina es 8Kb

Lecturas logicas: 100 ==> Se ha leido 100 paginas de datos

tamañano de la data: 100*8Kb = 800Kb
Supongamos que son 50 concurrentes
Tamaño total: 800*50 Kb = 40000Kb = 39Mb

PARAMETRO: Factor de rrelleno (FILLFACTOR)
------------------------------------------------

Indice FILLFACTOR=100% y son 500 paginas.
Si cambias el FILLFACTOR=50% ==> serian 1000 paginas
Se recomienda un FILLFACTOR de 80% para evitar divisiones de páginas.

*/

set statistics io on;
set statistics time on

SELECT * FROM Northwind..Customers
WHERE City='Madrid';




