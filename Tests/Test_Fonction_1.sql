create or replace PROCEDURE Test_Fonction_1

IS
    R NUMBER;
    len NUMBER;
    RArray ARRAY := ARRAY();
    temp VARCHAR(16);
    result NUMBER;

BEGIN
len:=0;
result:=0;

    ---------- Test des elements existants ----------
    BEGIN
        len := len+1;
        R :=1;
        SELECT
            QuantiteEnAttente(559,40)
        INTO result
        FROM
            dual;
        IF(result = 8)THEN
            R := 0;
        END IF;
    END;
    RArray.EXTEND(1);
    RArray(len):=R;
    ROLLBACK;
    
    ---------- Test des elements non existants ----------
    BEGIN
        len := len+1;
        R :=0;
        SELECT
            QuantiteEnAttente(0,999)
        INTO result
        FROM
            dual;
        IF(result >= 0)THEN
            R := 1;
        END IF;
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
    Test_Fonction_1();
END;