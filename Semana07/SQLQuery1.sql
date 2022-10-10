alter proc usp_demo
as
begin
	print 'Hola todos, esto se pone bueno!!';
end;
go

exec usp_demo;
go

create procedure usp_doble
(@numero int, @doble int out)
as
begin
	set @doble = @numero * 2;
end;
go

alter procedure usp_doble
(@numero int, @doble int out)
as
begin
	select @doble = @numero * 2;
end;
go


declare @doble int;
exec usp_doble 6, @doble out;
print 'Doble: ' + cast(@doble as varchar(15));
go


