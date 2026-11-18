use sprint2;


create table farmacia (
    idFarmacia int primary key auto_increment,
    nome varchar(50),
    cnpj char(18),
    tipo varchar(10),
    constraint chkTipoFarmacia check (tipo in ('matriz', 'filial'))
);

create table endereco (
    idEndereco int primary key auto_increment,
    logradouro varchar(60),
    numero varchar(10),
    complemento varchar(30),  
    bairro varchar(40),
    cidade varchar(40),
    uf char(2),
    cep char(9),
    fkFarmacia int not null
);

create table farmaceutico (
    idFarmaceutico int primary key auto_increment,
    nome varchar(50),
    crf varchar(15),
    telefone varchar(15),  
    salario decimal(8,2),
    fkFarmacia int not null
);

insert into farmacia (idFarmacia, nome, cnpj, tipo) values
    (1, 'Farma Vida Centro', '11.111.111/0001-11', 'matriz'),
    (2, 'Farma Vida Paulista', '11.111.111/0002-22', 'filial'),
    (3, 'Drogaria Saude Total', '22.222.222/0001-33', 'matriz'),
    (4, 'Drogaria Saude Norte', '22.222.222/0002-44', 'filial'),
    (5, 'Farmacia Popular Mais', '33.333.333/0001-55', 'matriz');

insert into endereco (idEndereco, logradouro, numero, complemento, bairro, cidade, uf, cep, fkFarmacia) values
    (1, 'Rua das Flores', '120', null, 'Centro', 'Sao Paulo', 'SP', '01001-000', 1),
    (2, 'Avenida Paulista', '1500', 'Loja 2', 'Bela Vista', 'Sao Paulo', 'SP', '01310-100', 2),
    (3, 'Rua XV de Novembro', '45', null, 'Centro', 'Campinas', 'SP', '13010-010', 3),
    (4, 'Rua Augusta', '800', 'Sala 10', 'Consolacao', 'Sao Paulo', 'SP', '01305-100', 4),
    (5, 'Avenida Brasil', '2300', null, 'Jardim America', 'Santos', 'SP', '11015-000', 5);


insert into farmaceutico (idFarmaceutico, nome, crf, telefone, salario, fkFarmacia) values
    (1, 'Marina Castro', 'CRF-SP 10001', '11 91111-1111', 6200.00, 1),
    (2, 'Paulo Ribeiro', 'CRF-SP 10002', null, 5800.00, 1),
    (3, 'Helena Martins', 'CRF-SP 10003', '11 92222-2222', 7500.00, 2),
    (4, 'Ricardo Gomes', 'CRF-SP 10004', null, 4900.00, 3),
    (5, 'Fernanda Lopes', 'CRF-SP 10005', '19 93333-3333', 8300.00, 4),
    (6, 'Tiago Barros', 'CRF-SP 10006', null, 5200.00, 4),
    (7, 'Camila Freitas', 'CRF-SP 10007', '13 94444-4444', 6800.00, 5);


alter table endereco add constraint fkEnderecoFarmacia
    foreign key (fkFarmacia) references farmacia (idFarmacia);
alter table endereco add constraint ukEnderecoFarmacia unique (fkFarmacia);


alter table farmaceutico add constraint fkFarmaceuticoFarmacia
    foreign key (fkFarmacia) references farmacia (idFarmacia);


select * from farmacia;
select * from endereco;
select * from farmaceutico;

select nome as Farmacia,
cnpj as CNPJ,
tipo as Tipo
from farmacia;

select f.nome as Farmacia,
       concat(e.logradouro, ', ', e.numero) as Endereco,
       e.cidade as Cidade
from farmacia as f
join endereco as e on e.fkFarmacia = f.idFarmacia;

select fm.nome as Farmaceutico, .nome as Farmacia
    from farmaceutico as fm
    join farmacia as f on fm.fkFarmacia = f.idFarmacia;

select nome, tipo,
case
	when tipo = 'matriz' then 'Sede'
	else 'Unidade'
end as classificacao
from farmacia;

select nome, salario,
case
	when salario >= 8000 then 'Faixa alta'
	when salario >= 5500 then 'Faixa media'
	else 'Faixa inicial'
end as faixaSalarial
from farmaceutico;


select logradouro, numero,
       ifnull(complemento, 'Sem complemento') as complemento
    from endereco;

select nome,
       ifnull(telefone, 'Sem telefone') as telefone
    from farmaceutico;