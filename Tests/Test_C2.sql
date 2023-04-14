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
        INSERT INTO Produit VALUES(953,'Cyber Converter','2023-02-27',12,10,458495522);
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
        INSERT INTO Produit VALUES(953,'Cyber Converter','',12,10,458495522);
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
        INSERT INTO Produit VALUES(953,'Cyber Converter','Allo',12,10,458495522);
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
        INSERT INTO Produit VALUES(953,'Cyber Converter','2023-04-25',12,10,458495522);
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
    Test_C2();
END;