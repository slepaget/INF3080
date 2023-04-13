
INSERT INTO Client VALUES(1,'Kunis','MySQLa','1234 Neverland Dr, Wonderland, XYZ 12345','(133) 700-7734','My5QLPass');
INSERT INTO Client VALUES(2,'Carey','MariaDB','9876 Imaginary Rd, Dreamland, ABC 67890','(555) 555-1337','Postgre4me');
INSERT INTO Client VALUES(3,'McBeal','Oracley ','4567 Fictitious Blvd, Fantasy City, DEF 23456','(420) 123-4567','SQLite4u');
INSERT INTO Client VALUES(4,'Stallone','SQLite ', '5555 Mirage Ave, Illusion Town, GHI 78901','(800) 555-3131','Couchb4se');
INSERT INTO Client VALUES(10,'Alain','Boyer', '8888 Phantasm St, Mythical Village, JKL 34567','(888) 555-6969','M4riDBpass');
INSERT INTO Client VALUES(12,'Michel','Tremblay', '9999 Helm St, Imaginary Town, YGD 36543','(999) 666-7070','BigMich123');

INSERT INTO Commande (no_commande, date_commande,no_client)
                     VALUES(10,SYSDATE-1,1);
INSERT INTO Commande VALUES(20,SYSDATE-10,'ANNULEE',2);
INSERT INTO Commande VALUES(30,SYSDATE-100,'FERMEE',3);
INSERT INTO Commande VALUES(35,'2023-02-07','ENCOURS',12);
INSERT INTO Commande VALUES(40,'2023-01-05','ENCOURS',10);
INSERT INTO Commande VALUES(50,'2023-03-10','ENCOURS',10);
INSERT INTO Commande VALUES(300,'2023-03-10','ENCOURS',12);

INSERT INTO Produit (no_produit,description,quantite_stock,quantite_seuil,code_fournisseur_prioritaire) 
                    VALUES(167,'Data Dazzler',500,50,565878531);
INSERT INTO Produit VALUES(953,'Cyber Converter',SYSDATE-5,12,10,458495522);
INSERT INTO Produit VALUES(158,'Schema Sculptor',SYSDATE-50,24,20,348953213);
INSERT INTO Produit VALUES(559,'Backup Booster',SYSDATE-500,48,30,247997724);
INSERT INTO Produit VALUES(001,'Query Quantum',SYSDATE-5000,96,40,154987865);

INSERT INTO Prix_Produit VALUES(123.45,SYSDATE,167);
INSERT INTO Prix_Produit VALUES(46.38,SYSDATE+31,953);
INSERT INTO Prix_Produit VALUES(78.01,SYSDATE+62,158);
INSERT INTO Prix_Produit VALUES(19.95,SYSDATE+365,559);
INSERT INTO Prix_Produit VALUES(999999.99,SYSDATE+999,001);

INSERT INTO Prix_Produit VALUES(100,SYSDATE-7,167);
INSERT INTO Prix_Produit VALUES(200,SYSDATE-7,953);
INSERT INTO Prix_Produit VALUES(300,SYSDATE-7,158);
INSERT INTO Prix_Produit VALUES(29.99,SYSDATE-7,559);
INSERT INTO Prix_Produit VALUES(85.96,SYSDATE-7,001);

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
INSERT INTO Approvisionnement VALUES(001,6513489,10,SYSDATE-300,'LIVRE');

INSERT INTO Ligne_Commande VALUES(10,167,2);
INSERT INTO Ligne_Commande VALUES(20,953,4);
INSERT INTO Ligne_Commande VALUES(30,158,6);
INSERT INTO Ligne_Commande VALUES(35,167,6);
INSERT INTO Ligne_Commande VALUES(40,559,8);
INSERT INTO Ligne_Commande VALUES(40,953,6);
INSERT INTO Ligne_Commande VALUES(40,001,2);
INSERT INTO Ligne_Commande VALUES(50,167,3);
INSERT INTO Ligne_Commande VALUES(50,559,5);
INSERT INTO Ligne_Commande VALUES(50,953,1);
INSERT INTO Ligne_Commande VALUES(300,953,2);

INSERT INTO Livraison VALUES(523,SYSDATE+7);
INSERT INTO Livraison VALUES(156,SYSDATE+7);
INSERT INTO Livraison VALUES(852,SYSDATE+7);
INSERT INTO Livraison VALUES(659,SYSDATE+14);
INSERT INTO Livraison VALUES(751,SYSDATE+21);
INSERT INTO Livraison VALUES(50021,SYSDATE+21);

INSERT INTO Ligne_Livraison VALUES(523,10,167,2);
INSERT INTO Ligne_Livraison VALUES(852,20,953,4);
INSERT INTO Ligne_Livraison VALUES(156,30,158,6);
INSERT INTO Ligne_Livraison VALUES(659,40,559,8);
INSERT INTO Ligne_Livraison VALUES(659,40,953,6);
INSERT INTO Ligne_Livraison VALUES(659,40,001,2);
INSERT INTO Ligne_Livraison VALUES(751,50,953,1);
INSERT INTO Ligne_Livraison VALUES(751,50,559,5);
INSERT INTO Ligne_Livraison VALUES(50021,50,953,1);

INSERT INTO Paiement VALUES(1001,SYSDATE,10000.00,'CREDIT', NULL, 'Cash-ualty Bank', '754696587458', 'MASTERCARD',523);
INSERT INTO Paiement VALUES(1002,SYSDATE,20.25,'CASH', NULL, 'CASH PAYMENT Bank', NULL, NULL, 659);
INSERT INTO Paiement VALUES(1003,SYSDATE-56,1337.00,'CHEQUE', '954785631245989631', 'Capital Pains Savings', NULL, NULL, 751);
INSERT INTO Paiement VALUES(1004,'2022/11/15',80085.77,'CASH', NULL, 'Requête 3.5 Bank', NULL, NULL, 751);
INSERT INTO Paiement VALUES(1005,'2022/11/18',80085.77,'CASH', NULL, 'Requête 3.5 Bank', NULL, NULL, 50021);
INSERT INTO Paiement    (date_paiement, montant,    type_paiement,  no_cheque,  nom_banque,         no_carte_credit,    type_carte_credit,  no_livraison) 
    VALUES(             SYSDATE,        1.25,       'CASH',         NULL,       'Requête3.1 Bank',  NULL,               NULL,               751);