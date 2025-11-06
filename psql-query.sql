-- Buscar o valor de comissão de um corretor específico e o preço de um imóvel.

DECLARE
    v_cpf_corretor      CORRETOR.CPF%TYPE := '44444444444';
    v_comissao_padrao   CORRETOR.ComissaoPadrao%TYPE;
    v_id_imovel         IMOVEL.ID_Imovel%TYPE := 1001;
    v_valor_anunciado   IMOVEL.ValorVendaLocacao%TYPE;
BEGIN
    SELECT
        C.ComissaoPadrao, I.ValorVendaLocacao
    INTO
        v_comissao_padrao, v_valor_anunciado
    FROM
        CORRETOR C
    JOIN
        IMOVEL I ON C.CPF = I.CPF_Corretor
    WHERE
        C.CPF = v_cpf_corretor
        AND I.ID_Imovel = v_id_imovel;

    DBMS_OUTPUT.PUT_LINE('Corretor: ' || v_cpf_corretor);
    DBMS_OUTPUT.PUT_LINE('Comissão Padrão: ' || v_comissao_padrao || '%');
    DBMS_OUTPUT.PUT_LINE('Valor Anunciado do Imóvel ' || v_id_imovel || ': R$ ' || v_valor_anunciado);

    IF v_comissao_padrao > 5.50 THEN
        DBMS_OUTPUT.PUT_LINE('Comissão acima da média.');
    ELSIF v_comissao_padrao = 5.50 THEN
        DBMS_OUTPUT.PUT_LINE('Comissão na média.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Comissão abaixo da média.');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Corretor ou Imóvel não encontrado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro Inesperado: ' || SQLERRM);
END;





-- Procedimento que recebe um CPF de Cliente (IN), consulta o nome do corretor principal que o gerencia e retorna (OUT) o nome desse corretor.

CREATE OR REPLACE PROCEDURE SP_BUSCAR_CORRETOR_PRINCIPAL (
    p_cpf_cliente IN CLIENTE.CPF%TYPE,
    p_nome_corretor OUT USUARIO.Nome%TYPE
)
AS
    v_cpf_corretor CORRETOR.CPF%TYPE;
    v_status_cliente VARCHAR2(20);
BEGIN
    SELECT CPF_Corretor INTO v_cpf_corretor
    FROM CLIENTE
    WHERE CPF = p_cpf_cliente;

    CASE
        WHEN v_cpf_corretor IS NOT NULL THEN
            SELECT Nome INTO p_nome_corretor
            FROM USUARIO
            WHERE CPF = v_cpf_corretor;
            v_status_cliente := 'Corretor Atribuído';
        ELSE
            p_nome_corretor := 'Nenhum Corretor Principal';
            v_status_cliente := 'Sem Corretor';
    END CASE;

    DBMS_OUTPUT.PUT_LINE('Status da Gerência: ' || v_status_cliente);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_nome_corretor := 'Cliente Não Encontrado';
END;
/



-- Listar Imóveis de um Proprietário e Status de Proposta
DECLARE
    CURSOR c_imoveis_proprietario (p_cpf PROPRIETARIO.CPF%TYPE) IS
        SELECT
            I.ID_Imovel,
            I.Tipo,
            I.Status
        FROM
            IMOVEL I
        WHERE
            I.CPF_Proprietario = p_cpf;

    v_cpf_proprietario PROPRIETARIO.CPF%TYPE := '11111111111';
    v_has_proposta_ativa BOOLEAN;
    v_nome_proprietario USUARIO.Nome%TYPE;
BEGIN
    SELECT Nome INTO v_nome_proprietario
    FROM USUARIO
    WHERE CPF = v_cpf_proprietario;

    DBMS_OUTPUT.PUT_LINE('Proprietário: ' || v_nome_proprietario || ' (' || v_cpf_proprietario || ')');
    DBMS_OUTPUT.PUT_LINE('--- Status dos Imóveis ---');

    FOR r_imovel IN c_imoveis_proprietario(v_cpf_proprietario) LOOP
        SELECT CASE WHEN COUNT(*) > 0 THEN TRUE ELSE FALSE END INTO v_has_proposta_ativa
        FROM PROPOSTA
        WHERE ID_Imovel = r_imovel.ID_Imovel
          AND Status IN ('Pendente', 'Aceita');

        DBMS_OUTPUT.PUT_LINE('Imóvel ' || r_imovel.ID_Imovel || ' (' || r_imovel.Tipo || '): Status: ' || r_imovel.Status);

        IF v_has_proposta_ativa THEN
            DBMS_OUTPUT.PUT_LINE('  * Tem PROPOSTAS ATIVAS!');
        ELSE
            DBMS_OUTPUT.PUT_LINE('  * Sem Propostas Ativas.');
        END IF;

    END LOOP;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Proprietário não encontrado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro Inesperado: ' || SQLERRM);
END;
/




--Lista de Clientes de um Corretor Usando RECORD e Coleção
DECLARE
    -- 1. Definição do Tipo RECORD
    TYPE t_cliente_record IS RECORD (
        nome_cliente USUARIO.Nome%TYPE,
        preferencias CLIENTE.PreferenciasImovel%TYPE
    );

    TYPE t_lista_clientes_table IS TABLE OF t_cliente_record INDEX BY PLS_INTEGER;

    v_cpf_corretor_principal CORRETOR.CPF%TYPE := '44444444444';
    v_corretor_nome USUARIO.Nome%TYPE;
    v_lista_clientes t_lista_clientes_table;
    v_contador PLS_INTEGER := 0;

    CURSOR c_clientes IS
        SELECT
            U.Nome,
            C.PreferenciasImovel
        FROM
            CLIENTE C
        JOIN
            USUARIO U ON C.CPF = U.CPF
        WHERE
            C.CPF_Corretor = v_cpf_corretor_principal;

BEGIN
    SELECT Nome INTO v_corretor_nome
    FROM USUARIO
    WHERE CPF = v_cpf_corretor_principal;

    FOR r_cliente IN c_clientes LOOP
        v_contador := v_contador + 1;
        v_lista_clientes(v_contador).nome_cliente := r_cliente.Nome;
        v_lista_clientes(v_contador).preferencias := r_cliente.PreferenciasImovel;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Corretor: ' || v_corretor_nome || ' (' || v_cpf_corretor_principal || ')');
    DBMS_OUTPUT.PUT_LINE('Total de Clientes Gerenciados: ' || v_lista_clientes.COUNT);
    DBMS_OUTPUT.PUT_LINE('--- Detalhes dos Clientes ---');

    FOR i IN 1..v_lista_clientes.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_lista_clientes(i).nome_cliente);
        DBMS_OUTPUT.PUT_LINE('  Preferências: ' || COALESCE(v_lista_clientes(i).preferencias, 'Não informadas.'));
    END LOOP;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Corretor não encontrado ou sem clientes gerenciados.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro Inesperado: ' || SQLERRM);
END;
/





--Função para Calcular Bônus Condicional (Usando WHILE LOOP)
CREATE OR REPLACE FUNCTION FN_CALCULAR_BONUS_CONTRATOS (
    p_cpf_corretor IN CORRETOR.CPF%TYPE
)
RETURN NUMERIC
IS
    v_total_contratos INT;
    v_bonus NUMERIC(10, 2) := 0;
    v_contador INT := 0;
BEGIN
    SELECT COUNT(C.ID_Contrato) INTO v_total_contratos
    FROM CONTRATO C
    JOIN PROPOSTA P ON C.ID_Proposta = P.ID_Proposta
    JOIN IMOVEL I ON P.ID_Imovel = I.ID_Imovel
    WHERE I.CPF_Corretor = p_cpf_corretor;

    WHILE v_contador < v_total_contratos LOOP
        v_contador := v_contador + 1;

        IF v_contador > 5 THEN
            v_bonus := v_bonus + 1000.00;
        END IF;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Contratos fechados: ' || v_total_contratos);
    RETURN v_bonus;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro na função de bônus: ' || SQLERRM);
        RETURN 0;
END;
/

DECLARE
    v_cpf_corretor CORRETOR.CPF%TYPE := '44444444444';
    v_nome_corretor USUARIO.Nome%TYPE;
    v_bonus_calculado NUMERIC(10, 2);
BEGIN
    SELECT Nome INTO v_nome_corretor FROM USUARIO WHERE CPF = v_cpf_corretor;

    v_bonus_calculado := FN_CALCULAR_BONUS_CONTRATOS(v_cpf_corretor);

    DBMS_OUTPUT.PUT_LINE('Cálculo de Bônus para ' || v_nome_corretor || ':');
    DBMS_OUTPUT.PUT_LINE('Bônus Total: R$ ' || v_bonus_calculado);
END;
/




-- Definição do Package (Especificação)
CREATE OR REPLACE PACKAGE PKG_TRANSACAO_IMOVEL
AS
    PROCEDURE SP_ATUALIZAR_STATUS_IMOVEL (
        p_id_proposta IN PROPOSTA.ID_Proposta%TYPE
    );

    FUNCTION FN_BUSCAR_STATUS_CONTRATO (
        p_tipo_contrato IN CONTRATO.Tipo%TYPE
    )
    RETURN IMOVEL.Status%TYPE;
END PKG_TRANSACAO_IMOVEL;
/




--Corpo do Package (Implementação)
CREATE OR REPLACE PACKAGE BODY PKG_TRANSACAO_IMOVEL
AS
    FUNCTION FN_BUSCAR_STATUS_CONTRATO (
        p_tipo_contrato IN CONTRATO.Tipo%TYPE
    )
    RETURN IMOVEL.Status%TYPE
    IS
    BEGIN
        IF p_tipo_contrato = 'Venda' THEN
            RETURN 'Vendido';
        ELSIF p_tipo_contrato = 'Locação' THEN
            RETURN 'Alugado';
        ELSE
            RETURN 'Em Negociação'; 
        END IF;
    END FN_BUSCAR_STATUS_CONTRATO;

    PROCEDURE SP_ATUALIZAR_STATUS_IMOVEL (
        p_id_proposta IN PROPOSTA.ID_Proposta%TYPE
    )
    IS
        v_id_imovel IMOVEL.ID_Imovel%TYPE;
        v_tipo_contrato CONTRATO.Tipo%TYPE;
        v_novo_status IMOVEL.Status%TYPE;
    BEGIN
        SELECT P.ID_Imovel, C.Tipo
        INTO v_id_imovel, v_tipo_contrato
        FROM PROPOSTA P
        JOIN CONTRATO C ON P.ID_Proposta = C.ID_Proposta
        WHERE P.ID_Proposta = p_id_proposta;

        v_novo_status := FN_BUSCAR_STATUS_CONTRATO(v_tipo_contrato);

        UPDATE IMOVEL
        SET Status = v_novo_status
        WHERE ID_Imovel = v_id_imovel;

        DBMS_OUTPUT.PUT_LINE('Imóvel ' || v_id_imovel || ' atualizado para status: ' || v_novo_status);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Proposta ou Contrato não encontrado: ' || p_id_proposta);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro na atualização do status: ' || SQLERRM);
    END SP_ATUALIZAR_STATUS_IMOVEL;
END PKG_TRANSACAO_IMOVEL;
/




--Trigger de Comando (Log de Contratos)
CREATE TABLE LOG_CONTRATOS (
    ID_Log INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    Acao VARCHAR2(10),
    DataAcao TIMESTAMP,
    Usuario VARCHAR2(50)
);

CREATE OR REPLACE TRIGGER TRG_LOG_CONTRATO_COMANDO
BEFORE INSERT OR UPDATE OR DELETE ON CONTRATO
DECLARE
    v_acao VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_acao := 'INSERT';
    ELSIF UPDATING THEN
        v_acao := 'UPDATE';
    ELSIF DELETING THEN
        v_acao := 'DELETE';
    END IF;

    INSERT INTO LOG_CONTRATOS (Acao, DataAcao, Usuario)
    VALUES (v_acao, SYSTIMESTAMP, USER);

    DBMS_OUTPUT.PUT_LINE('LOG: Comandos DML em CONTRATO registrados.');
END;
/



--Trigger de Linha (Executa o procedimento do package)
CREATE OR REPLACE TRIGGER TRG_CONTRATO_AFTER_INSERT
AFTER INSERT ON CONTRATO
FOR EACH ROW
BEGIN
    PKG_TRANSACAO_IMOVEL.SP_ATUALIZAR_STATUS_IMOVEL(:NEW.ID_Proposta);

END;
/