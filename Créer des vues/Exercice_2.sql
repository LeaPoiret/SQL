-- Active: 1664375272525@@127.0.0.1@3306@papyrus

--Exercice 2 : vues sur la base papyrus.

--1.v_GlobalCde correspondant à la requête : A partir de la table Ligcom, afficher par code produit, la somme des quantités commandées et le prix total correspondant : 
--on nommera la colonne correspondant à la somme des quantités commandées, QteTot et le prix total, PrixTot.

CREATE VIEW v_GlobalCde
AS
SELECT l.codart, sum(l.qtecde) as QteTot, (l.priuni*qtecde) as PrixTot
FROM ligcom l
GROUP BY l.codart;

SELECT * FROM v_GlobalCde;
DROP VIEW IF EXISTS `v_GlobalCde`;
--2.v_VentesI100 correspondant à la requête : Afficher les ventes dont le code produit est le I100 (affichage de toutes les colonnes de la table Vente).

CREATE VIEW v_VentesI100
AS
SELECT v.delliv, v.qte1, v.prix1, v.qte2, v.prix2, v.qte3, v.prix3, v.numfou, l.codart, l.qtecde 
FROM vente v
LEFT JOIN ligcom l ON v.codart = l.codart
WHERE v.codart = 'I100';

SELECT * FROM `v_VentesI100`;

DROP VIEW IF EXISTS `v_VentesI100`;
--3.A partir de la vue précédente, créez v_VentesI100Grobrigan remontant toutes les ventes concernant le produit I100 et le fournisseur 00120.

CREATE VIEW v_VentesI100Grobrigan
AS
SELECT v.delliv, v.qte1, v.prix1, v.qte2, v.prix2, v.qte3, v.prix3, v.numfou, l.codart, l.qtecde
FROM vente v
LEFT JOIN ligcom l ON v.codart = l.codart
WHERE v.codart = 'I100' AND v.numfou = 00120;

SELECT * FROM `v_VentesI100Grobrigan`;

DROP VIEW IF EXISTS `v_VentesI100Grobrigan`;