drop database if exists game_notes;

create database if not exists game_notes;

-- default character set utf8
-- default collate utf8_general_ci;

use game_notes;

CREATE TABLE IF NOT EXISTS jogador (
    id int not null,
    nome varchar(50) not null,
    idade int not null,
    email varchar(50),
    ativo boolean,
    primary key (id)
);

CREATE TABLE IF NOT EXISTS raca (
    id int not null,
	nome varchar(50) not null,
    descricao varchar(300),
    habilidades varchar(100) not null,
    primary key (id)
);

CREATE TABLE IF NOT EXISTS classe (
    id int not null,
	nome varchar(100) not null,
    descricao varchar(300),
    habilidades varchar(310) not null,
    primary key (id)
);

CREATE TABLE IF NOT EXISTS item (
    id int not null,
	nome varchar(100) not null,
    tipo varchar(10) not null,
    raridade varchar(10) not null,
    descricao varchar(200) not null,
    preco double,
    primary key (id)
);

CREATE TABLE IF NOT EXISTS npc (
    id int not null,
	nome varchar(100) not null,
    funcao varchar(50),
    localizacao varchar(100),
    primary key (id)
);

CREATE TABLE IF NOT EXISTS quest (
    id int not null,
    descricao varchar(300) not null,
    recompensa varchar(100),
    id_npc int not null,
    primary key (id),
    foreign key (id_npc)
        references npc (id)
);

CREATE TABLE IF NOT EXISTS personagem (
    id int not null,
    nome varchar(40),
    nivel int not null,
    descricao varchar(300) not null,
    id_jogador int not null,
    id_raca int not null,
    id_classe int not null,
    primary key (id),
    foreign key (id_jogador)
        references jogador (id),
    foreign key (id_raca)
        references raca (id),
	foreign key (id_classe)
        references classe (id)
);

CREATE TABLE IF NOT EXISTS itens_personagem (
    id_personagem int not null,
    id_item int not null,
    quantidade int,
    primary key (id_personagem, id_item),
    foreign key (id_personagem)
        references personagem (id),
	foreign key (id_item)
        references item (id)
);

CREATE TABLE IF NOT EXISTS quests_personagem (
    id_personagem int not null,
    id_quest int not null,
    completa boolean,
    primary key (id_personagem, id_quest),
    foreign key (id_personagem)
        references personagem (id),
	foreign key (id_quest)
        references quest (id)
);

CREATE TABLE IF NOT EXISTS transacao (
    id int not null,
	valor_total double,
    id_personagem int not null,
    primary key (id),
    foreign key (id_personagem)
		references personagem (id)
);

CREATE TABLE IF NOT EXISTS lojas (
    id int not null,
	nome varchar(40),
    tipo varchar(20),
    localizacao varchar(100),
    id_item int not null,
    id_transacao int not null,
    primary key (id),
    foreign key (id_item)
		references item (id),
	foreign key (id_transacao)
		references transacao (id)
);

CREATE TABLE IF NOT EXISTS itens_transacao (
    id_item int not null,
    id_transacao int not null,
    quantidade int,
    primary key (id_item, id_transacao),
    foreign key (id_item)
		references item (id),
	foreign key (id_transacao)
		references transacao (id)
);

