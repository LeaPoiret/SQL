-- Active: 1664375272525@@127.0.0.1@3306@papyrus
--1. Quelles sont les commandes du fournisseur 09120 ?

SELECT f.numfou, e.numcom, l.numlig, l.qtecde, p.codart
FROM fournis f
JOIN entcom e ON f.numfou = e.numfou
JOIN ligcom l ON e.numcom = l.numcom
JOIN produit p ON p.codart = l.codart
WHERE f.numfou = 09120;

select * 
from entcom 
where numfou=09120;

--2. Afficher le code des fournisseurs pour lesquels des commandes ont été passées.

SELECT distinct numfou
FROM entcom;
--3. Afficher le nombre de commandes fournisseurs passées, et le nombre de fournisseur concernés.

SELECT count(numcom), count(distinct numfou)
FROM entcom;

--4. Editer les produits ayant un stock inférieur ou égal au stock d'alerte et dont la quantité annuelle est inférieur est inférieure à 1000
--(informations à fournir : n° produit, libellé produit, stock, stock actuel d'alerte, quantité annuelle).

SELECT *
FROM produit
WHERE qteann<1000
and stkphy<=stkale;

--5. Quels sont les fournisseurs situés dans les départements 75 78 92 77 ? L’affichage (département, nom fournisseur) sera effectué par
--département décroissant, puis par ordre alphabétique.

SELECT posfou, nomfou
FROM fournis
WHERE posfou LIKE '75%' or posfou LIKE '77%' or posfou LIKE '78%' or posfou LIKE '92%'
ORDER BY posfou DESC, nomfou;

SELECT posfou, nomfou 
FROM fournis
WHERE SUBSTRING(posfou, 1, 2) IN('75', '77', '78', '92')
ORDER BY posfou DESC, nomfou;

--6. Quelles sont les commandes passées au mois de mars et avril ?
SELECT numcom, datcom
FROM entcom
WHERE month(datcom) between 3 and 4;

--7. Quelles sont les commandes du jour qui ont des observations particulières ? (Affichage numéro de commande, date de commande).
SELECT numcom, datcom, obscom 
FROM entcom
WHERE obscom is not NULL;

SELECT MAX(datcom) 
FROM entcom;

--8. Lister le total de chaque commande par total décroissant (Affichage numéro de commande et total).

SELECT numcom, sum(qtecde*priuni) as total
FROM ligcom
GROUP BY numcom
ORDER BY total DESC;

--9. Lister les commandes dont le total est supérieur à 10 000€ ; on exclura dans le calcul du total les articles commandés en quantité supérieure
--ou égale à 1000. (Affichage numéro de commande et total).

SELECT numcom, sum(qtecde*priuni) as total
FROM ligcom
WHERE qtecde<=1000
GROUP BY numcom
HAVING total>10000
ORDER BY total DESC;

--10. Lister les commandes par nom fournisseur (Afficher le nom du fournisseur, le numéro de commande et la date).

SELECT f.nomfou, e.numcom, e.datcom
FROM entcom e
JOIN fournis f on e.numfou=f.numfou
ORDER BY f.nomfou;

--11. Sortir les produits des commandes ayant le mot "urgent' en observation? (Afficher le numéro de commande, le nom du fournisseur, le libellé du
--produit et le sous total = quantité commandée * Prix unitaire).
select e.numcom, f.nomfou, p.libart, l.qtecde*l.priuni
from ligcom l
join produit p on p.codart=l.codart
join entcom e on e.numcom=l.numcom
join fournis f on f.numfou=e.numfou
where e.obscom like '%urgent%'; 
--12. Coder de 2 manières différentes la requête suivante : Lister le nom des fournisseurs susceptibles de livrer au moins un article.
select distinct f.nomfou
from fournis f 
join entcom e on f.numfou=e.numfou
join ligcom l on e.numcom=l.numcom
where l.qteliv>0;


select nomfou from fournis where numfou in (
    select numfou from entcom where numcom in (
        select numcom from ligcom where qteliv>0
    )
)
;
--13. Coder de 2 manières différentes la requête suivante Lister les commandes (Numéro et date) dont le fournisseur est celui de
--la commande 70210 :

SELECT fournis.nomfou, numcom, datcom
FROM entcom
JOIN fournis ON entcom.numfou = fournis.numfou
WHERE fournis.numfou = (SELECT numfou FROM entcom WHERE numcom = 70210);

SELECT fournis.nomfou, numcom, datcom
FROM fournis
JOIN entcom ON fournis.numfou = entcom.numfou
WHERE fournis.numfou = (SELECT numfou FROM entcom WHERE numcom = 70210);

--14. Dans les articles susceptibles d’être vendus, lister les articles moins chers (basés sur Prix1) que le moins cher des rubans (article dont le
--premier caractère commence par R). On affichera le libellé de l’article et prix1.

SELECT libart, prix1
FROM produit
JOIN vente ON produit.codart = vente.codart
WHERE prix1 < (SELECT MIN(prix1) FROM vente WHERE LEFT(codart, 1) = 'R' );

--15. Editer la liste des fournisseurs susceptibles de livrer les produits dont le stock est inférieur ou égal à 150 % du stock d'alerte. La liste est
--triée par produit puis fournisseur.
SELECT nomfou, libart, (qtecde - qteliv) as 'Reste a livré'
FROM fournis
JOIN entcom ON fournis.numfou = entcom.numfou
JOIN ligcom ON entcom.numcom = ligcom.numcom
JOIN produit ON ligcom.codart = produit.codart
WHERE qteliv < qtecde AND stkphy <= (stkale * 1.5)
ORDER BY libart ASC, nomfou ASC;

--16. Éditer la liste des fournisseurs susceptibles de livrer les produit dont le stock est inférieur ou égal à 150 % du stock d'alerte et un délai de
--livraison d'au plus 30 jours. La liste est triée par fournisseur puis produit.
SELECT nomfou, libart, (qtecde - qteliv) as 'Reste a livré'
FROM fournis
JOIN entcom ON fournis.numfou = entcom.numfou
JOIN ligcom ON entcom.numcom = ligcom.numcom
JOIN produit ON ligcom.codart = produit.codart
JOIN vente ON produit.codart = vente.codart
WHERE qteliv < qtecde AND stkphy <= (stkale * 1.5) AND delliv <= 30
ORDER BY libart ASC, nomfou ASC;

--17. Avec le même type de sélection que ci-dessus, sortir un total des stocks par fournisseur trié par total décroissant.
SELECT nomfou, SUM(stkphy) as 'Stock total'
FROM produit
JOIN vente ON produit.codart = vente.codart
JOIN fournis ON vente.numfou = fournis.numfou
GROUP BY nomfou
ORDER BY SUM(stkphy) DESC;

--18. En fin d'année, sortir la liste des produits dont la quantité réellement commandée dépasse 90% de la quantité annuelle prévue.
SELECT libart, qteann, SUM(qtecde)
FROM produit
JOIN ligcom ON produit.codart = ligcom.codart
GROUP BY libart
HAVING SUM(qtecde) > (qteann * 1.9);

--19. Calculer le chiffre d'affaire par fournisseur pour l'année 93 sachant que les prix indiqués sont hors taxes et que le taux de TVA est 20%.

SELECT nomfou, (SUM(qtecde * prix1) * 1.2) as 'Prix TTC'
FROM fournis
JOIN vente ON fournis.numfou = vente.numfou
JOIN produit ON vente.codart = produit.codart
JOIN ligcom ON produit.codart = ligcom.codart
JOIN entcom ON ligcom.numcom = entcom.numcom
WHERE YEAR(datcom) = '1993'
GROUP BY nomfou;

--IV LES BESOINS DE MISE A JOUR

--1.Application d'une augmentation de tarif de 4% pour le prix et de 2% pour le prix2 pour le fournisseur 9180.
UPDATE vente
SET prix1 = prix1*1.04
AND prix2 = prix2*1.02
WHERE numfou = 9180;

--2.Dans la table de vente, mettre à jour le prix2 des articles dont le prix2 est null, en affectant à prix2 la valeur de prix1.
UPDATE vente
SET prix2 
WHERE prix2 IFNULL(prix1);

--3. Mettre à jour le champs obscom en positionnant '*****' pour toutes les commandes dont le fournisseur a un indice de 
--satisfication <5.

--4. Suppression du produit I110.
DELETE FROM produit
WHERE codart = 'I110';
--5.Suppression des entête de commande qui n'ont aucune ligne.


