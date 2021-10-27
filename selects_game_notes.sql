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
SELECT jogador.nome AS jogador, personagem.nome AS personagem
FROM personagem
JOIN jogador
	ON jogador.id = personagem.id_jogador
WHERE jogador.ativo = true;

-- Mostrar personagens e os itens que ele possui
SELECT personagem.nome AS personagem, item.nome AS item, item.preco,  item.raridade
FROM personagem
JOIN itens_personagem
	ON personagem.id = itens_personagem.id_personagem
JOIN item
	ON item.id = itens_personagem.id_item
ORDER BY personagem.nome;

-- Mostrar o registro de vendas das lojas
SELECT lojas.nome AS loja, item.nome AS item, itens_transacao.preco_item AS preço , itens_transacao.quantidade, personagem.nome AS comprador
FROM lojas
JOIN transacao
	ON transacao.id_loja = lojas.id
JOIN itens_transacao
	ON itens_transacao.id_transacao = transacao.id
JOIN item
	ON item.id = itens_transacao.id_item
JOIN personagem
	ON transacao.id_personagem = personagem.id
ORDER BY lojas.nome;

-- Mostrar um personagem e as missões que ele está encarregado de fazer
SELECT personagem.nome AS personagem, quest.descricao AS quest
FROM personagem
JOIN quests_personagem
	ON quests_personagem.id_personagem = personagem.id
JOIN quest
	ON quest.id = quests_personagem.id_quest
ORDER BY personagem.nome;

-- Mostrar uma operaçao de compra completa, com loja, personagem, jogador, item, preço...alter, ordenado por JOGADOR
SELECT jogador.nome AS jogador, personagem.nome AS personagem, lojas.nome AS loja, transacao.dia_da_transacao, item.nome AS item, itens_transacao.quantidade, itens_transacao.valor_total
FROM jogador
JOIN personagem
	ON personagem.id_jogador = jogador.id
JOIN transacao 
	ON transacao.id_personagem = personagem.id
JOIN lojas 
	ON lojas.id = transacao.id_loja
JOIN itens_transacao
	ON itens_transacao.id_transacao = transacao.id
JOIN item
	ON item.id = itens_transacao.id_item
ORDER BY jogador.nome;

-- select classe e raça de cada personagem
SELECT personagem.nome AS prsonagem, raca.nome AS raca, classe.nome AS classe
FROM personagem 
JOIN classe
	ON personagem.id_classe = classe.id
JOIN raca
	ON personagem.id_raca = raca.id
ORDER BY personagem.nome;

-- numero total de personagens em cada raca
SELECT raca.nome, COUNT(personagem.nome) AS quantidade
FROM raca 
LEFT JOIN personagem
	ON personagem.id_raca = raca.id
GROUP by raca.nome
ORDER BY quantidade DESC;

-- numero total de personagens em cada classe
SELECT classe.nome AS classe, COUNT(personagem.nome) AS quantidade
FROM classe 
LEFT JOIN personagem
	ON personagem.id_classe = classe.id
GROUP by classe.nome
ORDER BY quantidade DESC;

-- jogadores com mais de um ano de cadastro
SELECT nome AS jogador, email
FROM jogador
WHERE id = ANY(SELECT id_jogador FROM personagem WHERE year(current_date()) - year(data_criacao) >= 1);

-- NPC e suas quests
SELECT npc.nome AS npc, npc.localizacao, quest.descricao, quest.recompensa
FROM npc 
JOIN quest 
	ON quest.id_npc = npc.id
ORDER BY npc.nome;

-- Personagens com quest ja concluidas e os detalhes de suas quests
SELECT personagem.nome AS personagem, npc.nome AS npc, quest.descricao AS missao_completa, quest.recompensa
FROM personagem
JOIN quests_personagem 
	ON personagem.id = quests_personagem.id_personagem
JOIN quest
	ON quest.id = quests_personagem.id_quest
JOIN npc
	ON npc.id = quest.id_npc
WHERE quests_personagem.completa = true;

-- Media de valores dos itens comuns, quando os itens forem custarem mais de 6 moedas
SELECT AVG(preco) FROM item
WHERE preco > 6; 

-- Personagens com o preco total de seus itens maior que 100 ordenados de acordo com o preco total de seus itens
SELECT personagem.nome AS personagem, SUM(item.preco) * itens_personagem.quantidade AS precoTotalItens
FROM personagem
JOIN itens_personagem
	ON itens_personagem.id_personagem = personagem.id
JOIN item
	ON item.id = itens_personagem.id_item
GROUP BY personagem.nome
HAVING precoTotalItens > 100
ORDER BY precoTotalItens;

-- Personagens que foram cadastrados em 2021 com o preco total de seus itens e o email de seus jogadores,
-- selecionando os que tiverem o preco total de seus itens maior que 600 moedas
-- ordenados de acordo com o preco total de seus itens
SELECT personagem.nome AS personagem, jogador.email AS email_Jogador, SUM(item.preco) * itens_personagem.quantidade AS precoTotalItens
FROM personagem
JOIN jogador
	ON jogador.id = personagem.id_jogador
JOIN itens_personagem
	ON itens_personagem.id_personagem = personagem.id
JOIN item
	ON item.id = itens_personagem.id_item
WHERE year(personagem.data_criacao) = 2021
GROUP BY personagem.nome
HAVING precoTotalItens > 600
ORDER BY precoTotalItens;

-- nostra todas as lojas e todas as transações que elas fizeram ou não
SELECT *
FROM lojas
LEFT JOIN transacao
	ON lojas.id = transacao.id_loja
ORDER BY lojas.id;
