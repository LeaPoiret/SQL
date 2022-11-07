-- Active: 1664375272525@@127.0.0.1@3306@papyrus
--Exemple:

--Création d'une procédure stockée avec un SELECT simple:

DELIMITER |
CREATE PROCEDURE listeClient()
BEGIN
    SELECT cli_id, cli_nom, cli_prenom, cli_ville FROM client;
END |

DELIMITER ;

CALL listeClient;

--Délimiteur paramètres:

drop PROCEDURE listeClientParVille;
DELIMITER |

CREATE PROCEDURE listeClientParVille(In ville Varchar(50))

BEGIN
   SELECT cli_id, cli_nom, cli_prenom, cli_ville 
   FROM client
   WHERE cli_ville = ville;
END |

DELIMITER ;

CALL listeClientParVille('LA');

--Procédure stockée avec plusieurs paramètres:

DELIMITER |

CREATE PROCEDURE ajoutClient(
    In nom varchar (50), 
    In prenom varchar (50), 
    In ville varchar (50)
)

BEGIN
   INSERT INTO client (cli_nom, cli_prenom, cli_ville) VALUES (nom, prenom, ville);
END |

DELIMITER ;
CALL ajoutClient('jessica', 'Pikatchien', 'Dunkerque')

--Exercice 1 : création d'une procédure stockée sans paramètre.
DELIMITER |

CREATE PROCEDURE Lst_fournis()
BEGIN

SELECT distinct numfou
FROM entcom;

END |

DELIMITER ;

SHOW CREATE PROCEDURE Lst_fournis;
CALL `Lst_fournis`;

--Exercice 2 : création d'une procédure stockée avec un paramètre en entrée.

drop PROCEDURE Lst_Commandes;
DELIMITER |

CREATE PROCEDURE Lst_Commandes()
BEGIN

SELECT e.numcom, f.nomfou, p.libart, l.qtecde*l.priuni
FROM ligcom l
JOIN produit p on p.codart=l.codart
JOIN entcom e on e.numcom=l.numcom
JOIN fournis f on f.numfou=e.numfou
WHERE e.obscom like '%urgent%'; 

END |

DELIMITER ;

CALL Lst_Commandes();


--Exercice 3 : création d'une procédure stockée avec plusieurs paramètres.

DELIMITER |
CREATE PROCEDURE CA_Fournisseur(IN annee INT)
BEGIN
SELECT f.nomfou, (SUM(qtecde * prix1) * 1.2) as 'Prix TTC'
FROM fournis f
JOIN vente v ON f.numfou = v.numfou
JOIN produit p ON v.codart = .p.codart
JOIN ligcom l ON p.codart = l.codart
JOIN entcom e ON l.numcom = e.numcom
WHERE YEAR(datcom) = annee
GROUP BY nomfou;

END |


DELIMITER ;
DROP PROCEDURE IF EXISTS CA_Fournisseur;

call CA_Fournisseur(2007);