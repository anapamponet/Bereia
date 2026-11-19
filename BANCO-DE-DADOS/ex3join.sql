use sprint2;
create table pessoa (
    idPessoa int primary key auto_increment,
    nome varchar(40),
    cidade varchar(40),
    dtNasc date,
    telefone varchar(15),
    fkPessoa int 
);
insert into pessoa values
    (default, 'Ana', 'São Paulo', '1995-04-12', '11 91234-5678', null),
    (default, 'Beatriz', 'Campinas', '1990-09-30', null, 1),
    (default, 'Carla Dias', 'São Paulo', '2001-01-15', '11 98765-4321', 1),
    (default, 'Henrique', 'Santos', '1988-11-05', null, 2),
    (default, 'Elis', 'Osasco', '2003-07-21', '11 97777-1234', 3);
    
alter table pessoa add constraint fkPessoaIndicou
    foreign key (fkPessoa) references pessoa (idPessoa);
    
select * from pessoa;

select nome as Pessoa,
	cidade as Cidade,
	dtNasc as DataNascimento
    from pessoa;
    
select p.nome as Pessoa,
	i.nome as Indicador
    from pessoa as p
    join pessoa as i on p.fkPessoa = i.idPessoa;
    
select nome, dtNasc,
case
	when dtNasc >= '2000-01-01' then 'Nascido a partir de 2000'
	when dtNasc >= '1990-01-01' then 'Nascido nos anos 90'
	else 'Nascido antes de 1990'
end as faixaNascimento
from pessoa;

select nome,
       ifnull(telefone, 'Sem telefone') as telefone
    from pessoa;
    

 


    
