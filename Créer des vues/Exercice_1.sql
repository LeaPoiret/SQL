-- Active: 1664375272525@@127.0.0.1@3306@hotel

--1.Afficher la liste des hôtels avec leur station.
CREATE VIEW list_hotel
AS
SELECT h.hot_nom, s.sta_nom
FROM hotel h 
JOIN station s ON s.sta_id = h.hot_sta_id;

--2.Afficher la liste des chambres et leur hôtel.

CREATE VIEW chambre_hotel
AS 
SELECT c.cha_numero, h.hot_nom
FROM hotel h 
JOIN chambre c ON h.hot_id = c.cha_hot_id;

--3.Afficher la liste des réservations avec le nom des clients.

CREATE VIEW reservation_client
AS
SELECT c.cli_nom, r.res_id
FROM client c 
JOIN reservation r ON c.cli_id = r.res_cli_id;

--4.Afficher la liste des chambres avec le nom de l’hôtel et le nom de la station.

CREATE VIEW list_chambre_hotel_station
AS
SELECT c.cha_id, h.hot_nom, s.sta_nom
FROM station s
JOIN hotel h ON s.sta_id = h.hot_sta_id
JOIN chambre c ON h.hot_id = c.cha_hot_id;

--5.Afficher les réservations avec le nom du client et le nom de l’hôtel.

CREATE VIEW reservation_client_hotel
AS
SELECT r.res_id, c.cli_nom, h.hot_nom
FROM client c 
JOIN reservation r ON c.cli_id = r.res_cli_id
JOIN chambre C ON C.cha_id = r.res_cha_id
JOIN hotel h ON h.hot_id = C.cha_hot_id;