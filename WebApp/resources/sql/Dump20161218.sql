CREATE DATABASE  IF NOT EXISTS `krishnadeep` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `krishnadeep`;
-- MySQL dump 10.13  Distrib 5.6.23, for Win64 (x86_64)
--
-- Host: localhost    Database: krishnadeep
-- ------------------------------------------------------
-- Server version	5.6.25-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dispensary_master`
--

DROP TABLE IF EXISTS `dispensary_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispensary_master` (
  `dispensary_id` int(11) NOT NULL AUTO_INCREMENT,
  `dispensary_name` mediumtext,
  `dispensary_of` mediumtext,
  `is_active` char(1) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`dispensary_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispensary_master`
--

LOCK TABLES `dispensary_master` WRITE;
/*!40000 ALTER TABLE `dispensary_master` DISABLE KEYS */;
INSERT INTO `dispensary_master` VALUES (1,'Krishnadeep Hospital','Ganesh Gharat','1',1,'2016-12-17 17:49:48');
/*!40000 ALTER TABLE `dispensary_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispensary_user_map`
--

DROP TABLE IF EXISTS `dispensary_user_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispensary_user_map` (
  `dispensary_user_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `dispensary_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` char(1) NOT NULL DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`dispensary_user_map_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispensary_user_map`
--

LOCK TABLES `dispensary_user_map` WRITE;
/*!40000 ALTER TABLE `dispensary_user_map` DISABLE KEYS */;
INSERT INTO `dispensary_user_map` VALUES (1,1,1,'1',1,'2016-12-17 17:50:07',1);
/*!40000 ALTER TABLE `dispensary_user_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_master`
--

DROP TABLE IF EXISTS `patient_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_master` (
  `patient_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(200) NOT NULL,
  `contact_no` varchar(15) NOT NULL,
  `sex` char(1) DEFAULT NULL,
  `bloodGroup` varchar(45) DEFAULT NULL,
  `address` varchar(2000) DEFAULT NULL,
  `dob` varchar(12) DEFAULT NULL,
  `is_active` char(1) NOT NULL DEFAULT '1',
  `created_by` int(11) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_master`
--

LOCK TABLES `patient_master` WRITE;
/*!40000 ALTER TABLE `patient_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_master`
--

DROP TABLE IF EXISTS `role_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_master` (
  `role_id` int(11) NOT NULL,
  `role_description` varchar(45) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `is_active` char(1) DEFAULT '1',
  PRIMARY KEY (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_master`
--

LOCK TABLES `role_master` WRITE;
/*!40000 ALTER TABLE `role_master` DISABLE KEYS */;
INSERT INTO `role_master` VALUES (1,'Admin','1','2016-10-29 20:36:11','1'),(2,'Reception','1','2016-10-29 20:36:11','1');
/*!40000 ALTER TABLE `role_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_menu_map`
--

DROP TABLE IF EXISTS `role_menu_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_menu_map` (
  `role_menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `is_active` char(1) DEFAULT NULL,
  PRIMARY KEY (`role_menu_id`),
  KEY `RoleId_idx` (`role_id`),
  KEY `MenuId_idx` (`menu_id`),
  CONSTRAINT `Role_Menu_Menu_FK` FOREIGN KEY (`menu_id`) REFERENCES `user_menu_master` (`menu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_menu_map`
--

LOCK TABLES `role_menu_map` WRITE;
/*!40000 ALTER TABLE `role_menu_map` DISABLE KEYS */;
INSERT INTO `role_menu_map` VALUES (1,1,1,'1','2016-10-29 20:36:11','1'),(2,1,2,'1','2016-10-29 20:36:11','1'),(3,1,3,'1','2016-10-29 20:36:11','1'),(4,1,4,'1','2016-10-29 20:36:11','1'),(5,1,5,'1','2016-10-29 20:36:11','1'),(6,1,6,'1','2016-10-29 20:36:11','1'),(7,2,1,'1','2016-10-29 20:36:11','1'),(8,2,2,'1','2016-10-29 20:36:11','1'),(9,2,4,'1','2016-10-29 20:36:11','1'),(10,2,5,'1','2016-10-29 20:36:11','1');
/*!40000 ALTER TABLE `role_menu_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_master`
--

DROP TABLE IF EXISTS `user_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_master` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(200) NOT NULL,
  `user_name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `new_password` varchar(45) NOT NULL DEFAULT '',
  `is_active` tinyint(4) NOT NULL DEFAULT '1',
  `created_by` int(11) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_master`
--

LOCK TABLES `user_master` WRITE;
/*!40000 ALTER TABLE `user_master` DISABLE KEYS */;
INSERT INTO `user_master` VALUES (1,'Kiran','Vijay','Kadav','kadav.kiran@gmail.com','kiran','kiran','',1,NULL,'2016-12-17 17:31:53');
/*!40000 ALTER TABLE `user_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_menu_master`
--

DROP TABLE IF EXISTS `user_menu_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_menu_master` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_description` varchar(45) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `is_active` char(1) DEFAULT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_menu_master`
--

LOCK TABLES `user_menu_master` WRITE;
/*!40000 ALTER TABLE `user_menu_master` DISABLE KEYS */;
INSERT INTO `user_menu_master` VALUES (1,'Report','1','2016-10-29 20:36:11','1'),(2,'Home','1','2016-10-29 20:36:11','1'),(3,'Order','1','2016-10-29 20:36:11','1'),(4,'Master','1','2016-10-29 20:36:11','1'),(5,'Cooking','1','2016-10-29 20:36:11','1'),(6,'Parcel','1','2016-10-29 20:36:11','1');
/*!40000 ALTER TABLE `user_menu_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'krishnadeep'
--

--
-- Dumping routines for database 'krishnadeep'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-18  0:32:03
