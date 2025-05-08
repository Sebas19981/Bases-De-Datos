-- Adminer 5.2.1 MySQL 9.1.0 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `equipos`;
CREATE TABLE `equipos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_general_ci,
  `serial` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estado` enum('disponible','prestado','dañado') COLLATE utf8mb4_general_ci DEFAULT 'disponible',
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial` (`serial`),
  KEY `idx_nombre_equipo` (`nombre`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `equipos` (`id`, `nombre`, `descripcion`, `serial`, `estado`) VALUES
(1,	'Portátil Dell',	'Core i5, 8GB RAM',	'A12345',	'disponible'),
(2,	'Proyector Epson',	'HD, 3000 lúmenes',	'B98765',	'disponible');

DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` text COLLATE utf8mb4_general_ci,
  `nivel` enum('INFO','WARNING','ERROR') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `logs` (`id`, `descripcion`, `nivel`, `fecha`) VALUES
(1,	'Equipo 1 prestado a usuario 1',	'INFO',	'2025-05-02 02:46:15');

DROP TABLE IF EXISTS `prestamos`;
CREATE TABLE `prestamos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `equipo_id` int DEFAULT NULL,
  `usuario_id` int DEFAULT NULL,
  `fecha_prestamo` date DEFAULT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `devuelto` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `equipo_id` (`equipo_id`),
  KEY `idx_usuario_fecha` (`usuario_id`,`fecha_prestamo`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `prestamos` (`id`, `equipo_id`, `usuario_id`, `fecha_prestamo`, `fecha_devolucion`, `devuelto`) VALUES
(1,	1,	1,	'2025-05-01',	NULL,	0);

DELIMITER ;;

CREATE TRIGGER `after_prestamo_insert` AFTER INSERT ON `prestamos` FOR EACH ROW
BEGIN
  INSERT INTO logs (descripcion, nivel)
  VALUES (
    CONCAT('Equipo ', NEW.equipo_id, ' prestado a usuario ', NEW.usuario_id),
    'INFO'
  );
END;;

DELIMITER ;

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `correo` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `programa_academico` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP VIEW IF EXISTS `vista_estado_equipos`;
CREATE TABLE `vista_estado_equipos` (`id` int, `nombre` varchar(100), `estado` enum('disponible','prestado','dañado'));


DROP TABLE IF EXISTS `vista_estado_equipos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_estado_equipos` AS select `equipos`.`id` AS `id`,`equipos`.`nombre` AS `nombre`,`equipos`.`estado` AS `estado` from `equipos`;

-- 2025-05-08 17:57:28 UTC
