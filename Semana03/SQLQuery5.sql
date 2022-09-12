/*
Resumen de ventas en EDUCA
*/

ALTER FUNCTION dbo.fnResumen()
RETURNS @resumen TABLE(
	id int primary key not null,
	nombre varchar(100) not null,
	vacantes int not null,
	matriculados int not null,
	disponibles int not null default 0,
	comprometido money not null default 0,
	recaudado money not null default 0,
	faltaCobrar money not null default 0
)
as
begin
	-- Datos base
	insert into @resumen(id,nombre,vacantes,matriculados)
	select cur_id, cur_nombre, cur_vacantes, cur_matriculados
	from curso;
	-- Disponibles
	update @resumen set disponibles = vacantes - matriculados;
	-- Comprometido
	update @resumen 
	set comprometido = isnull( (select sum(mat_precio) 
			from MATRICULA m where m.cur_id = r.id), 0 )
	from @resumen r;
	-- recaudado
	update @resumen 
	set recaudado = isnull( (select sum(pag_importe) 
			from PAGO p where p.cur_id = r.id), 0 )
	from @resumen r;
	-- Falta cobrar
	update @resumen
	set faltaCobrar = comprometido - recaudado;
	RETURN;
end;
go

select * from dbo.fnResumen();
go

select * from educa..CURSO;