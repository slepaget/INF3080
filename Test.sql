--Requête 2.1
SELECT nom, prenom, telephone 
FROM Client
WHERE no_client IN (
    SELECT no_client FROM Commande);

--Requête 2.2
SELECT no_commande, date_commande, nom, prenom, telephone
FROM Commande, Client
WHERE Commande.no_client = Client.no_client AND date_commande BETWEEN '23-02-02' 
AND '23-03-10'

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

--Requête 2.4

--a)
SELECT Produit.no_produit, Produit.description, Fournisseur.raison_sociale, Fournisseur.telephone
FROM Produit, Fournisseur, Approvisionnement
WHERE Approvisionnement.code_fournisseur = Fournisseur.code_fournisseur AND Approvisionnement.no_produit = Produit.no_produit

--b)
--A revoir***
SELECT Produit.description, COUNT(DISTINCT Produit.code_fournisseur_prioritaire) AS nombre_fournisseurs
FROM Produit, Approvisionnement
WHERE Produit.no_produit = Approvisionnement.no_produit
GROUP BY Produit.description
ORDER BY Produit.description ASC;

--Requête 2.5
SELECT 
produit.no_produit, produit.description, produit.quantite_stock,
prix_produit.prix_unitaire, prix_produit.date_envigueur
FROM Produit
INNER JOIN Prix_Produit ON produit.no_produit = prix_produit.no_produit
ORDER BY prix_produit.date_envigueur ASC;

--Requête 2.6

--a)
SELECT Livraison.no_livraison, date_livraison, date_paiement, montant, type_paiement
FROM Livraison, Paiement
WHERE Livraison.no_livraison = Paiement.no_livraison AND Livraison.no_livraison = 50021

--b)
SELECT Livraison.no_livraison, SUM(Paiement.montant) AS total_paiements, COUNT(Paiement.id_paiement) AS nombre_paiements
FROM Livraison, Paiement
WHERE Livraison.no_livraison = Paiement.no_livraison
GROUP BY Livraison.no_livraison
ORDER BY Livraison.no_livraison;

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
SELECT MAX(quantite_cmd) AS max_items
FROM Ligne_commande, (
    SELECT Commande.no_commande, COUNT(Ligne_commande.no_produit) AS nbr_items
    FROM Commande, Ligne_commande
    GROUP BY Commande.no_commande
);

--b)
SELECT Ligne_commande.no_commande
FROM Ligne_commande
WHERE Ligne_commande.quantite_cmd = (
    SELECT MAX(quantite_cmd) AS max_items
    FROM Ligne_commande, (
    SELECT Commande.no_commande, COUNT(Ligne_commande.no_produit) AS nbr_items
    FROM Commande, Ligne_commande
    GROUP BY Commande.no_commande
    )
);

--c)
SELECT Commande.no_commande, date_commande, Commande.statut, Client.no_client, nom, prenom
FROM Commande, Client
WHERE Commande.no_client = Client.no_client AND Commande.no_commande = (
    SELECT Ligne_commande.no_commande
    FROM Ligne_commande
    WHERE Ligne_commande.quantite_cmd = (
        SELECT MAX(quantite_cmd) AS max_items
        FROM Ligne_commande, (
            SELECT Commande.no_commande, COUNT(Ligne_commande.no_produit) AS nbr_items
            FROM Commande, Ligne_commande
            GROUP BY Commande.no_commande
            )
        )
);


