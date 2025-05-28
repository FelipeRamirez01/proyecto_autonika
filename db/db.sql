-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: autonika
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
-- Table structure for table `apilado`
--
use railway;

DROP TABLE IF EXISTS `apilado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apilado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maquina_id` int NOT NULL,
  `mesas_endagadas` int DEFAULT NULL,
  `tiempo_ultima_mesa` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `maquina_id` (`maquina_id`),
  CONSTRAINT `apilado_ibfk_1` FOREIGN KEY (`maquina_id`) REFERENCES `maquina` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apilado`
--

LOCK TABLES `apilado` WRITE;
/*!40000 ALTER TABLE `apilado` DISABLE KEYS */;
/*!40000 ALTER TABLE `apilado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datos_app`
--

DROP TABLE IF EXISTS `datos_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datos_app` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `email` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datos_app`
--

LOCK TABLES `datos_app` WRITE;
/*!40000 ALTER TABLE `datos_app` DISABLE KEYS */;
INSERT INTO `datos_app` VALUES (1,'CIMET S.A.S','Km 23 via villavicencio Acacias','3142033335','ventas@cimet.com.co');
/*!40000 ALTER TABLE `datos_app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `descargue`
--

DROP TABLE IF EXISTS `descargue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `descargue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maquina_id` int NOT NULL,
  `carros_descargados` int DEFAULT NULL,
  `paquetes_formados` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `maquina_id` (`maquina_id`),
  CONSTRAINT `descargue_ibfk_1` FOREIGN KEY (`maquina_id`) REFERENCES `maquina` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `descargue`
--

LOCK TABLES `descargue` WRITE;
/*!40000 ALTER TABLE `descargue` DISABLE KEYS */;
/*!40000 ALTER TABLE `descargue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horno`
--

DROP TABLE IF EXISTS `horno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horno` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maquina_id` int NOT NULL,
  `carros_empujados_diarios` int DEFAULT NULL,
  `tiempo_entre_empujes` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `maquina_id` (`maquina_id`),
  CONSTRAINT `horno_ibfk_1` FOREIGN KEY (`maquina_id`) REFERENCES `maquina` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horno`
--

LOCK TABLES `horno` WRITE;
/*!40000 ALTER TABLE `horno` DISABLE KEYS */;
INSERT INTO `horno` VALUES (1,1,120,20);
/*!40000 ALTER TABLE `horno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_actividad`
--

DROP TABLE IF EXISTS `log_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_actividad` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `accion` varchar(255) NOT NULL,
  `tipo` varchar(255) DEFAULT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `log_actividad_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_actividad`
--

LOCK TABLES `log_actividad` WRITE;
/*!40000 ALTER TABLE `log_actividad` DISABLE KEYS */;
INSERT INTO `log_actividad` VALUES (1,1,'Inicia Sesion','Login','2025-05-15 16:00:15','127.0.0.1'),(2,1,'Ingresa a Home-Usuario','Home-Usuario','2025-05-15 16:00:15','127.0.0.1'),(3,1,'Cierra Sesion','Cierra Sesion','2025-05-15 16:00:26','127.0.0.1'),(4,1,'Inicia Sesion','Login','2025-05-15 16:03:37','127.0.0.1'),(5,1,'Ingresa a Home-Usuario','Home-Usuario','2025-05-15 16:03:37','127.0.0.1'),(6,1,'Inicia Sesion','Login','2025-05-15 16:04:23','127.0.0.1'),(7,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:04:23','127.0.0.1'),(8,1,'Cierra Sesion','Cierra Sesion','2025-05-15 16:04:37','127.0.0.1'),(9,1,'Inicia Sesion','Login','2025-05-15 16:05:54','127.0.0.1'),(10,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:05:54','127.0.0.1'),(11,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:05:56','127.0.0.1'),(12,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:06:24','127.0.0.1'),(13,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:06:37','127.0.0.1'),(14,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:06:40','127.0.0.1'),(15,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:07:20','127.0.0.1'),(16,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:07:23','127.0.0.1'),(17,1,'Inicia Sesion','Login','2025-05-15 16:08:01','127.0.0.1'),(18,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:08:01','127.0.0.1'),(19,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:08:09','127.0.0.1'),(20,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:09:33','127.0.0.1'),(21,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:09:35','127.0.0.1'),(22,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:15:29','127.0.0.1'),(23,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:15:31','127.0.0.1'),(24,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:16:49','127.0.0.1'),(25,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:16:58','127.0.0.1'),(26,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:18:14','127.0.0.1'),(27,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:18:47','127.0.0.1'),(28,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:18:58','127.0.0.1'),(29,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:20:38','127.0.0.1'),(30,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:20:50','127.0.0.1'),(31,1,'Inicia Sesion','Login','2025-05-15 16:34:46','127.0.0.1'),(32,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:34:46','127.0.0.1'),(33,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:36:15','127.0.0.1'),(34,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:36:37','127.0.0.1'),(35,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:38:01','127.0.0.1'),(36,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:38:02','127.0.0.1'),(37,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:38:03','127.0.0.1'),(38,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:38:11','127.0.0.1'),(39,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:38:19','127.0.0.1'),(40,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:38:21','127.0.0.1'),(41,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:38:40','127.0.0.1'),(42,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:39:28','127.0.0.1'),(43,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:39:28','127.0.0.1'),(44,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:42:13','127.0.0.1'),(45,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:43:00','127.0.0.1'),(46,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:43:02','127.0.0.1'),(47,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:43:13','127.0.0.1'),(48,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:43:30','127.0.0.1'),(49,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:43:30','127.0.0.1'),(50,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:43:32','127.0.0.1'),(51,1,'Cierra Sesion','Cierra Sesion','2025-05-15 16:43:43','127.0.0.1'),(52,1,'Inicia Sesion','Login','2025-05-15 16:43:49','127.0.0.1'),(53,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:43:49','127.0.0.1'),(54,1,'Inicia Sesion','Login','2025-05-15 16:44:15','127.0.0.1'),(55,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:44:15','127.0.0.1'),(56,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:46:04','127.0.0.1'),(57,1,'Cierra Sesion','Cierra Sesion','2025-05-15 16:46:06','127.0.0.1'),(58,1,'Inicia Sesion','Login','2025-05-15 16:47:56','127.0.0.1'),(59,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:47:56','127.0.0.1'),(60,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:48:07','127.0.0.1'),(61,1,'Inicia Sesion','Login','2025-05-15 16:49:01','127.0.0.1'),(62,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:49:01','127.0.0.1'),(63,1,'Inicia Sesion','Login','2025-05-23 11:12:56','127.0.0.1'),(64,1,'Ingresa a Home-Admin','Home-Admin','2025-05-23 11:12:56','127.0.0.1'),(65,1,'Visualiza Lista Usuarios','Usuarios','2025-05-23 11:13:00','127.0.0.1'),(66,1,'Inicia Sesion','Login','2025-05-23 11:14:31','127.0.0.1'),(67,1,'Ingresa a Home-Admin','Home-Admin','2025-05-23 11:14:31','127.0.0.1'),(68,1,'Inicia Sesion','Login','2025-05-23 15:43:30','127.0.0.1'),(69,1,'Ingresa a Home-Admin','Home-Admin','2025-05-23 15:43:30','127.0.0.1'),(70,1,'Inicia Sesion','Login','2025-05-23 15:45:02','127.0.0.1'),(71,1,'Ingresa a Home-Admin','Home-Admin','2025-05-23 15:45:02','127.0.0.1'),(72,1,'Inicia Sesion','Login','2025-05-23 15:46:43','127.0.0.1'),(73,1,'Ingresa a Home-Admin','Home-Admin','2025-05-23 15:46:43','127.0.0.1'),(74,1,'Inicia Sesion','Login','2025-05-23 15:48:53','127.0.0.1'),(75,1,'Ingresa a Home-Admin','Home-Admin','2025-05-23 15:48:53','127.0.0.1'),(76,1,'Ingresa a Home-Admin','Home-Admin','2025-05-23 15:55:28','127.0.0.1'),(77,1,'Visualiza Lista Usuarios','Usuarios','2025-05-23 15:58:06','127.0.0.1'),(78,1,'Inicia Sesion','Login','2025-05-23 16:10:52','127.0.0.1'),(79,1,'Ingresa a Home-Admin','Home-Admin','2025-05-23 16:10:52','127.0.0.1'),(80,1,'Ingresa a Home-Admin','Home-Admin','2025-05-23 16:11:18','127.0.0.1'),(81,1,'Visualiza Lista Usuarios','Usuarios','2025-05-23 16:15:20','127.0.0.1'),(82,1,'Visualiza Lista Usuarios','Usuarios','2025-05-23 16:16:26','127.0.0.1'),(83,1,'Visualiza Lista Usuarios','Usuarios','2025-05-23 16:16:27','127.0.0.1'),(84,1,'Ingresa a Home-Admin','Home-Admin','2025-05-23 16:22:02','127.0.0.1'),(85,1,'Visualiza Lista Usuarios','Usuarios','2025-05-23 16:22:07','127.0.0.1'),(86,1,'Visualiza Lista Usuarios','Usuarios','2025-05-23 16:22:12','127.0.0.1'),(87,1,'Inicia Sesion','Login','2025-05-23 16:27:37','127.0.0.1'),(88,1,'Ingresa a Home-Admin','Home-Admin','2025-05-23 16:27:37','127.0.0.1'),(89,1,'Inicia Sesion','Login','2025-05-23 16:30:37','127.0.0.1'),(90,1,'Ingresa a Home-Admin','Home-Admin','2025-05-23 16:30:37','127.0.0.1'),(91,1,'Inicia Sesion','Login','2025-05-23 16:41:28','127.0.0.1'),(92,1,'Ingresa a Home-Admin','Home-Admin','2025-05-23 16:41:28','127.0.0.1'),(93,1,'Ingresa a Home-Admin','Home-Admin','2025-05-23 16:41:39','127.0.0.1'),(94,1,'Visualiza Lista Usuarios','Usuarios','2025-05-23 16:41:55','127.0.0.1'),(95,1,'Ingresa a Home-Usuario','Home-Usuario','2025-05-23 16:43:20','127.0.0.1'),(96,1,'Ingresa a Home-Usuario','Home-Usuario','2025-05-23 16:43:33','127.0.0.1'),(97,1,'Ingresa a Home-Usuario','Home-Usuario','2025-05-23 16:43:35','127.0.0.1'),(98,1,'Ingresa a Home-Usuario','Home-Usuario','2025-05-23 16:43:36','127.0.0.1'),(99,1,'Ingresa a Home-Admin','Home-Admin','2025-05-23 16:43:47','127.0.0.1'),(100,1,'Inicia Sesion','Login','2025-05-25 09:32:25','127.0.0.1'),(101,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 09:32:25','127.0.0.1'),(102,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 09:32:29','127.0.0.1'),(103,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 09:32:35','127.0.0.1'),(104,1,'Inicia Sesion','Login','2025-05-25 09:33:57','127.0.0.1'),(105,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 09:33:57','127.0.0.1'),(106,1,'Inicia Sesion','Login','2025-05-25 10:05:16','127.0.0.1'),(107,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 10:05:16','127.0.0.1'),(108,1,'Inicia Sesion','Login','2025-05-25 10:11:54','127.0.0.1'),(109,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 10:11:54','127.0.0.1'),(110,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:11:57','127.0.0.1'),(111,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:12:55','127.0.0.1'),(112,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:12:57','127.0.0.1'),(113,1,'Inicia Sesion','Login','2025-05-25 10:14:02','127.0.0.1'),(114,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 10:14:02','127.0.0.1'),(115,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:14:04','127.0.0.1'),(116,1,'Inicia Sesion','Login','2025-05-25 10:16:55','127.0.0.1'),(117,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 10:16:55','127.0.0.1'),(118,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:16:57','127.0.0.1'),(119,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 10:17:04','127.0.0.1'),(120,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:17:12','127.0.0.1'),(121,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 10:17:40','127.0.0.1'),(122,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:17:57','127.0.0.1'),(123,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 10:18:02','127.0.0.1'),(124,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:18:10','127.0.0.1'),(125,1,'Lista Roles','Roles','2025-05-25 10:18:11','127.0.0.1'),(126,1,'Lista Usuarios Logs','Auditoria','2025-05-25 10:18:56','127.0.0.1'),(127,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:18:58','127.0.0.1'),(128,1,'Lista Roles','Roles','2025-05-25 10:18:58','127.0.0.1'),(129,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:19:05','127.0.0.1'),(130,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:19:07','127.0.0.1'),(131,1,'Modifica Datos del conjunto','Configuracion','2025-05-25 10:21:40','127.0.0.1'),(132,1,'Inicia Sesion','Login','2025-05-25 10:23:59','127.0.0.1'),(133,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 10:23:59','127.0.0.1'),(134,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:24:00','127.0.0.1'),(135,1,'Modifica Datos del conjunto','Configuracion','2025-05-25 10:25:22','127.0.0.1'),(136,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:25:35','127.0.0.1'),(137,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 10:25:37','127.0.0.1'),(138,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 10:26:01','127.0.0.1'),(139,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:26:05','127.0.0.1'),(140,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 10:26:07','127.0.0.1'),(141,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:26:07','127.0.0.1'),(142,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 10:26:19','127.0.0.1'),(143,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 10:26:21','127.0.0.1'),(144,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 10:26:32','127.0.0.1'),(145,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 10:27:33','127.0.0.1'),(146,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 10:31:35','127.0.0.1'),(147,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 10:31:39','127.0.0.1'),(148,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:31:41','127.0.0.1'),(149,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 10:31:43','127.0.0.1'),(150,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 10:34:58','127.0.0.1'),(151,1,'Cierra Sesion','Cierra Sesion','2025-05-25 10:37:26','127.0.0.1'),(152,1,'Inicia Sesion','Login','2025-05-25 10:39:01','127.0.0.1'),(153,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 10:39:01','127.0.0.1'),(154,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 10:39:03','127.0.0.1'),(155,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 10:39:09','127.0.0.1'),(156,1,'Cierra Sesion','Cierra Sesion','2025-05-25 10:39:10','127.0.0.1'),(157,1,'Inicia Sesion','Login','2025-05-25 10:40:29','127.0.0.1'),(158,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 10:40:29','127.0.0.1'),(159,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 10:40:34','127.0.0.1'),(160,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 10:40:39','127.0.0.1'),(161,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 10:40:45','127.0.0.1'),(162,1,'Inicia Sesion','Login','2025-05-25 11:42:30','127.0.0.1'),(163,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 11:42:30','127.0.0.1'),(164,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 11:43:24','127.0.0.1'),(165,1,'Inicia Sesion','Login','2025-05-25 11:46:26','127.0.0.1'),(166,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 11:46:26','127.0.0.1'),(167,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 11:48:38','127.0.0.1'),(168,1,'Visualiza opciones de configuracion','Configuracion','2025-05-25 11:49:11','127.0.0.1'),(169,1,'Inicia Sesion','Login','2025-05-25 12:09:35','127.0.0.1'),(170,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 12:09:35','127.0.0.1'),(171,1,'Inicia Sesion','Login','2025-05-25 12:11:23','127.0.0.1'),(172,1,'Ingresa a Home-Admin','Home-Admin','2025-05-25 12:11:23','127.0.0.1'),(173,1,'Visualiza Lista Usuarios','Usuarios','2025-05-25 12:18:54','127.0.0.1'),(174,1,'Cierra Sesion','Cierra Sesion','2025-05-25 12:18:59','127.0.0.1'),(175,1,'Inicia Sesion','Login','2025-05-27 14:35:51','127.0.0.1'),(176,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 14:35:51','127.0.0.1'),(177,1,'Inicia Sesion','Login','2025-05-27 14:38:22','127.0.0.1'),(178,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 14:38:22','127.0.0.1'),(179,1,'Inicia Sesion','Login','2025-05-27 14:39:23','127.0.0.1'),(180,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 14:39:23','127.0.0.1'),(181,1,'Visualiza Lista Usuarios','Usuarios','2025-05-27 14:44:08','127.0.0.1'),(182,1,'Inicia Sesion','Login','2025-05-27 14:44:30','127.0.0.1'),(183,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 14:44:30','127.0.0.1'),(184,1,'Inicia Sesion','Login','2025-05-27 14:45:02','127.0.0.1'),(185,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 14:45:02','127.0.0.1'),(186,1,'Inicia Sesion','Login','2025-05-27 14:45:56','127.0.0.1'),(187,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 14:45:56','127.0.0.1'),(188,1,'Inicia Sesion','Login','2025-05-27 14:46:59','127.0.0.1'),(189,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 14:46:59','127.0.0.1'),(190,1,'Inicia Sesion','Login','2025-05-27 14:47:39','127.0.0.1'),(191,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 14:47:39','127.0.0.1'),(192,1,'Inicia Sesion','Login','2025-05-27 14:49:46','127.0.0.1'),(193,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 14:49:46','127.0.0.1'),(194,1,'Inicia Sesion','Login','2025-05-27 14:50:18','127.0.0.1'),(195,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 14:50:18','127.0.0.1'),(196,1,'Inicia Sesion','Login','2025-05-27 14:50:56','127.0.0.1'),(197,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 14:50:56','127.0.0.1'),(198,1,'Inicia Sesion','Login','2025-05-27 14:52:34','127.0.0.1'),(199,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 14:52:34','127.0.0.1'),(200,1,'Inicia Sesion','Login','2025-05-27 15:28:42','127.0.0.1'),(201,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 15:28:42','127.0.0.1'),(202,1,'Inicia Sesion','Login','2025-05-27 15:29:09','127.0.0.1'),(203,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 15:29:09','127.0.0.1'),(204,1,'Inicia Sesion','Login','2025-05-27 15:29:40','127.0.0.1'),(205,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 15:29:40','127.0.0.1'),(206,1,'Inicia Sesion','Login','2025-05-27 15:30:49','127.0.0.1'),(207,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 15:30:49','127.0.0.1'),(208,1,'Inicia Sesion','Login','2025-05-27 15:33:53','127.0.0.1'),(209,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 15:33:53','127.0.0.1'),(210,1,'Inicia Sesion','Login','2025-05-27 15:36:49','127.0.0.1'),(211,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 15:36:49','127.0.0.1'),(212,1,'Inicia Sesion','Login','2025-05-27 15:37:22','127.0.0.1'),(213,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 15:37:22','127.0.0.1'),(214,1,'Inicia Sesion','Login','2025-05-27 15:48:01','127.0.0.1'),(215,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 15:48:01','127.0.0.1'),(216,1,'Inicia Sesion','Login','2025-05-27 15:55:03','127.0.0.1'),(217,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 15:55:03','127.0.0.1'),(218,1,'Inicia Sesion','Login','2025-05-27 15:56:05','127.0.0.1'),(219,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 15:56:05','127.0.0.1'),(220,1,'Inicia Sesion','Login','2025-05-27 16:16:09','127.0.0.1'),(221,1,'Ingresa a Home-Admin','Home-Admin','2025-05-27 16:16:09','127.0.0.1');
/*!40000 ALTER TABLE `log_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maquina`
--

DROP TABLE IF EXISTS `maquina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maquina` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `ubicacion` varchar(100) NOT NULL,
  `temperatura_max` float DEFAULT NULL,
  `temperatura_min` float DEFAULT NULL,
  `velocidad` float DEFAULT NULL,
  `produccion_min` int DEFAULT NULL,
  `tipo` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maquina`
--

LOCK TABLES `maquina` WRITE;
/*!40000 ALTER TABLE `maquina` DISABLE KEYS */;
INSERT INTO `maquina` VALUES (1,'HORNO PRINCIPAL','CUARTO 3',1,1,1,1,'horno');
/*!40000 ALTER TABLE `maquina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moldeo`
--

DROP TABLE IF EXISTS `moldeo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moldeo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maquina_id` int NOT NULL,
  `cortes_por_minuto` int DEFAULT NULL,
  `velocidad_cajones` float DEFAULT NULL,
  `velocidad_extrusora` float DEFAULT NULL,
  `tiempo_parada` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `maquina_id` (`maquina_id`),
  CONSTRAINT `moldeo_ibfk_1` FOREIGN KEY (`maquina_id`) REFERENCES `maquina` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moldeo`
--

LOCK TABLES `moldeo` WRITE;
/*!40000 ALTER TABLE `moldeo` DISABLE KEYS */;
/*!40000 ALTER TABLE `moldeo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permisos`
--

DROP TABLE IF EXISTS `permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permisos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `tipo` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permisos`
--

LOCK TABLES `permisos` WRITE;
/*!40000 ALTER TABLE `permisos` DISABLE KEYS */;
INSERT INTO `permisos` VALUES (1,'Registro','Usuarios'),(2,'Modificar','Usuarios');
/*!40000 ALTER TABLE `permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol_permiso`
--

DROP TABLE IF EXISTS `rol_permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol_permiso` (
  `rol_id` int NOT NULL,
  `permiso_id` int NOT NULL,
  PRIMARY KEY (`rol_id`,`permiso_id`),
  KEY `permiso_id` (`permiso_id`),
  CONSTRAINT `rol_permiso_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rol_permiso_ibfk_2` FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol_permiso`
--

LOCK TABLES `rol_permiso` WRITE;
/*!40000 ALTER TABLE `rol_permiso` DISABLE KEYS */;
INSERT INTO `rol_permiso` VALUES (2,1),(2,2);
/*!40000 ALTER TABLE `rol_permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador'),(2,'Usuario');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `secador`
--

DROP TABLE IF EXISTS `secador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `secador` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maquina_id` int NOT NULL,
  `descargue_bajometa_tiempo` float DEFAULT NULL,
  `tiempo_carga_bajonetas` float DEFAULT NULL,
  `funcionamiento_brazo_descargue` tinyint(1) DEFAULT NULL,
  `funcionamiento_brazo_cargue` tinyint(1) DEFAULT NULL,
  `temperatura_secador` float DEFAULT NULL,
  `bajonetas_ingresadas` int DEFAULT NULL,
  `bajonetas_salidas` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `maquina_id` (`maquina_id`),
  CONSTRAINT `secador_ibfk_1` FOREIGN KEY (`maquina_id`) REFERENCES `maquina` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `secador`
--

LOCK TABLES `secador` WRITE;
/*!40000 ALTER TABLE `secador` DISABLE KEYS */;
/*!40000 ALTER TABLE `secador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temperatura_horno`
--

DROP TABLE IF EXISTS `temperatura_horno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temperatura_horno` (
  `id` int NOT NULL AUTO_INCREMENT,
  `horno_id` int NOT NULL,
  `fecha` datetime NOT NULL,
  `temperatura_1` float DEFAULT NULL,
  `temperatura_2` float DEFAULT NULL,
  `temperatura_3` float DEFAULT NULL,
  `temperatura_4` float DEFAULT NULL,
  `temperatura_5` float DEFAULT NULL,
  `temperatura_6` float DEFAULT NULL,
  `temperatura_7` float DEFAULT NULL,
  `temperatura_8` float DEFAULT NULL,
  `temperatura_9` float DEFAULT NULL,
  `temperatura_10` float DEFAULT NULL,
  `temperatura_11` float DEFAULT NULL,
  `temperatura_12` float DEFAULT NULL,
  `temperatura_13` float DEFAULT NULL,
  `temperatura_14` float DEFAULT NULL,
  `temperatura_15` float DEFAULT NULL,
  `temperatura_16` float DEFAULT NULL,
  `temperatura_17` float DEFAULT NULL,
  `temperatura_18` float DEFAULT NULL,
  `temperatura_19` float DEFAULT NULL,
  `temperatura_20` float DEFAULT NULL,
  `temperatura_21` float DEFAULT NULL,
  `temperatura_22` float DEFAULT NULL,
  `temperatura_23` float DEFAULT NULL,
  `temperatura_24` float DEFAULT NULL,
  `temperatura_25` float DEFAULT NULL,
  `temperatura_26` float DEFAULT NULL,
  `temperatura_27` float DEFAULT NULL,
  `temperatura_28` float DEFAULT NULL,
  `temperatura_29` float DEFAULT NULL,
  `temperatura_30` float DEFAULT NULL,
  `temperatura_31` float DEFAULT NULL,
  `temperatura_32` float DEFAULT NULL,
  `temperatura_33` float DEFAULT NULL,
  `temperatura_34` float DEFAULT NULL,
  `temperatura_35` float DEFAULT NULL,
  `temperatura_36` float DEFAULT NULL,
  `temperatura_37` float DEFAULT NULL,
  `temperatura_38` float DEFAULT NULL,
  `temperatura_39` float DEFAULT NULL,
  `temperatura_40` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `horno_id` (`horno_id`),
  CONSTRAINT `temperatura_horno_ibfk_1` FOREIGN KEY (`horno_id`) REFERENCES `horno` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temperatura_horno`
--

LOCK TABLES `temperatura_horno` WRITE;
/*!40000 ALTER TABLE `temperatura_horno` DISABLE KEYS */;
INSERT INTO `temperatura_horno` VALUES (1,1,'2025-05-27 14:30:00',40,38,41,42,37,35,40,41,50,20,53,41,42,48,35,62,54,25,55,50,51,21,42,23,50,41,42,22,38,40,12,52,40,40,41,43,55,55,60,70);
/*!40000 ALTER TABLE `temperatura_horno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `identificacion` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `estado` int NOT NULL DEFAULT '1',
  `codigo_temporal` varchar(255) DEFAULT NULL,
  `fecha_temporal` datetime DEFAULT NULL,
  `id_rol` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'admin','11111111','admin@gmail.com','scrypt:32768:8:1$GjLmhsIwg7oCZkPV$f14971f6e32d5a0b7ef0eac674b6c8c556cafeeccfa0f332e9dc03589b50e0d6137a48797be08c7fa1e18950fe4f125c1b076047e42126f7da9d431f13981ea6','12345',1,NULL,NULL,1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-27 16:46:46
