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