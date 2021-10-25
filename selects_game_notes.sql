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

-- Mostrar personagens e os itens que ele possui
SELECT personagem.nome, item.nome, item.preco,  item.raridade
FROM personagem
JOIN itens_personagem
	ON personagem.id = itens_personagem.id_personagem
JOIN item
	ON item.id = itens_personagem.id_item
ORDER BY personagem.nome;

-- Mostrar o registro de vendas de uma loja
SELECT lojas.nome, item.nome AS item, itens_transacao.preco_item, itens_transacao.quantidade
FROM lojas
JOIN transacao
	ON transacao.id_loja = lojas.id
JOIN itens_transacao
	ON itens_transacao.id_transacao = transacao.id
JOIN item
	ON item.id = itens_transacao.id_item
ORDER BY lojas.nome;
-- Mostrar um personagem e as missões que ele está encarregado de fazer
SELECT personagem.nome, quest.descricao AS quest
FROM personagem
JOIN quests_personagem
	ON quests_personagem.id_personagem = personagem.id
JOIN quest
	ON quest.id = quests_personagem.id_quest
ORDER BY personagem.nome;
-- Mostrar uma operaçao de compra completa, com loja, personagem, jogador, item, preço...alter

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

-- NPC e suas quests
SELECT npc.nome, npc.localizacao, quest.descricao, quest.recompensa
FROM npc 
JOIN quest 
	ON quest.id_npc = npc.id
ORDER BY npc.nome;

-- Personagens com quest ja concluidas e os detalhes de suas quests
SELECT personagem.nome, npc.nome AS npc, quest.descricao, quest.recompensa
FROM personagem
JOIN quests_personagem 
	ON personagem.id = quests_personagem.id_personagem
JOIN quest
	ON quest.id = quests_personagem.id_quest
JOIN npc
	ON npc.id = quest.id_npc
WHERE quests_personagem.completa = true;