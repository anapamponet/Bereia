CREATE DATABASE sprint1;
use sprint1;

CREATE TABLE cadastro(
id int primary key auto_increment,
nome varchar(50) not null,
cpf char(11),
dtnasc date,
altura float,
salario decimal (10,2),
email varchar(60),
constraint chkemail check(email like '%@%')
) auto_increment = 2000;

insert into cadastro (nome, dtnasc, salario, email) values
	('Rick', '2000-01-01', 3000.99, 'rick@email.com'),
    ('Rock', '2000-03-01', 6000.99, 'rock@email.com');
    
alter table cadastro modify column cpf char(11) unique,
	modify column email varchar(60) not null;
    
describe cadastro;

alter table cadastro add constraint chksalario
	check (salario >=0);
    
alter table cadastro add column dtcadastro datetime default current_timestamp;

update cadastro set dtcadastro = curdate() -- apenas data
	where id >= 2000;
    
update cadastro set dtcadastro = now() -- data e hora do momento exato
	where id >= 2000;
    
select * from cadastro;
select ifnull (cpf, 'estrangeiro'),
	concat('Nome é ', nome) as nome,
    case
		when salario >1000 then 'top'
        else 'não top'
        end as salario
        from cadastro;
        
select concat('Cadastro realizado!', nome, ' tem o cpf',
	ifnull(cpf, ' sem cpf'), ' e o salario é ',
    case
    when salario >1000 then 'Ganha bem'
    else 'Ganha mais ou menos'
    end) as frasecompleta from cadastro;
    
select dtnasc,
	timestampdiff(year, dtnasc, now()) as idade from cadastro;
select * from cadastro;
update cadastro set cpf= '01234567890', altura = 1.67,
	salario = null where id=2000;
    
select cpf from cadastro where cpf is null;

alter table cadastro add column statuscadastro tinyint,
	add constraint chkstatuscadastro
		check(statuscadastro in (0,1));