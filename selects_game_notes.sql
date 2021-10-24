use game_notes;

-- Teste pra ver se a db ta funcionando
select * from jogador;
select * from raca;
select * from classe;
select * from item;
select * from npc;
select * from quest;
select * from personagem;
select * from itens_personagem;
select * from quests_personagem;
select * from lojas;
select * from transacao;
select * from itens_transacao;

-- Mostrar quais jogadores estão ativos e seus respectivos personagens

-- Mostrar personagens e os itens que ele possui?

-- Mostrar o registro de vendas de uma loja

-- Mostrar um personagem e as missões que ele está encarregado de fazer

-- Mostrar uma operaçao de compra completa, com loja, personagem, jogador, item, preço...alter

-- Pensar em outros selects

-- select classe de cada personagem
SELECT classe.nome, personagem.nome 
FROM classe 
JOIN personagem
	ON personagem.id_classe = classe.id 
ORDER BY classe.nome;

-- select raça de cada personagem
SELECT raca.nome, personagem.nome 
FROM raca 
JOIN personagem
	ON personagem.id_raca = raca.id 
ORDER BY raca.nome;

-- numero total de personagens em cada raca
SELECT raca.nome, COUNT(personagem.nome) AS quantidade
FROM raca 
JOIN personagem
	ON personagem.id_raca = raca.id
GROUP by raca.nome;

-- numero total de personagens em cada classe
SELECT classe.nome, COUNT(personagem.nome) AS quantidade
FROM classe 
JOIN personagem
	ON personagem.id_classe = classe.id
GROUP by classe.nome;

-- jogadores com mais de um ano de cadastro
SELECT nome, email
FROM jogador
WHERE id = ANY(SELECT id_jogador FROM personagem WHERE year(current_date()) - year(data_criacao) >= 1);
