use sprint2;
create table musica (
    idMusica int primary key auto_increment,
    titulo varchar(40),
    artista varchar(40),
    genero varchar(40)
);
insert into musica values
    (default, 'Cristo é Superior', 'Henrique Machado', 'Worship'),
    (default, 'Cristo', 'Alessandro Vilas Boas', 'Worship'),
    (default, 'Cristo Sustenta', 'Alessandro Vilas Boas', 'Worship'),
    (default, 'Desejo Eterno', 'Alessandro Vilas Boas', 'Worship'),
    (default, 'À Espreita de Ti', 'Henrique Machado', 'Worship'),
    (default, 'Aba', 'Laura Souguellis', 'Worship'),
    (default, 'Meu Coração Dói de Amor', 'ONE-Sounds', 'Worship'),
    (default, 'Espírito de Deus', 'ONE-Sounds', 'Worship');

create table album (
    idAlbum int primary key auto_increment,
    nome varchar(35),
    tipo varchar(30),
    dtLancamento date,
    constraint chkTipo check (tipo in ('digital', 'fisico')));

insert into album values
    (default, 'Cristo é Superior', 'digital', '2026-03-03'),
    (default, 'Cristo', 'digital', '2023-11-08'),
    (default, 'Filho do Homem', 'fisico', '2025-07-29'),
    (default, 'Deus Espírito', 'digital', '2026-06-08'),
    (default, 'À Espreita de Ti', 'digital', '2024-03-22'),
    (default, 'Fornalha Laura Souguellis', 'digital', '2017-06-28'),
    (default, 'Telos', 'digital', '2024-08-30');
    
select * from musica;
select * from album;

alter table musica add column fkAlbum int;

alter table musica add constraint fkMusicaAlbum
foreign key (fkAlbum) 
references album (idAlbum);

update musica set fkAlbum = 1 
	where idMusica = 1;
update musica set fkAlbum = 4
	where idMusica in (3,4);
update musica set fkAlbum = 4
	where idMusica = 2;
update musica set fkAlbum = 5
	where idMusica = 5;
update musica set fkAlbum = 6 
	where idMusica = 6;
update musica set fkAlbum = 7 
	where idMusica in (7,8);

    
select * from musica
    join album on fkAlbum = idAlbum;

select musica.titulo, album.nome
    from musica join album on fkAlbum = idAlbum;
    
select * from musica
    join album on fkAlbum = idAlbum
    where album.tipo = 'digital';
    
select * from musica
    join album on fkAlbum = idAlbum
    where album.tipo = 'fisico';




    
