DROP DATABASE IF EXISTS foros;
CREATE DATABASE foros;

USE foros;

-- MySQL dump 10.9
--
-- Host: localhost    Database: foros
-- ------------------------------------------------------
-- Server version	4.1.12-Debian_1ubuntu3.1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `avisos`
--

DROP TABLE IF EXISTS `avisos`;
CREATE TABLE `avisos` (
  `id` int(11) NOT NULL auto_increment,
  `idUsuario` varchar(15) NOT NULL default '',
  `idTema` int(11) NOT NULL default '0' COMMENT 'tema a chequear',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='avisos al movil cuando se mande un mensaje a un hilo';

--
-- Dumping data for table `avisos`
--


/*!40000 ALTER TABLE `avisos` DISABLE KEYS */;
LOCK TABLES `avisos` WRITE;
INSERT INTO `avisos` VALUES (4,'pepe',6);
UNLOCK TABLES;
/*!40000 ALTER TABLE `avisos` ENABLE KEYS */;

--
-- Table structure for table `foros`
--

DROP TABLE IF EXISTS `foros`;
CREATE TABLE `foros` (
  `id` int(11) NOT NULL auto_increment,
  `titulo` varchar(100) NOT NULL default '',
  `descripcion` varchar(250) NOT NULL default '',
  `numTemas` int(11) NOT NULL default '0',
  `numMensajes` int(11) NOT NULL default '0',
  `idUltMensaje` int(11) NOT NULL default '0' COMMENT 'identificador del ltimo mensaje enviado al foro',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `foros`
--


/*!40000 ALTER TABLE `foros` DISABLE KEYS */;
LOCK TABLES `foros` WRITE;
INSERT INTO `foros` VALUES (1,'Programacion en Java','JSPs, Tomcat, Midlets..un mundo maravilloso a tu alcance',1,2,20),(2,'Cine','Todo sobre cine, ya sea en la multisala o en casa (gracias al emule)',2,5,23);
UNLOCK TABLES;
/*!40000 ALTER TABLE `foros` ENABLE KEYS */;

--
-- Table structure for table `mensajes`
--

DROP TABLE IF EXISTS `mensajes`;
CREATE TABLE `mensajes` (
  `id` int(11) NOT NULL auto_increment,
  `idTema` int(11) NOT NULL default '0' COMMENT 'hilo en el que esta el mensaje',
  `asunto` varchar(200) NOT NULL default '',
  `texto` mediumtext NOT NULL,
  `autor` varchar(15) NOT NULL default '0',
  `fecha` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mensajes`
--


/*!40000 ALTER TABLE `mensajes` DISABLE KEYS */;
LOCK TABLES `mensajes` WRITE;
INSERT INTO `mensajes` VALUES (17,6,'Dogville',' ¿La habeis visto? ¿Que tal esta?','pepe','2005-12-17 19:42:51'),(18,7,'SMS con KToolbar','Estoy intentando probar el envio de SMS desde los emuladores de ktoolbar, pero al cargar la aplicacion me dice que no puede inicializar WMA y luego no funcionan los SMS.\r\n\r\n¿Sabeis cual es el problema?','pepe','2005-12-17 19:46:27'),(19,6,'','Es muy buena, se la recomiendo a todo el mundo. El final es lo mejor\n\nUltima practica de TW','piolin','2005-12-17 19:49:14'),(20,7,'','A veces pasa en Linux. Cierralo y vuelvelo a abrir y se solucionara.\r\n\r\nUltima practica de TW','piolin','2005-12-17 19:51:31'),(21,8,'Las mejores peliculas','¿Cuales son para vosotros las 3 mejores peliculas de la historia?\r\n\r\nLas mias son:\r\n\r\n1) Los cazafantasmas\r\n2) Robocop\r\n3) Regreso al futuro','piolin','2005-12-17 19:55:00'),(22,6,'','Gracias por la respuesta.\r\n\r\nEntonces me comprare el DVD, que ahora lo han rebajado.','pepe','2005-12-17 19:59:34'),(23,6,'','Muy buena opcion, yo me la compre cuando valia un paston.\r\n\r\nYa me contaras que te parece cuando la veas.\n\nUltima practica de TW','piolin','2005-12-17 20:04:39');
UNLOCK TABLES;
/*!40000 ALTER TABLE `mensajes` ENABLE KEYS */;

--
-- Table structure for table `smileys`
--

DROP TABLE IF EXISTS `smileys`;
CREATE TABLE `smileys` (
  `id` varchar(15) NOT NULL default '',
  `imag` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `smileys`
--


/*!40000 ALTER TABLE `smileys` DISABLE KEYS */;
LOCK TABLES `smileys` WRITE;
INSERT INTO `smileys` VALUES ('[:-)]','smilies/feliz.gif'),('[:-(]','smilies/triste.gif'),('[:-/]','smilies/enojado.gif'),('[:-$]','smilies/durmiendo.gif'),('[:-%]','smilies/colorado.gif'),('[:-!]','smilies/exclamacion.gif');
UNLOCK TABLES;
/*!40000 ALTER TABLE `smileys` ENABLE KEYS */;

--
-- Table structure for table `temas`
--

DROP TABLE IF EXISTS `temas`;
CREATE TABLE `temas` (
  `id` int(11) NOT NULL auto_increment COMMENT '	',
  `idForo` int(11) NOT NULL default '0',
  `asunto` varchar(100) NOT NULL default '',
  `numMensajes` int(11) NOT NULL default '0',
  `idUltMensaje` int(11) NOT NULL default '0' COMMENT 'identificador del ultimo mensaje del hilo',
  `autor` varchar(15) NOT NULL default '0' COMMENT 'usuario que creo el tema',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `temas`
--


/*!40000 ALTER TABLE `temas` DISABLE KEYS */;
LOCK TABLES `temas` WRITE;
INSERT INTO `temas` VALUES (6,2,'Dogville',3,23,'pepe'),(7,1,'SMS con KToolbar',1,20,'pepe'),(8,2,'Las mejores peliculas',0,21,'piolin');
UNLOCK TABLES;
/*!40000 ALTER TABLE `temas` ENABLE KEYS */;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id` varchar(15) NOT NULL default '' COMMENT 'login',
  `email` varchar(50) NOT NULL default '',
  `movil` varchar(12) NOT NULL default '',
  `ubicacion` varchar(50) NOT NULL default '' COMMENT 'localidad',
  `numMensajes` int(11) NOT NULL default '0' COMMENT 'numero de mensajes que ha enviado hasta el momento',
  `firma` varchar(250) NOT NULL default '',
  `fechaRegistro` timestamp NOT NULL default '0000-00-00 00:00:00',
  `password` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuarios`
--


/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
LOCK TABLES `usuarios` WRITE;
INSERT INTO `usuarios` VALUES ('pepe','pepe@hotmail.com','5550001','Alicante',3,'','0000-00-00 00:00:00','pepe'),('piolin','piolin@hotmail.com','5550002','Alicante',4,'Ultima practica de TW','0000-00-00 00:00:00','piolin');
UNLOCK TABLES;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

