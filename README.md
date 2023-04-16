# Manuel d'utilisation de la base de donnée TP3 INF3080

## Développeurs
- Francis Lewis-Dupuis
- Simon Lepage-Trudeau

## Introduction

Ce manuel d'utilisation a pour but de guider l'utilisateur au cours des différentes étapes de création d'une base de données sur `SQL Developper`. Il aura l'opportunité de créer des tables, insérer des données et de faire des tests pour voir si les contraintes sont respectées.

Il est assumer que:
- Vous opérez depuis `SQL Developper v20.2.0.175` minimum
- Vous êtes connecté au server `zeta2` de l'UQAM
- Vous débutez avec une base de données vide ou contenant uniquement des éléments de ce présent document.

Veuillez suivre les procédures suivantes afin d'obtenir le résultat escompté.

## 1. Création des tables

La première étape concerne la création des tables et triggers dans la base de donnée. 
- Copiez l'entièreté du contenu du fichier `1_creation.sql`
- Coller dans l'espace de travail sur `SQL Developper`. 
- Executez le script entier (F5)

Une fois exécuté le programme aura créé les différentes tables de la base de données.

## 2. Insertion des données

La deuxième étape consiste à ajouter les enregistrements à l'aide d'insertion dans les tables de la base de données. 
- Copiez l'entièreté du contenu du fichier `2_Insertion.sql`
- Coller dans l'espace de travail sur `SQL Developper` 
- Executez le script entier (F5)

Une fois exécuté le programme aura créé les différents enregistrements dans les tables de la base de données.

## 3. Création des procedures de tests unitaires

La troisième étape est de créer les procédures de tests qui vérifient la stabilité et la justesse des contraintes, checks et triggers de la base de donnée.

- Copiez l'entièreté du contenu du fichier `3_Tests.sql`
- Coller dans l'espace de travail sur `SQL Developper` 
- Executez le script entier (F5)

Une fois exécuté le programme aura créé les différentes procédures de tests de la base de données.

## 4. Exécution des procedures de tests unitaires

La quatriéme étape est d'exécuter les procédures de tests créées au #3

- Ouvrir la fenêtre `DBMS Output` se trouvant dans l'onglet `View` de `SQL Developper`
  - Nous recommendons de positionner la fenêtre pour avoir le plus de verticallitée possible
- Ouvrir une nouvelle connexion à la base de données `zeta2` à l'aide du bouton `+`
- Copiez l'entièreté du contenu du fichier `4_Tests_Run.sql`
- Coller dans l'espace de travail sur `SQL Developper` 
- Executez le script entier (F5)

Suite à l'exécution, une série de messages seront écrit dans le `DBMS Output`
Une sous-section existe pour:
- les 10 contraintes inscrite lors du TP2 (C1..C10)
- le trigger inscrit au TP2 (Trigger)
- la procédure inscrite au TP3 (Procedure_1)
- les fonctions inscrites au TP3 (Fonction_1..Fonction_2)

Pour chaque section, une série de tests unitaires seront effectués et un message de confirmation sera écrit dans le `DBMS Output`.

Si un test est exécuté avec succès (l'élément testé fonctionne correctement);
le message suivant sera écrit:
`Test #1   PASSED`

Si le test est exécuté avec échec (l'élément testé échoue ou à un comportement anormal);
le message suivant sera écrit:
`Test #4   *****FAILED*****`

Notez que si une procédure/fonction testée ecrit, elle aussi, des données dans le `DBMS Output` ces information apparaitront avant le test qui les a causé.

## Conclusion

En conclusion, la base de donnée contient maintenant des tables, des données et nous savons que les contraintes listées sont fonctionnelles. L'utilisateur est maintenant libre de manipuler la base de données à sa guise.
