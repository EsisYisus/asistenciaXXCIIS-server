-- INSERTA HORARIOS
insert into horario (horario_ingreso, horario_salida, dia_evento) values 
('08:00', '13:00', '2019-11-11'),
('14:30', '18:30', '2019-11-11'),
('08:00', '13:00', '2019-11-12'),
('14:30', '18:30', '2019-11-12'),
('08:00', '13:00', '2019-11-13'),
('14:30', '18:30', '2019-11-13'),
('08:00', '13:00', '2019-11-14'),
('14:30', '18:30', '2019-11-14'),
('08:00', '13:00', '2019-11-15'),
('14:30', '18:30', '2019-11-15');


/**
 *  Insertar asistencia
 *  Marca asistencia de acuerdo al codigo proporcionado
 *  @param {integer} codigo
 *  return {char} nombre
 */
-- BEGIN
-- 	SET @nombre = (SELECT CONCAT(nombres,' ',apellidos) FROM usuarios WHERE codigo=$1);
-- 	IF EXISTS (SELECT codigo from usuarios WHERE codigo=$1) THEN
-- 		SIGNAL SQLSTATE '45000' SET message_text = 'Usuario existe';
-- 		IF NOT EXISTS (select asistio from asistencias where user_id=(select id from usuarios where codigo=$1)) THEN
-- 			-- marca asistencia
-- 			INSERT INTO asistencias (user_id, asistio, hora) VALUES ((SELECT id FROM usuarios WHERE codigo=$1),true,NOW());
-- 			SIGNAL SQLSTATE '45000' SET message_text = 'Asistencia marcada';
-- 			RETURN @nombre;
-- 		ELSE
-- 			SIGNAL SQLSTATE '45000' SET message_text = 'Usuario ya marco asistencia';
-- 			RETURN CONCAT(@nombre,' ya marco asistencia');
-- 		END IF;
-- 	ELSE
-- 		SIGNAL SQLSTATE '45000' SET message_text = 'Usuario no registrado';
-- 		RETURN 'Usuario no registrado';
-- 	END IF;
-- END;


-- -- prueba
-- USE asistenciaxxciis;
-- delimiter $$

-- CREATE FUNCTION marcaAsistencia(codigo INT)
-- RETURNS INT	
-- BEGIN
-- 	DECLARE suma INT;
-- 	SET suma = codigo + 10;
-- 	RETURN suma;
-- END $$
-- delimiter ;

-- SELECT marcaAsistencia(100);

--