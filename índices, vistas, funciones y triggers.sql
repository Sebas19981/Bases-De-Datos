-- Índice para buscar equipos por nombre
CREATE INDEX idx_nombre_equipo ON equipos(nombre);

-- Índice para consultar préstamos por usuario y fechas
CREATE INDEX idx_usuario_fecha ON prestamos(usuario_id, fecha_prestamo);


-- Vista del estado de todos los equipos
CREATE VIEW vista_estado_equipos AS
SELECT id, nombre, estado
FROM equipos;


-- Devuelve la cantidad de equipos actualmente prestados
DELIMITER //

CREATE FUNCTION total_equipos_prestados()
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE cantidad INT;
  SELECT COUNT(*) INTO cantidad FROM prestamos WHERE devuelto = FALSE;
  RETURN cantidad;
END;
//

DELIMITER ;

-- Registra un préstamo y actualiza estado del equipo
DELIMITER //

CREATE PROCEDURE registrar_prestamo(
    IN p_equipo_id INT,
    IN p_usuario_id INT,
    IN p_fecha DATE
)
BEGIN
  INSERT INTO prestamos (equipo_id, usuario_id, fecha_prestamo)
  VALUES (p_equipo_id, p_usuario_id, p_fecha);

  UPDATE equipos SET estado = 'prestado' WHERE id = p_equipo_id;
END;
//

DELIMITER ;


-- Después de registrar préstamo, insertar log
DELIMITER //

CREATE TRIGGER after_prestamo_insert
AFTER INSERT ON prestamos
FOR EACH ROW
BEGIN
  INSERT INTO logs (descripcion, nivel)
  VALUES (
    CONCAT('Equipo ', NEW.equipo_id, ' prestado a usuario ', NEW.usuario_id),
    'INFO'
  );
END;
//

DELIMITER ;


-- Tabla para registrar eventos
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT,
    nivel ENUM('INFO', 'WARNING', 'ERROR'),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
