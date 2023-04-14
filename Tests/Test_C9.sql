create or replace PROCEDURE Test_C9

IS
    R NUMBER;
    len NUMBER;
    RArray ARRAY := ARRAY();
    temp VARCHAR(16);

BEGIN
len:=0;

    ---------- Test avec une type paiement cash ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
        INSERT INTO Produit VALUES(999,'Query Quantum',SYSDATE,999,999,999);
        INSERT INTO Ligne_Commande VALUES(999,999,1);
        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Paiement VALUES(999,'2022/11/18',80085.77,'CASH', NULL, 'Requête 3.5 Bank', NULL, NULL, 999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;
    
    ---------- Test avec une type paiement cheque ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
        INSERT INTO Produit VALUES(999,'Query Quantum',SYSDATE,999,999,999);
        INSERT INTO Ligne_Commande VALUES(999,999,1);
        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Paiement VALUES(999,'2022/11/18',80085.77,'CHEQUE', NULL, 'Requête 3.5 Bank', NULL, NULL, 999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;
    
    ---------- Test avec une type paiement cheque ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
        INSERT INTO Produit VALUES(999,'Query Quantum',SYSDATE,999,999,999);
        INSERT INTO Ligne_Commande VALUES(999,999,1);
        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Paiement VALUES(999,'2022/11/18',80085.77,'CREDIT', NULL, 'Requête 3.5 Bank', NULL, NULL, 999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;
    
    ---------- Test avec une type paiement autre ----------
    BEGIN
        len := len+1;
        R :=1;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
        INSERT INTO Produit VALUES(999,'Query Quantum',SYSDATE,999,999,999);
        INSERT INTO Ligne_Commande VALUES(999,999,1);
        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Paiement VALUES(999,'2022/11/18',80085.77,'LIQUIDE', NULL, 'Requête 3.5 Bank', NULL, NULL, 999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;
    
    ---------- Test avec une type paiement nombre ----------
    BEGIN
        len := len+1;
        R :=1;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
        INSERT INTO Produit VALUES(999,'Query Quantum',SYSDATE,999,999,999);
        INSERT INTO Ligne_Commande VALUES(999,999,1);
        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Paiement VALUES(999,'2022/11/18',80085.77,1, NULL, 'Requête 3.5 Bank', NULL, NULL, 999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;
    
    ---------- Test avec une type paiement NULL ----------
    BEGIN
        len := len+1;
        R :=1;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
        INSERT INTO Produit VALUES(999,'Query Quantum',SYSDATE,999,999,999);
        INSERT INTO Ligne_Commande VALUES(999,999,1);
        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Paiement VALUES(999,'2022/11/18',80085.77,1, NULL, 'Requête 3.5 Bank', NULL, NULL, 999);
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

BEGIN
    Test_C9();
END;