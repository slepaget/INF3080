create or replace PROCEDURE Test_Procedure_1

IS
    R NUMBER;
    len NUMBER;
    RArray ARRAY := ARRAY();
    temp VARCHAR(16);
    result NUMBER;

BEGIN
len:=0;
result:=0;

    ---------- Test avec un client existant ----------
    BEGIN
        len := len+1;
        R :=0;
        
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,999,999,999);
        INSERT INTO Ligne_Commande VALUES(999,999,999);
        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Ligne_Livraison VALUES(999,999,999,999);
        BEGIN
            PreparerLivraison(999);
        END;
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec un client non existant ----------
    BEGIN
        len := len+1;
        R :=1;
        BEGIN
            PreparerLivraison(999);
        END;
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec un client string ----------
    BEGIN
        len := len+1;
        R :=1;
        BEGIN
            PreparerLivraison('Allo');
        END;
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec aucun argument ----------
    BEGIN
        len := len+1;
        R :=1;
        BEGIN
            PreparerLivraison('');
        END;
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;


    FOR i IN 1..RArray.COUNT LOOP
        IF RArray(i)= 0 THEN 
            temp:='PASSED';
        ELSE 
            temp:='*****FAILED*****';
        END IF;
        DBMS_OUTPUT.PUT_LINE('Test #' || i || '   ' || temp);
    END LOOP;
END;