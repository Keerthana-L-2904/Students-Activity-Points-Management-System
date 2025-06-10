-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: student_activity_points
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity` (
  `actID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `DID` int DEFAULT NULL,
  `Date` date NOT NULL,
  `type` enum('Institute','Department','other') NOT NULL,
  `outside_inside` enum('Inside','Outside') NOT NULL,
  `no_of_people` int DEFAULT '0',
  `mandatory` int DEFAULT NULL,
  `points` int DEFAULT NULL,
  PRIMARY KEY (`actID`),
  KEY `DID` (`DID`),
  CONSTRAINT `activity_ibfk_1` FOREIGN KEY (`DID`) REFERENCES `departments` (`DID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` VALUES (6,'Painting Competition','Part of Ragam 2025',1,'2025-03-14','Institute','Inside',NULL,0,5),(7,'Ma Pa Dha Ni Sa','Part of Ragam 2025',1,'2025-03-04','Institute','Inside',NULL,0,5);
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcements` (
  `aid` int NOT NULL AUTO_INCREMENT,
  `FAID` int NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text,
  PRIMARY KEY (`aid`),
  KEY `FAID` (`FAID`),
  CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`FAID`) REFERENCES `fa` (`FAID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
INSERT INTO `announcements` VALUES (1,1,'2024-12-10','10:00:00','Holiday Notice','The college will remain closed on 25th December.');
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `DID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`DID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Computer Science');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa`
--

DROP TABLE IF EXISTS `fa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fa` (
  `FAID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `emailID` varchar(255) NOT NULL,
  `DID` int NOT NULL,
  PRIMARY KEY (`FAID`),
  UNIQUE KEY `emailID` (`emailID`),
  KEY `DID` (`DID`),
  CONSTRAINT `fa_ibfk_1` FOREIGN KEY (`DID`) REFERENCES `departments` (`DID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa`
--

LOCK TABLES `fa` WRITE;
/*!40000 ALTER TABLE `fa` DISABLE KEYS */;
INSERT INTO `fa` VALUES (1,'Veda FA','veda_b220584cs@nitc.ac.in',1),(2,'Veena FA','veenavijayshankar@gmail.com',1);
/*!40000 ALTER TABLE `fa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `NID` int NOT NULL AUTO_INCREMENT,
  `receiver_id` varchar(255) NOT NULL,
  `receiver_type` enum('Student','FA') NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text,
  `category` enum('Approval','Announcement','New Activity','Low Points','Pending Request') NOT NULL,
  `related_activity_id` int DEFAULT NULL,
  `related_request_id` int DEFAULT NULL,
  `related_announcement_id` int DEFAULT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `status` enum('Unread','Read') DEFAULT 'Unread',
  `related_id` int NOT NULL,
  PRIMARY KEY (`NID`),
  KEY `related_activity_id` (`related_activity_id`),
  KEY `related_request_id` (`related_request_id`),
  KEY `related_announcement_id` (`related_announcement_id`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`related_activity_id`) REFERENCES `activity` (`actID`),
  CONSTRAINT `notification_ibfk_2` FOREIGN KEY (`related_request_id`) REFERENCES `requests` (`rid`),
  CONSTRAINT `notification_ibfk_3` FOREIGN KEY (`related_announcement_id`) REFERENCES `announcements` (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,'B220584CS','Student','Coding competition','A new coding workshop is scheduled.','New Activity',NULL,NULL,NULL,'2024-12-09','14:30:00','Unread',0);
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requested`
--

DROP TABLE IF EXISTS `requested`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requested` (
  `rid` int NOT NULL AUTO_INCREMENT,
  `FAID` int NOT NULL,
  PRIMARY KEY (`rid`),
  KEY `FAID` (`FAID`),
  CONSTRAINT `requested_ibfk_1` FOREIGN KEY (`FAID`) REFERENCES `fa` (`FAID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requested`
--

LOCK TABLES `requested` WRITE;
/*!40000 ALTER TABLE `requested` DISABLE KEYS */;
INSERT INTO `requested` VALUES (1,1);
/*!40000 ALTER TABLE `requested` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requests` (
  `rid` int NOT NULL AUTO_INCREMENT,
  `sid` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `status` enum('Pending','Approved','Rejected') NOT NULL DEFAULT 'Pending',
  `link` varchar(255) DEFAULT NULL,
  `decision_date` date DEFAULT NULL,
  `activity_name` varchar(255) DEFAULT NULL,
  `description` text,
  `activity_date` date DEFAULT NULL,
  `type` enum('Institute','Department','other') NOT NULL,
  `decison_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`rid`),
  KEY `sid` (`sid`),
  CONSTRAINT `requests_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `student` (`SID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requests`
--

LOCK TABLES `requests` WRITE;
/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
INSERT INTO `requests` VALUES (1,'B220584CS','2024-12-01','Approved','http://example.com/request','2024-12-18','Art Competition','Participated in inter-college art competition','2024-11-28','Institute',NULL);
/*!40000 ALTER TABLE `requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `SID` varchar(255) NOT NULL,
  `FAID` int NOT NULL,
  `emailID` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `DID` int NOT NULL,
  `dept_points` int DEFAULT '0',
  `institute_points` int DEFAULT '0',
  PRIMARY KEY (`SID`),
  UNIQUE KEY `emailID` (`emailID`),
  KEY `FAID` (`FAID`),
  KEY `DID` (`DID`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`FAID`) REFERENCES `fa` (`FAID`),
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`DID`) REFERENCES `departments` (`DID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('B220448CS',1,'berty@gmail.com','berty',1,11,16),('B220584CS',1,'vedavijayshankar.xia6@gmail.com','Veda Vijay Shankar',1,10,20);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_activity`
--

DROP TABLE IF EXISTS `student_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_activity` (
  `actid` int NOT NULL,
  `sid` varchar(255) NOT NULL,
  `date` datetime(6) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `points` int DEFAULT '0',
  PRIMARY KEY (`actid`,`sid`),
  KEY `FKowxecsdxbyhk408543vf01hy1` (`sid`),
  CONSTRAINT `FK4oh3s3nc1x37b0e5rsy6n8mkl` FOREIGN KEY (`actid`) REFERENCES `activity` (`actID`) ON DELETE CASCADE,
  CONSTRAINT `FKowxecsdxbyhk408543vf01hy1` FOREIGN KEY (`sid`) REFERENCES `student` (`SID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_activity`
--

LOCK TABLES `student_activity` WRITE;
/*!40000 ALTER TABLE `student_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `validation`
--

DROP TABLE IF EXISTS `validation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `validation` (
  `VID` int NOT NULL AUTO_INCREMENT,
  `SID` varchar(255) NOT NULL,
  `FAID` int NOT NULL,
  `actID` int NOT NULL,
  `upload_date` date NOT NULL,
  `validated` enum('No','Yes') NOT NULL DEFAULT 'No',
  PRIMARY KEY (`VID`),
  KEY `SID` (`SID`),
  KEY `FAID` (`FAID`),
  KEY `validation_ibfk_3` (`actID`),
  CONSTRAINT `validation_ibfk_1` FOREIGN KEY (`SID`) REFERENCES `student` (`SID`),
  CONSTRAINT `validation_ibfk_2` FOREIGN KEY (`FAID`) REFERENCES `fa` (`FAID`),
  CONSTRAINT `validation_ibfk_3` FOREIGN KEY (`actID`) REFERENCES `activity` (`actID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validation`
--

LOCK TABLES `validation` WRITE;
/*!40000 ALTER TABLE `validation` DISABLE KEYS */;
/*!40000 ALTER TABLE `validation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-16 16:55:42
