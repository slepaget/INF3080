create or replace PROCEDURE Test_Trigger

IS
    R NUMBER;
    len NUMBER;
    RArray ARRAY := ARRAY();
    temp VARCHAR(16);
    a NUMBER;
    b NUMBER;

BEGIN
len:=0;

--TEST THAT PASSES IF THE COMMAND IS EXECUTED CORRECTLY
--TEST THAT PASSES IF THE DIFF BETWEEN THE TWO IS 1
    BEGIN
        len := len+1;
        R :=0;

        a:=0;
        b:=0;
        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Paiement    (date_paiement, montant,    type_paiement,  no_cheque,  nom_banque,         no_carte_credit,    type_carte_credit,  no_livraison) 
            VALUES(             SYSDATE,        999.99,       'CASH',         NULL,       'TestTrigger1',  NULL,               NULL,               999);
        INSERT INTO Paiement    (date_paiement, montant,    type_paiement,  no_cheque,  nom_banque,         no_carte_credit,    type_carte_credit,  no_livraison) 
            VALUES(             SYSDATE,        999.99,       'CASH',         NULL,       'TestTrigger2',  NULL,               NULL,               999);


        SELECT id_paiement
        INTO a
        FROM Paiement
        WHERE nom_banque = 'TestTrigger1';

        SELECT id_paiement
        INTO b
        FROM Paiement
        WHERE nom_banque = 'TestTrigger2';

        IF (b-a)<>1
        THEN
            R := 1;
        ELSE    
            R := 0;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);RArray(len):=R;ROLLBACK;

    --TEST THAT PASSES IF THE COMMAND IS EXECUTED CORRECTLY
    --TEST THAT PASSES IF THE DIFF BETWEEN THE TWO IS 1
    --TEST FROM EXISTING CONDITION
    --TEST WITH MAX()
    BEGIN
        len := len+1;
        R :=0;

        a:=0;
        b:=0;

        SELECT MAX(id_paiement)as maxiID
        INTO a
        FROM Paiement;
        
        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Paiement    (date_paiement, montant,    type_paiement,  no_cheque,  nom_banque,         no_carte_credit,    type_carte_credit,  no_livraison) 
            VALUES(             SYSDATE,        999.99,       'CASH',         NULL,       'TestTrigger1',  NULL,               NULL,               999);


        SELECT MAX(id_paiement)as maxiID
        INTO b
        FROM Paiement;
 

        IF (b-a)<>1
        THEN
            R := 1;
        ELSE    
            R := 0;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);RArray(len):=R;ROLLBACK;


--LOOP OVER THE RESULTS AND PRINTS
    FOR i IN 1..RArray.COUNT LOOP
        IF RArray(i)= 0 THEN 
            temp:='PASSED';
        ELSE 
            temp:='*****FAILED*****';
        END IF;
        DBMS_OUTPUT.PUT_LINE('Test #' || i || '   ' || temp);
    END LOOP;

END;