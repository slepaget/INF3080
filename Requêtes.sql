--Requête 2.1
SELECT nom, prenom, telephone 
FROM Client
WHERE no_client IN (
    SELECT no_client FROM Commande);

--Requête 2.2

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

--Requête 2.5
SELECT 
produit.no_produit, produit.description, produit.quantite_stock,
prix_produit.prix_unitaire, prix_produit.date_envigueur
FROM Produit
INNER JOIN Prix_Produit ON produit.no_produit = prix_produit.no_produit
ORDER BY prix_produit.date_envigueur ASC;

--Requête 2.6

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

--Requête 3.3
SELECT DISTINCT statut, COUNT(*) as count FROM Commande
GROUP BY statut

--Requête 3.4

--Requête 3.5
SELECT SUM(montant) from Paiement 
WHERE type_paiement = 'CASH'
AND date_paiement BETWEEN '2022/11/01' AND '2022/11/30'

--Requête 3.6
