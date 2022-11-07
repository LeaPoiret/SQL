DROP DATABASE if EXISTS papyrus;
CREATE DATABASE papyrus;
USE papyrus;

CREATE TABLE fournis (
  numfou int(11) NOT NULL,
  nomfou varchar(25) NOT NULL,
  ruefou varchar(50) NOT NULL,
  posfou char(5) NOT NULL,
  vilfou varchar(30) NOT NULL,
  confou varchar(15) NOT NULL,
  satisf tinyint(4) DEFAULT NULL, CHECK (satisf >=0 AND satisf <=10),
  PRIMARY KEY (numfou)
) ;

INSERT INTO fournis(numfou,nomfou,ruefou,posfou,vilfou,confou,satisf)
VALUES
	(00120, "Grobrigan", "20 rue du papier", 92200, "papercity", "Goerges", 08),	
	(00540, "Eclipse", "53 rue laisse flotter les rubans", 78250, "Bugbugville", "Nestor", 07),
	(08700, "Medicis", "120 rue des plantes", 75014, "Paris", "Lison"),
	(09120, "Discobol", "11 rue des sports", 85100," La Roche sur Yon", "Hercule", 08),
	(09150, "Depanpap", "26 avenue des locomotives", 59987, "Coroncountry", "Pollux", 05),
	(09180, "Hurrytape", "68 boulevard des octets", 04044, "Dumpville", "Track")

CREATE TABLE produit (
  codart char(4) NOT NULL,
  libart varchar(30) NOT NULL,
  stkale int(11) NOT NULL,
  stkphy int(11) NOT NULL,
  qteann int(11) NOT NULL,
  unimes char(5) NOT NULL,
  PRIMARY KEY (codart)
) ;

INSERT INTO produit (codart, libart, stkale, stkphy, qteann, unimes)
VALUES 
	("I100", "Papier 1 ex continu", 100, 557, 3500, "B1000"),
	("I105", "Papier 2 ex continu", 75, 5, 2300, "B1000"),
	("I108", "Papier 3 ex continu", 200, 557, 3500, "B500"),
	("I110", "papier 4 ex continu", 10, 12, 63, "B400"),
	("P220", "pré imprimé commande", 500, 2500, 24500, "B500"),
	("P230", "pré imprimé facture", 500, 250, 12500, "B500"),
	("P240", "pré imprimé bulletin paie", 500, 3000, 6250, "B500"),
	("P250", "pré imprimé bon lvraison", 500, 2500, 24500, "B500"),
	("P270", "pré imprimé bon fabrication", 500 2500, 24500, "B500")

CREATE TABLE entcom (
  numcom int(11) NOT NULL AUTO_INCREMENT,
  obscom varchar(50) DEFAULT NULL,
  datcom timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  numfou int(11) DEFAULT NULL,
  PRIMARY KEY (numcom),
  KEY numfou (numfou),
  FOREIGN KEY (numfou) REFERENCES fournis (numfou)
) ;

INSERT INTO entcom (numcom,obscom,datcom,numfou)
VALUES 
	(70010,, 10/02/2007, 00120),
	(70011, "Commande urgente", 01/03/2007, 00540),
	(70020," ", 25/04/2007, 09180),
	(70025, "Commande urente", 30/04/2007, 09150),
	(70210, "Commande cadencée", 05/05/2007, 00120),
	(70300, " ", 06/06/2007, 09120),
	(70250, "Commande cadencée", 02/10/2007, 08700),
	(70620, " ", 02/10/2007, 00540),
	(70625, " ", 09/10/2007, 00120),
	(70629, " ", 12/10/2007, 09180)

CREATE TABLE ligcom (
  numcom int(11) NOT NULL,
  numlig tinyint(4) NOT NULL,
  codart char(4) NOT NULL,
  qtecde int(11) NOT NULL,
  priuni decimal(5,0) NOT NULL,
  qteliv int(11) DEFAULT NULL,
  derliv date NOT NULL,
  PRIMARY KEY (numcom,numlig),
  KEY codart (codart),
  FOREIGN KEY (numcom) REFERENCES entcom (numcom),
  FOREIGN KEY (codart) REFERENCES produit (codart)
) ;

INSERT INTO Ligcom (numcom,numlig,codart,qtecde,priuni,qteliv,derliv)
VALUES
	(70010, "I100", 01, 3000, 470, 3000, 15/03/2007),
	(70010, "I105", 02, 2000, 485, 2000, 05/07/2007),
	(70010, "I108", 03, 1000, 680, 1000, 20/08/2007),
	(70010, "D035", 04, 200, 40, 250, 20/02/2007),
	(70010, "P220", 05, 6000, 3500, 6000, 31/03/2007),
	(70010, "P240", 06, 6000, 2000, 2000, 31/03/2007),
	(70011, "I105", 01, 1000, 600, 1000, 16/05/2007),
	(70020, "B001", 01, 200, 140, , 31/12/2007),
	(70020, "B002", 02, 200, 140, , 31/12/2007),
	(70025, "I100", 01 1000, 590, 1000, 15/05/2007),
	(70025, "I105", 02, 50, 590, 500, 15/05/2007),
	(70210, "I100", 01, 1000, 470, 1000, 15/07/2007),
	(70010, "P220", 02, 10000, 3500, 10000, 31/08/2007),
	(70300, "I110", 01, 50, 790, 50, 31/10/2007),
	(70250, "P230", 01, 15000, 4900, 12000, 15/12/2007),
	(70250, "P220", 02, 10000, 3350, 10000, 10/11/2007),
	(70620, "I105", 01, 200, 600, 200, 01/11/2007),
	(70625, "I100", 01, 1000, 470, 1000, 15/10/2007),
	(70625, "P220", 02, 10000, 3500, 10000, 31/10/2007),
	(70629, "B001", 01, 200, 140, ,31/12/2007),
	(70629, "B002", 02, 200, 140, , 31/12/2007)

CREATE TABLE vente (
  codart char(4) NOT NULL,
  numfou int(11) NOT NULL,
  delliv smallint(6) NOT NULL,
  qte1 int(11) NOT NULL,
  prix1 decimal(5,0) NOT NULL,
  qte2 int(11) DEFAULT NULL,
  prix2 decimal(5,0) DEFAULT NULL,
  qte3 int(11) DEFAULT NULL,
  prix3 decimal(5,0) DEFAULT NULL,
  PRIMARY KEY (codart,numfou),
  KEY numfou (numfou),
  FOREIGN KEY (numfou) REFERENCES fournis (numfou),
  FOREIGN KEY (codart) REFERENCES produit (codart)
) ;

INSERT INTO vente(codart, numfou, delliv, qte1, prix1, qte2, prix2, qte3, prix3)
VALUES 
	("I100", 00120, 90, 0, 700, 50, 600, 120, 500),
	("I100", 00540, 70, 0, 710, 60, 630, 100, 600),
	("I100", 09120, 60, 0, 800, 70, 600, 90, 500),
	("I100", 09150, 90, 0, 650, 90, 600, 200,590),
	("I100", 09180, 30, 0, 720, 50, 670, 100, 490),
	("I105", 00120, 90, 10, 705, 50, 6.30, 120, 500),
	("I105", 00540, 70, 0, 810, 60, 645, 100, 600),
	("I105", 09120, 60, 0, 920, 70, 800, 90, 700),
	("I105", 09150, 90, 0, 685, 90, 600, 200, 590),
	("I105", 08700, 30, 0, 720, 50, 670, 100, 510),
	("I108", 00120, 90, 5, 795, 30, 720, 100, 680),
	("I108", 09120, 60, 0, 920, 70, 820, 100, 780),
	("I110", 09180, 90, 0, 900, 70, 870, 90, 835),
	("I110", 09120, 60, 0, 950, 70, 850, 90, 790),
	("D035", 00120, 0, 0, 40, , , , ),
	("D035", 09120, 5, 0, 40, 100, 30, , ),
	("I105", 09120, 8, 0, 37, , , , ),
	("D035", 00120, 0, 0, 40, , , , ),
	("D035", 09120, 5, 0, 40, 100, 30, 5, 0),
	("I105", 09120, 8, 0, 37, , , , ),
	("P220", 00120, 15, 0, 3700, 100, 3500),
	("P230", 00120, 30, 0, 5200, 100, 5000),
	("P240", 00120, 15, 0, 2200, 100, 2000, ),
	("P250", 00120, 30, 0, 1500, 100, 1400, 500, 1200),
	("P250", 09120, 30, 0, 1500, 100, 1400, 500, 1200),
	("P200", 08700, 20 50, 3500, 100, 3350, , ),
	("P230", 08700, 60, 0, 5000, 50, 4900, , ),
	("R080", 09120, 10, 0, 120, 100, 100, , ),
	("P132", 09120, 5, 0, 275, , , , ),
	("B001", 08700, 15, 0, 150, 50, 145, 100, 140),
	("B002", 08700, 15, 0, 210, 50, 200, 100, 185)
	
	
