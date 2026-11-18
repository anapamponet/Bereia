create database sprint3;
use sprint3;

create table curso (
idcurso int primary key auto_increment,
nome varchar(45),
tipo varchar(45),
constraint chktipo check (tipo in ('presencial', 'remoto')),
cargahoraria int
);

insert into curso (nome,tipo) values
	('inglês', 'presencial'),
    ('espanhol', 'presencial');
    
select * from curso;

create table aluno (
idaluno int primary key auto_increment,
nome varchar(45),
email varchar(45)
) auto_increment = 1000;

insert into aluno (nome) values
	('Inácio'),
    ('Idailton'),
	('Idalina');
    
create table matricula (
idmatricula int auto_increment,
fkcurso int,
constraint fkcursomatricula foreign key (fkcurso)
	references curso(idcurso),
fkaluno int,
constraint fkalunomatricula foreign key (fkaluno)
	references aluno(idaluno),
constraint pkcomposta primary key (idmatricula, fkcurso, fkaluno),
nota decimal(4,2)
);

insert into matricula values
	(default, 1, 1000, 6),
    (default, 2, 1001, 5),
    (default, 2, 1001, 6);
    
select aluno.nome as nomealuno,
curso.nome as nomecurso,
nota,
case
when nota >=6 then 'Aprovado'
else 'Reprovado'
end statuss
from aluno join matricula
on fkaluno = idaluno
join curso
on fkcurso = idcurso;

select max(nota) from matricula;
select sum(nota) from matricula;
select avg(nota) from matricula;
select round(avg(nota), 2) from matricula;
select count(nota) from matricula;
select round(avg(nota), 2), curso.nome from curso 
	join matricula on idcurso = fkcurso
    group by curso.nome;
    
select aluno.nome, nota from aluno join matricula
	on idaluno = fkaluno
    where nota = 
(select max(nota) from matricula);