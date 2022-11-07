DROP DATABASE IF EXISTS 'Hotel';

CREATE DATABASE 'Hotel';

USE 'Hotel';

CREATE TABLE Station(
   sta_num COUNTER,
   sta_nom VARCHAR(30),
   PRIMARY KEY(sta_num)
);

CREATE TABLE Hotel(
   hot_num COUNTER,
   hot_capacite INT,
   hot_categorie VARCHAR(40),
   hot_nom VARCHAR(50),
   hot_adresse VARCHAR(50),
   sta_num INT NOT NULL,
   PRIMARY KEY(hot_num),
   FOREIGN KEY(sta_num) REFERENCES Station(sta_num)
);

CREATE TABLE Chambre(
   cha_num COUNTER,
   cha_capacite INT,
   cha_degreConfort DECIMAL(15,2),
   cha_exposition VARCHAR(30),
   cha_type VARCHAR(50),
   hot_num INT NOT NULL,
   PRIMARY KEY(cha_num),
   FOREIGN KEY(hot_num) REFERENCES Hotel(hot_num)
);

CREATE TABLE Client(
   cli_num VARCHAR(20),
   cli_adresse VARCHAR(50),
   cli_nom VARCHAR(30),
   cli_prenom VARCHAR(30),
   PRIMARY KEY(cli_num)
);

CREATE TABLE Asso_6(
   cha_num INT,
   cli_num VARCHAR(20),
   res_dateFin DATE,
   res_date DATE,
   res_montantArrhes INT,
   res_prixTotal DECIMAL(15,2),
   res_dateDebut DATE,
   PRIMARY KEY(cha_num, cli_num),
   FOREIGN KEY(cha_num) REFERENCES Chambre(cha_num),
   FOREIGN KEY(cli_num) REFERENCES Client(cli_num)
);
