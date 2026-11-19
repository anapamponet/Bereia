use sprint2;

create table pessoaA (
    idPessoa1 int primary key auto_increment,
    nome varchar(45),
    dtNascimento date
);

create table pessoaB (
    idPessoa2 int primary key auto_increment,
    nome varchar(45),
    dtNascimento date,
    fkPessoa1 int
);

insert into pessoaA (idPessoa1, nome, dtNascimento) values
    (1, 'Ana Souza', '1995-04-12'),
    (2, 'Bruno Lima', '1990-09-30'),
    (3, 'Carla Dias', '2001-01-15'),
    (4, 'Diego Alves', '1988-11-05'),
    (5, 'Elisa Rocha', '2003-07-21');

insert into pessoaB (idPessoa2, nome, dtNascimento, fkPessoa1) values
    (1, 'Marcos Pereira', '1992-02-10', 1),
    (2, 'Julia Costa', '1999-06-18', 2),
    (3, 'Rafael Nunes', '2000-12-03', 3),
    (4, 'Patricia Melo', '1985-08-25', 4),
    (5, 'Lucas Ferreira', '2004-03-09', null);


alter table pessoaB add constraint fkPessoaBPessoaA
    foreign key (fkPessoa1) references pessoaA (idPessoa1);

alter table pessoaB add constraint FkPessoaA unique (fkPessoa1);

select * from pessoaA;
select * from pessoaB;

select nome as Pessoa,
       dtNascimento as DataNascimento
    from pessoaA;

select p1.nome as Pessoa1,
       p2.nome as Pessoa2
    from pessoaA as p1
    join pessoaB as p2 on p2.fkPessoa1 = p1.idPessoa1;

select nome, dtNascimento,
case
	when dtNascimento >= '2000-01-01' then 'Nascido a partir de 2000'
	when dtNascimento >= '1990-01-01' then 'Nascido nos anos 90'
else 'Nascido antes de 1990'
end as faixaNascimento
from pessoa1;

select p1.nome as Pessoa1,
       ifnull(p2.nome, 'Sem correspondente') as Pessoa2
    from pessoa1 as p1
    left join pessoa2 as p2 on p2.fkPessoa1 = p1.idPessoa1;

select nome,
       ifnull(fkPessoa1, 0) as fkPessoa1
    from pessoaB;