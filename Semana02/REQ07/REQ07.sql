/*

Calcular los ingresos por mes de un determinado año, por curso.
Base de datos: EDUTEC 

NOMBRE CURSO ENERO FEBRERO MARZO ..... TOTAL 
----------------------------------------------------------------

*/

SELECT * FROM EduTec..CursoProgramado;
GO

/*
1. Analizar cada requerimiento.

De un curso se programan varias secciones por mes, el numero del mes
forma parte del IDCICLO, en base a esta información se puede saber 
los ingresos por mes, haciendo el calculo con la cantidad de matriculados
y el precio del curso.
*/



/*
2. Identificar los datos que debe tener el reporte.

- NOMBRE DEL CURSO
- INGRESO DE ENERO
- INGRESO DE FEBREO
- INGRESO DE MARZO
- ...
- INGRESO DE OCTUBRE
- INGRESO DE NOVIEMBRE
- INGRESO DE DICIEMBRE
-- INGRESO TOTAL

*/

/*
3. Identificar las tablas de donde obtendrá los datos.

- NOMBRE DEL CURSO: CURSO
- INGRESO DE ENERO: CURSOPROGRAMADO
- INGRESO DE FEBRERO: CURSOPROGRAMADO
- INGRESO DE MARZO: CURSOPROGRAMADO
- ...
- INGRESO DE OCTUBRE: CURSOPROGRAMADO
- INGRESO DE NOVIEMBRE: CURSOPROGRAMADO
- INGRESO DE DICIEMBRE: CURSOPROGRAMADO
-- INGRESO TOTAL: CURSOPROGRAMADO
*/

/*
4. Crear la vista en la base de datos.
*/

SELECT SUM(cp.PreCursoProg*cp.Matriculados) 
FROM EduTec..CursoProgramado cp
WHERE cp.IdCiclo like '2021%';
GO

SELECT 
	c.NomCurso CURSO,
	SUM(IIF(RIGHT(cp.idciclo,2)='01', cp.PreCursoProg*cp.Matriculados,0)) "ENERO",
	SUM(IIF(RIGHT(cp.idciclo,2)='02', cp.PreCursoProg*cp.Matriculados,0)) "FEBRERO",
	SUM(IIF(RIGHT(cp.idciclo,2)='03', cp.PreCursoProg*cp.Matriculados,0)) "MARZO",
	SUM(IIF(RIGHT(cp.idciclo,2)='04', cp.PreCursoProg*cp.Matriculados,0)) "ABRIL",
	SUM(IIF(RIGHT(cp.idciclo,2)='05', cp.PreCursoProg*cp.Matriculados,0)) "MAYO",
	SUM(IIF(RIGHT(cp.idciclo,2)='06', cp.PreCursoProg*cp.Matriculados,0)) "JUNIO",
	SUM(IIF(RIGHT(cp.idciclo,2)='07', cp.PreCursoProg*cp.Matriculados,0)) "JULIO",
	SUM(IIF(RIGHT(cp.idciclo,2)='08', cp.PreCursoProg*cp.Matriculados,0)) "AGOSTO",
	SUM(IIF(RIGHT(cp.idciclo,2)='09', cp.PreCursoProg*cp.Matriculados,0)) "SETIEMBRE",
	SUM(IIF(RIGHT(cp.idciclo,2)='10', cp.PreCursoProg*cp.Matriculados,0)) "OCTUBRE",
	SUM(IIF(RIGHT(cp.idciclo,2)='11', cp.PreCursoProg*cp.Matriculados,0)) "NOVIEMBRE",
	SUM(IIF(RIGHT(cp.idciclo,2)='12', cp.PreCursoProg*cp.Matriculados,0)) "DOCIEMBRE",
	SUM(cp.PreCursoProg*cp.Matriculados) "INGRESO TOTAL"
FROM EduTec..Curso c
join EduTec..CursoProgramado cp on c.IdCurso = cp.IdCurso
WHERE cp.IdCiclo like '2021%'
GROUP BY c.NomCurso;
GO


/*
5. Verificar su resultado.
6. Consultar la vista desde Microsoft Excel


*/





