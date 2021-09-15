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

-- (id int not null, nome varchar(100) not null, idade int not null, email varchar(50))
INSERT INTO jogador VALUES 
(01, "Ana" , 19, "ana123@gmail.com", false),
(02, "Flavio" , 21, "flavio123@gmail.com", false),
(03, "Jorge" , 25, "jorge123@gmail.com", true),
(04, "Lucia" , 18, "lucia123@gmail.com", true),
(05, "Mauricio" , 29, "mauricio123@gmail.com", false),
(06, "Edmar" , 16, "edmar123@gmail.com", true),
(07, "Rodolfo" , 23, "rodolfo123@gmail.com", false),
(08, "Beth" , 17, "beth123@gmail.com", false),
(09, "Paulo" , 35, "paulo123@gmail.com", false),
(10, "Marvin", 42, "marv1n42@gmail.com", true);

-- (id int not null, nome varchar(100) not null, descricao varchar(200), habilidades varchar(200) not null)
INSERT INTO raca VALUES
(01, "Anão", "", "Constituição +2"),
(02, "Elfo", "", "Destreza +2"),
(03, "Halfling", "", "Destreza +2"),
(04, "Humano", "", "+1 em todas as habilidades OU +2 em 2 habilidades e + 1 talento"),
(05, "Draconato", "", "Força +2, Carisma +1"),
(06, "Gnomo", "", "Inteligência +2"),
(07, "Meio-Elfo", "", "Carisma +2, outra habilidade +1"),
(08, "Meio-Orc", "", "Força +2, Constituição +1"),
(09, "Tiefling", "", "Carisma +2, Inteligência +1"),
(10, "Aasimar", "", "Carisma +2, Sabedoria +1");

-- (id int not null, nome varchar(100) not null, descricao varchar(200), habilidades varchar(200) not null)
INSERT INTO classe VALUES
(01, "Bárbaro", "", "Fúria, Defesa sem Armadura, Ataque Descuidado, Sentido de Perigo, Caminho Primitivo, Ataque Extra, Instinto Selvagem, Crítico Brutal, Fúria Implacável, Fúria Persistente, Força Indomável, Campeão Primitivo"),
(02, "Bardo", "", "Conjuração, Inspiração de Bardo, Versatilidade, Canção do Descanso, Colégio de Bardo, Aptidão, Fonte de Inspiração, Canção de Proteção, Segredos Mágicos, Inspiração Superior"),
(03, "Bruxo", "", "Patrono Transcendental, Magia de Pacto, Invocações Místicas, Dádiva do Pacto, Arcana Mística(6 - 9), Mestre Místico"),
(04, "Clérigo", "", "Conjuração, Domínio Divino, Canalizar Divindade, Destruir Mortos-Vivos, Intervenção Divina, Aprimoramento de Intervenção Divina"),
(05, "Druida", "", "Druídico, Conjuração, Círculo Druídico, Forma Selvagem, Aprimoramento de Forma Selvagem, Corpo Atemporal, Magias da Besta, Arquidruida"),
(06, "Feiticeiro", "", "Conjuração, Origem de Feitiçaria, Fonte de Magia, Metamágica, Restauração Mística"),
(07, "Guerreiro", "", "Estilo de Luta, Retomar o Fôlego, Surto de Ação, Arquétipo Marcial, Ataque Extra(5º/11º/20º), Indomável (9º/13º/17º)"),
(08, "Ladino", "", "Especialização(1º/6º), Ataque Furtivo, Gíria de Ladrão, Ação Ardilosa, Arquétipo de Ladino, Esquiva Sobrenatural, Evasão, Talento Confiável, Sentido Cego, Mente Escorregadia, Elusivo, Golpe de Sorte"),
(09, "Mago", "", "Conjuração, Recuperação Arcana, Tradição Arcana, Dominar Magia, Assinatura Mágica"),
(10, "Monge", "", "Defesa sem Armadura, Artes Marciais, Chi, Movimento sem Armadura, Tradição Monástica, Defletir Projéteis, Queda Lenta, Ataque Extra, Ataque Atordoante, Golpes de Chi, Evasão, Mente Tranquila, Pureza Corporal, Idiomas do Sol e da Lua, Alma de Diamante, Corpo Atemporal, Corpo Vazio, Auto Aperfeiçoamento"),
(11, "Paladino", "", "Sentido Divino, Cura pelas Mãos, Estilo de Luta, Conjuração, Destruição Divina, Saúde Divina, Juramento Sagrado, Ataque Extra, Aura da Coragem, Destruição Divina Aprimorada, Toque Purificador, Aprimoramentos de Aura"),
(12, "Patrulheiro", "", "Inimigo Favorito, Explorador Natural, Estilo de Luta, Conjuração, Arquétipo de Patrulheiro, Prontidão Primitiva, Ataque Extra, Aprimoramentos de Inimigo Favorito e Explorador Natural, Caminho da Floresta, Mimetismo, Desaparecer, Sentidos Selvagens, Matador de Inimigos");

-- (id int not null, nome varchar(100) not null, tipo varchar(10) not null, raridade varchar(10) not null, descricao varchar(200) not null, preco double)
INSERT INTO item VALUES
(),
(),
(),
(),
(),
(),
(),
(),
(),
();

-- (id int not null, nome varchar(100) not null, funcao varchar(50), localizacao varchar(100))
INSERT INTO npc VALUES
(),
(),
(),
(),
(),
(),
(),
(),
(),
();

-- (id int not null, descricao varchar(300) not null, recompensa varchar(100), id_npc int not null)
INSERT INTO quest VALUES
(),
(),
(),
(),
(),
(),
(),
(),
(),
();

-- (id int not null, nome varchar(40), nivel int not null, descricao varchar(300) not null, id_jogador int not null, id_raca int not null, id_classe int not null)
INSERT INTO personagem VALUES
(),
(),
(),
(),
(),
(),
(),
(),
(),
();

-- (id_personagem int not null, id_item int not null, quantidade int)
INSERT INTO itens_personagem VALUES
(),
(),
(),
(),
(),
(),
(),
(),
(),
();

-- (id_personagem int not null, id_quest int not null, completa boolean)
INSERT INTO quests_personagem VALUES
(),
(),
(),
(),
(),
(),
(),
(),
(),
();

-- (id int not null, valor_total double, id_personagem int not null)
INSERT INTO transacao VALUES
(),
(),
(),
(),
(),
(),
(),
(),
(),
();

-- (id int not null, nome varchar(40), tipo varchar(20), localizacao varchar(100), id_item int not null, id_transacao int not null)
INSERT INTO lojas VALUES
(),
(),
(),
(),
(),
(),
(),
(),
(),
();

-- (id_item int not null, id_transacao int not null, quantidade int)
INSERT INTO itens_transacao VALUES
(),
(),
(),
(),
(),
(),
(),
(),
(),
();