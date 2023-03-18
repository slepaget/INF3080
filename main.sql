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
    statut VARCHAR(7) DEFAULT 'ENCOURS' CONSTRAINT chk_statut CHECK (statut IN ('ENCOURS', 'ANNULEE', 'FERMEE')),
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
    statut VARCHAR(10) DEFAULT 'LIVRE' CONSTRAINT chk_statut2 CHECK (statut IN ('ENCOURS', 'ANNULEE', 'LIVRE')),
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

INSERT INTO Client VALUES(1,'Kunis','MySQLa','1234 Neverland Dr, Wonderland, XYZ 12345','(133) 700-7734','My5QLPass');
INSERT INTO Client VALUES(2,'Carey','MariaDB','9876 Imaginary Rd, Dreamland, ABC 67890','(555) 555-1337','Postgre4me');
INSERT INTO Client VALUES(3,'McBeal','Oracley ','4567 Fictitious Blvd, Fantasy City, DEF 23456','(420) 123-4567','SQLite4u');
INSERT INTO Client VALUES(4,'Stallone','SQLite ', '5555 Mirage Ave, Illusion Town, GHI 78901','(800) 555-3131','Couchb4se');
INSERT INTO Client VALUES(10,'Alain','Boyer ', '8888 Phantasm St, Mythical Village, JKL 34567','(888) 555-6969','M4riDBpass');

INSERT INTO Commande (no_commande, date_commande,no_client)
                     VALUES(10,SYSDATE-1,1);
INSERT INTO Commande VALUES(20,SYSDATE-10,'ENCOURS',2);
INSERT INTO Commande VALUES(30,SYSDATE-100,'ENCOURS',3);
INSERT INTO Commande VALUES(40,'2023-01-05','ANNULEE',10);
INSERT INTO Commande VALUES(50,'2023-03-10','FERMEE',10);

INSERT INTO Produit (no_produit,description,quantite_stock,quantite_seuil,code_fournisseur_prioritaire) 
                    VALUES(167,'Data Dazzler',500,50,565878531);
INSERT INTO Produit VALUES(953,'Cyber Converter',SYSDATE-5,12,10,458495522);
INSERT INTO Produit VALUES(158,'Schema Sculptor',SYSDATE-50,24,20,348953213);
INSERT INTO Produit VALUES(559,'Backup Booster',SYSDATE-500,48,30,247997724);
INSERT INTO Produit VALUES(001,'Query Quantum',SYSDATE-5000,96,40,154987865);

INSERT INTO Prix_Produit VALUES(123.45,SYSDATE+9,167);
INSERT INTO Prix_Produit VALUES(46.38,SYSDATE+18,953);
INSERT INTO Prix_Produit VALUES(78.00,SYSDATE+36,158);
INSERT INTO Prix_Produit VALUES(19.95,SYSDATE+72,559);
INSERT INTO Prix_Produit VALUES(999999.99,SYSDATE+999,001);

INSERT INTO Fournisseur VALUES(9541326,'GitGoing','4756 Quantum Boulevard, Suite 602, Cyberspace City','(345) 678-9012','GitGoing!');
INSERT INTO Fournisseur VALUES(8654139,'JavaJive','123 Roast Road, Suite 205, Espresso Heights','(234) 567-8901','$J@vaJiv3!');
INSERT INTO Fournisseur VALUES(7618996,'CodeBrew','987 Syntax Street, Suite 401, Binaryville','(456) 789-0123','Brew4Code');
INSERT INTO Fournisseur VALUES(6513489,'App-etizer','2468 Byte Boulevard, Suite 301, Silicon Springs','(567) 890-1234','App3tizer');
INSERT INTO Fournisseur VALUES(5126584,'ClickBait','369 Ad Avenue, Suite 102, Pixelville','(678) 901-2345','Click2Bait');

INSERT INTO Approvisionnement (no_produit,code_fournisseur,quantite_approvis,date_cmd_approvis) 
                              VALUES(167,9541326,6,SYSDATE);
INSERT INTO Approvisionnement VALUES(953,8654139,1,SYSDATE-50,'ENCOURS');
INSERT INTO Approvisionnement VALUES(158,7618996,12,SYSDATE-100,'ANNULEE');
INSERT INTO Approvisionnement VALUES(559,6513489,9,SYSDATE-200,'LIVRE');
INSERT INTO Approvisionnement VALUES(001,5126584,7,SYSDATE-500,'LIVRE');

INSERT INTO Ligne_Commande VALUES(10,167,2);
INSERT INTO Ligne_Commande VALUES(20,953,4);
INSERT INTO Ligne_Commande VALUES(30,158,6);
INSERT INTO Ligne_Commande VALUES(40,559,8);
INSERT INTO Ligne_Commande VALUES(40,953,6);
INSERT INTO Ligne_Commande VALUES(40,001,2);
INSERT INTO Ligne_Commande VALUES(50,167,3);
INSERT INTO Ligne_Commande VALUES(50,559,5);
INSERT INTO Ligne_Commande VALUES(50,953,1);

INSERT INTO Livraison VALUES(523,SYSDATE+7);
INSERT INTO Livraison VALUES(659,SYSDATE+14);
INSERT INTO Livraison VALUES(751,SYSDATE+21);

INSERT INTO Ligne_Livraison VALUES(523,10,167,2);
INSERT INTO Ligne_Livraison VALUES(523,20,953,4);
INSERT INTO Ligne_Livraison VALUES(659,30,158,6);
INSERT INTO Ligne_Livraison VALUES(659,40,559,8);
INSERT INTO Ligne_Livraison VALUES(751,50,953,1);

INSERT INTO Paiement VALUES(1,SYSDATE,10000.00,'CREDIT', NULL, 'Cash-ualty Bank', '754696587458', 'MASTERCARD',523);
INSERT INTO Paiement VALUES(2,SYSDATE,20.25,'CASH', NULL, 'CASH PAYMENT Bank', NULL, NULL, 659);
INSERT INTO Paiement VALUES(3,SYSDATE,1337.00,'CHEQUE', '954785631245989631', 'Capital Pains Savings', NULL, NULL, 751);






