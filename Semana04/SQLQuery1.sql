
use EDUCA;
GO

SELECT * FROM ALUMNO;
GO

CREATE TRIGGER tr_alumno_01
ON alumno
FOR INSERT, UPDATE
AS
BEGIN
	PRINT 'MENSAJE DESDE EL TRIGGER';
	PRINT 'Operación ejecutada correctamente';
END;
GO

select * from alumno order by 1 desc;
go

insert into alumno values(2000, 'Pedro Navaja', 'Lima', '967345856', 'pnavaja@gmail.com');
go

update alumno 
set alu_nombre = 'ERIC CORONEL'
where alu_id=2000;
go



