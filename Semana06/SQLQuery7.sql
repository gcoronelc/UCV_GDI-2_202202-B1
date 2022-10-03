
create table algo( clave varchar(50), valor int );

insert into algo values
('Cocodrilo',190),
('Lagarto',250),
('Puma',500),
('Corazon',900),
('Pantera',780),
('Cometa',480),
('Mamifero',657),
('Panama',5467);

select * from algo;

create CLUSTERED index idx_algo on algo(clave);
drop index algo.idx_algo;
go

create CLUSTERED index idx_algo on algo(valor);
drop index algo.idx_algo;
go


select * from algo 
where clave='aaa';
go

create CLUSTERED index idx_algo on algo(clave);
drop index algo.idx_algo;
go

set statistics io on;
set statistics time on

select * from algo where clave='aaa';
go

--====================================================================
create CLUSTERED index idx_algo on algo(clave);
drop index algo.idx_algo;
go

select * from algo where clave like 'co%';
go

--====================================================================
create CLUSTERED index idx_algo on algo(clave);
drop index algo.idx_algo;
go

select * from algo where clave like '%ma%';
go


