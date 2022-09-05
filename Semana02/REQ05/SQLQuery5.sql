/*
Desarrollar una VISTA que permita obtener el siguiente resultado: 

NOMBRE DEL CURSO   MATRICULADOS   COMPROMETIDO         PAGADO 
------------------------------------------------------------------ 
SQL SERVER ADM.         5             4,250.00        3,310.00

Base de datos: EDUCA

*/

/*

CASO
----------------------------------------
Si un curso cuesta: 2,000.00 Soles
Matriculados: 10 estudiantes
Comprometido a pagar: 20,000.00
Todos han pago el 40%, PAGADO: 8,000.00

*/

select * from curso;
go

select * from MATRICULA;
go

with 
v1 as (
	select 
		c.cur_id,
		c.cur_nombre curso,
		count(1) matriculados,
		sum(m.mat_precio) comprometido
	from curso c
	join matricula m on c.cur_id = m.cur_id 
	group by c.cur_id, c.cur_nombre),
v2 as (
	select cur_id, sum(pag_importe) pagado
	from pago 
	group by cur_id)
select v1.cur_id, v1.curso, v1.matriculados, v1.comprometido, isnull(v2.pagado,0.0) pagado
from v1 left join v2 on v1.cur_id=v2.cur_id;
go



SELECT 
	v1.cur_id, v1.curso, v1.matriculados, v1.comprometido, isnull(v2.pagado,0.0) pagado
FROM (
	select 
			c.cur_id,
			c.cur_nombre curso,
			count(1) matriculados,
			sum(m.mat_precio) comprometido
		from curso c
		join matricula m on c.cur_id = m.cur_id 
		group by c.cur_id, c.cur_nombre
) v1
left join (
	select cur_id, sum(pag_importe) pagado
		from pago 
		group by cur_id
) v2
on v1.cur_id = v2.cur_id
go




