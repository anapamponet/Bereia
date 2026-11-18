USE sprint1;
drop database sprint1;
create database sprint2;
use sprint2;
-- criar tabela responsável pois não tem fk
create table responsavel (
idresponsavel int primary key auto_increment,
nome varchar(45),
salario decimal(10,2)
) auto_increment = 5000;

insert into responsavel value
	(default, 'Jow', 1.88),
    (default, 'Jerry', 1.48),
    (default, 'Jan', 1.98);
    
create table empresa (
idempresa int primary key auto_increment,
nome varchar(45),
cnpj char(15) unique,
fkresponsavel int not null unique,
constraint fkempresaresponsavel
	foreign key (fkresponsavel)
		references responsavel(idresponsavel)
);

insert into empresa values
	(default,'C6 Bank', null, 5000),
    (default, 'Safra', null, 5001),
    (default, 'Stefanini', null, 5002);

-- primeiro JOIN (Junção)
-- sempre usando ON para indicar qual tabela e qual coluna.
select * from responsavel
	join empresa on fkresponsavel = idresponsavel;
    
select responsavel.nome as responsa,
	empresa.nome as nomeempresa
    from empresa join responsavel
		on idresponsavel = fkresponsavel;
        
create table aluno (
ra char(8) primary key,
nome varchar(45),
bairro varchar (25),
fkempresa int not null
);

alter table aluno add constraint fkempresaaluno
	foreign key (fkempresa)
		references empresa(idempresa);
        
insert into aluno values
	('0126111', 'Jonas', 'Paraiso', 1),
    ('0126112', 'Janaina', 'Perdizes', 1),
    ('0126113', 'Jeremias', null, 1),
    ('0126114', 'Januario', null, 3);
    
select * from empresa
	join aluno on fkempresa = idempresa;
    
select empresa.nome as empresa,
	aluno.nome as aluno,
    responsavel.nome as responsavel
    from empresa join responsavel
		on idresponsavel = fkresponsavel
        join aluno
        on idempresa = fkempresa
        where empresa.nome = 'C6 bank';