-- Active: 1664375272525@@127.0.0.1@3306@hotel

--LOT 1:
--1-Afficher la liste des hôtels. Le résultat doit faire apparaître le nom de l’hôtel et la ville.

SELECT hot_nom, hot_ville
FROM hotel;

--2-Afficher la ville de résidence de Mr White Le résultat doit faire apparaître le nom, le prénom, et l'adresse du client.

SELECT cli_nom, cli_prenom ,cli_adresse, cli_ville
FROM client
WHERE cli_nom = "white";

--3-Afficher la liste des stations dont l’altitude < 1000 Le résultat doit faire apparaître le nom de la station et l'altitude.

SELECT sta_nom, sta_altitude
FROM station
WHERE sta_altitude <1000;

--4-Afficher la liste des chambres ayant une capacité > 1 Le résultat doit faire apparaître le numéro de la chambre ainsi que la capacité.

SELECT cha_numero, cha_capacite
FROM chambre
WHERE cha_capacite >1;

--5-Afficher les clients n’habitant pas à Londre Le résultat doit faire apparaître le nom du client et la ville.

SELECT cli_nom, cli_ville
FROM client
WHERE cli_ville != 'londre';

--6-Afficher la liste des hôtels située sur la ville de Bretou et possédant une catégorie>3 Le résultat doit faire apparaître le nom de l'hôtel, ville et la catégorie.

SELECT hot_nom, hot_ville, hot_categorie
FROM hotel 
WHERE hot_ville = 'bretou' AND hot_categorie > 3;

--LOT 2:

--7-Afficher la liste des hôtels avec leur station Le résultat doit faire apparaître le nom de la station, le nom de l’hôtel, la catégorie, la ville).

SELECT hot_nom, hot_categorie, hot_ville, sta_nom
FROM hotel
JOIN station
on station.sta_id = hotel.hot_id;

--8-Afficher la liste des chambres et leur hôtel Le résultat doit faire apparaître le nom de l’hôtel, la catégorie, la ville, le numéro de la chambre).

SELECT cha_numero, hot_nom, hot_categorie, hot_ville
FROM chambre
JOIN hotel
on hotel.hot_id = chambre.cha_id; 

--9-Afficher la liste des chambres de plus d'une place dans des hôtels situés sur la ville de Bretou Le résultat doit faire apparaître le nom de l’hôtel, la catégorie, la ville, le numéro de la chambre et sa capacité).

SELECT cha_numero, cha_capacite, hot_nom, hot_categorie, hot_ville
FROM chambre
JOIN hotel
on hotel.hot_id = chambre.cha_id
WHERE cha_capacite >1 AND hot_ville = 'bretou';
--10-Afficher la liste des réservations avec le nom des clients Le résultat doit faire apparaître le nom du client, le nom de l’hôtel, la date de réservation.

SELECT cli_nom, hot_nom, res_date
FROM client
JOIN reservation
on reservation.res_id = client.cli_id 
JOIN chambre
on chambre.cha_id = reservation.res_id
JOIN hotel
on reservation.res_id = hotel.hot_id;

--11-Afficher la liste des chambres avec le nom de l’hôtel et le nom de la station Le résultat doit faire apparaître le nom de la station, le nom de l’hôtel, le numéro de la chambre et sa capacité).

SELECT cha_numero, cha_capacite, hot_nom, sta_nom
FROM chambre
JOIN hotel
on hotel.hot_id = chambre.cha_id
JOIN station
on station.sta_id = hotel.hot_id;

--12-Afficher les réservations avec le nom du client et le nom de l’hôtel Le résultat doit faire apparaître le nom du client, le nom de l’hôtel, la date de début du séjour et la durée du séjour.

SELECT cli_nom, hot_nom,res_date_debut ,datediff(res_date_fin, res_date_debut) as 'Durée séjour'
FROM client
JOIN reservation
on reservation.res_cli_id = client.cli_id
JOIN chambre
on chambre.cha_id = reservation.res_cha_id
JOIN hotel
on hot_id = cha_hot_id;
-- En gros , la il recupere bien toute les reservation / client , alors qu'avant tu affiche juste toute les reservation , ducoup le duplicata sur
-- squire ne s'affiche pas alors qu'on le demande ;) ;) ;) ;) ;) et oublie pas dans la journée j'te detruit l'epaule sale tchoin :) :) :) :)

--LOT 3:

--13-Compter le nombre d’hôtel par station.

SELECT sta_nom, count(hot_nom)
FROM hotel
JOIN station
on station.sta_id = hotel.hot_sta_id
GROUP BY sta_nom;

--14-Compter le nombre de chambre par station.

SELECT sta_nom, count(cha_numero) as "nombre de chambres"
FROM station
JOIN hotel
on hotel.hot_sta_id = station.sta_id
JOIN chambre
on chambre.cha_hot_id = hotel.hot_id
GROUP BY sta_nom;

--15-Compter le nombre de chambre par station ayant une capacité > 1.
SELECT sta_nom, cha_capacite, count(cha_numero) as "nombre de chambres"
FROM station
JOIN hotel
on hotel.hot_sta_id = station.sta_id
JOIN chambre
on chambre.cha_hot_id = hotel.hot_id
WHERE cha_capacite > 1
GROUP BY sta_nom;

--16-Afficher la liste des hôtels pour lesquels Mr Squire a effectué une réservation.

SELECT h.hot_nom, r.res_cli_id, C.cli_nom
FROM hotel h 
join chambre c on h.hot_id = c.cha_hot_id
join reservation r on c.cha_id = r.res_cha_id
join client C on C.cli_id = r.res_cli_id
where cli_nom = 'squire';

--17-Afficher la durée moyenne des réservations par station.
SELECT avg(datediff(r.res_date_fin, r.res_date_debut)) as 'Moyenne durée séjour'
from reservation r;