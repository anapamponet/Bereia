use sprint2;
create table funcionario(
idfuncionario int primary key auto_increment,
nome varchar(45),
areaa varchar(45),
salario decimal(10,2),
fksuper int,
constraint fkfuncsuper
	foreign key (fksuper)
    references funcionario(idfuncionario)
);
insert into funcionario (nome,salario, fksuper) value
('Brandão', 100.00, null),
('Vivian', 99.00, 1),
('Matheus', 96.00, 1),
('Pedro', 101.00, 2);

select * from funcionario join funcionario as supervisor
	on funcionario.fksuper = supervisor.idfuncionario;
    
select funcionario.nome as nomefunc,
	supervisor.nome as nomesuper
    from funcionario join funcionario as supervisor
		on funcionario.fksuper = supervisor.idfuncionario;
        
select funcionario.nome as nomefunc,
	ifnull(supervisor.nome, 'supervisor') as nomesuper
    from funcionario left join funcionario as supervisor
		on funcionario.fksuper = supervisor.idfuncionario;
        
create table dependente (
iddependente int,
fkfunc int,
constraint pkcomposta primary key (iddependente,fkfunc),
nome varchar(45),
parentesco varchar(45),
constraint fkdepfunc foreign key(fkfunc)
	references funcionario (idfuncionario)
);

insert into dependente values
	(1,2, 'Cintia', 'namorada'),
    (1,3, 'Lola', 'pet'),
    (2,3, 'Sebastian', 'Matheus bêbado'),
    (1,4, 'Eliane', 'Mãe');
    
select funcionario.nome as func,
	dependente.nome as dependente
    from funcionario left join dependente
    on idfuncionario = fkfunc
    where fkfunc is null;
    
alter table funcionario add constraint salariopositivo
	check (salario >=0);
    
select f.idfuncionario as 'id funcionario',
f.fksuper as 'id super',
f.nome as 'nome funcionario',
s.nome as 'nome supervisor',
d.nome as 'nome dependente'
from funcionario as f join funcionario as s
on f.fksuper = s.idfuncionario
join dependente as d
on f.idfuncionario = d.fkfunc
order by f.idfuncionario;