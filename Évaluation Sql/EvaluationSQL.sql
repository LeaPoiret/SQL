-- Active: 1664375272525@@127.0.0.1@3306@northwind

--1.Liste des contacts français :

SELECT CompanyName, ContactName, ContactTitle, Phone
FROM customers
WHERE country = 'france'
ORDER BY CompanyName ASC;

--2.Produits vendus par le fournisseur « Exotic Liquids » :

SELECT p.ProductName, p.UnitPrice
FROM products p
JOIN suppliers s ON s.supplierID = p.supplierID
WHERE CompanyName = 'Exotic liquids';

--3.Nombre de produits vendus par les fournisseurs Français dans l’ordre décroissant :

SELECT CompanyName, count(ProductID)
FROM suppliers s
JOIN products p ON p.supplierID = s.SupplierID
WHERE Country = 'france'
GROUP BY CompanyName
ORDER BY count(ProductID) DESC;

--4.Liste des clients Français ayant plus de 10 commandes :

SELECT c.CompanyName, count(o.OrderID) as 'Nombre de commandes'
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'france'
GROUP BY c.CompanyName
HAVING count(o.OrderID) >10;

--5.Liste des clients ayant un chiffre d’affaires > 30.000 :

SELECT c.CompanyName, sum(OD.UnitPrice* OD.Quantity) as CA, c.Country
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
JOIN `order details` OD ON o.OrderID = OD.OrderID
JOIN products p ON OD.ProductID = p.ProductID
GROUP BY c.CompanyName
having sum(OD.UnitPrice* OD.Quantity) >= 30000
ORDER BY CA desc;

--6.– Liste des pays dont les clients ont passé commande de produits fournis par « Exotic Liquids » :

SELECT c.Country
FROM customers c
JOIN orders o ON o.CustomerID = c.CustomerID
JOIN `order details` od ON od.OrderID = o.OrderID
JOIN products p ON p.ProductID = od.ProductID
JOIN suppliers s ON s.SupplierID = p.SupplierID
WHERE s.CompanyName = 'Exotic Liquids'
GROUP BY c.Country
ORDER BY c.Country ASC;

--7.Montant des ventes de 1997 :

SELECT sum(od.UnitPrice* od.Quantity)  as 'Montant des ventes 1997'
FROM orders o
JOIN `order details` od ON od.OrderID = o.OrderID
WHERE YEAR(OrderDate) = 1997;

--8.– Montant des ventes de 1997 mois par mois :

SELECT sum(od.UnitPrice* od.Quantity)  as 'Montant des ventes 1997'
FROM orders o
JOIN `order details` od ON od.OrderID = o.OrderID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY month(o.OrderDate);

--9.Depuis quelle date le client « Du monde entier » n’a plus commandé ?

SELECT max(o.OrderDate) as 'Date de dernière commande'
FROM customers c
JOIN orders o ON o.CustomerID = c.CustomerID
WHERE c.CompanyName = 'Du monde entier'
GROUP BY c.CompanyName
ORDER BY o.OrderDate;

--10.Quel est le délai moyen de livraison en jours ?

SELECT round(avg(datediff(o.ShippedDate,o.OrderDate))) as 'Délai moyen de livraison en jours'
FROM orders o;


--2) Procédures stockées:

--Première requête procédure stockée:
DELIMITER |

CREATE PROCEDURE Dernière_commande_clientDuMondeEntier(IN nom_company varchar(40))
BEGIN

    SELECT max(o.OrderDate) as 'Date de dernière commande'
    FROM customers c
    JOIN orders o ON o.CustomerID = c.CustomerID
    WHERE c.CompanyName = nom_company
    GROUP BY c.CompanyName
    ORDER BY o.OrderDate;

END |
DELIMITER ;

DROP PROCEDURE Dernière_commande_clientDuMondeEntier;
 CALL Dernière_commande_clientDuMondeEntier('Du monde entier');

--Seconde requête procédure stockée:

DELIMITER |
CREATE PROCEDURE Delai_livraison_moyen()
BEGIN

    SELECT round(avg(datediff(o.ShippedDate,o.OrderDate))) as 'Délai moyen de livraison en jours'
    FROM orders o;

END |

DELIMITER ;

DROP PROCEDURE Delai_livraison_moyen;

CALL Delai_livraison_moyen();

--3) Mise en place d'une règle de gestion: 
DROP TRIGGER livraison_pays_identique;
DELIMITER |

 CREATE TRIGGER livraison_pays_identique
AFTER
INSERT
    ON `order details` FOR EACH ROW BEGIN DECLARE pays VARCHAR(15);

SET
    pays = (
        SELECT
            suppliers.SupplierID
        FROM
            orders
            JOIN customers ON orders.CustomerID = customers.CustomerID
            JOIN orderdetails ON orders.OrderID = orderdetails.OrderID
            JOIN products ON orderdetails.ProductID = products.ProductID
            JOIN suppliers ON products.SupplierID = suppliers.SupplierID
        WHERE
            suppliers.Country = customers.Country
            AND `order details`.ProductID = NEW.ProductID
            AND `order details`.OrderID = NEW.OrderID
    );

if suppliers.Country != customers.Country THEN SIGNAL SQLSTATE '40000'
SET
    MESSAGE_TEXT = 'Le pays n\'est pas similaire !';

END if;

END; 

DELIMITER;

use northwind;