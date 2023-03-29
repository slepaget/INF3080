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
SELECT Produit.description, COUNT(DISTINCT Approvisionnement.code_fournisseur) AS nombre_fournisseurs
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
