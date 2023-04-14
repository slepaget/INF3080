create or replace PROCEDURE Test_C1

IS
    R NUMBER;
    len NUMBER;
    RArray ARRAY := ARRAY();
    temp VARCHAR(16);

BEGIN
len:=0;

    --TEST THAT PASSES IF THE COMMAND FAILS
    BEGIN
        len := len+1;
        R :=1;
        INSERT INTO Commande VALUES(99,'2023-02-07','zzzzzz',12);
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    --TEST THAT PASSES IF THE COMMAND EXECUTED CORRECTLY
    BEGIN
        len := len+1;
        R :=0;
        INSERT INTO Commande VALUES(100,'2023-02-07','ENCOURS',12);
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