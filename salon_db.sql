CREATE DATABASE  IF NOT EXISTS `salon_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `salon_db`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: salon_db
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `kunden`
--

DROP TABLE IF EXISTS `kunden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kunden` (
  `kunden_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefon` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `erstellt_am` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`kunden_id`),
  KEY `idx_kunden_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kunden`
--

LOCK TABLES `kunden` WRITE;
/*!40000 ALTER TABLE `kunden` DISABLE KEYS */;
INSERT INTO `kunden` VALUES (1,'Alex Beispiel','0000-000001','alex.beispiel@example.org','2026-11-17 11:39:36'),(2,'Kim Muster','0000-000002','kim.muster@example.org','2026-11-17 11:39:36'),(3,'asasesae','+491231321231321','asesaee@gmail.com','2026-11-20 10:08:13'),(4,'as','+491231321231321','asdasdad@gmail.com','2026-11-20 10:12:06'),(5,'aw','+491231321231323','aew@asd.com','2026-11-20 10:14:22'),(6,'Patrick Mrosek von Glischinski','+49123132123132123','glischinski@gmail.com','2026-11-20 10:47:06');
/*!40000 ALTER TABLE `kunden` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leistungen`
--

DROP TABLE IF EXISTS `leistungen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leistungen` (
  `leistungs_id` int unsigned NOT NULL AUTO_INCREMENT,
  `bezeichnung` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dauer_minuten` smallint unsigned NOT NULL,
  `preis` decimal(8,2) NOT NULL,
  `aktiv` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`leistungs_id`),
  UNIQUE KEY `bezeichnung` (`bezeichnung`),
  CONSTRAINT `chk_leistungen_dauer` CHECK ((`dauer_minuten` > 0)),
  CONSTRAINT `chk_leistungen_preis` CHECK ((`preis` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leistungen`
--

LOCK TABLES `leistungen` WRITE;
/*!40000 ALTER TABLE `leistungen` DISABLE KEYS */;
INSERT INTO `leistungen` VALUES (1,'Herrenschnitt',30,28.00,1),(2,'Damenschnitt',45,42.00,1),(3,'Waschen und Föhnen',30,22.00,1),(4,'Kinderschnitt',20,16.00,1),(5,'Bartpflege',15,12.00,1),(6,'Färben',90,75.00,1);
/*!40000 ALTER TABLE `leistungen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mitarbeiter`
--

DROP TABLE IF EXISTS `mitarbeiter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mitarbeiter` (
  `mitarbeiter_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `benutzername` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `passwort` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rolle` enum('admin','team') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'team',
  `aktiv` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`mitarbeiter_id`),
  UNIQUE KEY `benutzername` (`benutzername`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mitarbeiter`
--

LOCK TABLES `mitarbeiter` WRITE;
/*!40000 ALTER TABLE `mitarbeiter` DISABLE KEYS */;
INSERT INTO `mitarbeiter` VALUES (1,'Sabine Kowalski','sabine','abcd1234','admin',1),(2,'Mara','mara',NULL,'team',1),(3,'Jonas','jonas',NULL,'team',1);
/*!40000 ALTER TABLE `mitarbeiter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mitarbeiter_leistungen`
--

DROP TABLE IF EXISTS `mitarbeiter_leistungen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mitarbeiter_leistungen` (
  `mitarbeiter_id` int unsigned NOT NULL,
  `leistungs_id` int unsigned NOT NULL,
  PRIMARY KEY (`mitarbeiter_id`,`leistungs_id`),
  KEY `fk_ml_leistung` (`leistungs_id`),
  CONSTRAINT `fk_ml_leistung` FOREIGN KEY (`leistungs_id`) REFERENCES `leistungen` (`leistungs_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ml_mitarbeiter` FOREIGN KEY (`mitarbeiter_id`) REFERENCES `mitarbeiter` (`mitarbeiter_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mitarbeiter_leistungen`
--

LOCK TABLES `mitarbeiter_leistungen` WRITE;
/*!40000 ALTER TABLE `mitarbeiter_leistungen` DISABLE KEYS */;
INSERT INTO `mitarbeiter_leistungen` VALUES (1,1),(2,1),(3,1),(1,2),(2,2),(1,3),(2,3),(3,3),(1,4),(2,4),(3,4),(1,5),(2,5),(3,5),(1,6),(2,6);
/*!40000 ALTER TABLE `mitarbeiter_leistungen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oeffnungszeiten`
--

DROP TABLE IF EXISTS `oeffnungszeiten`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oeffnungszeiten` (
  `wochentag` tinyint unsigned NOT NULL,
  `von` time NOT NULL,
  `bis` time NOT NULL,
  PRIMARY KEY (`wochentag`),
  CONSTRAINT `chk_oeffnungszeiten_wochentag` CHECK ((`wochentag` between 1 and 7)),
  CONSTRAINT `chk_oeffnungszeiten_zeit` CHECK ((`bis` > `von`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oeffnungszeiten`
--

LOCK TABLES `oeffnungszeiten` WRITE;
/*!40000 ALTER TABLE `oeffnungszeiten` DISABLE KEYS */;
INSERT INTO `oeffnungszeiten` VALUES (2,'09:00:00','18:00:00'),(3,'09:00:00','18:00:00'),(4,'09:00:00','18:00:00'),(5,'09:00:00','18:00:00'),(6,'09:00:00','14:00:00');
/*!40000 ALTER TABLE `oeffnungszeiten` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `termine`
--

DROP TABLE IF EXISTS `termine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `termine` (
  `termin_id` int unsigned NOT NULL AUTO_INCREMENT,
  `kunden_id` int unsigned NOT NULL,
  `mitarbeiter_id` int unsigned NOT NULL,
  `leistungs_id` int unsigned NOT NULL,
  `beginn` datetime NOT NULL,
  `ende` datetime NOT NULL,
  `preis_bei_buchung` decimal(8,2) NOT NULL,
  `dauer_bei_buchung` smallint unsigned NOT NULL,
  `status` enum('gebucht','abgeschlossen','storniert') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'gebucht',
  `stornierungs_token_hash` char(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storniert_am` datetime DEFAULT NULL,
  `storniert_von` enum('kunde','team') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `erstellt_am` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`termin_id`),
  UNIQUE KEY `stornierungs_token_hash` (`stornierungs_token_hash`),
  KEY `fk_termine_leistung` (`leistungs_id`),
  KEY `idx_termine_mitarbeiter_zeit` (`mitarbeiter_id`,`beginn`,`ende`,`status`),
  KEY `idx_termine_kunde` (`kunden_id`),
  KEY `idx_termine_beginn` (`beginn`),
  CONSTRAINT `fk_termine_kunde` FOREIGN KEY (`kunden_id`) REFERENCES `kunden` (`kunden_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_termine_leistung` FOREIGN KEY (`leistungs_id`) REFERENCES `leistungen` (`leistungs_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_termine_mitarbeiter` FOREIGN KEY (`mitarbeiter_id`) REFERENCES `mitarbeiter` (`mitarbeiter_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_termine_dauer` CHECK ((`dauer_bei_buchung` > 0)),
  CONSTRAINT `chk_termine_preis` CHECK ((`preis_bei_buchung` >= 0)),
  CONSTRAINT `chk_termine_zeit` CHECK ((`ende` > `beginn`))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `termine`
--

LOCK TABLES `termine` WRITE;
/*!40000 ALTER TABLE `termine` DISABLE KEYS */;
INSERT INTO `termine` VALUES (1,1,2,2,'2026-11-24 10:00:00','2026-11-24 10:45:00',42.00,45,'gebucht',NULL,NULL,NULL,'2026-11-17 11:39:36'),(2,2,3,1,'2026-11-24 11:00:00','2026-11-24 11:30:00',28.00,30,'gebucht',NULL,NULL,NULL,'2026-11-17 11:39:36'),(3,2,1,1,'2026-11-25 10:00:00','2026-11-25 10:30:00',28.00,30,'gebucht',NULL,NULL,NULL,'2026-11-20 09:04:22'),(5,2,1,1,'2026-11-25 11:00:00','2026-11-25 11:30:00',28.00,30,'gebucht',NULL,NULL,NULL,'2026-11-20 09:25:51'),(6,2,1,1,'2026-11-25 12:00:00','2026-11-25 12:30:00',28.00,30,'gebucht',NULL,NULL,NULL,'2026-11-20 09:28:26'),(7,3,1,1,'2026-11-20 12:45:00','2026-11-20 13:15:00',28.00,30,'gebucht',NULL,NULL,NULL,'2026-11-20 10:08:13'),(8,2,1,1,'2026-11-26 12:00:00','2026-11-26 12:30:00',28.00,30,'gebucht',NULL,NULL,NULL,'2026-11-20 10:11:33'),(9,4,1,1,'2026-11-20 13:15:00','2026-11-20 13:45:00',28.00,30,'gebucht',NULL,NULL,NULL,'2026-11-20 10:12:06'),(10,5,1,1,'2026-11-20 12:15:00','2026-11-20 12:45:00',28.00,30,'gebucht',NULL,NULL,NULL,'2026-11-20 10:14:22'),(14,6,2,1,'2026-11-20 17:30:00','2026-11-20 18:00:00',28.00,30,'gebucht',NULL,NULL,NULL,'2026-11-20 10:47:06');
/*!40000 ALTER TABLE `termine` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-20 11:20:47
