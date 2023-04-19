drop table 	CLIENT	cascade constraints;
drop table 	COMMANDE	cascade constraints;
drop table 	PRODUIT	cascade constraints;
drop table 	PRIX_PRODUIT	cascade constraints;
drop table 	FOURNISSEUR	cascade constraints;
drop table 	LIGNE_COMMANDE	cascade constraints;
drop table 	LIVRAISON	cascade constraints;
drop table 	LIGNE_LIVRAISON	cascade constraints;
drop table 	PAIEMENT	cascade constraints;
drop table 	APPROVISIONNEMENT cascade constraints;
drop function QuantiteEnAttente;
drop procedure PreparerLivraison;
drop procedure ProduireFacture; 
--drop view V_commande_item;

CREATE TABLE Client (
    no_client INT,
    nom VARCHAR(30),
    prenom VARCHAR(30),
    adr_client VARCHAR(60),
    telephone VARCHAR(15),
    mot_de_passe VARCHAR(10),
    PRIMARY KEY (no_client)
);

CREATE TABLE Commande (
    no_commande INT,
    date_commande DATE,
    statut VARCHAR(7) DEFAULT 'ENCOURS' CONSTRAINT chk_statut CHECK (statut IN ('ENCOURS', 'ANNULE', 'FERMEE')),
    no_client INT, 
    PRIMARY KEY (no_commande),
    FOREIGN KEY (no_client) REFERENCES Client
);

CREATE TABLE Produit(
    no_produit INT,
    description VARCHAR(50),
    date_inscription DATE default SYSDATE,
    quantite_stock INT DEFAULT 0
        check (quantite_stock >= 0),
    quantite_seuil INT DEFAULT 0 
        check (quantite_seuil >= 0),
    code_fournisseur_prioritaire INT,
    PRIMARY KEY (no_produit)
);

CREATE TABLE Prix_Produit(
    prix_unitaire NUMBER(8,2),
    date_envigueur DATE,
    no_produit INT,
    PRIMARY KEY (prix_unitaire, date_envigueur, no_produit),
    FOREIGN KEY (no_produit) REFERENCES Produit
);

CREATE TABLE Fournisseur(
    code_fournisseur INT,
    raison_sociale VARCHAR(50),
    adr_fournisseur VARCHAR(60),
    telephone VARCHAR(15),
    mot_de_passe VARCHAR(10),
    PRIMARY KEY (code_fournisseur)
);

CREATE TABLE Approvisionnement(
    no_produit INT,
    code_fournisseur INT,
    quantite_approvis INT
        check (quantite_approvis >= 0),
    date_cmd_approvis DATE,
    statut VARCHAR(10) DEFAULT 'LIVRE' CONSTRAINT chk_statut2 CHECK (statut IN ('ENCOURS', 'ANNULE', 'LIVRE')),
    PRIMARY KEY (no_produit, code_fournisseur),
    FOREIGN KEY (no_produit) REFERENCES Produit,
    FOREIGN KEY (code_fournisseur) REFERENCES Fournisseur
);

CREATE TABLE Ligne_Commande(
    no_commande INT,
    no_produit INT,
    quantite_cmd INT
        check (quantite_cmd >= 0),
    PRIMARY KEY (no_commande, no_produit),
    FOREIGN KEY (no_commande) REFERENCES Commande,
    FOREIGN KEY (no_produit) REFERENCES Produit
);

CREATE TABLE Livraison(
    no_livraison INT,
    date_livraison DATE,
    PRIMARY KEY (no_livraison)
);

CREATE TABLE Ligne_Livraison(
    no_livraison INT,
    no_commande INT,
    no_produit INT,
    quantite_livree INT
        check (quantite_livree >= 0),
    PRIMARY KEY (no_livraison, no_commande, no_produit),
    FOREIGN KEY (no_livraison) REFERENCES Livraison,
    FOREIGN KEY (no_commande, no_produit) REFERENCES Ligne_Commande
);

CREATE TABLE Paiement(
    id_paiement INT,
    date_paiement DATE,
    montant NUMBER(8,2),
    type_paiement VARCHAR(20) CONSTRAINT chk_type_paiement CHECK (type_paiement IN ('CASH', 'CHEQUE', 'CREDIT')),
    no_cheque INT NULL,
    nom_banque VARCHAR(50) NULL,
    no_carte_credit VARCHAR(16) NULL,
    type_carte_credit VARCHAR(20) CONSTRAINT chk_type_carte_credit CHECK (type_carte_credit IN ('VISA', 'MASTERCARD', 'AMEX')),
    no_livraison INT,
    PRIMARY KEY (id_paiement),
    FOREIGN KEY (no_livraison) REFERENCES Livraison
);

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
/
create or replace TYPE array IS TABLE OF NUMBER