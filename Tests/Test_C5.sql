--C5 Check qte_commander >0 Ligne commande
create or replace PROCEDURE Test_C5

IS
    R NUMBER;
    len NUMBER;
    RArray ARRAY := ARRAY();
    temp VARCHAR(16);

BEGIN
len:=0;

--TEST THAT PASSES IF THE COMMAND ***FAILS***
    BEGIN
        len := len+1;
        R :=1;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
        INSERT INTO Produit VALUES(999,'Query Quantum',SYSDATE,999,999,999);
        INSERT INTO Ligne_Commande VALUES(999,999,-1);

    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);RArray(len):=R;ROLLBACK;


--TEST THAT PASSES IF THE COMMAND IS EXECUTED CORRECTLY
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
        INSERT INTO Produit VALUES(999,'Query Quantum',SYSDATE,999,999,999);
        INSERT INTO Ligne_Commande VALUES(999,999,1);

    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);RArray(len):=R;ROLLBACK;


--TEST THAT PASSES IF THE COMMAND IS EXECUTED CORRECTLY
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
        INSERT INTO Produit VALUES(999,'Query Quantum',SYSDATE,999,999,999);
        INSERT INTO Ligne_Commande VALUES(999,999,0);

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
ROLLBACK;
END;
