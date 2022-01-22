CREATE DATABASE  IF NOT EXISTS `hotel` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `hotel`;
-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: hotel
-- ------------------------------------------------------
-- Server version	5.7.24-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cat_habitacion_equipamiento`
--

DROP TABLE IF EXISTS `cat_habitacion_equipamiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `cat_habitacion_equipamiento` (
  `idCategoria` int(11) NOT NULL,
  `idEquipamiento` int(11) NOT NULL,
  PRIMARY KEY (`idCategoria`,`idEquipamiento`),
  KEY `fk_CATEGORIA_HABITACION_has_EQUIPAMIENTO_EQUIPAMIENTO1_idx` (`idEquipamiento`),
  KEY `fk_CATEGORIA_HABITACION_has_EQUIPAMIENTO_CATEGORIA_HABITACI_idx` (`idCategoria`),
  CONSTRAINT `fk_CATEGORIA_HABITACION_has_EQUIPAMIENTO_CATEGORIA_HABITACION1` FOREIGN KEY (`idCategoria`) REFERENCES `categoria_habitacion` (`idCategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CATEGORIA_HABITACION_has_EQUIPAMIENTO_EQUIPAMIENTO1` FOREIGN KEY (`idEquipamiento`) REFERENCES `equipamiento` (`idEquipamiento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_habitacion_equipamiento`
--

LOCK TABLES `cat_habitacion_equipamiento` WRITE;
/*!40000 ALTER TABLE `cat_habitacion_equipamiento` DISABLE KEYS */;
INSERT INTO `cat_habitacion_equipamiento` VALUES (1,1),(2,1),(3,1),(4,1),(1,2),(2,2),(3,2),(4,2),(2,3),(3,3),(4,3),(3,4),(4,4),(4,5),(4,6),(4,7);
/*!40000 ALTER TABLE `cat_habitacion_equipamiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria_habitacion`
--

DROP TABLE IF EXISTS `categoria_habitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categoria_habitacion` (
  `idCategoria` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL COMMENT 'Económico\nBásico\nIntermedio\nCompleto',
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_habitacion`
--

LOCK TABLES `categoria_habitacion` WRITE;
/*!40000 ALTER TABLE `categoria_habitacion` DISABLE KEYS */;
INSERT INTO `categoria_habitacion` VALUES (1,'Económico'),(2,'Básico'),(3,'Intermedio'),(4,'Completo');
/*!40000 ALTER TABLE `categoria_habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `cliente` (
  `idCliente` int(11) NOT NULL,
  `fechaRegistro` date NOT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCliente`),
  KEY `fk_CLIENTE_PERSONA1_idx` (`idCliente`),
  KEY `fk_CLIENTE_USUARIO2_idx` (`idUsuario`),
  CONSTRAINT `fk_CLIENTE_PERSONA1` FOREIGN KEY (`idCliente`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CLIENTE_USUARIO2` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 PACK_KEYS=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'2017-12-05',NULL),(2,'2017-12-04',NULL),(3,'2017-12-04',NULL),(6,'2017-01-04',NULL),(8,'2017-12-04',NULL),(9,'2017-12-13',NULL),(10,'2017-11-30',NULL),(11,'2017-12-09',NULL),(13,'2017-12-08',NULL),(15,'2017-12-04',NULL),(17,'2017-12-06',NULL),(19,'2017-12-08',NULL),(20,'2017-11-30',NULL),(21,'2017-12-18',NULL),(23,'2017-12-04',NULL),(25,'2017-12-05',NULL),(26,'2017-12-05',NULL),(27,'2017-12-06',NULL),(28,'2017-12-06',NULL);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_gasto`
--

DROP TABLE IF EXISTS `detalle_gasto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `detalle_gasto` (
  `idGasto` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `costo` decimal(11,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`idGasto`,`idProducto`),
  KEY `fk_GASTO_has_PRODUCTO_PRODUCTO1_idx` (`idProducto`),
  KEY `fk_GASTO_has_PRODUCTO_GASTO1_idx` (`idGasto`),
  CONSTRAINT `fk_GASTO_has_PRODUCTO_GASTO1` FOREIGN KEY (`idGasto`) REFERENCES `gasto` (`idGasto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GASTO_has_PRODUCTO_PRODUCTO1` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_gasto`
--

LOCK TABLES `detalle_gasto` WRITE;
/*!40000 ALTER TABLE `detalle_gasto` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_gasto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enlace`
--

DROP TABLE IF EXISTS `enlace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `enlace` (
  `idEnlace` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `ruta` varchar(45) NOT NULL,
  PRIMARY KEY (`idEnlace`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enlace`
--

LOCK TABLES `enlace` WRITE;
/*!40000 ALTER TABLE `enlace` DISABLE KEYS */;
INSERT INTO `enlace` VALUES (1,'Crud Cliente','CrudCliente.jsp'),(2,'Crud Trabajador','CrudTrabajador.jsp'),(3,'Crud Producto','CrudProducto.jsp'),(4,'Crud Habitacion','CrudHabitacion.jsp'),(5,'Consulta Trabajador Por Fecha Contratacion','ConsultaTrabajadorPorFechaContratacion.jsp'),(6,'Consulta Trabajador Por Fecha Nacimiento','ConsultaTrabajadorPorFechaNacimiento.jsp'),(7,'Registro Hospedaje','RegistroHospedaje.jsp'),(8,'Consulta Cliente Por Fecha Nacimiento','ConsultaClientePorFechaNacimiento.jsp'),(9,'Consulta Hospedajes por Fecha de Ingreso','ConsultaHospedajesPorFechaIngreso.jsp');
/*!40000 ALTER TABLE `enlace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipamiento`
--

DROP TABLE IF EXISTS `equipamiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `equipamiento` (
  `idEquipamiento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL COMMENT 'Frío Bar\nTV\nAire Acondicionado\nBlue Ray\nWifi\nDirectTV\nInternet\nNetflix',
  PRIMARY KEY (`idEquipamiento`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipamiento`
--

LOCK TABLES `equipamiento` WRITE;
/*!40000 ALTER TABLE `equipamiento` DISABLE KEYS */;
INSERT INTO `equipamiento` VALUES (1,'Frío Bar'),(2,'TV'),(3,'Aire acondicionado'),(4,'Blue Ray'),(5,'Wi fi'),(6,'Direct TV'),(7,'Internet');
/*!40000 ALTER TABLE `equipamiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_cuenta`
--

DROP TABLE IF EXISTS `estado_cuenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `estado_cuenta` (
  `idEstadoCuenta` int(11) NOT NULL AUTO_INCREMENT,
  `costoTotal` decimal(11,2) NOT NULL,
  `idHospedaje` int(11) NOT NULL,
  PRIMARY KEY (`idEstadoCuenta`),
  KEY `fk_ESTADO_CUENTA_HOSPEDAJE1_idx` (`idHospedaje`),
  CONSTRAINT `fk_ESTADO_CUENTA_HOSPEDAJE1` FOREIGN KEY (`idHospedaje`) REFERENCES `hospedaje` (`idHospedaje`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_cuenta`
--

LOCK TABLES `estado_cuenta` WRITE;
/*!40000 ALTER TABLE `estado_cuenta` DISABLE KEYS */;
/*!40000 ALTER TABLE `estado_cuenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_habitacion`
--

DROP TABLE IF EXISTS `estado_habitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `estado_habitacion` (
  `idEstado` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL COMMENT 'Disponible\nReservada\nMantenimiento\nOcupada',
  PRIMARY KEY (`idEstado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_habitacion`
--

LOCK TABLES `estado_habitacion` WRITE;
/*!40000 ALTER TABLE `estado_habitacion` DISABLE KEYS */;
INSERT INTO `estado_habitacion` VALUES (1,'Disponible'),(2,'Reservada'),(3,'Mantenimiento'),(4,'Ocupada');
/*!40000 ALTER TABLE `estado_habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gasto`
--

DROP TABLE IF EXISTS `gasto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `gasto` (
  `idGasto` int(11) NOT NULL AUTO_INCREMENT,
  `idHospedaje` int(11) NOT NULL,
  `igv` decimal(4,2) NOT NULL,
  `fecha` date NOT NULL,
  `idTrabajador` int(11) NOT NULL,
  PRIMARY KEY (`idGasto`),
  KEY `fk_GASTO_HOSPEDAJE1_idx` (`idHospedaje`),
  KEY `fk_GASTO_TRABAJADOR1_idx` (`idTrabajador`),
  CONSTRAINT `fk_GASTO_HOSPEDAJE1` FOREIGN KEY (`idHospedaje`) REFERENCES `hospedaje` (`idHospedaje`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GASTO_TRABAJADOR1` FOREIGN KEY (`idTrabajador`) REFERENCES `trabajador` (`idTrabajador`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gasto`
--

LOCK TABLES `gasto` WRITE;
/*!40000 ALTER TABLE `gasto` DISABLE KEYS */;
/*!40000 ALTER TABLE `gasto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habitacion`
--

DROP TABLE IF EXISTS `habitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `habitacion` (
  `idHabitacion` int(11) NOT NULL AUTO_INCREMENT,
  `numero` int(11) NOT NULL,
  `piso` int(11) NOT NULL,
  `idTipo` int(11) NOT NULL,
  `idCategoria` int(11) NOT NULL,
  `idEstado` int(11) NOT NULL,
  `costo` decimal(11,2) NOT NULL,
  PRIMARY KEY (`idHabitacion`),
  KEY `fk_HABITACION_TIPO_HABITACION1_idx` (`idTipo`),
  KEY `fk_HABITACION_CATEGORIA_HABITACION1_idx` (`idCategoria`),
  KEY `fk_HABITACION_ESTADO_HABITACION1_idx` (`idEstado`),
  CONSTRAINT `fk_HABITACION_CATEGORIA_HABITACION1` FOREIGN KEY (`idCategoria`) REFERENCES `categoria_habitacion` (`idCategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_HABITACION_ESTADO_HABITACION1` FOREIGN KEY (`idEstado`) REFERENCES `estado_habitacion` (`idEstado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_HABITACION_TIPO_HABITACION1` FOREIGN KEY (`idTipo`) REFERENCES `tipo_habitacion` (`idTipo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habitacion`
--

LOCK TABLES `habitacion` WRITE;
/*!40000 ALTER TABLE `habitacion` DISABLE KEYS */;
INSERT INTO `habitacion` VALUES (1,1,1,1,1,4,5000.00),(2,2,1,1,1,4,5000.00),(3,3,1,2,2,1,6000.00),(4,4,1,3,4,4,5000.00),(5,5,1,2,3,1,9000.00),(6,1,2,1,1,4,5000.00),(7,6,1,3,4,4,4000.00),(8,7,1,1,4,4,2000.00),(10,8,1,3,4,4,100.00);
/*!40000 ALTER TABLE `habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habitacion_has_reserva`
--

DROP TABLE IF EXISTS `habitacion_has_reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `habitacion_has_reserva` (
  `idHabitacion` int(11) NOT NULL,
  `idReserva` int(11) NOT NULL,
  `costo` decimal(11,2) NOT NULL,
  PRIMARY KEY (`idHabitacion`,`idReserva`),
  KEY `fk_HABITACION_has_RESERVA_RESERVA1_idx` (`idReserva`),
  KEY `fk_HABITACION_has_RESERVA_HABITACION1_idx` (`idHabitacion`),
  CONSTRAINT `fk_HABITACION_has_RESERVA_HABITACION1` FOREIGN KEY (`idHabitacion`) REFERENCES `habitacion` (`idHabitacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_HABITACION_has_RESERVA_RESERVA1` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habitacion_has_reserva`
--

LOCK TABLES `habitacion_has_reserva` WRITE;
/*!40000 ALTER TABLE `habitacion_has_reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `habitacion_has_reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospedaje`
--

DROP TABLE IF EXISTS `hospedaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `hospedaje` (
  `idHospedaje` int(11) NOT NULL AUTO_INCREMENT,
  `fechaIngreso` date NOT NULL,
  `fechaSalida` date NOT NULL,
  `igv` decimal(4,2) NOT NULL,
  `estado` tinyint(4) DEFAULT NULL COMMENT 'Abierto (Se pueden realizar compras, gastos, etc)\nCerrado (Ya no se puede pedir más cosas)',
  `idReserva` int(11) DEFAULT NULL,
  `idCliente` int(11) NOT NULL,
  `idTrabajador` int(11) DEFAULT NULL,
  PRIMARY KEY (`idHospedaje`),
  KEY `fk_HOSPEDAJE_RESERVA1_idx` (`idReserva`),
  KEY `fk_HOSPEDAJE_CLIENTE1_idx` (`idCliente`),
  KEY `fk_HOSPEDAJE_TRABAJADOR1_idx` (`idTrabajador`),
  CONSTRAINT `fk_HOSPEDAJE_CLIENTE1` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_HOSPEDAJE_RESERVA1` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_HOSPEDAJE_TRABAJADOR1` FOREIGN KEY (`idTrabajador`) REFERENCES `trabajador` (`idTrabajador`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospedaje`
--

LOCK TABLES `hospedaje` WRITE;
/*!40000 ALTER TABLE `hospedaje` DISABLE KEYS */;
INSERT INTO `hospedaje` VALUES (7,'2017-12-06','2017-12-08',18.00,NULL,NULL,1,NULL),(8,'2017-12-06','2017-12-13',18.00,NULL,NULL,1,NULL),(9,'2017-12-06','2017-12-13',18.00,NULL,NULL,1,1),(10,'2017-12-06','2017-12-07',18.00,NULL,NULL,28,1),(11,'2017-12-06','2017-12-14',18.00,NULL,NULL,2,1),(12,'2017-12-07','2017-12-30',18.00,NULL,NULL,17,1);
/*!40000 ALTER TABLE `hospedaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospedaje_habitacion`
--

DROP TABLE IF EXISTS `hospedaje_habitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `hospedaje_habitacion` (
  `idHospedaje` int(11) NOT NULL,
  `idHabitacion` int(11) NOT NULL,
  `costo` decimal(11,2) NOT NULL,
  PRIMARY KEY (`idHospedaje`,`idHabitacion`),
  KEY `fk_HOSPEDAJE_has_HABITACION_HABITACION1_idx` (`idHabitacion`),
  KEY `fk_HOSPEDAJE_has_HABITACION_HOSPEDAJE1_idx` (`idHospedaje`),
  CONSTRAINT `fk_HOSPEDAJE_has_HABITACION_HABITACION1` FOREIGN KEY (`idHabitacion`) REFERENCES `habitacion` (`idHabitacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_HOSPEDAJE_has_HABITACION_HOSPEDAJE1` FOREIGN KEY (`idHospedaje`) REFERENCES `hospedaje` (`idHospedaje`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospedaje_habitacion`
--

LOCK TABLES `hospedaje_habitacion` WRITE;
/*!40000 ALTER TABLE `hospedaje_habitacion` DISABLE KEYS */;
INSERT INTO `hospedaje_habitacion` VALUES (7,8,4000.00),(7,10,200.00),(8,4,35000.00),(8,7,28000.00),(8,10,700.00),(9,1,35000.00),(9,2,35000.00),(10,6,5000.00),(11,10,800.00),(12,6,115000.00),(12,7,92000.00),(12,8,46000.00),(12,10,2300.00);
/*!40000 ALTER TABLE `hospedaje_habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospedaje_habitacion_huesped`
--

DROP TABLE IF EXISTS `hospedaje_habitacion_huesped`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `hospedaje_habitacion_huesped` (
  `idHospedaje` int(11) NOT NULL,
  `idHabitacion` int(11) NOT NULL,
  `idHuesped` int(11) NOT NULL,
  PRIMARY KEY (`idHospedaje`,`idHabitacion`,`idHuesped`),
  KEY `fk_HOSPEDAJE_has_HABITACION_has_HUESPED_HUESPED1_idx` (`idHuesped`),
  KEY `fk_HOSPEDAJE_has_HABITACION_has_HUESPED_HOSPEDAJE_has_HABIT_idx` (`idHospedaje`,`idHabitacion`),
  CONSTRAINT `fk_HOSPEDAJE_has_HABITACION_has_HUESPED_HOSPEDAJE_has_HABITAC1` FOREIGN KEY (`idHospedaje`, `idHabitacion`) REFERENCES `hospedaje_habitacion` (`idHospedaje`, `idHabitacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_HOSPEDAJE_has_HABITACION_has_HUESPED_HUESPED1` FOREIGN KEY (`idHuesped`) REFERENCES `huesped` (`idHuesped`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospedaje_habitacion_huesped`
--

LOCK TABLES `hospedaje_habitacion_huesped` WRITE;
/*!40000 ALTER TABLE `hospedaje_habitacion_huesped` DISABLE KEYS */;
/*!40000 ALTER TABLE `hospedaje_habitacion_huesped` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `huesped`
--

DROP TABLE IF EXISTS `huesped`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `huesped` (
  `idHuesped` int(11) NOT NULL,
  `fechaRegistro` date NOT NULL,
  PRIMARY KEY (`idHuesped`),
  KEY `fk_HUESPED_PERSONA1_idx` (`idHuesped`),
  CONSTRAINT `fk_HUESPED_PERSONA1` FOREIGN KEY (`idHuesped`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `huesped`
--

LOCK TABLES `huesped` WRITE;
/*!40000 ALTER TABLE `huesped` DISABLE KEYS */;
/*!40000 ALTER TABLE `huesped` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pago_hospedaje_consumo`
--

DROP TABLE IF EXISTS `pago_hospedaje_consumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `pago_hospedaje_consumo` (
  `idPago` int(11) NOT NULL AUTO_INCREMENT,
  `idHospedaje` int(11) NOT NULL,
  `fechaPago` date NOT NULL,
  `tipoComprobante` varchar(45) NOT NULL,
  `numeroComprobante` varchar(45) NOT NULL,
  `igv` decimal(4,2) NOT NULL,
  `monto` decimal(11,2) NOT NULL,
  PRIMARY KEY (`idPago`),
  KEY `fk_PAGO_HOSPEDAJE_CONSUMO_HOSPEDAJE1_idx` (`idHospedaje`),
  CONSTRAINT `fk_PAGO_HOSPEDAJE_CONSUMO_HOSPEDAJE1` FOREIGN KEY (`idHospedaje`) REFERENCES `hospedaje` (`idHospedaje`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pago_hospedaje_consumo`
--

LOCK TABLES `pago_hospedaje_consumo` WRITE;
/*!40000 ALTER TABLE `pago_hospedaje_consumo` DISABLE KEYS */;
/*!40000 ALTER TABLE `pago_hospedaje_consumo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pago_reserva`
--

DROP TABLE IF EXISTS `pago_reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `pago_reserva` (
  `idPagoReserva` int(11) NOT NULL AUTO_INCREMENT,
  `idReserva` int(11) NOT NULL,
  `fechaPago` date NOT NULL,
  `tipoComprobante` varchar(45) NOT NULL,
  `numeroComprobante` varchar(45) NOT NULL,
  `igv` decimal(4,2) NOT NULL,
  `monto` decimal(11,2) NOT NULL,
  PRIMARY KEY (`idPagoReserva`),
  KEY `fk_PAGO_RESERVA_RESERVA1_idx` (`idReserva`),
  CONSTRAINT `fk_PAGO_RESERVA_RESERVA1` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pago_reserva`
--

LOCK TABLES `pago_reserva` WRITE;
/*!40000 ALTER TABLE `pago_reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `pago_reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `persona` (
  `idPersona` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `dni` varchar(45) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `telefono` varchar(12) DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  PRIMARY KEY (`idPersona`),
  UNIQUE KEY `dni_UNIQUE` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (1,'Luis','Gomez','45512423','Jr Las Esmeraldas 123','988745451','1995-12-15'),(2,'Joel','Vilchez','42212457','Av Heroes 122','465456456','1990-12-30'),(3,'Jorge','Zimmerman','08556565','Calle Los Girasoles','966521245','1993-07-28'),(6,'Eduardo','Perez Yañez','09554578','Rua Guilherme Alfredo Geiser, 1363','02134569','1995-05-05'),(8,'Ronadl','E. Reed','45124521','Avenida Catarina Etelvina Pedroso, 1983','98899989','2005-12-30'),(9,'Margaret ','Martinez','87897987','sdfsdfsdfsd','966969696','2017-11-29'),(10,'GasparÃ­n','Gonzalo MejÃ­a','45556449','Rua Cinco, 1775','4564651321','2017-11-29'),(11,'Kurinob','Esmeregildo Perez','11111111','Calle Las Hortalizas','9663785415','1990-01-01'),(13,'Margaret','Petterson','45465456','Rua Apolo, 1097','3751386','2017-11-30'),(15,'Carlos','Carlin','45546545','Rua Tito, 749','654654564','2017-01-01'),(17,'Rodrigo','Franco','46654578','Rua Miguel Rodrigues dos Santos, 1725','65456456','2017-04-04'),(18,'James','Bond','46654871','Valadouro, 60','6541655','2017-04-04'),(19,'Joseph','Franco','33534534','Rua São Gonçalo, 1744','234234','2017-12-27'),(20,'Timothy','Ring','23423432','Rua Antônio Brasilino Santos, 1672','234234234','2017-12-27'),(21,'Sandy','Watson','23423423','31210 Los Arcos','234234234','2017-01-01'),(23,'Lorene','Garay','78899879','Carretera Cádiz-Málaga, 56','34534534534','2000-02-01'),(25,'Patrick','Fletcher','43534543','Boriñaur enparantza, 36','234234234','2017-12-15'),(26,'Cody','Arbogast','65465446','Avenida Afonso Lopes de Baião, 1938','345345345','2017-12-08'),(27,'Monster','Mons Ter','99999999','Rua Amparo, 933','9744665','2002-01-29'),(28,'Pedro','Rosas','98754343','Puerta Nueva, 70','89798798','2004-03-03');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `producto` (
  `idProducto` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL COMMENT 'Lavado (con el servicio de Lavado y Planchado)\nPlanchado (con el servicio de Lavado y Planchado)\nPollo Broster (Alimentación)\nArroz con Pollo (Alimentación)\nJarra de Sangría (Bebidas)\nCerveza Cristal (Bebidas)\nMovilidad a lugar A (Movilidad)',
  `costo` decimal(11,2) NOT NULL,
  `idServicio` int(11) NOT NULL,
  PRIMARY KEY (`idProducto`),
  KEY `fk_PRODUCTO_SERVICIO1_idx` (`idServicio`),
  CONSTRAINT `fk_PRODUCTO_SERVICIO1` FOREIGN KEY (`idServicio`) REFERENCES `servicio` (`idServicio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'Lavado de ropa',5000.00,3),(2,'Planchado de ropa',25.00,3),(3,'Pollo Broster 1 unidad',55.00,1),(4,'Arroz con Pollo - Almuerzo',15.00,1),(5,'Jarra de Sangria',18.00,2),(6,'Cerveza Cristal 310ml',5.00,2),(7,'Movilidad a museo',12.00,4);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva`
--

DROP TABLE IF EXISTS `reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `reserva` (
  `idReserva` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `fechaIngreso` date NOT NULL,
  `fechaSalida` date NOT NULL,
  `igv` decimal(4,2) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idTrabajador` int(11) DEFAULT NULL,
  PRIMARY KEY (`idReserva`),
  KEY `fk_RESERVA_CLIENTE1_idx` (`idCliente`),
  KEY `fk_RESERVA_TRABAJADOR1_idx` (`idTrabajador`),
  CONSTRAINT `fk_RESERVA_CLIENTE1` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RESERVA_TRABAJADOR1` FOREIGN KEY (`idTrabajador`) REFERENCES `trabajador` (`idTrabajador`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `rol` (
  `idRol` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'Registrador');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol_enlace`
--

DROP TABLE IF EXISTS `rol_enlace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `rol_enlace` (
  `idRol` int(11) NOT NULL,
  `idEnlace` int(11) NOT NULL,
  PRIMARY KEY (`idRol`,`idEnlace`),
  KEY `fk_ROL_has_ENLACE_ENLACE1_idx` (`idEnlace`),
  KEY `fk_ROL_has_ENLACE_ROL1_idx` (`idRol`),
  CONSTRAINT `fk_ROL_has_ENLACE_ENLACE1` FOREIGN KEY (`idEnlace`) REFERENCES `enlace` (`idEnlace`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ROL_has_ENLACE_ROL1` FOREIGN KEY (`idRol`) REFERENCES `rol` (`idRol`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol_enlace`
--

LOCK TABLES `rol_enlace` WRITE;
/*!40000 ALTER TABLE `rol_enlace` DISABLE KEYS */;
INSERT INTO `rol_enlace` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9);
/*!40000 ALTER TABLE `rol_enlace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicio`
--

DROP TABLE IF EXISTS `servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `servicio` (
  `idServicio` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL COMMENT 'Alimentación\nBebidas\nLavado y Planchado\nTraslado',
  PRIMARY KEY (`idServicio`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicio`
--

LOCK TABLES `servicio` WRITE;
/*!40000 ALTER TABLE `servicio` DISABLE KEYS */;
INSERT INTO `servicio` VALUES (1,'Alimentación'),(2,'Bebidas'),(3,'Lavado y Planchado'),(4,'Traslado');
/*!40000 ALTER TABLE `servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tarifa`
--

DROP TABLE IF EXISTS `tarifa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tarifa` (
  `idCategoria` int(11) NOT NULL,
  `idTipo` int(11) NOT NULL,
  `precio` decimal(11,2) NOT NULL,
  PRIMARY KEY (`idCategoria`,`idTipo`),
  KEY `fk_CATEGORIA_HABITACION_has_TIPO_HABITACION_TIPO_HABITACION_idx` (`idTipo`),
  KEY `fk_CATEGORIA_HABITACION_has_TIPO_HABITACION_CATEGORIA_HABIT_idx` (`idCategoria`),
  CONSTRAINT `fk_CATEGORIA_HABITACION_has_TIPO_HABITACION_CATEGORIA_HABITAC1` FOREIGN KEY (`idCategoria`) REFERENCES `categoria_habitacion` (`idCategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CATEGORIA_HABITACION_has_TIPO_HABITACION_TIPO_HABITACION1` FOREIGN KEY (`idTipo`) REFERENCES `tipo_habitacion` (`idTipo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarifa`
--

LOCK TABLES `tarifa` WRITE;
/*!40000 ALTER TABLE `tarifa` DISABLE KEYS */;
INSERT INTO `tarifa` VALUES (1,1,50.00),(1,2,70.00),(1,3,90.00),(2,1,110.00),(2,2,130.00),(2,3,150.00),(3,1,170.00),(3,2,190.00),(3,3,210.00),(4,1,230.00),(4,2,250.00),(4,3,270.00);
/*!40000 ALTER TABLE `tarifa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_habitacion`
--

DROP TABLE IF EXISTS `tipo_habitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tipo_habitacion` (
  `idTipo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL COMMENT 'Simple\nDoble\nTriple',
  PRIMARY KEY (`idTipo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_habitacion`
--

LOCK TABLES `tipo_habitacion` WRITE;
/*!40000 ALTER TABLE `tipo_habitacion` DISABLE KEYS */;
INSERT INTO `tipo_habitacion` VALUES (1,'Simple'),(2,'Doble'),(3,'Triple');
/*!40000 ALTER TABLE `tipo_habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trabajador`
--

DROP TABLE IF EXISTS `trabajador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `trabajador` (
  `idTrabajador` int(11) NOT NULL,
  `fechaContratacion` date NOT NULL,
  `salario` decimal(11,2) NOT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`idTrabajador`),
  KEY `fk_TRABAJADOR_PERSONA1_idx` (`idTrabajador`),
  KEY `fk_TRABAJADOR_USUARIO2_idx` (`idUsuario`),
  CONSTRAINT `fk_TRABAJADOR_PERSONA1` FOREIGN KEY (`idTrabajador`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TRABAJADOR_USUARIO2` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trabajador`
--

LOCK TABLES `trabajador` WRITE;
/*!40000 ALTER TABLE `trabajador` DISABLE KEYS */;
INSERT INTO `trabajador` VALUES (1,'2016-12-04',2500.00,1),(2,'2017-12-04',5000.00,NULL),(11,'2017-12-05',7000.00,NULL),(26,'2017-12-05',80000.00,NULL),(28,'2017-12-06',9000.00,NULL);
/*!40000 ALTER TABLE `trabajador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'luis','guisado');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_rol`
--

DROP TABLE IF EXISTS `usuario_rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usuario_rol` (
  `idUsuario` int(11) NOT NULL,
  `idRol` int(11) NOT NULL,
  PRIMARY KEY (`idUsuario`,`idRol`),
  KEY `fk_USUARIO_has_ROL_ROL1_idx` (`idRol`),
  KEY `fk_USUARIO_has_ROL_USUARIO1_idx` (`idUsuario`),
  CONSTRAINT `fk_USUARIO_has_ROL_ROL1` FOREIGN KEY (`idRol`) REFERENCES `rol` (`idRol`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_USUARIO_has_ROL_USUARIO1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_rol`
--

LOCK TABLES `usuario_rol` WRITE;
/*!40000 ALTER TABLE `usuario_rol` DISABLE KEYS */;
INSERT INTO `usuario_rol` VALUES (1,1);
/*!40000 ALTER TABLE `usuario_rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'hotel'
--

--
-- Dumping routines for database 'hotel'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-22 13:05:20
