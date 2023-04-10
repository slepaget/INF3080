
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

INSERT INTO Paiement (date_paiement,montant,type_paiement,no_cheque,nom_banque,no_carte_credit,type_carte_credit,no_livraison) 
    VALUES(SYSDATE,1.25,'CASH', NULL, 'Requête3.1 Bank', NULL, NULL,751);

SELECT * FROM Paiement WHERE nom_banque='Requête3.1 Bank'


--Requête 3.2

--a)
CREATE VIEW V_commande_item AS
SELECT nom, prenom, Commande.no_commande, Ligne_commande.quantite_cmd, Prix_produit.prix_unitaire, Commande.statut
FROM Commande, Prix_produit, Client, Ligne_commande, Produit
WHERE Commande.no_client = Client.no_client AND Commande.no_commande = Ligne_commande.no_commande AND Ligne_commande.no_produit = Produit.no_produit AND Produit.no_produit = Prix_produit.no_produit;

SELECT * 
FROM V_commande_item;

--Modification de la vue dans laquelle on ajoute une colonne pour avoir le prix total de l'item
CREATE OR REPLACE VIEW V_commande_item AS
SELECT nom, prenom, Commande.no_commande, Ligne_commande.quantite_cmd, Prix_produit.prix_unitaire, Commande.statut, (Ligne_commande.quantite_cmd * prix_produit.prix_unitaire) AS Prix_Total_item
FROM Commande, Prix_produit, Client, Ligne_commande, Produit
WHERE Commande.no_client = Client.no_client AND Commande.no_commande = Ligne_commande.no_commande AND Ligne_commande.no_produit = Produit.no_produit AND Produit.no_produit = Prix_produit.no_produit;


--b)
SELECT * 
FROM V_commande_item
WHERE nom = 'Michel' AND prenom = 'Tremblay'

--c)
SELECT * 
FROM V_commande_item
WHERE no_commande = 300


--d)
SELECT SUM(Prix_Total_item) AS Montant_total_commande
FROM V_commande_item
WHERE no_commande = 300;

--Requête 3.3
SELECT DISTINCT statut, COUNT(*) as count FROM Commande
GROUP BY statut

--Requête 3.4

SELECT Commande.no_commande, COUNT(Ligne_commande.no_produit) AS nbr_items
FROM Commande, Ligne_commande
WHERE Commande.no_commande = Ligne_commande.no_commande
GROUP BY Commande.no_commande
ORDER BY nbr_items DESC;

SELECT Commande.no_commande, COUNT(Ligne_commande.no_produit) AS nbr_items
FROM Commande, Ligne_commande
WHERE Commande.no_commande = Ligne_commande.no_commande
GROUP BY Commande.no_commande
HAVING COUNT(Ligne_commande.no_produit) > 1;


--Requête 3.5
SELECT SUM(montant) from Paiement 
WHERE type_paiement = 'CASH'
AND date_paiement BETWEEN '2022/11/01' AND '2022/11/30'

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