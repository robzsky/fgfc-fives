-- MySQL dump 10.13  Distrib 5.5.34, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: forest_glade
-- ------------------------------------------------------
-- Server version	5.5.34-0ubuntu0.12.10.1

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
-- Table structure for table age_group
--

DROP TABLE IF EXISTS age_group;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE age_group (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  description varchar(10) DEFAULT NULL,
  day varchar(30) DEFAULT NULL,
  open tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table age_group
--

LOCK TABLES age_group WRITE;
/*!40000 ALTER TABLE age_group DISABLE KEYS */;
INSERT INTO age_group VALUES (1,'U6','Saturday May 28th',0),(2,'U7','Sunday May 25th',1),(3,'U8','Saturday May 24th',1),(4,'U9','Sunday May 25th',1),(5,'U10','Saturday May 24th',1),(6,'U11','Sunday May 25th',1),(7,'U12 Girls','Sunday May 25th',1),(8,'U12','Saturday May 24th',1),(9,'U13','Sunday May 25th',1),(10,'U14 Girls','Sunday May 25th',1),(11,'U14','Saturday May 24th',1),(12,'U15','Sunday May 25th',1),(13,'U16','Saturday May 24th',1),(14,'U18','Saturday May 24th',1);
/*!40000 ALTER TABLE age_group ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table fives_team
--

DROP TABLE IF EXISTS fives_team;
CREATE TABLE fives_team (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  age_group_id bigint(20) NOT NULL,
  team_name varchar(60) NOT NULL,
  team_designation varchar(30) NOT NULL,
  manager_name varchar(70) NOT NULL,
  mobile_phone varchar(14) DEFAULT NULL,
  home_phone varchar(14) DEFAULT NULL,
  paid tinyint(1) DEFAULT '0',
  paypal tinyint(1) DEFAULT '0',
  email_address varchar(50) DEFAULT NULL,
  address_line1 varchar(250) DEFAULT NULL,
  address_line2 varchar(250) DEFAULT NULL,
  address_town varchar(255) DEFAULT NULL,
  address_county varchar(255) DEFAULT NULL,
  address_postcode varchar(10) DEFAULT NULL,
  date_registered date DEFAULT NULL,
  division varchar(20) DEFAULT NULL,
  league_name varchar(80) DEFAULT NULL,
  league_division varchar(20) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY fk_age_group (age_group_id),
  CONSTRAINT fk_age_group FOREIGN KEY (age_group_id) REFERENCES age_group (id) ON DELETE NO ACTION ON UPDATE NO ACTION
)


DROP TABLE IF EXISTS mailing_list;
CREATE TABLE mailing_list (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  email_address varchar(50) DEFAULT NULL,
  opted_out tinyint(1) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY ak1_email_address (email_address)
)

DROP TABLE IF EXISTS user;
CREATE TABLE user (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  login varchar(30) DEFAULT NULL,
  password varchar(30) DEFAULT NULL,
  role varchar(20) DEFAULT NULL,
  name varchar(30) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY login (login)
)

INSERT INTO user VALUES (1,'Rob','rh20!!','root','Rob'),(2,'Lee','la20!!','admin','Lee'),(3,'Mike','mb20!!','admin','Mike');

--
-- Final view structure for view summary
--

CREATE VIEW summary AS select ag.id AS id,ag.description AS age_group,
count(ft.age_group_id) AS total,
sum((case ft.paid when 1 then 1 else 0 end)) AS paid,
sum((case ft.paid when 0 then 1 else 0 end)) AS unpaid
from (age_group ag left join fives_team ft on((ft.age_group_id = ag.id)))
group by ag.id

