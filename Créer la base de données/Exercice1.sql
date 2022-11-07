-- Active: 1664375272525@@127.0.0.1@3306@phpmyadmin
drop database if exists 'exercice1';

create database 'exercice1';

use 'exercice1';

CREATE TABLE Personne(
   per_num COUNTER,
   per_nom VARCHAR(50),
   per_prenom VARCHAR(50),
   per_adresse VARCHAR(50),
   per_ville VARCHAR(50),
   PRIMARY KEY(per_num)
);

CREATE TABLE Groupe(
   gro_num COUNTER,
   gro_libelle VARCHAR(50),
   PRIMARY KEY(gro_num)
);

CREATE TABLE Appartient(
   per_num INT,
   gro_num INT,
   PRIMARY KEY(per_num, gro_num),
   FOREIGN KEY(per_num) REFERENCES Personne(per_num),
   FOREIGN KEY(gro_num) REFERENCES Groupe(gro_num)
);
