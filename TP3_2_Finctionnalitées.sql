--REQUÈTE 2.1

CREATE OR REPLACE FUNCTION QuantiteEnAttente (numProduit Ligne_Commande.no_produit%TYPE, numCommande Commande.no_commande%TYPE)
RETURN NUMBER IS QuantiteEnAttente NUMBER;
BEGIN
SELECT quantite_cmd INTO QuantiteEnAttente
    FROM Commande
    INNER JOIN Ligne_Commande ON commande.no_commande = ligne_commande.no_commande
    WHERE numProduit = Ligne_Commande.no_produit
    AND numCommande = Commande.no_commande
    AND Commande.statut = 'ENCOURS';
    RETURN QuantiteEnAttente;
END;


--REQUÈTE 2.2

create or replace PROCEDURE PreparerLivraison (Vno_client client.no_client%TYPE)
IS 
    Vnom client.nom%TYPE;
    Vprenom client.prenom%TYPE;
    vtelephone client.telephone%TYPE;
    Vadr_client client.adr_client%TYPE;
    --
    maxNo livraison.no_livraison%type;
    --
    cursor c1 IS SELECT Produit.Description, Ligne_Commande.quantite_cmd, produit.quantite_stock, commande.no_commande, commande.date_commande
        FROM Ligne_Commande 
        INNER JOIN Produit ON produit.no_produit = ligne_commande.no_produit
        INNER JOIN Commande ON commande.no_commande = ligne_commande.no_commande
        WHERE commande.no_client = Vno_client
        AND Commande.statut = 'ENCOURS';
    VDescription Produit.Description%TYPE;
    VqteCommande Ligne_Commande.quantite_cmd%TYPE;
    VqteStock produit.quantite_stock%TYPE;
    VnoCommande commande.no_commande%TYPE;
    VdateCommande commande.date_commande%TYPE;

    
BEGIN
    
    SELECT nom, prenom, telephone, adr_client
    INTO Vnom, Vprenom, vtelephone,Vadr_client
    FROM Client

    WHERE client.no_client = Vno_client;
    
    
    DBMS_OUTPUT.PUT_LINE(Vnom || ', ' ||Vprenom);
    DBMS_OUTPUT.PUT_LINE('tel: '||vtelephone);
    DBMS_OUTPUT.PUT_LINE(Vadr_client);
    DBMS_OUTPUT.PUT_LINE('**********');
    
    SELECT MAX(no_livraison)
    INTO maxNo
    FROM LIVRAISON;
    maxNo:=maxNo+1;
    DBMS_OUTPUT.PUT_LINE('Livraison #'|| maxNo);
    DBMS_OUTPUT.PUT_LINE(SYSDATE);
    DBMS_OUTPUT.PUT_LINE('**********');

    OPEN c1;
    LOOP
        FETCH c1 INTO VDescription, VqteCommande, VqteStock, VnoCommande, VdateCommande;
        EXIT WHEN c1%NOTFOUND;
        IF (VqteCommande > VqteStock) THEN 
            RAISE_APPLICATION_ERROR(-20001,'OH NOES');
        END IF;
            DBMS_OUTPUT.PUT_LINE('#'||VnoCommande || ' ' || VdateCommande || ' ' || VDescription ||': '|| VqteCommande);
        END LOOP;
        CLOSE c1;
        
END;


--REQUÈTE 2.3

create or replace PROCEDURE ProduireFacture (Vno_livraison livraison.no_livraison%TYPE)
IS
    Vnom client.nom%TYPE;
    Vprenom client.prenom%TYPE;
    Vadr_client client.adr_client%TYPE;
    Vdate_livraison livraison.date_livraison%TYPE;
    cursor c2 IS 
        SELECT DISTINCT produit.no_produit, produit.description, ligne_livraison.no_commande, ligne_livraison.quantite_livree, prix_produit.prix_unitaire
        FROM Ligne_Livraison
        INNER JOIN Produit ON produit.no_produit = Ligne_Livraison.no_produit
        INNER JOIN (
            SELECT no_produit, MAX(date_envigueur)as maxDate
            FROM PRIX_PRODUIT
            WHERE PRIX_PRODUIT.date_envigueur <= SYSDATE
            GROUP BY no_produit) table_filtree ON Ligne_Livraison.no_produit = table_filtree.no_produit
        INNER JOIN PRIX_PRODUIT ON table_filtree.no_produit = prix_produit.no_produit AND table_filtree.maxdate = prix_produit.date_envigueur
        WHERE no_livraison = Vno_livraison;
    vNoProduit produit.no_produit%TYPE;
    vDescription produit.description%TYPE;
    vNoCommande commande.no_commande%TYPE;
    vQteLivree ligne_livraison.quantite_livree%TYPE;
    vPrixUnitaire prix_produit.prix_unitaire%TYPE;
    --
    MontantAvantTaxe NUMBER(10,2);
    MontantTaxes NUMBER(10,2);
    MontantTotal NUMBER(10,2);
    MontantLigne NUMBER(10,2);

BEGIN
    MontantAvantTaxe:=0;
    MontantTaxes:=0;
    MontantTotal:=0;
    MontantLigne:=0;

    SELECT nom, prenom, adr_client
    INTO Vnom, Vprenom,Vadr_client
    FROM Livraison
    INNER JOIN Ligne_Livraison ON livraison.no_livraison = ligne_livraison.no_livraison
    INNER JOIN Commande On commande.no_commande = ligne_livraison.no_commande
    INNER JOIN CLIENT ON client.no_client = commande.no_client
    WHERE livraison.no_livraison = Vno_livraison;

    SELECT date_livraison
    INTO Vdate_livraison
    FROM Livraison
    WHERE livraison.no_livraison = Vno_livraison;

    DBMS_OUTPUT.PUT_LINE(Vnom||', '||Vprenom);
    DBMS_OUTPUT.PUT_LINE(Vadr_client);
    DBMS_OUTPUT.PUT_LINE('Livraison# '||Vno_livraison ||' en date du: '||Vdate_livraison);
    DBMS_OUTPUT.PUT_LINE('Facture#   '||Vno_livraison );
    DBMS_OUTPUT.PUT_LINE('-----------------------');
    OPEN c2;
    LOOP
        FETCH c2 INTO vNoProduit, vDescription, vNoCommande, vQteLivree, vPrixUnitaire;
        EXIT WHEN c2%NOTFOUND;
        MontantLigne:= vQteLivree * vPrixUnitaire;
        MontantAvantTaxe:= MontantAvantTaxe + (MontantLigne);
        DBMS_OUTPUT.PUT_LINE('#'||vNoProduit || ' ' || vDescription || ' ' || vNoCommande ||': '|| vQteLivree || ' ' ||vPrixUnitaire || '$ ' || MontantLigne || '$');
    END LOOP;
    CLOSE c2;
    DBMS_OUTPUT.PUT_LINE('Sous-total: '||MontantAvantTaxe);
    MontantTaxes:= MontantAvantTaxe*0.15;
    DBMS_OUTPUT.PUT_LINE('Taxes:      '||MontantTaxes);
    MontantTotal:=MontantTaxes + MontantAvantTaxe;
    DBMS_OUTPUT.PUT_LINE('-----------------------');
    DBMS_OUTPUT.PUT_LINE('Total:      '||MontantTotal);

END;
