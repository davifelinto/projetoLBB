-- VIEWS
-- view do registro de vendas

use game_notes;

CREATE VIEW registroVendas AS
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

-- view personagnes e quests completadas, com o email de cada jogador
CREATE VIEW questsCompletas AS
SELECT jogador.email AS email, personagem.nome AS personagem, npc.nome AS npc, quest.descricao AS missao_completa, quest.recompensa
FROM personagem
JOIN jogador 
	ON personagem.id_jogador = jogador.id
JOIN quests_personagem 
	ON personagem.id = quests_personagem.id_personagem
JOIN quest
	ON quest.id = quests_personagem.id_quest
JOIN npc
	ON npc.id = quest.id_npc
WHERE quests_personagem.completa = true
UNION
SELECT jogador.email AS email, personagem.nome AS personagem, npc.nome AS npc, quest.descricao AS missao_completa, quest.recompensa
FROM personagem
JOIN jogador 
	ON personagem.id_jogador = jogador.id
JOIN quests_personagem 
	ON personagem.id = quests_personagem.id_personagem
JOIN quest
	ON quest.id = quests_personagem.id_quest
JOIN npc
	ON npc.id = quest.id_npc
WHERE quests_personagem.completa = false;

