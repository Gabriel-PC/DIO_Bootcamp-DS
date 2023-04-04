USE oficina;
SET SQL_SAFE_UPDATES=0;
SHOW TABLES;
-- `autopeças_estoque`, `autorização_de_orçamento`, `cliente_pj_pf`, `conserto`, `equipe_designada`, `garantia`,
-- `mecânico_eletricista`, `motoboy`, `mão_de_obra`, `ordem_de_serviço`, `revisão_progamada_ou_esporádica`, `veículo`

-- idCliente_PJ_PF, CNPJ_CPF, Endereço, No_Fidelidade, Tel_Contato
SELECT * FROM `cliente_pj_pf`;
INSERT INTO `cliente_pj_pf` (CNPJ_CPF, Endereço, No_Fidelidade, Tel_Contato) VALUES
	(01409999999999, 'Rua numero 1 - bairro 1', NULL, 012099999999), -- 1o
    (01408888888888, 'Rua numero 2 - bairro 2', NULL, 012088888888), -- 2o
    (01407777777777, 'Rua numero 3 - bairro 3', NULL, 012077777777), -- 3o
    (01406666666666, 'Rua numero 4 - bairro 4', NULL, 012066666666), -- 4o
    (01405555555555, 'Rua numero 5 - bairro 5', NULL, 012055555555); -- 5o

-- idVeículo, Placa, Marca, Ano, Modelo, Cliente_PJ_PF_idCliente_PJ_PF
SELECT * FROM `veículo`; -- precisa do Cliente
INSERT INTO `veículo` (Placa, Marca, Ano, Modelo, Cliente_PJ_PF_idCliente_PJ_PF) VALUES
	('MEC4N11', 'Fiat', 2020, 'UNO Way 1.3', 1), -- na ordem 1, 2, 3, 4, 5.
    ('MEC4N12', 'Volkswagen', 2020, 'Gol 1.6 MSI', 2),
    ('MEC4N13', 'Ford', 2020, 'Ka SE 1.5', 3),
    ('MEC4N14', 'Chevrolet ', 2020, 'Onix LTZ 1.0', 4),
    ('MEC4N15', 'Renault', 2020, 'Sandero ZEN 1.6', 5);

-- idEquipe_Designada, Escala, Cronograma, Hora_por_Carro
SELECT * FROM `equipe_designada`; -- Ordem de Serviço (OS) só pode ser gerada depois de existir uma equipe para atender
INSERT INTO `equipe_designada`(Escala, Cronograma, Hora_por_Carro) VALUES
	('1 - examinadores, especialistas', '9h - 2a-6a', '01:00:00'),	-- 1
    ('2 - estagiários, inexperientes', '6h - 2a-6a', '03:00:00'),	-- 2
    ('5 - pleno', '24h - plantão, hora extra', '08:45:00'),			-- 3
    ('6 - pleno', '24h - plantão, hora extra', '08:45:00');			-- 4
     
-- idOrdem_de_Serviço, Data_de_Emissão, Status, Previsão_entrega, Equipe_Designada_idEquipe_Designada
SELECT * FROM `ordem_de_serviço`; -- OS Status('ATENDIMENTO', 'ORÇAMENTO', 'MANUTENÇÃO', 'FINALIZADO')
INSERT INTO `ordem_de_serviço` (Data_de_Emissão, Status, Previsão_entrega, Equipe_Designada_idEquipe_Designada) VALUES
	(20230331081235, DEFAULT, 20230331180000, 3),		-- 1
    (20230331091100, 'ORÇAMENTO', 20230331120000, 2),	-- 2
    (20230331111509, 'MANUTENÇÃO', 20230401114000, 4),	-- 3
    (20230330131512, 'MANUTENÇÃO', 20230331131500, 1),	-- 4
    (20230330154801, 'FINALIZADO', 20230331100000, 4);	-- 5
-- corrigindo erro de sintaxe e votando o id pra 1...
-- DELETE FROM `ordem_de_serviço`;
-- ALTER TABLE `ordem_de_serviço` AUTO_INCREMENT = 1;

-- Veículo_idVeículo, Veículo_Cliente_PJ_PF_idCliente_PJ_PF, Ordem_de_Serviço_idOrdem_de_Serviço, Kilometragem, Descrição_do_Cliente
SELECT * FROM `conserto`; -- precisa da OS
INSERT INTO `conserto` (Veículo_idVeículo, Veículo_Cliente_PJ_PF_idCliente_PJ_PF, Ordem_de_Serviço_idOrdem_de_Serviço, Kilometragem, Descrição_do_Cliente) VALUES
	(3, 3, 3, 56920, 'Quebrou numa batida, trocar eixo e parachoque');

-- Veículo_idVeículo, Veículo_Cliente_PJ_PF_idCliente_PJ_PF, Ordem_de_Serviço_idOrdem_de_Serviço, Kilometragem, Descrição_por_km    
SELECT * FROM `revisão_progamada_ou_esporádica`; -- precisa da OS
INSERT INTO `revisão_progamada_ou_esporádica` (Veículo_idVeículo, Veículo_Cliente_PJ_PF_idCliente_PJ_PF, Ordem_de_Serviço_idOrdem_de_Serviço, Kilometragem, Descrição_por_km) VALUES
	(1, 1, 1, 37561, 'problema na injeção, carro apaga'),
    (2, 2, 2, 21057, 'trocar oleo, agua, pastilha');
    
-- Cliente_PJ_PF_idCliente_PJ_PF, Ordem_de_Serviço_idOrdem_de_Serviço, Equipe_Designada_idEquipe_Designada, Orçamento, Status, Descrição_do_Serviço
SELECT * FROM `autorização_de_orçamento`; -- meio que era pra ser a próxima transição do conserto/revisão
INSERT INTO `autorização_de_orçamento` (Cliente_PJ_PF_idCliente_PJ_PF, Ordem_de_Serviço_idOrdem_de_Serviço, Equipe_Designada_idEquipe_Designada, Orçamento, Status, Descrição_do_Serviço) VALUES
	(4, 4, 1, 550, 'AUTORIZADO - Add 3 limpadores brisa', 'Troca do vidro frontal e lateral esquerdo'),
    (5, 5, 4, 1250, 'AUTORIZADO', 'Revisão +completa de 80k');

-- idPeças_de_Reposição, Nome_Modelo, Valor, Tamanho_Peso
SELECT * FROM `autopeças_estoque`;
INSERT INTO `autopeças_estoque` (Nome_Modelo, Valor, Tamanho_Peso) VALUES
	('Parachoque do Ka', 350, '2m x 0.50m'),	-- 1
    ('eixo dianteiro Ka', 500, '1m'),			-- 2
    ('vidro frontal Onix', 612, '2m x 3m'),		-- 3
    ('vidro lateral Onix', 109, '1.2m x 1.3m');	-- 4
   
-- Veículo_idVeículo, Veículo_Cliente_PJ_PF_idCliente_PJ_PF, Autopeças_Estoque_idPeças_de_Reposição, Data_compra, Prazo_data_expirada
SELECT * FROM `garantia`; -- relação autopeças/cliente
INSERT INTO `garantia` (Veículo_idVeículo, Veículo_Cliente_PJ_PF_idCliente_PJ_PF, Autopeças_Estoque_idPeças_de_Reposição, Data_compra, Prazo_data_expirada) VALUES
	(3, 3, 1, 20230331135500, NULL),
    (3, 3, 2, 20230331135500, NULL),
    (4, 4, 3, 20230330140000, 20240330140000),
    (4, 4, 4, 20230330140000, 20240330140000);
    
-- Autopeças_Estoque_idPeças_de_Reposição, Equipe_Designada_idEquipe_Designada, Status, Frete
SELECT * FROM `motoboy`; -- relação autopeças/equipe -- STATUS('Espera', 'Transporte', 'Pagamento')
INSERT INTO `motoboy` (Autopeças_Estoque_idPeças_de_Reposição, Equipe_Designada_idEquipe_Designada, Status, Frete) VALUES
	(1, 4, 'Pagamento', NULL),
    (2, 4, 'Pagamento', 25),
    (3, 1, 'Transporte', 55),
    (4, 1, 'Transporte', NULL);
    
-- idMecânico_Eletricista, Nome, Endereço, Especialidade_Função, Código_de_Funcionário, Mecânico_Eletricistacol
SELECT * FROM `mecânico_eletricista`; -- corpo de funcionários
INSERT INTO `mecânico_eletricista` (Nome, Endereço, Especialidade_Função, Código_de_Funcionário) VALUES
	('Vitor', 'Av do Trabalhador - apto01', 'Eletricista', '001AA'),			-- 1
    ('E Leo', 'Av do Empregado - casa02', 'Mecatrônico', '002BB'),				-- 2
    ('Anita', 'Av do Trampo - s/n', 'Estagiária', '010XY'),						-- 3
    ('Renato Russo', 'Av do FazmeRir - apto09', 'Estagiário', '011XZ'),			-- 4
    ('Gessinger Trio', 'Rua do Contadinho - n°05', 'Mecânico', '101gg'),		-- 5
    ('Herbet Vianna', 'Rua da Bufunfa - n°1 fundos', 'Vidraceiro', '102gh'),	-- 6
    ('Tom Jobim', 'Av Verdinho - Resid.Carioca', 'Funileiro', '103gi'),			-- 7
    ('Zeca Baleiro', 'Rua da Carteira Cheia 12345', 'Borracheiro', '104gj');	-- 8
UPDATE `mecânico_eletricista` SET Especialidade_Função = 'Estagiário' WHERE Especialidade_Função = 'Estagiária';
    
-- Equipe_Designada_idEquipe_Designada, Mecânico_Eletricista_idMecânico_Eletricista, Custo_por_Hora, Hora_trabalhada
SELECT * FROM `mão_de_obra`; -- relação equipe_designada/corpo_de_funcionários
INSERT INTO `mão_de_obra` (Equipe_Designada_idEquipe_Designada, Mecânico_Eletricista_idMecânico_Eletricista, Custo_por_Hora) VALUES
	(1, 1, 45.76),
    (1, 2, 48.92),
    (2, 3, 11.10),
    (2, 4, 10.57),
    (3, 5, 38.59),
    (3, 6, 35.65),
    (4, 7, 41.56),
    (4, 8, 38.59);

-- INFERÊNCIAS:
-- Qual é a média salarial dos empregados?]
SELECT Nome, Especialidade_Função, Custo_por_Hora FROM `mecânico_eletricista` me, `mão_de_obra` mdo
	WHERE mdo.Mecânico_Eletricista_idMecânico_Eletricista = me.idMecânico_Eletricista;
SELECT Especialidade_Função, AVG(Custo_por_Hora) FROM `mecânico_eletricista` me, `mão_de_obra` mdo
	WHERE mdo.Mecânico_Eletricista_idMecânico_Eletricista = me.idMecânico_Eletricista
		group by Especialidade_Função;
SELECT AVG(Custo_por_Hora) as Media_EmpregadoHora FROM `mecânico_eletricista` me, `mão_de_obra` mdo
	WHERE mdo.Mecânico_Eletricista_idMecânico_Eletricista = me.idMecânico_Eletricista;
    
-- Quais carros estão em manuteção?
SELECT OS.Status FROM `ordem_de_serviço` OS
	WHERE OS.Status='MANUTENÇÃO';
SELECT Modelo, OS.Status FROM `ordem_de_serviço` OS, `veículo`
	WHERE OS.Status='MANUTENÇÃO';
SELECT distinct Modelo as Carro, OS.Status, idOrdem_de_Serviço as Identificador FROM `ordem_de_serviço` OS, `veículo`, `conserto` A, `revisão_progamada_ou_esporádica` B, `autorização_de_orçamento` C
	WHERE (OS.Status IN ('MANUTENÇÃO') AND A.Ordem_de_Serviço_idOrdem_de_Serviço = idOrdem_de_Serviço AND A.Veículo_idVeículo=idVeículo) 
    XOR (OS.Status IN ('MANUTENÇÃO') AND B.Ordem_de_Serviço_idOrdem_de_Serviço = idOrdem_de_Serviço AND B.Veículo_idVeículo=idVeículo) 
    XOR (OS.Status IN ('MANUTENÇÃO') AND C.Ordem_de_Serviço_idOrdem_de_Serviço = idOrdem_de_Serviço AND C.Cliente_PJ_PF_idCliente_PJ_PF = `veículo`.Cliente_PJ_PF_idCliente_PJ_PF); -- dei mole, eram pra todos passar por conserto/revisão

-- Qual o tempo de espera médio?
SELECT TIMESTAMPDIFF(MINUTE, Data_de_Emissão, Previsão_Entrega) as Minutos_em_Espera FROM `ordem_de_serviço`;
SELECT AVG(TIMESTAMPDIFF(MINUTE, Data_de_Emissão, Previsão_Entrega)) as Minutos_em_Espera FROM `ordem_de_serviço`; -- media geral, ficou feio demais
SELECT 	DATE_FORMAT(Data_de_Emissão, '%d/%m/%Y as %Hh%i') as Entrada, 
		DATE_FORMAT(Previsão_Entrega, '%d/%m/%Y as %Hh%i') as Saída,
		TIMESTAMPDIFF(MINUTE, Data_de_Emissão, Previsão_Entrega) as Minutos_em_Espera
			FROM `ordem_de_serviço`;

-- Quem são os funcionários de cada equipe por carro em atendimento? -- tirando o finalizado
-- -- teste1 - duas partes certas juntadas erradas
(SELECT distinct Modelo, OS.Status FROM `mecânico_eletricista` ME, `veículo`, `equipe_designada` ED, `mão_de_obra` MdO, `ordem_de_serviço` OS, `conserto` A, `revisão_progamada_ou_esporádica` B, `autorização_de_orçamento` C
	WHERE (A.Ordem_de_Serviço_idOrdem_de_Serviço=idOrdem_de_Serviço AND A.Veículo_idVeículo=idVeículo) 
		XOR (B.Ordem_de_Serviço_idOrdem_de_Serviço=idOrdem_de_Serviço AND B.Veículo_idVeículo=idVeículo) 
		XOR (C.Ordem_de_Serviço_idOrdem_de_Serviço=idOrdem_de_Serviço AND C.Cliente_PJ_PF_idCliente_PJ_PF=`veículo`.Cliente_PJ_PF_idCliente_PJ_PF))
	UNION
(SELECT distinct Escala, ME.Nome FROM `mecânico_eletricista` ME, `veículo`, `equipe_designada` ED, `mão_de_obra` MdO, `ordem_de_serviço` OS, `conserto` A, `revisão_progamada_ou_esporádica` B, `autorização_de_orçamento` C 
	WHERE (MdO.Mecânico_Eletricista_idMecânico_Eletricista=ME.idMecânico_Eletricista AND MdO.Equipe_Designada_idEquipe_Designada=ED.idEquipe_Designada));
-- teste2 - sem JOIN ou UNION, só FROM e WHERE (mais pesado)
SELECT distinct Modelo, OS.Status, ME.Nome, ED.Escala FROM `mecânico_eletricista` ME, `mão_de_obra` MdO, `equipe_designada` ED, `ordem_de_serviço` OS, `conserto` A, `revisão_progamada_ou_esporádica` B, `autorização_de_orçamento` C, `veículo`
	WHERE 		(MdO.Mecânico_Eletricista_idMecânico_Eletricista=ME.idMecânico_Eletricista)
			AND (MdO.Equipe_Designada_idEquipe_Designada=ED.idEquipe_Designada)
            AND (ED.idEquipe_Designada=OS.Equipe_Designada_idEquipe_Designada)
            AND ((A.Ordem_de_Serviço_idOrdem_de_Serviço=idOrdem_de_Serviço AND A.Veículo_idVeículo=idVeículo AND A.Veículo_Cliente_PJ_PF_idCliente_PJ_PF=`veículo`.Cliente_PJ_PF_idCliente_PJ_PF) 
			XOR (B.Ordem_de_Serviço_idOrdem_de_Serviço=idOrdem_de_Serviço AND B.Veículo_idVeículo=idVeículo AND B.Veículo_Cliente_PJ_PF_idCliente_PJ_PF=`veículo`.Cliente_PJ_PF_idCliente_PJ_PF) 
			XOR (C.Ordem_de_Serviço_idOrdem_de_Serviço=idOrdem_de_Serviço AND C.Cliente_PJ_PF_idCliente_PJ_PF=`veículo`.Cliente_PJ_PF_idCliente_PJ_PF AND ED.idEquipe_designada=C.Equipe_designada_idEquipe_designada))
        ;
-- teste3 - mais limpo e organizado
(select ve.Modelo, eq.Escala, me.Nome, os.Status
    from `veículo` ve
    join `conserto` co ON ve.idVeículo=co.Veículo_idVeículo
    join `ordem_de_serviço` os ON os.idOrdem_de_Serviço=co.Ordem_de_Serviço_idOrdem_de_Serviço
    join `equipe_designada` eq ON eq.idEquipe_designada=os.Equipe_designada_idEquipe_designada
    join `mão_de_obra` ob ON ob.Equipe_designada_idEquipe_designada=eq.idEquipe_designada
    join `mecânico_eletricista` me ON me.idMecânico_Eletricista=ob.Mecânico_Eletricista_idMecânico_Eletricista)
		UNION
(select ve.Modelo, eq.Escala, me.Nome, os.Status
    from `veículo` ve
    join `revisão_progamada_ou_esporádica` co ON ve.idVeículo=co.Veículo_idVeículo
    join `ordem_de_serviço` os ON os.idOrdem_de_Serviço=co.Ordem_de_Serviço_idOrdem_de_Serviço
    join `equipe_designada` eq ON eq.idEquipe_designada=os.Equipe_designada_idEquipe_designada
    join `mão_de_obra` ob ON ob.Equipe_designada_idEquipe_designada=eq.idEquipe_designada
    join `mecânico_eletricista` me ON me.idMecânico_Eletricista=ob.Mecânico_Eletricista_idMecânico_Eletricista)
		UNION
(select ve.Modelo, eq.Escala, me.Nome, os.Status
    from `veículo` ve
    join `cliente_pj_pf` pf ON pf.idCliente_PJ_PF=ve.Cliente_PJ_PF_idCliente_PJ_PF
    join `autorização_de_orçamento` co ON pf.idCliente_PJ_PF=co.Cliente_PJ_PF_idCliente_PJ_PF
    join `ordem_de_serviço` os ON os.idOrdem_de_Serviço=co.Ordem_de_Serviço_idOrdem_de_Serviço
    join `equipe_designada` eq ON eq.idEquipe_designada=os.Equipe_designada_idEquipe_designada
    join `mão_de_obra` ob ON ob.Equipe_designada_idEquipe_designada=eq.idEquipe_designada
    join `mecânico_eletricista` me ON me.idMecânico_Eletricista=ob.Mecânico_Eletricista_idMecânico_Eletricista);

-- O que cada carro veio fazer na oficina?
(SELECT Modelo, Descrição_do_Cliente as Descrição_para_Serviço FROM `ordem_de_serviço` OS, `veículo`, `conserto` A
	WHERE (A.Ordem_de_Serviço_idOrdem_de_Serviço = idOrdem_de_Serviço AND A.Veículo_idVeículo=idVeículo))
		UNION
(SELECT Modelo, Descrição_por_km FROM `ordem_de_serviço` OS, `veículo`, `revisão_progamada_ou_esporádica` B
	WHERE (B.Ordem_de_Serviço_idOrdem_de_Serviço = idOrdem_de_Serviço AND B.Veículo_idVeículo=idVeículo))
		UNION
(SELECT Modelo, Descrição_do_Serviço FROM `ordem_de_serviço` OS, `veículo`, `autorização_de_orçamento` C
	WHERE (C.Ordem_de_Serviço_idOrdem_de_Serviço = idOrdem_de_Serviço AND C.Cliente_PJ_PF_idCliente_PJ_PF = `veículo`.Cliente_PJ_PF_idCliente_PJ_PF));
    
-- 