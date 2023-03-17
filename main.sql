
DROP TABLE Client;

CREATE TABLE Client (
    no_client INT PRIMARY KEY,
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
    statut VARCHAR(7) DEFAULT 'ENCOURS' CONSTRAINT chk_statut CHECK (statut IN ('ENCOURS', 'ANNULEE', 'FERMEE')),
    no_client INT, 
    PRIMARY KEY (no_commande),
    FOREIGN KEY (no_client) REFERENCES Client
)

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
    statut VARCHAR(10) DEFAULT 'LIVRE' CONSTRAINT chk_statut CHECK (statut IN ('ENCOURS', 'ANNULEE', 'LIVRE')),
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
    FOREIGN KEY (no_commande) REFERENCES Ligne_Commande,
    FOREIGN KEY (no_produit) REFERENCES Ligne_Commande
);
