-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: proyecto_sergio
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
  `nit` varchar(20) NOT NULL,
  `numero_cuenta` varchar(50) NOT NULL,
  `codigo_cuenta` varchar(20) NOT NULL,
  `terminos_pdf` varchar(100) DEFAULT NULL,
  `politicas_pdf` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nit` (`nit`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datos_app`
--

LOCK TABLES `datos_app` WRITE;
/*!40000 ALTER TABLE `datos_app` DISABLE KEYS */;
INSERT INTO `datos_app` VALUES (1,'Proyecto','Calle','12345','12345','12345','12345',NULL,NULL);
/*!40000 ALTER TABLE `datos_app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datos_horno`
--

DROP TABLE IF EXISTS `datos_horno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datos_horno` (
  `id` int NOT NULL AUTO_INCREMENT,
  `zona` varchar(20) DEFAULT NULL,
  `temperatura_real` float DEFAULT NULL,
  `temperatura_objetivo` float DEFAULT NULL,
  `tiempo` int DEFAULT NULL,
  `presion` float DEFAULT NULL,
  `estado` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datos_horno`
--

LOCK TABLES `datos_horno` WRITE;
/*!40000 ALTER TABLE `datos_horno` DISABLE KEYS */;
INSERT INTO `datos_horno` VALUES (1,'Zona 1',250,300,120,1.2,'ok'),(2,'Zona 2',270,300,140,1.3,'ok'),(3,'Zona 3',290,310,160,1.5,'alerta'),(4,'Zona 4',320,310,180,1.8,'error');
/*!40000 ALTER TABLE `datos_horno` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_actividad`
--

LOCK TABLES `log_actividad` WRITE;
/*!40000 ALTER TABLE `log_actividad` DISABLE KEYS */;
INSERT INTO `log_actividad` VALUES (1,1,'Inicia Sesion','Login','2025-05-15 16:00:15','127.0.0.1'),(2,1,'Ingresa a Home-Usuario','Home-Usuario','2025-05-15 16:00:15','127.0.0.1'),(3,1,'Cierra Sesion','Cierra Sesion','2025-05-15 16:00:26','127.0.0.1'),(4,1,'Inicia Sesion','Login','2025-05-15 16:03:37','127.0.0.1'),(5,1,'Ingresa a Home-Usuario','Home-Usuario','2025-05-15 16:03:37','127.0.0.1'),(6,1,'Inicia Sesion','Login','2025-05-15 16:04:23','127.0.0.1'),(7,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:04:23','127.0.0.1'),(8,1,'Cierra Sesion','Cierra Sesion','2025-05-15 16:04:37','127.0.0.1'),(9,1,'Inicia Sesion','Login','2025-05-15 16:05:54','127.0.0.1'),(10,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:05:54','127.0.0.1'),(11,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:05:56','127.0.0.1'),(12,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:06:24','127.0.0.1'),(13,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:06:37','127.0.0.1'),(14,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:06:40','127.0.0.1'),(15,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:07:20','127.0.0.1'),(16,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:07:23','127.0.0.1'),(17,1,'Inicia Sesion','Login','2025-05-15 16:08:01','127.0.0.1'),(18,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:08:01','127.0.0.1'),(19,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:08:09','127.0.0.1'),(20,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:09:33','127.0.0.1'),(21,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:09:35','127.0.0.1'),(22,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:15:29','127.0.0.1'),(23,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:15:31','127.0.0.1'),(24,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:16:49','127.0.0.1'),(25,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:16:58','127.0.0.1'),(26,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:18:14','127.0.0.1'),(27,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:18:47','127.0.0.1'),(28,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:18:58','127.0.0.1'),(29,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:20:38','127.0.0.1'),(30,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:20:50','127.0.0.1'),(31,1,'Inicia Sesion','Login','2025-05-15 16:34:46','127.0.0.1'),(32,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:34:46','127.0.0.1'),(33,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:36:15','127.0.0.1'),(34,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:36:37','127.0.0.1'),(35,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:38:01','127.0.0.1'),(36,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:38:02','127.0.0.1'),(37,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:38:03','127.0.0.1'),(38,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:38:11','127.0.0.1'),(39,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:38:19','127.0.0.1'),(40,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:38:21','127.0.0.1'),(41,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:38:40','127.0.0.1'),(42,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:39:28','127.0.0.1'),(43,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:39:28','127.0.0.1'),(44,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:42:13','127.0.0.1'),(45,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:43:00','127.0.0.1'),(46,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:43:02','127.0.0.1'),(47,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:43:13','127.0.0.1'),(48,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:43:30','127.0.0.1'),(49,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:43:30','127.0.0.1'),(50,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:43:32','127.0.0.1'),(51,1,'Cierra Sesion','Cierra Sesion','2025-05-15 16:43:43','127.0.0.1'),(52,1,'Inicia Sesion','Login','2025-05-15 16:43:49','127.0.0.1'),(53,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:43:49','127.0.0.1'),(54,1,'Inicia Sesion','Login','2025-05-15 16:44:15','127.0.0.1'),(55,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:44:15','127.0.0.1'),(56,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:46:04','127.0.0.1'),(57,1,'Cierra Sesion','Cierra Sesion','2025-05-15 16:46:06','127.0.0.1'),(58,1,'Inicia Sesion','Login','2025-05-15 16:47:56','127.0.0.1'),(59,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:47:56','127.0.0.1'),(60,1,'Visualiza Lista Usuarios','Usuarios','2025-05-15 16:48:07','127.0.0.1'),(61,1,'Inicia Sesion','Login','2025-05-15 16:49:01','127.0.0.1'),(62,1,'Ingresa a Home-Admin','Home-Admin','2025-05-15 16:49:01','127.0.0.1');
/*!40000 ALTER TABLE `log_actividad` ENABLE KEYS */;
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

-- Dump completed on 2025-05-15 17:10:16
