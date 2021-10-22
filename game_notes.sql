drop database if exists game_notes;

create database if not exists game_notes
default character set utf8
default collate utf8_general_ci;

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
    habilidades varchar(310) not null,
    primary key (id)
);

CREATE TABLE IF NOT EXISTS item (
    id int not null,
	nome varchar(100) not null,
    tipo varchar(15) not null,
    raridade varchar(20) not null,
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
    id_jogador int not null,
    id_raca int not null,
    id_classe int not null,
    data_criacao date,
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

CREATE TABLE IF NOT EXISTS lojas (
    id int not null,
	nome varchar(40),
    tipo varchar(20),
    localizacao varchar(100),
    primary key (id)
);

CREATE TABLE IF NOT EXISTS transacao (
    id int not null,
    id_personagem int not null,
    id_loja int not null,
    dia_da_transacao date,
    primary key (id),
    foreign key (id_personagem)
		references personagem (id),
	foreign key (id_loja)
		references lojas (id)
);

CREATE INDEX preco_item
ON item (preco);
CREATE TABLE IF NOT EXISTS itens_transacao (
    id_item int not null,
    id_transacao int not null,
    preco_item double,
    quantidade int,
	valor_total double,
    primary key (id_item, id_transacao),
    foreign key (id_item)
		references item (id),
	foreign key (id_transacao)
		references transacao (id),
	foreign key (preco_item)
		references item (preco)
);

use game_notes;

-- (id int not null, nome varchar(100) not null, idade int not null, email varchar(50))
INSERT INTO jogador VALUES 
(1, "Ana" , 19, "ana123@gmail.com", false),
(2, "Flavio" , 21, "flavio123@gmail.com", false),
(3, "Jorge" , 25, "jorge123@gmail.com", true),
(4, "Lucia" , 18, "lucia123@gmail.com", true),
(5, "Mauricio" , 29, "mauricio123@gmail.com", false),
(6, "Edmar" , 16, "edmar123@gmail.com", true),
(7, "Rodolfo" , 23, "rodolfo123@gmail.com", false),
(8, "Beth" , 17, "beth123@gmail.com", false),
(9, "Paulo" , 35, "paulo123@gmail.com", false),
(10, "Marvin", 42, "marv1n42@gmail.com", true);

-- (id int not null, nome varchar(100) not null, descricao varchar(200), habilidades varchar(200) not null)
INSERT INTO raca VALUES
(1, "Anão", "Reinos ricos em grandiosidade, salões cravejados nas raízes das montanhas, o eco de picaretas e martelos nas minas e nas forjas, dedicação a clã e tradição, e um ódio por orcs e goblins - são essas as heranças de todo anão.", "Constituição +2"),
(2, "Elfo", "Elfos são um povo mágico com graça sobrenatural, vivendo no mundo mas não inteiramente parte dele.", "Destreza +2"),
(3, "Halfling", "Os confortos do lar são o objetivo da maioria dos halflings: Se acomodar em paz e silêncio, longe de monstros e exércitos, com uma boa refeição, bebida e companhia.", "Destreza +2"),
(4, "Humano", "Humanos são a mais nova das raças, com razões e culturas diversas, inovadores, desbravadores e pioneiros.", "+1 em todas as habilidades OU +2 em 2 habilidades e + 1 talento"),
(5, "Draconato", "Nascido de dragões como diz seu nome, os draconatos andam orgulhosamente por um mundo que os recebe como medo e incompreensão.", "Força +2, Carisma +1"),
(6, "Gnomo", "Gnomos aproveitam a vida com dedicação, aproveitando cada momento de invenção, exploração, investigação, criação ou brincadeira.", "Inteligência +2"),
(7, "Meio-Elfo", "Andando em dois mundos mas não pertencendo a nenhum, meios-elfos combinam algumas das melhores qualidades de humanos e elfos: Curiosidade, inventividade e ambição humanas temperadas pelos sentidos afiados, amor pela natureza e gostos artísticos dos elfos", "Carisma +2, outra habilidade +1"),
(8, "Meio-Orc", "Meios-orcs são filhos da fronteira, em terras onde orcs e humanos guerreiam ou comerciam. A maioria deles anda pelo mundo fazendo o que é necessário para sobreviver em um mundo que os ignora.", "Força +2, Constituição +1"),
(9, "Tiefling", "Ser recebido com encaradas e sussurros, sofrer violência e insulto na rua, ver desconfiança e medo em cada olhar: Essa é a vida dos tieflings, um povo amaldiçoado por um pacto feito gerações atrás com diabos.", "Carisma +2, Inteligência +1"),
(10, "Aasimar", "Descendentes de criaturas celestiais, Aasimares parecem humanos gloriosos e heroicos. Aasimares costumam tentar disfarçar sua linhagem para enfrentar o mal sem chamar atenção.", "Carisma +2, Sabedoria +1");

-- (id int not null, nome varchar(100) not null, habilidades varchar(200) not null)
INSERT INTO classe VALUES
(1, "Bárbaro", "Fúria, Defesa sem Armadura, Ataque Descuidado, Sentido de Perigo, Caminho Primitivo, Ataque Extra, Instinto Selvagem, Crítico Brutal, Fúria Implacável, Fúria Persistente, Força Indomável, Campeão Primitivo"),
(2, "Bardo", "Conjuração, Inspiração de Bardo, Versatilidade, Canção do Descanso, Colégio de Bardo, Aptidão, Fonte de Inspiração, Canção de Proteção, Segredos Mágicos, Inspiração Superior"),
(3, "Bruxo", "Patrono Transcendental, Magia de Pacto, Invocações Místicas, Dádiva do Pacto, Arcana Mística(6 - 9), Mestre Místico"),
(4, "Clérigo", "Conjuração, Domínio Divino, Canalizar Divindade, Destruir Mortos-Vivos, Intervenção Divina, Aprimoramento de Intervenção Divina"),
(5, "Druida", "Druídico, Conjuração, Círculo Druídico, Forma Selvagem, Aprimoramento de Forma Selvagem, Corpo Atemporal, Magias da Besta, Arquidruida"),
(6, "Feiticeiro", "Conjuração, Origem de Feitiçaria, Fonte de Magia, Metamágica, Restauração Mística"),
(7, "Guerreiro", "Estilo de Luta, Retomar o Fôlego, Surto de Ação, Arquétipo Marcial, Ataque Extra(5º/11º/20º), Indomável (9º/13º/17º)"),
(8, "Ladino", "Especialização(1º/6º), Ataque Furtivo, Gíria de Ladrão, Ação Ardilosa, Arquétipo de Ladino, Esquiva Sobrenatural, Evasão, Talento Confiável, Sentido Cego, Mente Escorregadia, Elusivo, Golpe de Sorte"),
(9, "Mago", "Conjuração, Recuperação Arcana, Tradição Arcana, Dominar Magia, Assinatura Mágica"),
(10, "Monge", "Defesa sem Armadura, Artes Marciais, Chi, Movimento sem Armadura, Tradição Monástica, Defletir Projéteis, Queda Lenta, Ataque Extra, Ataque Atordoante, Golpes de Chi, Evasão, Mente Tranquila, Pureza Corporal, Idiomas do Sol e da Lua, Alma de Diamante, Corpo Atemporal, Corpo Vazio, Auto Aperfeiçoamento"),
(11, "Paladino", "Sentido Divino, Cura pelas Mãos, Estilo de Luta, Conjuração, Destruição Divina, Saúde Divina, Juramento Sagrado, Ataque Extra, Aura da Coragem, Destruição Divina Aprimorada, Toque Purificador, Aprimoramentos de Aura"),
(12, "Patrulheiro", "Inimigo Favorito, Explorador Natural, Estilo de Luta, Conjuração, Arquétipo de Patrulheiro, Prontidão Primitiva, Ataque Extra, Aprimoramentos de Inimigo Favorito e Explorador Natural, Caminho da Floresta, Mimetismo, Desaparecer, Sentidos Selvagens, Matador de Inimigos");

-- (id int not null, nome varchar(100) not null, tipo varchar(10) not null, raridade varchar(20) not null, preco double)
INSERT INTO item VALUES
(1, "Adaga" , "Arma", "Comum", 5.8),
(2, "Armadura de couro" , "Armadura", "Comum", 25.0),
(3, "Cajado do Arquimago" , "Magico", "Muito Raro", 1500.5),
(4, "Botas de rapidez" , "Magico", "Muito Raro", 550.5),
(5, "Poção de cura" , "Consumivel", "Comum", 50.0),
(6, "Poção de invisibilidade" , "Consumivel", "Incomum", 100.5),
(7, "Corda (metro)" , "Equipamento", "Ordinário", 25.0),
(8, "Pe de Cabra" , "Ferramenta", "Ordinário", 1.0),
(9, "Cristal transparente" , "Componente", "Comum", 0.5),
(10, "Pedra preciosa", "Tesouro", "Incomum", 100.5);

-- (id int not null, nome varchar(100) not null, funcao varchar(50), localizacao varchar(100))
INSERT INTO npc VALUES
(1,"Bazim Barlyr", "Pirata", "Baía da Perdição"),
(2,"Carydion", "Artista", "Escola de artes de Neverwinter"),
(3,"Cpt. Fright", "Militar", "Campo de treinamento de soldados de Mithral Hall"),
(4,"Rhymus", "Cavaleiro", "Guarda no porto de Baldur's Gate"),
(5,"Aesli Thrdar", "Mercante", "Andarilho. Atualmente em Daggerford"),
(6, "Almod", "Sacerdote", "Templo da Tríade em Bryn Shander"),
(7, "Grinarv Blaine", "Aristocrata", "Mansão dos Blaine em Neverwinter"),
(8, "Isert Sarkarov", "Mercenario", "Anda pelo porto de Baldur's Gate"),
(9, "Carlos Guilhans", "Taberneiro", "Taberna em Bryn Shander"),
(10, "Jiulia Vendeta", "Paladina", "Sede da Guilda dos Cruzados");

-- (id int not null, descricao varchar(300) not null, recompensa varchar(100), id_npc int not null)
INSERT INTO quest VALUES
(1,"Roubar itens de um navio inimigo.", "Metade do saque", 1),
(2,"Ajudar na proteção dos portões contra uma invasão de bandidos.", "Acesso livre ao porto e 100 gold", 4),
(3,"Resgatar a esposa do lorde que esta presa com o rival de comercio.", "100 gold", 7),
(4,"Ajudar a caravana de entrega de suprimentos da taberna que sofreu um acidente.", "Estadia e alimentação de graça", 9),
(5,"Buscar uma peça de arte sem danificá-la, em outra cidade.", "200 gold", 2),
(6,"Escolta durante a viagem do mercante até outra cidade.", "15 gold por dia de viagem", 5),
(7,"Explorar a tumba de Gwinhel Growew, e eliminar espectros na área.", "100 gold e qualquer loot que tiver na tumba", 6),
(8,"Pegar uma maçã dourada na arvore da eternidade.", "Entrar na guilda mais forte da cidade", 10),
(9,"Eliminar uma gangue de orcs que anda roubando viajantes nas estradas próximas à cidade.", "350 gold e armas", 3),
(10,"Ajudar a eliminar um grupo de bandidos que saqueou seu esconderijo.", "50 gold, e uma arma", 8);

-- (id int not null, nome varchar(40), nivel int not null, id_jogador int not null, id_raca int not null, id_classe int not null, data_criacao date)
INSERT INTO personagem VALUES
(1, "Gehard", 7, 3, 4, 1, '2020/12/14'),
(2, "Jim Lee", 9, 6, 4, 10, '2020/1/10'),
(3, "Caylinn", 6, 2, 2, 9, '2021/1/23'),
(4, "Perola", 5, 1, 4, 8, '2021/3/23'),
(5, "Fushinn", 5, 4, 9, 3, '2021/3/15'),
(6, "Yonani", 4, 5, 10, 7, '2021/8/15'),
(7, "AEgir", 4, 9, 8, 5, '2021/8/15'),
(8, "Ellywick", 3, 7, 6, 4, '2021/9/3'),
(9, "Dandelion", 6, 10, 9, 2, '2021/1/23'),
(10, "Dreki", 8, 8, 4, 6, '2020/3/18');

-- (id_personagem int not null, id_item int not null, quantidade int)
INSERT INTO itens_personagem VALUES
(1, 05, 20),
(2, 06, 3),
(3, 08, 2),
(4, 09, 5),
(5, 04, 1),
(6, 07, 50),
(7, 03, 1),
(8, 01, 10),
(9, 02, 1),
(10, 10, 13);

-- (id_personagem int not null, id_quest int not null, completa boolean)
INSERT INTO quests_personagem VALUES
(2, 1, true),
(6, 5, true),
(8, 6, false),
(4, 8, false),
(1, 7, false),
(5, 9, false),
(9, 3, true),
(3, 10, false),
(7, 4, false),
(10, 2, true);

-- (id int not null, nome varchar(40), tipo varchar(20), localizacao varchar(100))
INSERT INTO lojas VALUES
(1, "O machado prateado", "Armas", "Waterdeep"),
(2, "O caldeirão de Hastur", "Poções", "Neverwinter"),
(3, "Grimório de Merlim", "Magia", "Daggerford"),
(4, "Pergaminho do Sabichão", "Biblioteca", "Luskan"),
(5, "A couraça do herói", "Armadura", "Elturel"),
(6, "Prada", "Tecidos", "Sundabar"),
(7, "Mochila de aventureito", "Equipamentos gerais", "Everlund"),
(8, "Ghilihal especiarias", "Componentes", "Phlan"),
(9, "Castelo Forte", "Ferramentas", "Berdusk"),
(10, "Emporio de Rendaril", "Casa de Trocas", "Bryn Shander");

-- (id int not null, id_personagem int not null, id_loja int not null, data_transacao date)
INSERT INTO transacao VALUES
(1, 5, 1, '2019/12/19'),
(2, 4, 5, '2020/6/15'),
(3, 7, 3, '2021/1/7'),
(4, 8, 5, '2021/1/19'),
(5, 2, 2, '2021/2/10'),
(6, 1, 2, '2021/2/28'),
(7, 9, 7, '2021/3/17'),
(8, 10, 9, '2021/3/26'),
(9, 3, 8, '2021/6/8'),
(10, 6, 10, '2021/6/25');

-- (id_item int not null, id_transacao int not null, preco_item double not null, quantidade int)
INSERT INTO itens_transacao VALUES
(1, 1, 5.8, 10, preco_item*quantidade),
(2, 2, 25.0, 3, preco_item*quantidade),
(3, 3, 1500.5, 1, preco_item*quantidade),
(4, 4, 550.5, 2, preco_item*quantidade),
(5, 5, 50.0, 3, preco_item*quantidade),
(6, 6, 100.5, 1, preco_item*quantidade),
(7, 7, 25.0, 5, preco_item*quantidade),
(8, 8, 1.0, 6, preco_item*quantidade),
(9, 9, 0.5, 8, preco_item*quantidade),
(10, 10, 100.5, 1, preco_item*quantidade);