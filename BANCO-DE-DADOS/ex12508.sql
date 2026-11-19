use sprint1;

create table produtos (
id int primary key auto_increment,
nome varchar(60),
categoria varchar(50),
preco decimal(10,2),
tamanho varchar(5),
disponivel tinyint,
constraint chktamanho check(tamanho in ('P','M','G','GG')));

insert into produtos (nome, categoria, preco, tamanho, disponivel) values
('Camiseta Básica Preta', 'Camiseta', 49.90, 'M', 1),
('Camiseta Estampada', 'Camiseta', 59.90, 'P', 1),
('Calça Jeans Azul', 'Calça', 119.90, 'G', 1),
('Calça Jogger Preta', 'Calça', 99.90, 'M', 1),
('Moletom Cinza', 'Moletom', 149.90, 'GG', 1),
('Moletom Preto', 'Moletom', 139.90, 'P', 1);

alter table produtos add column dtcadastro datetime default current_timestamp;

select * from produtos;

--  Listar os produtos que contenham a palavra "Camiseta" no nome
select * from produtos
	where categoria = 'Camiseta';
    
    
-- Listar os produtos que não sejam do tamanho 'M'
select * from produtos
	where tamanho = 'M';
    

-- Exibir apenas os produtos cadastrados depois de 18 de agosto de 2025
select * from produtos
	where dtcadastro > 2026-08-18;
    

-- Listar os produtos disponíveis cuja categoria seja "Camiseta" ou "Blusa".
select * from produtos
	where categoria in ('Camiseta','Moletom');
    

-- Exibir o nome do produto concatenado com seu preço, com o alias 'produto_preco'.
select concat(nome, preco) as nome_preco
	from produtos;
    

-- Listar os produtos cujo nome NÃO contenha a palavra "Blusa".
select * from produtos
	where categoria <> 'Moletom';
    

-- Listar todos os produtos com uma coluna adicional chamada 'status' que mostre "Disponível" se disponivel = 1 e "Indisponível" caso contrário.
SELECT *,
CASE
    WHEN disponivel = 1 THEN 'Disponível'
    ELSE 'Indisponível'
END AS statuss
FROM produtos;


-- Liste os produtos da categoria "Calça" com preço maior que 100 reais.
select * from produtos
	where categoria = 'Calça'
    and preco >100;
    
-- Liste os produtos com nome que não contenha a palavra "Camiseta".
select * from produtos
	where nome not like '%Camiseta%';
    
-- Exiba os produtos cujo id seja 1, 3 ou 5.
select * from produtos
	where id in (1,3,5);
    
-- Liste os produtos com tamanho diferente de 'P' e 'M'.
select * from produtos
	where tamanho not in ('P', 'M');
    
-- Liste os produtos cadastrados antes de 18 de agosto de 2025.
select * from Produto
	where data_cadastro < '2025-08-18'; -- erro pois são todos da mesma data.
    











    

