USE [VENTA]
GO
CREATE USER [neymar] FOR LOGIN [neymar]
GO


create procedure usp_listado
as
	select * from rol;
go

exec usp_listado;
go


