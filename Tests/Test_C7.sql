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

BEGIN
    Test_C7();
END;