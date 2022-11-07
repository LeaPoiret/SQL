-- MariaDB dump 10.19  Distrib 10.6.7-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: papyrus
-- ------------------------------------------------------
-- Server version	10.6.7-MariaDB-2ubuntu1.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `entcom`
--

DROP TABLE IF EXISTS `entcom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entcom` (
  `numcom` int(11) NOT NULL AUTO_INCREMENT,
  `obscom` varchar(50) DEFAULT NULL,
  `datcom` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `numfou` int(11) DEFAULT NULL,
  PRIMARY KEY (`numcom`),
  KEY `numfou` (`numfou`),
  CONSTRAINT `entcom_ibfk_1` FOREIGN KEY (`numfou`) REFERENCES `fournis` (`numfou`)
) ENGINE=InnoDB AUTO_INCREMENT=70630 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entcom`
--

LOCK TABLES `entcom` WRITE;
/*!40000 ALTER TABLE `entcom` DISABLE KEYS */;
INSERT INTO `entcom` VALUES (70010,NULL,'2007-02-09 23:00:00',120),(70011,'Commande urgente','2007-02-28 23:00:00',540),(70020,NULL,'2007-04-24 22:00:00',9180),(70025,'Commande urente','2007-04-29 22:00:00',9150),(70210,'Commande cadencée','2007-05-04 22:00:00',120),(70250,'Commande cadencée','2007-10-01 22:00:00',8700),(70300,NULL,'2007-06-05 22:00:00',9120),(70620,NULL,'2007-10-01 22:00:00',540),(70625,NULL,'2007-10-08 22:00:00',120),(70629,NULL,'2007-10-11 22:00:00',9180);
/*!40000 ALTER TABLE `entcom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fournis`
--

DROP TABLE IF EXISTS `fournis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fournis` (
  `numfou` int(11) NOT NULL,
  `nomfou` varchar(25) NOT NULL,
  `ruefou` varchar(50) NOT NULL,
  `posfou` char(5) NOT NULL,
  `vilfou` varchar(30) NOT NULL,
  `confou` varchar(15) NOT NULL,
  `satisf` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`numfou`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`satisf` >= 0 and `satisf` <= 10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fournis`
--

LOCK TABLES `fournis` WRITE;
/*!40000 ALTER TABLE `fournis` DISABLE KEYS */;
INSERT INTO `fournis` VALUES (120,'Grobrigan','20 rue du papier','92200','papercity','Goerges',8),(540,'Eclipse','53 rue laisse flotter les rubans','78250','Bugbugville','Nestor',7),(8700,'Medicis','120 rue des plantes','75014','Paris','Lison',NULL),(9120,'Discobol','11 rue des sports','85100',' La Roche sur Yon','Hercule',8),(9150,'Depanpap','26 avenue des locomotives','59987','Coroncountry','Pollux',5),(9180,'Hurrytape','68 boulevard des octets','4044','Dumpville','Track',NULL);
/*!40000 ALTER TABLE `fournis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ligcom`
--

DROP TABLE IF EXISTS `ligcom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ligcom` (
  `numcom` int(11) NOT NULL,
  `numlig` tinyint(4) NOT NULL,
  `codart` char(4) NOT NULL,
  `qtecde` int(11) NOT NULL,
  `priuni` decimal(5,0) NOT NULL,
  `qteliv` int(11) DEFAULT NULL,
  `derliv` date NOT NULL,
  PRIMARY KEY (`numcom`,`numlig`),
  KEY `codart` (`codart`),
  CONSTRAINT `ligcom_ibfk_1` FOREIGN KEY (`numcom`) REFERENCES `entcom` (`numcom`),
  CONSTRAINT `ligcom_ibfk_2` FOREIGN KEY (`codart`) REFERENCES `produit` (`codart`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ligcom`
--

LOCK TABLES `ligcom` WRITE;
/*!40000 ALTER TABLE `ligcom` DISABLE KEYS */;
INSERT INTO `ligcom` VALUES (70010,1,'I100',3000,470,3000,'2007-03-15'),(70010,2,'I105',2000,485,2000,'2007-07-05'),(70010,3,'I108',1000,680,1000,'2007-08-20'),(70010,4,'D035',200,40,250,'2007-02-20'),(70010,5,'P220',6000,3500,6000,'2007-03-31'),(70010,6,'P240',6000,2000,2000,'2007-03-31'),(70010,9,'P220',10000,3500,10000,'2007-08-31'),(70011,1,'I105',1000,600,1000,'2007-05-16'),(70020,1,'B001',200,140,NULL,'2007-12-31'),(70020,2,'B002',200,140,NULL,'2007-12-31'),(70025,1,'I100',1000,590,1000,'2007-05-15'),(70025,2,'I105',50,590,500,'2007-05-15'),(70210,1,'I100',1000,470,1000,'2007-07-15'),(70250,1,'P230',15000,4900,12000,'2007-12-15'),(70250,2,'P220',10000,3350,10000,'2007-11-10'),(70300,1,'I110',50,790,50,'2007-10-31'),(70620,1,'I105',200,600,200,'2007-11-01'),(70625,1,'I100',1000,470,1000,'2007-10-15'),(70625,2,'P220',10000,3500,10000,'2007-10-31'),(70629,1,'B001',200,140,NULL,'2007-12-31'),(70629,2,'B002',200,140,NULL,'2007-12-31');
/*!40000 ALTER TABLE `ligcom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produit`
--

DROP TABLE IF EXISTS `produit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produit` (
  `codart` char(4) NOT NULL,
  `libart` varchar(30) NOT NULL,
  `stkale` int(11) NOT NULL,
  `stkphy` int(11) NOT NULL,
  `qteann` int(11) NOT NULL,
  `unimes` char(5) NOT NULL,
  PRIMARY KEY (`codart`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produit`
--

LOCK TABLES `produit` WRITE;
/*!40000 ALTER TABLE `produit` DISABLE KEYS */;
INSERT INTO `produit` VALUES ('B001','Bande magnétique 1200',20,87,240,'unité'),('B002','Bande magnétique 6250',20,12,410,'unité'),('D035','CD R slim 80 mm',40,42,150,'B010'),('D050','CD R-W 80mm',50,4,0,'B010'),('I100','Papier 1 ex continu',100,557,3500,'B1000'),('I105','Papier 2 ex continu',75,5,2300,'B1000'),('I108','Papier 3 ex continu',200,557,3500,'B500'),('I110','Papier 4 ex continu',10,12,63,'B400'),('P220','Pré imprimé commande',500,2500,24500,'B500'),('P230','Pré imprimé facture',500,250,12500,'B500'),('P240','Pré imprimé bulletin paie',500,3000,6250,'B500'),('P250','Pré imprimé bon livraison',500,2500,24500,'B500'),('P270','Pré imprimé bon fabrication',500,2500,24500,'B500'),('R080','Ruban Epson 850',10,2,120,'unité'),('R132','Ruban imp1200 lignes',25,200,182,'unité');
/*!40000 ALTER TABLE `produit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vente`
--

DROP TABLE IF EXISTS `vente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vente` (
  `codart` char(4) NOT NULL,
  `numfou` int(11) NOT NULL,
  `delliv` smallint(6) NOT NULL,
  `qte1` int(11) NOT NULL,
  `prix1` decimal(5,0) NOT NULL,
  `qte2` int(11) DEFAULT NULL,
  `prix2` decimal(5,0) DEFAULT NULL,
  `qte3` int(11) DEFAULT NULL,
  `prix3` decimal(5,0) DEFAULT NULL,
  PRIMARY KEY (`codart`,`numfou`),
  KEY `numfou` (`numfou`),
  CONSTRAINT `vente_ibfk_1` FOREIGN KEY (`numfou`) REFERENCES `fournis` (`numfou`),
  CONSTRAINT `vente_ibfk_2` FOREIGN KEY (`codart`) REFERENCES `produit` (`codart`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vente`
--

LOCK TABLES `vente` WRITE;
/*!40000 ALTER TABLE `vente` DISABLE KEYS */;
INSERT INTO `vente` VALUES ('B001',120,0,0,40,NULL,NULL,NULL,NULL),('B001',8700,15,0,150,50,145,100,140),('B001',9120,8,0,37,NULL,NULL,NULL,NULL),('B002',8700,15,0,210,50,200,100,185),('B002',9120,60,0,920,70,800,90,700),('D035',120,0,0,40,NULL,NULL,NULL,NULL),('D035',9120,5,0,40,100,30,NULL,NULL),('I100',120,90,0,700,50,600,120,500),('I100',540,70,0,710,60,630,100,600),('I100',9120,60,0,800,70,600,90,500),('I100',9150,90,0,650,90,600,200,590),('I100',9180,30,0,720,50,670,100,490),('I105',120,90,10,705,50,630,120,500),('I105',540,70,0,810,60,645,100,600),('I105',8700,30,0,720,50,670,100,510),('I105',9120,8,0,37,NULL,NULL,NULL,NULL),('I105',9150,90,0,685,90,600,200,590),('I108',120,90,5,795,30,720,100,680),('I108',9120,60,0,920,70,820,100,780),('I110',9120,60,0,950,70,850,90,790),('I110',9180,90,0,900,70,870,90,835),('P220',120,15,0,3700,100,3500,NULL,NULL),('P220',8700,20,50,3500,100,3350,NULL,NULL),('P230',120,30,0,5200,100,5000,NULL,NULL),('P230',8700,60,0,5000,50,4900,NULL,NULL),('P240',120,15,0,2200,100,2000,NULL,NULL),('P250',120,30,0,1500,100,1400,500,1200),('P250',9120,30,0,1500,100,1400,500,1200),('R080',9120,10,0,120,100,100,NULL,NULL),('R132',9120,5,0,275,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `vente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-04  9:14:25
