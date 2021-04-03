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
-- Dumping data for table `cat_habitacion_equipamiento`
--

LOCK TABLES `cat_habitacion_equipamiento` WRITE;
/*!40000 ALTER TABLE `cat_habitacion_equipamiento` DISABLE KEYS */;
INSERT INTO `cat_habitacion_equipamiento` VALUES (1,1),(2,1),(3,1),(4,1),(1,2),(2,2),(3,2),(4,2),(2,3),(3,3),(4,3),(3,4),(4,4),(4,5),(4,6),(4,7);
/*!40000 ALTER TABLE `cat_habitacion_equipamiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `categoria_habitacion`
--

LOCK TABLES `categoria_habitacion` WRITE;
/*!40000 ALTER TABLE `categoria_habitacion` DISABLE KEYS */;
INSERT INTO `categoria_habitacion` VALUES (1,'Económico'),(2,'Básico'),(3,'Intermedio'),(4,'Completo');
/*!40000 ALTER TABLE `categoria_habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'2017-12-05',NULL),(2,'2017-12-04',NULL),(3,'2017-12-04',NULL),(6,'2017-01-04',NULL),(8,'2017-12-04',NULL),(9,'2017-12-13',NULL),(10,'2017-11-30',NULL),(11,'2017-12-09',NULL),(13,'2017-12-08',NULL),(15,'2017-12-04',NULL),(17,'2017-12-06',NULL),(19,'2017-12-08',NULL),(20,'2017-11-30',NULL),(21,'2017-12-18',NULL),(23,'2017-12-04',NULL),(25,'2017-12-05',NULL),(26,'2017-12-05',NULL),(27,'2017-12-06',NULL),(28,'2017-12-06',NULL);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `detalle_gasto`
--

LOCK TABLES `detalle_gasto` WRITE;
/*!40000 ALTER TABLE `detalle_gasto` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_gasto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `enlace`
--

LOCK TABLES `enlace` WRITE;
/*!40000 ALTER TABLE `enlace` DISABLE KEYS */;
INSERT INTO `enlace` VALUES (1,'Crud Cliente','CrudCliente.jsp'),(2,'Crud Trabajador','CrudTrabajador.jsp'),(3,'Crud Producto','CrudProducto.jsp'),(4,'Crud Habitacion','CrudHabitacion.jsp'),(5,'Consulta Trabajador Por Fecha Contratacion','ConsultaTrabajadorPorFechaContratacion.jsp'),(6,'Consulta Trabajador Por Fecha Nacimiento','ConsultaTrabajadorPorFechaNacimiento.jsp'),(7,'Registro Hospedaje','RegistroHospedaje.jsp'),(8,'Consulta Cliente Por Fecha Nacimiento','ConsultaClientePorFechaNacimiento.jsp'),(9,'Consulta Hospedajes por Fecha de Ingreso','ConsultaHospedajesPorFechaIngreso.jsp');
/*!40000 ALTER TABLE `enlace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `equipamiento`
--

LOCK TABLES `equipamiento` WRITE;
/*!40000 ALTER TABLE `equipamiento` DISABLE KEYS */;
INSERT INTO `equipamiento` VALUES (1,'Frío Bar'),(2,'TV'),(3,'Aire acondicionado'),(4,'Blue Ray'),(5,'Wi fi'),(6,'Direct TV'),(7,'Internet');
/*!40000 ALTER TABLE `equipamiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `estado_cuenta`
--

LOCK TABLES `estado_cuenta` WRITE;
/*!40000 ALTER TABLE `estado_cuenta` DISABLE KEYS */;
/*!40000 ALTER TABLE `estado_cuenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `estado_habitacion`
--

LOCK TABLES `estado_habitacion` WRITE;
/*!40000 ALTER TABLE `estado_habitacion` DISABLE KEYS */;
INSERT INTO `estado_habitacion` VALUES (1,'Disponible'),(2,'Reservada'),(3,'Mantenimiento'),(4,'Ocupada');
/*!40000 ALTER TABLE `estado_habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `gasto`
--

LOCK TABLES `gasto` WRITE;
/*!40000 ALTER TABLE `gasto` DISABLE KEYS */;
/*!40000 ALTER TABLE `gasto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `habitacion`
--

LOCK TABLES `habitacion` WRITE;
/*!40000 ALTER TABLE `habitacion` DISABLE KEYS */;
INSERT INTO `habitacion` VALUES (1,1,1,1,1,4,5000.00),(2,2,1,1,1,4,5000.00),(3,3,1,2,2,1,6000.00),(4,4,1,3,4,4,5000.00),(5,5,1,2,3,1,9000.00),(6,1,2,1,1,4,5000.00),(7,6,1,3,4,4,4000.00),(8,7,1,1,4,4,2000.00),(10,8,1,3,4,4,100.00);
/*!40000 ALTER TABLE `habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `habitacion_has_reserva`
--

LOCK TABLES `habitacion_has_reserva` WRITE;
/*!40000 ALTER TABLE `habitacion_has_reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `habitacion_has_reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `hospedaje`
--

LOCK TABLES `hospedaje` WRITE;
/*!40000 ALTER TABLE `hospedaje` DISABLE KEYS */;
INSERT INTO `hospedaje` VALUES (7,'2017-12-06','2017-12-08',18.00,NULL,NULL,1,NULL),(8,'2017-12-06','2017-12-13',18.00,NULL,NULL,1,NULL),(9,'2017-12-06','2017-12-13',18.00,NULL,NULL,1,1),(10,'2017-12-06','2017-12-07',18.00,NULL,NULL,28,1),(11,'2017-12-06','2017-12-14',18.00,NULL,NULL,2,1),(12,'2017-12-07','2017-12-30',18.00,NULL,NULL,17,1);
/*!40000 ALTER TABLE `hospedaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `hospedaje_habitacion`
--

LOCK TABLES `hospedaje_habitacion` WRITE;
/*!40000 ALTER TABLE `hospedaje_habitacion` DISABLE KEYS */;
INSERT INTO `hospedaje_habitacion` VALUES (7,8,4000.00),(7,10,200.00),(8,4,35000.00),(8,7,28000.00),(8,10,700.00),(9,1,35000.00),(9,2,35000.00),(10,6,5000.00),(11,10,800.00),(12,6,115000.00),(12,7,92000.00),(12,8,46000.00),(12,10,2300.00);
/*!40000 ALTER TABLE `hospedaje_habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `hospedaje_habitacion_huesped`
--

LOCK TABLES `hospedaje_habitacion_huesped` WRITE;
/*!40000 ALTER TABLE `hospedaje_habitacion_huesped` DISABLE KEYS */;
/*!40000 ALTER TABLE `hospedaje_habitacion_huesped` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `huesped`
--

LOCK TABLES `huesped` WRITE;
/*!40000 ALTER TABLE `huesped` DISABLE KEYS */;
/*!40000 ALTER TABLE `huesped` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pago_hospedaje_consumo`
--

LOCK TABLES `pago_hospedaje_consumo` WRITE;
/*!40000 ALTER TABLE `pago_hospedaje_consumo` DISABLE KEYS */;
/*!40000 ALTER TABLE `pago_hospedaje_consumo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pago_reserva`
--

LOCK TABLES `pago_reserva` WRITE;
/*!40000 ALTER TABLE `pago_reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `pago_reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (1,'Luis Alberto','Guisado Mena','46687138','Jr Los Zafiros 2019','963847659','1991-12-30'),(2,'Karen','Peña Reyes','46687139','Jr Los Chasquis 999','465456456','1990-12-30'),(3,'Jorge','Guisado Mena','09557358','Jr Los Zafiros 2019','963847545','1993-07-28'),(6,'Eduardo','Perez YaÃ±ez','09554578','sdfsdlfnsdnf','89789654','1995-05-05'),(8,'gfhjfghdfgdf','gdfgdfgdfdf','46546564','dfgdfgdgdgdf','34534534534','2005-12-30'),(9,'sdfsdfssfsdfsd','sdfsdfsd','87897987','sdfsdfsdfsd','9878668468','2017-11-29'),(10,'GasparÃ­n','Gonzalo MejÃ­a','45556449','asdfnsjdfdjsfsd','4564651321','2017-11-29'),(11,'Kurinob','Esmeregildo Perez','11111111','Calle Las Hortalizas','999999999999','1990-01-01'),(13,'nklnlknlkglkfngdf','knlknklklnklnkl','45465456','lknklnklnklnlkn','lknlknlknlkn','2017-11-30'),(15,'Carlos','Carlin','45546545','sadfdsafdsfds','654654564','2017-01-01'),(17,'Rodrigo','Franco','46654578','asfdsdfsdfdsfds','65456456','2017-04-04'),(18,'James','Bond','46654871','sdfsdfsdfsd','6541655','2017-04-04'),(19,'sdfgdg','dfgdfg','33534534','23wsdfsdfds','234234','2017-12-27'),(20,'dfgdfgdfg','dfgdfgdfg','23423432','dgdfgdfgdfg','234234234','2017-12-27'),(21,'wdfdfdfdfgdf','dfgdfgdfg','23423423','dfgdfgdfg','234234234','2017-01-01'),(23,'23wertwer','dfgdfgdfgdf','78899879','dfgdfgdfgdfgfd','34534534534','2000-02-01'),(25,'asasdasd','sdfdsdfsdfsd','43534543','sdfsdfdsf','234234234','2017-12-15'),(26,'aaaaaaaaaaaaa','aaaaaaaaaaaaa','65465446','aaaaaaaaaaaaa','345345345','2017-12-08'),(27,'Monster','Mons Ter','99999999','asdkjfbskjdbfkjbfjkf','9744665','2002-01-29'),(28,'Pedro','Rosas','98754343','5sdfsdfsdfsdfsd','89798798','2004-03-03');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'Lavado de ropa',5000.00,3),(2,'Planchado de ropa',25.00,3),(3,'Pollo Broster 1 unidad',55.00,1),(4,'Arroz con Pollo - Almuerzo',15.00,1),(5,'Jarra de Sangria',18.00,2),(6,'Cerveza Cristal 310ml',5.00,2),(7,'Movilidad a museo',12.00,4);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'Registrador');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `rol_enlace`
--

LOCK TABLES `rol_enlace` WRITE;
/*!40000 ALTER TABLE `rol_enlace` DISABLE KEYS */;
INSERT INTO `rol_enlace` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9);
/*!40000 ALTER TABLE `rol_enlace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `servicio`
--

LOCK TABLES `servicio` WRITE;
/*!40000 ALTER TABLE `servicio` DISABLE KEYS */;
INSERT INTO `servicio` VALUES (1,'Alimentación'),(2,'Bebidas'),(3,'Lavado y Planchado'),(4,'Traslado');
/*!40000 ALTER TABLE `servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tarifa`
--

LOCK TABLES `tarifa` WRITE;
/*!40000 ALTER TABLE `tarifa` DISABLE KEYS */;
INSERT INTO `tarifa` VALUES (1,1,50.00),(1,2,70.00),(1,3,90.00),(2,1,110.00),(2,2,130.00),(2,3,150.00),(3,1,170.00),(3,2,190.00),(3,3,210.00),(4,1,230.00),(4,2,250.00),(4,3,270.00);
/*!40000 ALTER TABLE `tarifa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tipo_habitacion`
--

LOCK TABLES `tipo_habitacion` WRITE;
/*!40000 ALTER TABLE `tipo_habitacion` DISABLE KEYS */;
INSERT INTO `tipo_habitacion` VALUES (1,'Simple'),(2,'Doble'),(3,'Triple');
/*!40000 ALTER TABLE `tipo_habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `trabajador`
--

LOCK TABLES `trabajador` WRITE;
/*!40000 ALTER TABLE `trabajador` DISABLE KEYS */;
INSERT INTO `trabajador` VALUES (1,'2016-12-04',2500.00,1),(2,'2017-12-04',5000.00,NULL),(11,'2017-12-05',7000.00,NULL),(26,'2017-12-05',80000.00,NULL),(28,'2017-12-06',9000.00,NULL);
/*!40000 ALTER TABLE `trabajador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'luis','guisado');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

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

-- Dump completed on 2021-04-02 23:37:44
