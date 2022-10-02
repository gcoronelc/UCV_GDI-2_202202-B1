-- Problema 1

SELECT 
	d.nombre "NOMBRE DEPARTAMENTO",
	COUNT(1) "EMPLEADOS",
	SUM(SUELDO) "IMPORTE PLANILLA",
	SUM(ISNULL(comision,0)) "COMISION",
	SUM(SUELDO+ISNULL(comision,0)) "TOTAL"
FROM RH..empleado E
JOIN RH..departamento D ON E.iddepartamento=D.iddepartamento
GROUP BY d.nombre;
GO


-- Problema 3
withv1 as (	select 		c.NomCurso "Nombre del Curso",		count(cp.IdCursoProg) "Aulas Programadas",		sum(cp.Vacantes+cp.Matriculados) "Vacantes Programadas",		sum(cp.Matriculados) "Matriculados"	from CursoProgramado cp	join Curso c on cp.IdCurso=c.IdCurso 	where cp.IdCiclo='2020-01'	group by c.NomCurso)select 	v1.*, v1.Matriculados*100.0/v1.[Vacantes Programadas]from v1
go


-- Problema 4
select 	concat(p.NomProfesor,' ',p.ApeProfesor) "Nombre Profesor",	count(cp.IdCursoProg) "Aulas Programadas",	sum(t.Horas) "Horas Dictadas",	sum(t.PagoHora*t.Horas) "Importe"from CursoProgramado cpjoin Curso c on cp.IdCurso = c.IdCursojoin Tarifa t on c.IdTarifa = t.IdTarifajoin Profesor p on cp.IdProfesor = p.IdProfesorwhere cp.IdCiclo='2022-01'group by concat(p.NomProfesor,' ',p.ApeProfesor)
go


-- Problema 6

WITH
V1 AS (
	SELECT 
		O.ShipCountry "PAIS",
		COUNT(DISTINCT O.OrderID) "PEDIDOS",
		SUM(OD.Quantity) "CANTIDAD PRODUCTOS",
		SUM(OD.Quantity*OD.UnitPrice) "IMPORTE"
	FROM Northwind..[Order Details] OD 
	JOIN Northwind..Orders O  ON OD.OrderID=O.OrderID
	GROUP BY O.ShipCountry),
V2 AS (SELECT SUM(V1.IMPORTE) TOTAL FROM V1)
SELECT 
	V1.*,
	V1.IMPORTE*100.0/V2.TOTAL "PORCENTAJE"
FROM V1 CROSS JOIN V2;
GO

SELECT SUM(Quantity) FROM Northwind..[Order Details];
GO

SELECT SUM(Quantity*UnitPrice) FROM Northwind..[Order Details];
GO



