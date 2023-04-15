create or replace PROCEDURE Test_C1

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
        INSERT INTO Commande VALUES(999,SYSDATE,'zzzzzz',999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

        --TEST THAT PASSES IF THE COMMAND ***FAILS***
    BEGIN
        len := len+1;
        R :=1;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,' ',999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;


    --TEST THAT PASSES IF THE COMMAND IS EXECUTED CORRECTLY
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande (no_commande, date_commande,no_client)
                     VALUES(999,SYSDATE,999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;


    --TEST THAT PASSES IF THE COMMAND IS EXECUTED CORRECTLY
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;   
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;


    --TEST THAT PASSES IF THE COMMAND IS EXECUTED CORRECTLY
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ANNULE',999);
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
        INSERT INTO Commande VALUES(999,SYSDATE,'FERMEE',999);
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
/

create or replace PROCEDURE Test_C2

IS
    R NUMBER;
    len NUMBER;
    RArray ARRAY := ARRAY();
    temp VARCHAR(16);

BEGIN
len:=0;

    ---------- Test avec l'entree d'une date manuellement ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Produit VALUES(999,'Test','2023-02-27',999,999,999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec aucune entree de date ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Produit VALUES(999,'Test','',999,999,999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec un string ----------
    BEGIN
        len := len+1;
        R :=1;
        INSERT INTO Produit VALUES(999,'Test','Allo',999,999,999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec une date future ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Produit VALUES(999,'Test','2023-04-25',999,999,999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
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
/

create or replace PROCEDURE Test_C3

IS
    R NUMBER;
    len NUMBER;
    RArray ARRAY := ARRAY();
    temp VARCHAR(16);

BEGIN
len:=0;

    ---------- Test avec une quantite negative ----------
    BEGIN
        len := len+1;
        R :=1;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,-1,999,999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec une quantite positive ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,20,999,999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec une quantite de 0 ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,0,999,999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec un String ----------
    BEGIN
        len := len+1;
        R :=1;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,'Allo',999,999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec une quantite vide ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,'',999,999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
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
/

create or replace PROCEDURE Test_C4

IS
    R NUMBER;
    len NUMBER;
    RArray ARRAY := ARRAY();
    temp VARCHAR(16);

BEGIN
len:=0;

    ---------- Test avec une quantite negative ----------
    BEGIN
        len := len+1;
        R :=1;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,999,-1,999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec une quantite positive ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,99,20,99);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec une quantite de 0 ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,10,999,999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec un String ----------
    BEGIN
        len := len+1;
        R :=1;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,999,'Allo',999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec une quantite vide ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,999,'',999);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
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
/

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
/

create or replace PROCEDURE Test_C6

IS
    R NUMBER;
    len NUMBER;
    RArray ARRAY := ARRAY();
    temp VARCHAR(16);

BEGIN
len:=0;

    ---------- Test avec une quantite negative ----------
    BEGIN
        len := len+1;
        R :=1;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
        INSERT INTO Produit VALUES(999,'Query Quantum',SYSDATE,999,999,999);
        INSERT INTO Ligne_Commande VALUES(999,999,1);
        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Ligne_Livraison VALUES(999,999,999,-1);
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec une quantite positive ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
        INSERT INTO Produit VALUES(999,'Query Quantum',SYSDATE,999,999,999);
        INSERT INTO Ligne_Commande VALUES(999,999,1);
        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Ligne_Livraison VALUES(999,999,999,2);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec une quantite de 0 ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
        INSERT INTO Produit VALUES(999,'Query Quantum',SYSDATE,999,999,999);
        INSERT INTO Ligne_Commande VALUES(999,999,1);
        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Ligne_Livraison VALUES(999,999,999,0);
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec un String ----------
    BEGIN
        len := len+1;
        R :=1;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
        INSERT INTO Produit VALUES(999,'Query Quantum',SYSDATE,999,999,999);
        INSERT INTO Ligne_Commande VALUES(999,999,1);
        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Ligne_Livraison VALUES(999,999,999,'String');
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec une quantite vide ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Client VALUES(999,'Test','Test', 'Test','Test','Test');
        INSERT INTO Commande VALUES(999,SYSDATE,'ENCOURS',999);
        INSERT INTO Produit VALUES(999,'Query Quantum',SYSDATE,999,999,999);
        INSERT INTO Ligne_Commande VALUES(999,999,1);
        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Ligne_Livraison VALUES(999,999,999,'');
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
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
/

create or replace PROCEDURE Test_C7

IS
    R NUMBER;
    len NUMBER;
    RArray ARRAY := ARRAY();
    temp VARCHAR(16);

BEGIN
len:=0;

    ---------- Test avec une quantite negative ----------
    BEGIN
        len := len+1;
        R :=1;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,999,999,999);
        INSERT INTO Fournisseur VALUES(999,'Test','Test','Test','Test');
        INSERT INTO Approvisionnement VALUES(999,999,-1,SYSDATE,'LIVRE');
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec une quantite positive ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,999,999,999);
        INSERT INTO Fournisseur VALUES(999,'Test','Test','Test','Test');
        INSERT INTO Approvisionnement VALUES(999,999,10,SYSDATE,'LIVRE');
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec une quantite de 0 ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,999,999,999);
        INSERT INTO Fournisseur VALUES(999,'Test','Test','Test','Test');
        INSERT INTO Approvisionnement VALUES(999,999,0,SYSDATE,'LIVRE');
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec un String ----------
    BEGIN
        len := len+1;
        R :=1;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,999,999,999);
        INSERT INTO Fournisseur VALUES(999,'Test','Test','Test','Test');
        INSERT INTO Approvisionnement VALUES(999,999,'Test',SYSDATE,'LIVRE');
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec une quantite vide ----------
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,999,999,999);
        INSERT INTO Fournisseur VALUES(999,'Test','Test','Test','Test');
        INSERT INTO Approvisionnement VALUES(999,999,'',SYSDATE,'LIVRE');
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
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
/

create or replace PROCEDURE Test_C8

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
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,999,999,999);
        INSERT INTO Fournisseur VALUES(999,'Test','Test','Test','Test');
        INSERT INTO Approvisionnement VALUES(999,999,1,SYSDATE,'AAAAAAAAAA');
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

        --TEST THAT PASSES IF THE COMMAND IS EXECUTED CORRECTLY
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,999,999,999);
        INSERT INTO Fournisseur VALUES(999,'Test','Test','Test','Test');
        INSERT INTO Approvisionnement VALUES(999,999,1,SYSDATE,'ENCOURS');
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

        --TEST THAT PASSES IF THE COMMAND IS EXECUTED CORRECTLY
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,999,999,999);
        INSERT INTO Fournisseur VALUES(999,'Test','Test','Test','Test');
        INSERT INTO Approvisionnement VALUES(999,999,1,SYSDATE,'LIVRE');
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;
    
            --TEST THAT PASSES IF THE COMMAND IS EXECUTED CORRECTLY
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Produit VALUES(999,'Test',SYSDATE,999,999,999);
        INSERT INTO Fournisseur VALUES(999,'Test','Test','Test','Test');
        INSERT INTO Approvisionnement VALUES(999,999,1,SYSDATE,'ANNULE');
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;
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
/

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
/

--C10 Check type de carte de credit Paiement
create or replace PROCEDURE Test_C10

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
        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Paiement VALUES(999,SYSDATE,999.99,'CREDIT', NULL, 'Test Bank', '9999 9999 9999 9999', 'AAAAAAAAAAA',999);

    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);RArray(len):=R;ROLLBACK;


--TEST THAT PASSES IF THE COMMAND IS EXECUTED CORRECTLY
    BEGIN
        len := len+1;
        R :=0;

        INSERT INTO Livraison VALUES(999,SYSDATE);
        INSERT INTO Paiement VALUES(999,SYSDATE,999.99,'CREDIT', NULL, 'Test Bank', '9999999999999999', 'MASTERCARD',999);

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
/

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
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('------------------');
    DBMS_OUTPUT.PUT_LINE('Tests pour C1');
    Test_C1();
    DBMS_OUTPUT.PUT_LINE('------------------');
    DBMS_OUTPUT.PUT_LINE('Tests pour C2');
    Test_C2();
    DBMS_OUTPUT.PUT_LINE('------------------');
    DBMS_OUTPUT.PUT_LINE('Tests pour C3');
    Test_C3();
    DBMS_OUTPUT.PUT_LINE('------------------');
    DBMS_OUTPUT.PUT_LINE('Tests pour C4');
    Test_C4();
    DBMS_OUTPUT.PUT_LINE('------------------');
    DBMS_OUTPUT.PUT_LINE('Tests pour C5');
    Test_C5();
        DBMS_OUTPUT.PUT_LINE('------------------');
    DBMS_OUTPUT.PUT_LINE('Tests pour C6');
    Test_C6();
        DBMS_OUTPUT.PUT_LINE('------------------');
    DBMS_OUTPUT.PUT_LINE('Tests pour C7');
    Test_C7();
        DBMS_OUTPUT.PUT_LINE('------------------');
    DBMS_OUTPUT.PUT_LINE('Tests pour C8');
    Test_C8();
        DBMS_OUTPUT.PUT_LINE('------------------');
    DBMS_OUTPUT.PUT_LINE('Tests pour C9');
    Test_C9();
        DBMS_OUTPUT.PUT_LINE('------------------');
    DBMS_OUTPUT.PUT_LINE('Tests pour C10');
    Test_C10();
        DBMS_OUTPUT.PUT_LINE('------------------');
    DBMS_OUTPUT.PUT_LINE('Tests pour Trigger');
    Test_Trigger();
        DBMS_OUTPUT.PUT_LINE('------------------');
    DBMS_OUTPUT.PUT_LINE('Tests pour Fonction_1');
    Test_Fonction_1();
        DBMS_OUTPUT.PUT_LINE('------------------');
    DBMS_OUTPUT.PUT_LINE('Tests pour Procedure_1');
    Test_Procedure_1();
        DBMS_OUTPUT.PUT_LINE('------------------');
    DBMS_OUTPUT.PUT_LINE('Tests pour Procedure_2');
    Test_Procedure_2();
END;