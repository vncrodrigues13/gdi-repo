--Quais imóveis um dado cliente fez proposta?

SELECT
    I.ID_Imovel,
    I.Tipo,
    E.Rua || ', ' || E.Numero AS EnderecoCompleto,
    I.ValorVendaLocacao AS ValorAnunciado,
    P.ValorProposto,
    P.DataHoraProposta
FROM
    PROPOSTA P
JOIN
    IMOVEL I ON P.ID_Imovel = I.ID_Imovel
JOIN
    ENDERECO E ON I.Endereco_ID = E.ID
WHERE
    P.CPF_Cliente = 'CPF_DO_CLIENTE';


--Qual a média de preço de um imóvel de um determinado Bairro?


SELECT
    E.Bairro,
    AVG(I.ValorVendaLocacao) AS MediaValorImoveis
FROM
    IMOVEL I
JOIN
    ENDERECO E ON I.Endereco_ID = E.ID
WHERE
    E.Bairro = 'NOME_DO_BAIRRO' 
GROUP BY
    E.Bairro;



--Listagem agrupada da quantidade de imóveis e os bairros que são intermediados por um determinado corretor.

SELECT
    E.Bairro,
    COUNT(I.ID_Imovel) AS QuantidadeImoveisIntermediados
FROM
    IMOVEL I
JOIN
    ENDERECO E ON I.Endereco_ID = E.ID
WHERE
    I.CPF_Corretor = 'CPF_DO_CORRETOR'
GROUP BY
    E.Bairro
ORDER BY
    QuantidadeImoveisIntermediados DESC;


--Qual corretor teve mais agendamento em um determinado mês?


SELECT
    A.CPF_Corretor,
    U.Nome AS NomeCorretor,
    COUNT(A.DataHoraVisita) AS TotalAgendamentos
FROM
    AGENDA A
JOIN
    USUARIO U ON A.CPF_Corretor = U.CPF
WHERE
    EXTRACT(YEAR FROM A.DataHoraVisita) = 2024 AND
    EXTRACT(MONTH FROM A.DataHoraVisita) = 10
GROUP BY
    A.CPF_Corretor, U.Nome
ORDER BY
    TotalAgendamentos DESC
LIMIT 1;



--Qual o corretor teve a maior quantidade de propostas resultado em um contrato?

SELECT
   I.CPF_Corretor,
   U.Nome AS NomeCorretor,
   COUNT(C.ID_Contrato) AS ContratosFechados
FROM
   CONTRATO C
JOIN
   PROPOSTA P ON C.ID_Proposta = P.ID_Proposta
JOIN
   IMOVEL I ON P.ID_Imovel = I.ID_Imovel
JOIN
   USUARIO U ON I.CPF_Corretor = U.CPF
WHERE
   I.CPF_Corretor IS NOT NULL
GROUP BY
   I.CPF_Corretor, U.Nome
ORDER BY
   ContratosFechados DESC
LIMIT 1;




--Qual o proprietário com o maior número de imóveis?

SELECT
    I.CPF_Proprietario,
    U.Nome AS NomeProprietario,
    COUNT(I.ID_Imovel) AS TotalImoveis
FROM
    IMOVEL I
JOIN
    USUARIO U ON I.CPF_Proprietario = U.CPF
GROUP BY
    I.CPF_Proprietario, U.Nome
ORDER BY
    TotalImoveis DESC
LIMIT 1;




--Relatório de Estoque de Imóveis (disponíveis, em negociação, vendidos/alugados) por Corretor e Tipo.


SELECT
    U.Nome AS NomeCorretor,
    I.Tipo AS TipoImovel,
    I.Status AS StatusImovel,
    COUNT(I.ID_Imovel) AS Quantidade
FROM
    IMOVEL I
JOIN
    USUARIO U ON I.CPF_Corretor = U.CPF
WHERE
    I.CPF_Corretor IS NOT NULL
GROUP BY
    U.Nome, I.Tipo, I.Status
ORDER BY
    NomeCorretor, TipoImovel, StatusImovel;



--Relatório de Receita e Comissões pagas e a pagar por Corretor e Transação.

SELECT
    C.ID_Contrato,
    U_Corretor.Nome AS NomeCorretor,
    C.Tipo AS TipoTransacao,
    C.DataInicio AS DataContrato,
    C.ValorFinal AS ValorTotalTransacao,
    CR.ComissaoPadrao,
    (C.ValorFinal * CR.ComissaoPadrao / 100) AS ValorComissao,
    CASE
        WHEN C.DataInicio <= CURRENT_DATE - INTERVAL '30 days' THEN 'A Pagar'
        ELSE 'Pago'
    END AS StatusPagamento
FROM
    CONTRATO C
JOIN
    PROPOSTA P ON C.ID_Proposta = P.ID_Proposta
JOIN
    IMOVEL I ON P.ID_Imovel = I.ID_Imovel
JOIN
    CORRETOR CR ON I.CPF_Corretor = CR.CPF
JOIN
    USUARIO U_Corretor ON CR.CPF = U_Corretor.CPF
ORDER BY
    NomeCorretor, DataContrato DESC;




 --Listar todos os corretores que foram admitidos em um conjunto específico de anos (e.g., 2018, 2020, 2024).

SELECT
    U.Nome AS NomeCorretor,
    C.CRECI,
    C.DataAdmissao
FROM
    CORRETOR C
JOIN
    USUARIO U ON C.CPF = U.CPF
WHERE
    EXTRACT(YEAR FROM C.DataAdmissao) IN (2018, 2020, 2024)
ORDER BY
    C.DataAdmissao;



--Listar os clientes que fizeram propostas com um valor proposto maior do que a média de valor proposto de todas as propostas.

SELECT
    U.Nome AS NomeCliente,
    P.ValorProposto,
    P.DataHoraProposta
FROM
    PROPOSTA P
JOIN
    CLIENTE C ON P.CPF_Cliente = C.CPF
JOIN
    USUARIO U ON C.CPF = U.CPF
WHERE
    P.ValorProposto > (
        SELECT AVG(ValorProposto) FROM PROPOSTA
    )
ORDER BY
    P.ValorProposto DESC;



--Encontrar clientes cujas preferências de imóvel incluam as palavras "Apartamento" e "Locação".

SELECT
    U.Nome AS NomeCliente,
    C.PreferenciasImovel
FROM
    CLIENTE C
JOIN
    USUARIO U ON C.CPF = U.CPF
WHERE
    C.PreferenciasImovel LIKE '%Apartamento%'
    AND C.PreferenciasImovel LIKE '%locação%'
    AND C.PreferenciasImovel IS NOT NULL;



-- Combinar a listagem de todos os usuários que são Proprietários e de todos os usuários que são Corretores

SELECT
    U.CPF, U.Nome, 'Proprietário' AS Funcao
FROM
    USUARIO U
JOIN
    PROPRIETARIO P ON U.CPF = P.CPF
UNION
SELECT
    U.CPF, U.Nome, 'Corretor' AS Funcao
FROM
    USUARIO U
JOIN
    CORRETOR C ON U.CPF = C.CPF
ORDER BY
    Nome;



-- Criar uma View chamada V_RELATORIO_COMISSAO_PAGAR que armazena o resultado do relatório de Comissões, focando apenas nos contratos com status de pagamento "A Pagar"

CREATE VIEW V_RELATORIO_COMISSAO_PAGAR AS
SELECT
    C.ID_Contrato,
    U_Corretor.Nome AS NomeCorretor,
    C.DataInicio AS DataContrato,
    (C.ValorFinal * CR.ComissaoPadrao / 100) AS ValorComissao,
    'A Pagar' AS StatusPagamento
FROM
    CONTRATO C
JOIN
    PROPOSTA P ON C.ID_Proposta = P.ID_Proposta
JOIN
    IMOVEL I ON P.ID_Imovel = I.ID_Imovel
JOIN
    CORRETOR CR ON I.CPF_Corretor = CR.CPF
JOIN
    USUARIO U_Corretor ON CR.CPF = U_Corretor.CPF
WHERE
    -- Condição do status "A Pagar"
    C.DataInicio <= CURRENT_DATE - INTERVAL '30 days'
ORDER BY
    DataContrato ASC;