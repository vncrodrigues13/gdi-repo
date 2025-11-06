-- 1. ENDERECO
INSERT INTO ENDERECO (ID, Rua, Numero, Bairro, CEP, Cidade, Estado) VALUES
(1, 'Av. Central', '1500', 'Centro', '9000001', 'Porto Alegre', 'RS'),
(2, 'Rua das Palmeiras', '45', 'Jardim Botânico', '8800002', 'Florianópolis', 'SC'),
(3, 'Rua da Liberdade', '102A', 'Vila Nova', '0100003', 'São Paulo', 'SP'),
(4, 'Alameda dos Anjos', '30', 'Boa Viagem', '5100004', 'Recife', 'PE'),
(5, 'Rua Principal', '123', 'Bairro Novo', '5100005', 'Recife', 'PE'),
(6, 'Rua dos Pinheiros', '99', 'Pina', '5100006', 'Recife', 'PE'),
(7, 'Av. Rio Branco', '500', 'Centro', '9000007', 'Porto Alegre', 'RS'),
(8, 'Rua das Flores', '10', 'Bela Vista', '0100008', 'São Paulo', 'SP'),
(9, 'Travessa da Lua', '22', 'Ingleses', '8800009', 'Florianópolis', 'SC'),
(10, 'Av. Atlântica', '330', 'Copacabana', '2200010', 'Rio de Janeiro', 'RJ'),
(11, 'Rua do Sol', '55', 'Madalena', '5000011', 'Recife', 'PE'),
(12, 'Estrada Velha', '100', 'Zona Rural', '4000012', 'Salvador', 'BA'),
(13, 'Praça da Matriz', '5', 'Centro', '5000013', 'Recife', 'PE'),
(14, 'Rua Bela Vista', '80', 'Pituba', '4100014', 'Salvador', 'BA');


-- 2. USUARIO (Todos os usuários, incluindo os que são apenas clientes, corretores, proprietários ou múltiplos)
INSERT INTO USUARIO (CPF, Nome, Email, Endereco_ID) VALUES
('11111111111', 'João Silva', 'joao.silva@email.com', 1),
('22222222222', 'Maria Oliveira', 'maria.oliver@email.com', 2),
('33333333333', 'Carlos Santos', 'carlos.santos@email.com', 3),
('44444444444', 'Ana Costa', 'ana.costa@email.com', 4),
('55555555555', 'Pedro Rocha', 'pedro.rocha@email.com', 5),
('66666666666', 'Luiza Souza', 'luiza.souza@email.com', 6),
('77777777777', 'Marcos Lima', 'marcos.lima@email.com', 7),
('88888888888', 'Sofia Neves', 'sofia.neves@email.com', 8),
('99999999999', 'Roberto Melo', 'roberto.melo@email.com', 9),
('10101010101', 'Paula Gomes', 'paula.gomes@email.com', 10),
('11211211212', 'Felipe Nunes', 'felipe.nunes@email.com', 11),
('12312312312', 'Bruna Dias', 'bruna.dias@email.com', 12),
('10000000001', 'Ricardo Alves', 'ricardo.alves@email.com', 1),
('10000000002', 'Camila Leal', 'camila.leal@email.com', 2),
('10000000003', 'Guilherme Sá', 'guilherme.sa@email.com', 3),
('10000000004', 'Natália Reis', 'natalia.reis@email.com', 4),
('10000000005', 'André Mota', 'andre.mota@email.com', 5),
('10000000006', 'Teresa Pires', 'teresa.pires@email.com', 6),
('10000000007', 'Vitor Hugo', 'vitor.hugo@email.com', 7),
('10000000008', 'Marta Ribeiro', 'marta.ribeiro@email.com', 8),
('10000000009', 'Hugo Fernandes', 'hugo.fernandes@email.com', 9),
('10000000010', 'Gisele Dutra', 'gisele.dutra@email.com', 10),
('10000000011', 'Igor Campos', 'igor.campos@email.com', 11),
('10000000012', 'Aline Ferreira', 'aline.ferreira@email.com', 1),
('10000000013', 'Beto Silva', 'beto.silva@email.com', 2),
('10000000014', 'Diana Lopes', 'diana.lopes@email.com', 3),
('10000000015', 'Eduardo Pires', 'eduardo.pires@email.com', 4),
('10000000016', 'Fernanda Mota', 'fernanda.mota@email.com', 5),
('10000000017', 'Gabriel Costa', 'gabriel.costa@email.com', 13),
('10000000018', 'Heloisa Rangel', 'heloisa.rangel@email.com', 14);


-- 3. TELEFONES
INSERT INTO TELEFONES (CPF_USUARIO, NUMERO, DDD) VALUES
('11111111111', '987654321', '51'),
('11111111111', '333322221', '51'),
('22222222222', '998877665', '48'),
('33333333333', '912345678', '11'),
('44444444444', '987654321', '81'),
('55555555555', '955554444', '81'),
('66666666666', '966665555', '81'),
('77777777777', '977776666', '51'),
('88888888888', '988887777', '11'),
('99999999999', '999998888', '48'),
('10101010101', '900001111', '21'),
('11211211212', '911112222', '21');


-- 4. CORRETOR
INSERT INTO CORRETOR (CPF, CRECI, DataAdmissao, ComissaoPadrao) VALUES
('11111111111', '00001J', '2015-02-01', 5.00),
('22222222222', '12345F', '2020-05-10', 5.50),
('44444444444', '67890J', '2018-01-20', 6.00),
('99999999999', '11122F', '2022-11-01', 4.50),
('11211211212', '33344J', '2023-08-15', 5.80),
('10000000001', '55566F', '2019-03-01', 5.20),
('10000000002', '77788J', '2021-06-25', 5.10),
('10000000003', '99900F', '2024-01-10', 6.50),
('10000000004', '12023J', '2017-09-30', 4.80),
('10000000005', '34045F', '2020-12-12', 5.30);


-- 5. PROPRIETARIO
INSERT INTO PROPRIETARIO (CPF, Banco, Agencia, Conta) VALUES
('11111111111', 'Banco Sol', '0011', '55555-0'),
('55555555555', 'Banco Lua', '0022', '66666-1'),
('77777777777', 'Banco Mar', '0033', '77777-2'),
('10101010101', 'Banco Sol', '0011', '88888-3'),
('10000000006', 'Banco Terra', '0044', '11111-4'),
('10000000007', 'Banco Vento', '0055', '22222-5'),
('10000000008', 'Banco Céu', '0066', '33333-6'),
('10000000009', 'Banco Nuvem', '0077', '44444-7'),
('10000000010', 'Banco Sol', '0011', '99999-8'),
('10000000011', 'Banco Lua', '0022', '00000-9');


-- 6. CLIENTE
INSERT INTO CLIENTE (CPF, CPF_Corretor, PreferenciasImovel) VALUES
('22222222222', '44444444444', 'Apartamento, 2 Quartos, até R$ 500.000'),
('33333333333', '22222222222', 'Casa com piscina ou área externa grande.'),
('66666666666', '11111111111', 'Terreno para construção, grande metragem.'),
('88888888888', '99999999999', 'Apartamento de luxo no centro, mínimo 3 suítes.'),
('12312312312', '11211211212', 'Imóvel para locação no Rio de Janeiro, até R$ 2.500.'),
('10000000012', '10000000001', 'Casa com 3 ou mais quartos em SP, para compra.'),
('10000000013', '10000000002', 'Apartamento pequeno, 1 quarto, mobiliado, locação.'),
('10000000014', '10000000003', 'Imóvel comercial/escritório.'),
('10000000015', '10000000004', 'Cobertura no RJ, R$ 1.5M a R$ 3M.'),
('10000000016', '10000000005', 'Casa térrea, reformada, Florianópolis.'),
('10000000017', '44444444444', 'Apartamento em Recife, 1 ou 2 quartos, locação.'),
('10000000018', '22222222222', 'Terreno ou Casa na praia, para investimento.');


-- 7. IMOVEL (Status refletindo os contratos finalizados e novos disponíveis/em negociação)
INSERT INTO IMOVEL (ID_Imovel, CPF_Proprietario, CPF_Corretor, Tipo, Endereco_ID, AreaTotal, ValorVendaLocacao, Status, Descricao) VALUES
(1001, '11111111111', '44444444444', 'Apartamento', 6, 85.50, 450000.00, 'Vendido', 'Apto 3q, vista mar.'),
(1002, '55555555555', '22222222222', 'Casa', 7, 250.00, 3500.00, 'Alugado', 'Casa locação, 4 suítes, jardim.'),
(1003, '77777777777', '99999999999', 'Terreno', 8, 500.00, 200000.00, 'Vendido', 'Terreno grande em área em expansão.'),
(1004, '10101010101', '11111111111', 'Apartamento', 9, 120.00, 850000.00, 'Vendido', 'Cobertura de 3q, reformada.'),
(1005, '10000000006', '11211211212', 'Sala Comercial', 10, 50.00, 150000.00, 'Vendido', 'Sala comercial no centro.'),
(1006, '10000000007', '10000000001', 'Casa', 11, 180.00, 600000.00, 'Vendido', 'Casa de 2 andares, ótima localização.'),
(1007, '10000000008', '10000000002', 'Apartamento', 12, 60.00, 1200.00, 'Alugado', 'Apartamento para locação, 1 quarto.'),
(1008, '10000000009', '10000000003', 'Fazenda', 1, 10000.00, 5000000.00, 'Vendido', 'Grande fazenda com potencial agrícola.'),
(1009, '10000000010', '10000000004', 'Loft', 2, 45.00, 300000.00, 'Vendido', 'Loft moderno, recém-construído.'),
(1010, '10000000011', '10000000005', 'Casa', 3, 300.00, 1200000.00, 'Vendido', 'Casa de luxo em condomínio fechado.'),
(1011, '11111111111', '44444444444', 'Apartamento', 1, 60.00, 300000.00, 'Vendido', 'Apto 2q em PA, mobiliado.'),
(1012, '55555555555', '22222222222', 'Apartamento', 4, 150.00, 5500.00, 'Disponível', 'Locação, 3 suítes, Boa Viagem.'),
(1013, '77777777777', '11111111111', 'Terreno', 5, 800.00, 250000.00, 'Disponível', 'Terreno grande em Bairro Novo.'),
(1014, '10101010101', '10000000004', 'Casa', 3, 160.00, 950000.00, 'Vendido', 'Casa reformada em SP, 3q.'),
(1015, '10000000006', '10000000002', 'Apartamento', 13, 75.00, 2500.00, 'Alugado', 'Apto locação, 2q, centro de Recife.'),
(1016, '10000000007', '10000000003', 'Fazenda', 14, 20000.00, 8000000.00, 'Disponível', 'Fazenda enorme com potencial turístico.');


-- 8. PROPOSTA (Mais propostas recusadas/pendentes para taxa de conversão)
INSERT INTO PROPOSTA (ID_Proposta, ID_Imovel, CPF_Cliente, ValorProposto, DataHoraProposta, Status) VALUES
(1, 1002, '33333333333', 3200.00, '2025-10-28 10:00:00', 'Aceita'),
(2, 1001, '22222222222', 430000.00, '2025-10-29 15:30:00', 'Recusada'),
(3, 1003, '66666666666', 190000.00, '2025-10-29 18:00:00', 'Recusada'),
(4, 1004, '88888888888', 850000.00, '2025-10-30 09:00:00', 'Aceita'),
(5, 1005, '12312312312', 150000.00, '2025-10-30 11:30:00', 'Aceita'),
(6, 1006, '10000000012', 580000.00, '2025-10-31 14:00:00', 'Recusada'),
(7, 1007, '10000000013', 1100.00, '2025-10-31 16:00:00', 'Aceita'),
(8, 1001, '10000000015', 460000.00, '2025-11-01 10:00:00', 'Aceita'),
(9, 1009, '10000000016', 300000.00, '2025-11-01 11:30:00', 'Aceita'),
(10, 1010, '33333333333', 1150000.00, '2025-11-01 14:00:00', 'Recusada'),
(11, 1003, '10000000012', 200000.00, '2025-11-02 10:00:00', 'Aceita'),
(12, 1005, '10000000014', 150000.00, '2025-11-02 11:00:00', 'Aceita'),
(13, 1006, '33333333333', 600000.00, '2025-11-02 12:00:00', 'Aceita'),
(14, 1008, '88888888888', 4900000.00, '2025-11-02 13:00:00', 'Aceita'),
(15, 1010, '12312312312', 1200000.00, '2025-11-02 14:00:00', 'Aceita'),
(16, 1001, '66666666666', 450000.00, '2025-11-02 15:00:00', 'Aceita'),
(17, 1011, '33333333333', 280000.00, '2025-11-03 10:00:00', 'Pendente'),
(18, 1012, '10000000017', 5000.00, '2025-11-03 11:30:00', 'Pendente'),
(19, 1011, '22222222222', 300000.00, '2025-11-03 15:00:00', 'Aceita'),
(20, 1014, '10000000018', 900000.00, '2025-11-04 09:00:00', 'Recusada'),
(21, 1014, '10000000017', 950000.00, '2025-11-04 10:00:00', 'Aceita'),
(22, 1015, '10000000013', 2500.00, '2025-11-04 12:00:00', 'Aceita'),
(23, 1016, '66666666666', 7500000.00, '2025-11-04 14:00:00', 'Pendente'),
(24, 1013, '10000000012', 250000.00, '2025-11-05 10:00:00', 'Pendente'),
(25, 1012, '33333333333', 5200.00, '2025-11-05 11:00:00', 'Pendente');




-- 9. CONTRATO (Mais contratos, incluindo Locações para Repasses)
INSERT INTO CONTRATO (ID_Contrato, ID_Proposta, Tipo, DataInicio, DataTermino, ValorFinal) VALUES
(5001, 1, 'Locação', '2025-11-01', '2030-11-01', 3200.00),
(5002, 4, 'Venda', '2025-11-01', NULL, 850000.00),
(5003, 7, 'Locação', '2025-11-05', '2027-11-05', 1100.00),
(5004, 9, 'Venda', '2025-11-06', NULL, 300000.00),
(5005, 11, 'Venda', '2025-11-07', NULL, 200000.00),
(5006, 5, 'Venda', '2025-11-08', NULL, 150000.00),
(5007, 13, 'Venda', '2025-11-09', NULL, 600000.00),
(5008, 14, 'Venda', '2025-11-10', NULL, 4900000.00),
(5009, 15, 'Venda', '2025-11-11', NULL, 1200000.00),
(5010, 16, 'Venda', '2025-11-12', NULL, 450000.00),
(5011, 19, 'Venda', '2025-11-13', NULL, 300000.00),
(5012, 21, 'Venda', '2025-11-14', NULL, 950000.00),
(5013, 22, 'Locação', '2025-11-15', '2028-11-15', 2500.00);


-- 10. AGENDA (Mais visitas realizadas para 'Engajamento de Clientes' e 'Imóvel mais visitado')
INSERT INTO AGENDA (ID_Imovel, CPF_Cliente, CPF_Corretor, DataHoraVisita, StatusVisita) VALUES
(1001, '22222222222', '44444444444', '2025-10-30 11:00:00', 'Realizada'),
(1002, '33333333333', '22222222222', '2025-10-27 14:00:00', 'Realizada'),
(1003, '66666666666', '99999999999', '2025-11-03 10:00:00', 'Realizada'),
(1004, '88888888888', '11111111111', '2025-10-29 16:00:00', 'Realizada'),
(1005, '12312312312', '11211211212', '2025-11-04 15:30:00', 'Cancelada'),
(1006, '10000000012', '10000000001', '2025-11-05 09:00:00', 'Realizada'),
(1007, '10000000013', '10000000002', '2025-11-06 14:00:00', 'Realizada'),
(1008, '10000000014', '10000000003', '2025-11-07 11:00:00', 'Pendente'),
(1009, '10000000015', '10000000004', '2025-11-08 10:30:00', 'Realizada'),
(1010, '10000000016', '10000000005', '2025-11-09 13:00:00', 'Pendente'),
(1011, '33333333333', '44444444444', '2025-11-10 10:00:00', 'Realizada'),
(1011, '22222222222', '44444444444', '2025-11-10 15:00:00', 'Realizada'),
(1012, '10000000017', '22222222222', '2025-11-11 11:00:00', 'Realizada'),
(1014, '10000000018', '10000000004', '2025-11-12 14:00:00', 'Realizada'),
(1014, '10000000017', '10000000004', '2025-11-12 16:00:00', 'Realizada'),
(1015, '10000000013', '10000000002', '2025-11-13 10:00:00', 'Realizada'),
(1016, '66666666666', '10000000003', '2025-11-14 15:00:00', 'Pendente'),
(1001, '66666666666', '44444444444', '2025-11-01 16:00:00', 'Realizada'); -- Mais visitas para 1001


-- 11. INTERMEDIA (Mantido para 1:N com o corretor principal)
INSERT INTO INTERMEDIA (ID_Imovel, CPF_Proprietario, CPF_Corretor, Tipo) VALUES
(1001, '11111111111', '44444444444', 'Venda'),
(1002, '55555555555', '22222222222', 'Locação'),
(1003, '77777777777', '99999999999', 'Venda'),
(1004, '10101010101', '11111111111', 'Venda'),
(1005, '10000000006', '11211211212', 'Venda'),
(1006, '10000000007', '10000000001', 'Venda'),
(1007, '10000000008', '10000000002', 'Locação'),
(1008, '10000000009', '10000000003', 'Venda'),
(1009, '10000000010', '10000000004', 'Venda'),
(1010, '10000000011', '10000000005', 'Venda'),
(1011, '11111111111', '44444444444', 'Venda'),
(1012, '55555555555', '22222222222', 'Locação'),
(1013, '77777777777', '11111111111', 'Venda'),
(1014, '10101010101', '10000000004', 'Venda'),
(1015, '10000000006', '10000000002', 'Locação'),
(1016, '10000000007', '10000000003', 'Venda');


-- 12. GERENCIA (Mantido para 1:N de Corretor Principal para Cliente)
INSERT INTO GERENCIA (CPF_Cliente, CPF_Corretor_Principal) VALUES
('22222222222', '44444444444'),
('33333333333', '22222222222'),
('66666666666', '11111111111'),
('88888888888', '99999999999'),
('12312312312', '11211211212'),
('10000000012', '10000000001'),
('10000000013', '10000000002'),
('10000000014', '10000000003'),
('10000000015', '10000000004'),
('10000000016', '10000000005'),
('10000000017', '44444444444'),
('10000000018', '22222222222');


