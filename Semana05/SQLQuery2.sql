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



