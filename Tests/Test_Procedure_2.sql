create or replace PROCEDURE Test_Procedure_2

IS
    R NUMBER;
    len NUMBER;
    RArray ARRAY := ARRAY();
    temp VARCHAR(16);
    result NUMBER;

BEGIN
len:=0;
result:=0;

    ---------- Test avec une livraison existante ----------
    BEGIN
        len := len+1;
        R :=0;
        BEGIN
            ProduireFacture(50021);
        END;
    EXCEPTION
        WHEN OTHERS THEN
            R := 1;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec une livraison non existante ----------
    BEGIN
        len := len+1;
        R :=1;
        BEGIN
            ProduireFacture(999);
        END;
    EXCEPTION
        WHEN OTHERS THEN
            R := 0;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;

    ---------- Test avec un string ----------
    BEGIN
        len := len+1;
        R :=1;
        BEGIN
            ProduireFacture('Allo');
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
            ProduireFacture('');
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

BEGIN
    Test_Procedure_2();
END;