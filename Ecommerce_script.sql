USE projetoecommerce;
SET SQL_SAFE_UPDATES=0; 
-- não usar!!! drop database projetoecommerce;
alter table `cliente pf / pj` auto_increment=1;
show tables;
-- cliente pf / pj, disponibilidade, estoques, expedição, *formas de pagamento, fornecedor, franqueado, pagamento, pedido, pontos / armazéns, produto, terceirização de vendas, *transporte/entrega
-- similaridade da table com o vídeo "Persistindo e Recuperando Dados a partir de Consultas SQL no Banco de Dados" (em ordem):
-- clients, productsupplier, productstorage, productorder, (*add), supplier, seller, payments, order, storagelocation, product, productseller, (*add)

select * from `cliente pf / pj`; -- clients
-- `cliente pf / pj`, idCliente, `Nome / Razão Social`, `CPF / CNPJ`, `N° Fidelidade`, Endereço, `Dados de Contato`, `Histórico de Compras`
insert into `cliente pf / pj` (`Nome / Razão Social`, `CPF / CNPJ`, `N° Fidelidade`, Endereço, `Dados de Contato`, `Histórico de Compras`)
	values	('Maria M Silva', 00012345678901, NULL, 'rua silva de prata 29', 999888333, 'dia 12 - 50$'),
			('Matheus O Pimentel', 00098765432101, 123456789, 'rua alameda 289', 912345678, 'dia 10 - 81$'),
            ('Ricardo F Silva', 00045678913999, 456123789, 'av. alameda vinha 1009', 945612378, 'dia 24 - 95$'),
            ('Julia S França', 00078912345612, NULL, 'rua larankeiras 861', 978945612, ''),
            ('Roberta G Assis', 00097845631012, NULL, 'av. kolher 19', 923456789, 'dia 07 - 23$'),
            ('Isabela M Cruz', 00065478912321, NULL, 'rua alameda das flores 28', 998765432, 'dia 18 - 231$');

select * from disponibilidade; -- do fornecedor/3o -- productsupplier
-- Fornecedor_idFornecedor, Produto_idProduto, Quantidade
insert into disponibilidade (Fornecedor_idFornecedor, Produto_idProduto, Quantidade) values
			(1, 1, 500),
            (1, 2, 400),
            (2, 4, 633),
            (3, 3, 5),
            (2, 5, 10);
            
select * from estoques; -- proprio -- productstorage
-- Produto_idProduto, Pontos/Armazéns_idPontos/Armazéns, Quantidade
insert into estoques (Produto_idProduto, `Pontos/Armazéns_idPontos/Armazéns`, Quantidade) values
			(1, 1, 800),
            (1, 2, 150),
            (1, 3, 10),
            (2, 6, 20),
            (3, 1, 200),
            (3, 4, 35),
            (4, 2, 150),
            (4, 5, 10),
            (5, 4, 35),
            (5, 6, 20),
            (6, 4, 30),
            (7, 2, 200),
            (7, 6, 20);
select SUM(Quantidade) from estoques group by `Pontos/Armazéns_idPontos/Armazéns`; -- OK
            
select * from expedição; -- productorder
-- Pedido_idPedido, Produto_idProduto, Quantidade
insert into expedição (`Pedido_idPedido`, `Produto_idProduto`, Quantidade) values  
			(1, 1, 4), (1 ,4, 2), (1 ,7, 1), -- pedido n°1
            (2, 2, 2), (2, 3, 8), (2, 5, 1), -- n°2...
            (3, 6, 10),
            (4, 1, 1), (4, 5, 2), (4, 6, 5);       
            
select * from `formas de pagamento`;
-- idFormas de Pagamento, link externo, Boletos, PIX, Cartão de Crédito, Transferência, PicPay, PayPal
insert into `formas de pagamento` (`link externo`, Boletos, PIX, `Cartão de Crédito`, Transferência, PicPay, PayPal) values
			('www.pagueaqui.com.br', NULL, NULL, NULL, NULL, NULL, NULL), 	-- 8
            (NULL, 'gerador de boletos', NULL, NULL, NULL, NULL, NULL),		-- 9
            (NULL, NULL, 'cnpj 12340001-1000', NULL, NULL, NULL, NULL),		-- 10
            (NULL, NULL, NULL, 'visa/master/elo', NULL, NULL, NULL),		-- 11
            (NULL, NULL, NULL, NULL, 'BB ag123 cc98765432', NULL, NULL),	-- 12
            (NULL, NULL, NULL, NULL, NULL, 'codigo1234', NULL),				-- 13
            (NULL, NULL, NULL, NULL, NULL, NULL, 'codigo56789'); 			-- 14 / ficou um pouco estranho, mas não achei documentação de matriz
            
select * from fornecedor; -- supplier
-- idFornecedor, Razão Social, CNPJ, Local, Dados para Contato
insert into fornecedor (`Razão Social`, CNPJ, Local, `Dados para Contato`) values
			('Almeida e filhos', 12345678912345, 'Rio das Ostras - RJ', '21985474'),
            ('Eletrônicos Silva', 85415964914345, 'Bonito - MG', '21985484'),
            ('Eletrônicos Valma', 93456789393469, 'Serra do Rio do Rastro - SC', '21975474');
            
select * from franqueado; -- seller
-- idFranquia, Razão Social, CNPJ, Local, Dados para Contato
insert into franqueado (`Razão Social`, CNPJ, Local, `Dados para Contato`) values
			('Tech eletronics', 12345678945632, 'Rio de Janeiro', 219946287),
            ('Botique Durgas', 12345678399999, 'Rio de Janeiro', 219567895),
            ('Kids World', 45678912365448, 'São Paulo', 1198657484);

select * from pagamento; -- Status('aguardando', 'confirmado', 'parcelado') -- payments
-- idPagamento, Status de Pagamento, Impostos a Recolher, Forma de Pagamento, Contato Financeiro, Formas de Pagamento_idFormas de Pagamento
-- (agamentos parcelados precisam ser verificados/confirmados periodicamente,
-- portanto o 'status' poderia variar mês a mês entre 'aguardando' e 'confirmado'
-- porém atrasos e inadimplências não seriam contempados, por isto foi criado um categoria a parte.)
insert into pagamento (`Status de Pagamento`, `Impostos a Recolher`, `Forma de Pagamento`, `Contato Financeiro`, `Formas de Pagamento_idFormas de Pagamento`) values
			('aguardando', NULL, 'Boleto bancário', 'telefone do bb gerador de boleto', 9),
            ('confirmado', 11.30, 'PIX', 'ramal do financeiro', 10),
            ('parcelado', NULL, 'Cartão de Crédito', 'ramal da contabilidade', 11),
            ('confirmado', 2.30, 'Transferência', 'ramal do financeiro', 12);
            
select * from pedido; -- order
-- idPedido, Data, Status, Descrição, Frete, CT-e, Nota Fiscal e Série, Pagamento_idPagamento, Entrega_idEntrega, Cliente PJ / PF_idCliente
insert into pedido (Data, Status, Descrição, Frete, `Pagamento_idPagamento`, Entrega_idEntrega, `Cliente PJ / PF_idCliente`) values
			('2023-03-24 11:02', 'pagamento', 'Entregar até dia 20', 12.50, 1, 1, 3),
            ('2023-03-12 23:15', 'estoques', NULL, 9.35, 2, 2,  1),
            ('2023-03-10 09:18', 'entrega', NULL, 3.78, 3, 3, 2),
            ('2023-03-07 15:56', 'entrega', 'Entrega depois do dia 20', 28.43, 4, 4, 5);
            
select * from `pontos / armazéns`; -- proprio -- storagelocation
-- idPontos/Armazéns, Local, Dados de Contato
insert into `pontos / armazéns` (Local, `Dados de Contato`) values
			('Rio de Janeiro', 'zé do armazém 12323455'), 	-- 1000
            ('Rio de Janeiro', 'gerente ciclano 9678687'),	-- 500
            ('São Paulo', 'amazon email@algumacoisa'),		-- 10
            ('São Paulo', 'mercado livre @Jorge'),			-- 100
            ('São Paulo', 'caixa postal 666'),				-- 10
            ('Brasília', 'joão gabinete 989766767');		-- 60

select * from produto; -- product
-- idProduto, Categoria, Descrição, Valor
insert into produto (Categoria, Descrição, Valor)
	values	('Eletrônicos', 'Fone de ouvido', 29.90),
			('Brinquedos', 'Barbie Elsa', 89.50),
			('Vestimentas', 'Body Carters', 120.00),
            ('Eletrônicos', 'Microfone Vedo', 34.90),
            ('Móveis', 'Sofá Retrátil', 278.99),
            ('Alimentos', 'Farinha de Arroz', 8.35),
            ('Eletrônicos', 'Fire Stick Amazon', 224.10);
            
select * from `terceirização de vendas`; -- productseller
-- Franquia_idFranquia, Produto_idProduto, Meta Franqueado, Quantidade
insert into `terceirização de vendas` (Franquia_idFranquia, Produto_idProduto, `Meta Franqueado`, Quantidade) values
			(1, 6, 65, 80),
            (2, 7, 30, 10);

select * from `transporte/entrega`; -- Status('depósito', 'trânsito', 'entregue') -- localização se refere ao localizador, onde está o produto ou o caminhão de entrega
-- Franquia_idFranquia, Produto_idProduto, Meta Franqueado, Quantidade
insert into `transporte/entrega` (`Localização`, Status, `Dados de Contato`, `Cliente PJ / PF_idCliente`) values
			('Rua margarida', 'trânsito', 'portaria 988219361', 3),
            ('caminhão 456 rota B', 'depósito', 'vó fulana 324739827', 1),
            ('casa de alguém', 'entregue', 'contato', 2);
insert into `transporte/entrega` (`Localização`, Status, `Dados de Contato`, `Cliente PJ / PF_idCliente`) values
			('Prédio AZUL', 'depósito', 'detetives do P.A.', 5); -- faltou esse (id_transporte NN para o 4o pedido)

-- perguntas:
-- número de clientes
select count(*) from `cliente pf / pj`;

-- verificar pedidos por cada cliente
select * from `cliente pf / pj` c, pedido p where c.idCliente = p.`Cliente PJ / PF_idCliente`;

-- selecionando os atributos
select `Nome / Razão Social` as Cliente, idPedido as `n° Pedido`, Status from `cliente pf / pj` c, pedido p where c.idCliente = p.`Cliente PJ / PF_idCliente`;

-- verificando a lista de produtos/quantidade por cliente/pedido
select `Nome / Razão Social` as Cliente, idPedido as `n° Pedido`, Data, Categoria, pd.Descrição, Quantidade
	from `cliente pf / pj` c , pedido p, expedição e, produto pd
		where c.idCliente = p.`Cliente PJ / PF_idCliente` and e.Produto_idProduto = pd.idProduto and e.Pedido_idPedido = p.idPedido;         

-- lista de cliente esperando entrega/entregue
select `Nome / Razão Social` as Cliente, idPedido as `n° Pedido`, p.Descrição , pg.`Status de Pagamento`, t.Status, Localização
	from `cliente pf / pj` c , pedido p, `transporte/entrega` t, pagamento pg
		where c.idCliente = t.`Cliente PJ / PF_idCliente` and p.`Pagamento_idPagamento`= pg.idPagamento and p.Entrega_idEntrega = t.idEntrega;
        
-- verificando a quantidade de produtos no estoque por local
select * from estoques;
select SUM(Quantidade) as 'Estoque Total' from estoques group by `Pontos/Armazéns_idPontos/Armazéns`; -- reapresentando com a pergunta

-- verificando o estoque mínimo
select SUM(Quantidade) as 'Estoque Total' from estoques group by `Pontos/Armazéns_idPontos/Armazéns` having SUM(Quantidade)>200; 

-- acrescentando a localidade
select Quantidade as 'Estoque', p.`Local`, Produto_idProduto, `Pontos/Armazéns_idPontos/Armazéns`
	from estoques e 
		join `pontos / armazéns` p 
			on p.`idPontos/Armazéns` = e.`Pontos/Armazéns_idPontos/Armazéns`;

-- verificando o estoque total de cada unidade            
select SUM(Quantidade) as 'Estoque', p.`Local`, `Pontos/Armazéns_idPontos/Armazéns`
	from estoques e 
		inner join `pontos / armazéns` p 
			on p.`idPontos/Armazéns` = e.`Pontos/Armazéns_idPontos/Armazéns`
				group by `Pontos/Armazéns_idPontos/Armazéns`;
