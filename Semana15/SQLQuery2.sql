use BOOKSTORE;

select * from venta;

select SUSER_NAME(), USER_NAME();

USE VENTA;

SELECT * FROM CLIENTE;
SELECT * FROM EMPLEADO;

SELECT * FROM USUARIO;
select * from rol;
select * from control;
select * from ciudad;

EXEC sys.sp_setapprole 'ROL_BETA', 'admin';  
GO

select * from CARGO;
SELECT * FROM CIUDAD;
select * from cliente;
go


exec usp_listado;
go

select * from rol;


