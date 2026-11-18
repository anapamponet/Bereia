use sprint2;
create table atleta (
idaleta int primary key auto_increment,
nome varchar(40),
modalidade varchar(40),
qtdmedalha int
);

insert into atleta values
	(default,'Ana', 'Vôlei', 2),
    (default,'Beatrice', 'Ginástica', 3),
    (default,'Henrique', 'Basquete', 2),
    (default,'Ruby', 'Vôlei', 2),
    (default,'Amelie', 'Ginástica', 1),
    (default,'Joaquim', 'Basquete', 3),
    (default,'Oliviere', 'Basquete', 1);
    
create table paises (
idpais int primary key auto_increment,
nome varchar(30),
capital varchar(40)
);

insert into paises (nome, capital) values 
	('Argentina','Buenos Aires'),
    ('Brasil', 'Brasília'),
    ('Chile', 'Santiago'),
    ('Colômbia', 'Bogotá'),
    ('Suriname', 'Paramaribo'),
    ('Peru','Lima');
    
alter table atleta add column fkpais int;

alter table atleta add constraint
fkAtletaPais
foreign key (fkpais)
references paises(idpais);

select * from atleta;

update atleta set fkpais = 1
	where idaleta = 1;
update atleta set fkpais = 2
	where idaleta in (2,3);
update atleta set fkpais = 3
	where idaleta = 4;
update atleta set fkpais = 4
	where idaleta = 5;
update atleta set fkpais = 5
	where idaleta = 6;
update atleta set fkpais = 6
	where idaleta = 7;

select * from atleta;

select atleta.nome as atleta,
paises.nome as paises
from atleta join paises
on fkpais = idpais;

select * from atleta;
select * from paises;

select atleta.*,
paises.*
from atleta join paises
on fkpais = idpais
where capital = 'Lima';

