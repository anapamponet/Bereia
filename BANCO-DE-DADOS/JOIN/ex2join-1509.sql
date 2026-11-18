use sprint2;
create table musica (
idMusga int primary key auto_increment,
titulo varchar(40),
artista varchar(40),
genero varchar(40)
);

insert into musica values
	(default, 'Cristo é Superior', 'Henrique Machado', 'Whorship'),
    (default, 'Cristo', 'Alessandro Vilas Boas', 'Whorship'),
    (default, 'Cristo Sustenta', 'Alessandro Vilas Boas', 'Whorship'),
    (default, 'Desejo Eterno', 'Alessandro Vilas Boas', 'Whorship'),
    (default, 'À Espreita de Ti', 'Henrique Machado', 'Whorship'),
    (default, 'Aba', 'Laura Souguellis', 'Whorship'),
    (default, 'Meu Coração Dói de Amor', 'ONE-Sounds', 'Whorship'),
    (default, 'Espírito de Deus', 'ONE-Sounds', 'Whorship');
    
create table album (
idAlbum int primary key auto_increment,
nome varchar(20),
tipo varchar(30),
dtLanc date,
constraint chkTipo check (tipo in ('digital', 'fisico'))
);

alter table album modify column nome varchar(35);

insert into album values
	(default, 'Cristo é Superior', 'digital', '2026-03-03'),
    (default, 'Cristo', 'digital', '2023-11-08'),
    (default, 'Filho do Homem', 'digital', '2025-07-29'),
    (default, 'Deus Espírito', 'digital', '2026-06-08'),
    (default, 'À Espreita de Ti', 'digital', '2024-03-22'),
    (default, 'Fornalha Laura Souguellis', 'digital', '2017-06-28'),
    (default, 'Cristo é Superior', 'digital', '2026-03-03'),
    (default, 'Telos', 'digital', '2024-08-30');
    

    
