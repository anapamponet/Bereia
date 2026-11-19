use sprint2;
create table animal (
idAnimal int primary key auto_increment,
nome varchar(45),
especie varchar(45),
raca varchar(45),
idade int
);

create table fichaMedica (
idFM int primary key auto_increment,
dataUltCons date,
peso decimal(4,2),
vacEmDia tinyint not null default 2,
obs varchar(100),
fkidAnimal int
);

insert into animal values
	(default, 'Rex', 'Cachorro', 'Labrador', 3),
    (default, 'Mia', 'Gato', 'Siames', 2),
    (default, 'Thor', 'Cachorro', 'Bulldog Frances', 5),
    (default, 'Nina', 'Gato', 'Persa', 1),
    (default, 'Bento', 'Coelho', 'Mini Lop', 4);
    
insert into animal value
    (default, 'Pingo', 'Cachorro', 'York Shire', 6);
    
select * from animal;
select * from fichaMedica;

describe fichaMedica;

insert into fichaMedica values
	(default, '2026-08-15', 28.50, 1, 'Animal Saudável, sem restrições.', 1),
	(default,'2026-09-01', 04.20, 1, 'Recomendado acompanhamento dental.', 2),
	(default, '2026-07-20', 12.80, 2, 'Vacina antirrábica atrasada.', 3),
	(default, '2026-09-10', 03.90, 0, 'Filhote, aguardando início do calendário vacinal.', 4),
	(default, '2026-06-30', 02.10, 1, 'Peso ideal para a idade.', 5);


delete from fichaMedica where idFM=6;

select idFM, dataUltCons, peso,
  case vacEmDia
    when 0 then 'nulo'
    when 1 then 'vacinado'
    when 2 then 'pendente'
  end as Vacinas,
  obs, fkidAnimal
from fichaMedica;

select nome, especie from animal;
select * from fichaMedica
	where vacEmDia = 2;
select * from animal
	order by idade desc;
select * from animal
	where especie = 'Cachorro';
    
select nome as Pet from animal;
select especie as Tipo from animal;
select idade * 7 as "Idade Humana Aproximada" from animal;

select nome as 'Nome do Pet', raca as 'Raca/Tipo' from animal;

select nome as 'Nome do Pet',
	case
		when idade between 0 and 2 then 'FILHOTE'
        when idade between 3 and 7 then 'ADULTO'
        when idade between 8 and 20 then 'IDOSO'
        else 'NÃO INFORMADO'
	end as fase_vida
from animal;

select animal.nome as animal,
	case 
		when fichaMedica.vacEmDia = 1 then 'vacinado'
        when fichaMedica.vacEmDia = 0 then 'não iniciou o ciclo de vacinação'
        else 'pendente'
	end as vacinacao
from animal
join
fichaMedica on animal.idAnimal = fkidAnimal;

select peso,
	case
    when peso < 5 then 'Pequeno'
    when peso between 5 and 20 then 'Médio'
    else 'Grande'
    end as Porte
from fichaMedica;

select nome,
	case especie
    when 'Cachorro' then 'Canino'
    when 'Gato' then 'Falino'
    else 'Outro'
    end as Tipo_Espécie
from animal;   

insert into fichaMedica (idFM, dataUltCons, peso, vacEmDia, fkidAnimal) values
	(default, '2026-08-15', 03.50, 1, 6);
    
select animal.nome,
ifnull(fichaMedica.obs, 'Nechuma observação.') as observação
from animal
join fichaMedica on animal.idAnimal = fkidAnimal;

delete from fichaMedica where idFM = 6;

select animal.nome,
ifnull(fichaMedica.dataUltCons, 'SEM FICHA') as Data_da_Ultima_Consulta
from animal
left join fichaMedica on animal.idAnimal = fichaMedica.fkidAnimal;

select animal.nome as Nome,
	   peso as Peso,
       dataUltCons as Data_Ultima_Consulta
from animal
inner join fichaMedica on animal.idAnimal = fichaMedica.fkidAnimal;

select concat(animal.nome, '-', animal.especie, '-', fichaMedica.peso, 'kg') as resumo
from animal
inner join fichaMedica on animal.idAnimal = fichaMedica.fkidAnimal;

select nome, especie,
ifnull(raca, 'Raça não informada.') as Raça, idade
from animal;





        

	