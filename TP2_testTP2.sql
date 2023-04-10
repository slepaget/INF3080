--Requête 2.1
SELECT nom, prenom, telephone 
FROM Client
WHERE no_client IN (
    SELECT no_client FROM Commande);

/*
NOM                            PRENOM                         TELEPHONE      
------------------------------ ------------------------------ ---------------
Kunis                          MySQLa                         (133) 700-7734 
Carey                          MariaDB                        (555) 555-1337 
McBeal                         Oracley                        (420) 123-4567 
Michel                         Tremblay                       (999) 666-7070 
Alain                          Boyer                          (888) 555-6969 
*/

--Requête 2.2
SELECT no_commande, date_commande, nom, prenom, telephone
FROM Commande, Client
WHERE Commande.no_client = Client.no_client AND date_commande BETWEEN '23-02-02' 
AND '23-03-10'

/*
NO_COMMANDE DATE_COM NOM                            PRENOM                         TELEPHONE      
----------- -------- ------------------------------ ------------------------------ ---------------
         35 23-02-07 Michel                         Tremblay                       (999) 666-7070 
         50 23-03-10 Alain                          Boyer                          (888) 555-6969 
        300 23-03-10 Michel                         Tremblay                       (999) 666-7070 
*/

--Requête 2.3

SELECT 
Commande.no_commande, Commande.date_commande, 
produit.no_produit, produit.description,
ligne_commande.quantite_cmd
FROM Commande
INNER JOIN Ligne_Commande ON commande.no_commande = ligne_commande.no_commande
INNER JOIN Produit ON ligne_commande.no_produit = produit.no_produit
WHERE statut = 'ENCOURS' 
AND no_client IN (
    SELECT no_client 
    FROM Client 
    WHERE nom='Alain' AND prenom='Boyer')
ORDER BY commande.no_commande ASC;

/*
NO_COMMANDE DATE_COM NO_PRODUIT DESCRIPTION                                        QUANTITE_CMD
----------- -------- ---------- -------------------------------------------------- ------------
         40 23-01-05        953 Cyber Converter                                               6
         40 23-01-05        559 Backup Booster                                                8
         40 23-01-05          1 Query Quantum                                                 2
         50 23-03-10        167 Data Dazzler                                                  3
         50 23-03-10        953 Cyber Converter                                               1
         50 23-03-10        559 Backup Booster                                                5

6 rows selected. 
*/

--Requête 2.4

--a)
SELECT Produit.no_produit, Produit.description, Fournisseur.raison_sociale, Fournisseur.telephone
FROM Produit, Fournisseur, Approvisionnement
WHERE Approvisionnement.code_fournisseur = Fournisseur.code_fournisseur AND Approvisionnement.no_produit = Produit.no_produit

/*
NO_PRODUIT DESCRIPTION                                        RAISON_SOCIALE                                     TELEPHONE      
---------- -------------------------------------------------- -------------------------------------------------- ---------------
       167 Data Dazzler                                       GitGoing                                           (345) 678-9012 
       953 Cyber Converter                                    JavaJive                                           (234) 567-8901 
       158 Schema Sculptor                                    CodeBrew                                           (456) 789-0123 
       559 Backup Booster                                     App-etizer                                         (567) 890-1234 
         1 Query Quantum                                      App-etizer                                         (567) 890-1234 
         1 Query Quantum                                      ClickBait                                          (678) 901-2345 

6 rows selected. 
*/

--b)
SELECT Produit.description, COUNT(DISTINCT Approvisionnement.code_fournisseur) AS nombre_fournisseurs
FROM Produit, Approvisionnement
WHERE Produit.no_produit = Approvisionnement.no_produit
GROUP BY Produit.description
ORDER BY Produit.description ASC;

/*
DESCRIPTION                                        NOMBRE_FOURNISSEURS
-------------------------------------------------- -------------------
Backup Booster                                                       1
Cyber Converter                                                      1
Data Dazzler                                                         1
Query Quantum                                                        2
Schema Sculptor                                                      1
*/

--Requête 2.5
SELECT 
produit.no_produit, produit.description, produit.quantite_stock,
prix_produit.prix_unitaire, prix_produit.date_envigueur
FROM Produit
INNER JOIN Prix_Produit ON produit.no_produit = prix_produit.no_produit
ORDER BY prix_produit.date_envigueur ASC;

/*
NO_PRODUIT DESCRIPTION                                        QUANTITE_STOCK PRIX_UNITAIRE DATE_ENV
---------- -------------------------------------------------- -------------- ------------- --------
       167 Data Dazzler                                                  500        123.45 23-03-29
       953 Cyber Converter                                                12         46.38 23-04-29
       158 Schema Sculptor                                                24         78.01 23-05-30
       559 Backup Booster                                                 48         19.95 24-03-28
         1 Query Quantum                                                  96     999999.99 25-12-22
*/

--Requête 2.6

--a)
SELECT Livraison.no_livraison, date_livraison, date_paiement, montant, type_paiement
FROM Livraison, Paiement
WHERE Livraison.no_livraison = Paiement.no_livraison AND Livraison.no_livraison = 50021

/*
NO_LIVRAISON DATE_LIV DATE_PAI    MONTANT TYPE_PAIEMENT       
------------ -------- -------- ---------- --------------------
       50021 23-04-19 22-11-18   80085.77 CASH                
*/

--b)
SELECT Livraison.no_livraison, SUM(Paiement.montant) AS total_paiements, COUNT(Paiement.id_paiement) AS nombre_paiements
FROM Livraison, Paiement
WHERE Livraison.no_livraison = Paiement.no_livraison
GROUP BY Livraison.no_livraison
ORDER BY Livraison.no_livraison;

/*
NO_LIVRAISON TOTAL_PAIEMENTS NOMBRE_PAIEMENTS
------------ --------------- ----------------
         523           10000                1
         659           20.25                1
         751        81422.77                2
       50021        80085.77                1
*/

--Requête 3.1
CREATE OR REPLACE TRIGGER R31_IdPaiement
BEFORE INSERT ON Paiement
FOR EACH ROW
DECLARE 
  id INT;
BEGIN
    SELECT MAX(id_paiement) INTO id FROM Paiement;
    IF id IS NULL THEN
        id:=1000;
    ELSE
        id := id +1;
    END IF;
    :NEW.id_paiement := id;
END;

/*
Trigger R31_IDPAIEMENT compiled
*/

INSERT INTO Paiement (date_paiement,montant,type_paiement,no_cheque,nom_banque,no_carte_credit,type_carte_credit,no_livraison) 
    VALUES(SYSDATE,1.25,'CASH', NULL, 'Requête3.1 Bank', NULL, NULL,751);

SELECT * FROM Paiement WHERE nom_banque='Requête3.1 Bank'

/*
ID_PAIEMENT DATE_PAI    MONTANT TYPE_PAIEMENT         NO_CHEQUE NOM_BANQUE                                         NO_CARTE_CREDIT  TYPE_CARTE_CREDIT    NO_LIVRAISON
----------- -------- ---------- -------------------- ---------- -------------------------------------------------- ---------------- -------------------- ------------
       1006 23-03-29       1.25 CASH                            Requête3.1 Bank                                                                                   751
*/


--Requête 3.2

--a)
CREATE VIEW V_commande_item AS
SELECT nom, prenom, Commande.no_commande, Ligne_commande.quantite_cmd, Prix_produit.prix_unitaire, Commande.statut
FROM Commande, Prix_produit, Client, Ligne_commande, Produit
WHERE Commande.no_client = Client.no_client AND Commande.no_commande = Ligne_commande.no_commande AND Ligne_commande.no_produit = Produit.no_produit AND Produit.no_produit = Prix_produit.no_produit;

SELECT * 
FROM V_commande_item;

/*
NOM                            PRENOM                         NO_COMMANDE QUANTITE_CMD PRIX_UNITAIRE STATUT 
------------------------------ ------------------------------ ----------- ------------ ------------- -------
Alain                          Boyer                                   50            5         19.95 ENCOURS
Alain                          Boyer                                   40            8         19.95 ENCOURS
Michel                         Tremblay                               300            2         46.38 ENCOURS
Alain                          Boyer                                   50            1         46.38 ENCOURS
Alain                          Boyer                                   40            6         46.38 ENCOURS
Carey                          MariaDB                                 20            4         46.38 ANNULEE
McBeal                         Oracley                                 30            6         78.01 FERMEE 
Alain                          Boyer                                   50            3        123.45 ENCOURS
Michel                         Tremblay                                35            6        123.45 ENCOURS
Kunis                          MySQLa                                  10            2        123.45 ENCOURS
Alain                          Boyer                                   40            2     999999.99 ENCOURS

11 rows selected. 
*/

--Modification de la vue dans laquelle on ajoute une colonne pour avoir le prix total de l'item
CREATE OR REPLACE VIEW V_commande_item AS
SELECT nom, prenom, Commande.no_commande, Ligne_commande.quantite_cmd, Prix_produit.prix_unitaire, Commande.statut, (Ligne_commande.quantite_cmd * prix_produit.prix_unitaire) AS Prix_Total_item
FROM Commande, Prix_produit, Client, Ligne_commande, Produit
WHERE Commande.no_client = Client.no_client AND Commande.no_commande = Ligne_commande.no_commande AND Ligne_commande.no_produit = Produit.no_produit AND Produit.no_produit = Prix_produit.no_produit;


--b)
SELECT * 
FROM V_commande_item
WHERE nom = 'Michel' AND prenom = 'Tremblay'

/*
NOM                            PRENOM                         NO_COMMANDE QUANTITE_CMD PRIX_UNITAIRE STATUT  PRIX_TOTAL_ITEM
------------------------------ ------------------------------ ----------- ------------ ------------- ------- ---------------
Michel                         Tremblay                                35            6        123.45 ENCOURS           740.7
Michel                         Tremblay                               300            2         46.38 ENCOURS           92.76
*/

--c)
SELECT * 
FROM V_commande_item
WHERE no_commande = 300

/*
NOM                            PRENOM                         NO_COMMANDE QUANTITE_CMD PRIX_UNITAIRE STATUT  PRIX_TOTAL_ITEM
------------------------------ ------------------------------ ----------- ------------ ------------- ------- ---------------
Michel                         Tremblay                               300            2         46.38 ENCOURS           92.76
*/

--d)
SELECT SUM(Prix_Total_item) AS Montant_total_commande
FROM V_commande_item
WHERE no_commande = 300;

/*
MONTANT_TOTAL_COMMANDE
----------------------
                 92.76
*/

--Requête 3.3
SELECT DISTINCT statut, COUNT(*) as count FROM Commande
GROUP BY statut

/*
STATUT       COUNT
------- ----------
ANNULEE          1
ENCOURS          5
FERMEE           1
*/

--Requête 3.4

SELECT Commande.no_commande, COUNT(Ligne_commande.no_produit) AS nbr_items
FROM Commande, Ligne_commande
WHERE Commande.no_commande = Ligne_commande.no_commande
GROUP BY Commande.no_commande
ORDER BY nbr_items DESC;

/*
NO_COMMANDE  NBR_ITEMS
----------- ----------
         50          3
         40          3
         30          1
        300          1
         20          1
         10          1
         35          1

7 rows selected. 
*/

SELECT Commande.no_commande, COUNT(Ligne_commande.no_produit) AS nbr_items
FROM Commande, Ligne_commande
WHERE Commande.no_commande = Ligne_commande.no_commande
GROUP BY Commande.no_commande
HAVING COUNT(Ligne_commande.no_produit) > 1;

/*
NO_COMMANDE  NBR_ITEMS
----------- ----------
         40          3
         50          3
*/


--Requête 3.5
SELECT SUM(montant) from Paiement 
WHERE type_paiement = 'CASH'
AND date_paiement BETWEEN '2022/11/01' AND '2022/11/30'

/*
SUM(MONTANT)
------------
   160171.54
*/

--Requête 3.6

--a)
SELECT MAX(max_items) as max_items
FROM (
    SELECT no_commande, SUM(quantite_cmd) AS max_items
    FROM (
        SELECT no_commande, quantite_cmd
        FROM Ligne_commande)
    GROUP BY no_commande
);

/*
 MAX_ITEMS
----------
        16
*/

--b)
SELECT no_commande
FROM(
    SELECT no_commande,SUM(quantite_cmd) as qte_max
    FROM (
        SELECT no_commande, quantite_cmd
            FROM Ligne_commande)
    GROUP BY no_commande
    ) 
WHERE qte_max = (SELECT MAX(qte_max) FROM (
    SELECT no_commande,SUM(quantite_cmd) as qte_max
    FROM (
        SELECT no_commande, quantite_cmd
            FROM Ligne_commande)
    GROUP BY no_commande
    ) 
);

/*
NO_COMMANDE
-----------
         40
*/

--c)
SELECT Commande.no_commande, date_commande, Commande.statut, Client.no_client, nom, prenom
FROM Commande, Client
WHERE Commande.no_client = Client.no_client AND Commande.no_commande = (
    SELECT no_commande
    FROM(
        SELECT no_commande,SUM(quantite_cmd) as qte_max
        FROM (
            SELECT no_commande, quantite_cmd
            FROM Ligne_commande)
        GROUP BY no_commande
    ) 
    WHERE qte_max = (SELECT MAX(qte_max) 
    FROM (
        SELECT no_commande,SUM(quantite_cmd) as qte_max
        FROM (
            SELECT no_commande, quantite_cmd
            FROM Ligne_commande)
        GROUP BY no_commande
    ) 
    )
);

/*
NO_COMMANDE DATE_COM STATUT   NO_CLIENT NOM                            PRENOM                        
----------- -------- ------- ---------- ------------------------------ ------------------------------
         40 23-01-05 ENCOURS         10 Alain                          Boyer                         
*/


