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