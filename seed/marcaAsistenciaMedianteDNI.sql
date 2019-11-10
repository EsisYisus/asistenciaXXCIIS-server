USE asistenciaxxciis;
delimiter $$
CREATE FUNCTION marcaAsistenciaPorDNI( dni_asistencia INT,
                                        horarioProgramado INT) 
RETURNS VARCHAR(50)
BEGIN
	DECLARE nombre VARCHAR(50);
	DECLARE marcaDeAsistencia INT;
 	set marcaDeAsistencia=1;
	SET nombre = (SELECT CONCAT(nombres,' ',apellidos)
	FROM usuarios u 
    INNER JOIN inscripcion i
	ON u.id=i.id_usuario 
    WHERE u.dni=dni_asistencia);
		
	IF EXISTS 
			(select dni 
			FROM   usuarios 
			WHERE  dni=dni_asistencia)
            and
                               curdate()<=(select fecha_programada 
											  from horarios
                                              where id_horario=horarioProgramado)
							   and
                               curtime() >=(select horario_ingreso 
											  from horarios
                                              where id_horario=horarioProgramado)
							   and 
                               curtime() <=(select horario_salida 
											  from horarios
                                              where id_horario=horarioProgramado)
            THEN
			IF NOT EXISTS 
					(
                     select asistio 
					 FROM   asistencias 
					 WHERE  asistencias.id_usuario= 
						       ( 
							    SELECT     u.id 
								FROM       usuarios u 
								INNER JOIN inscripcion i 
								ON         u.id=i.id_usuario 
								WHERE      u.dni=dni_asistencia
							   ))
                               
                               THEN
							   INSERT INTO asistencias 
												( 
												id_usuario, 
												fecha_asistencia, 
												asistio, 
												hora 
												) 
											VALUES 
												( 
												( 
												 SELECT id 
												 FROM   usuarios 
												 WHERE  dni=dni_asistencia
												),
                                                curdate(),
                                                marcaDeAsistencia,
												curtime() 
												);
								
			 ELSE
					RETURN Concat(nombre,' ya marco asistencia');
			 END IF; 
	ELSE 
		SET nombre = 'Error: Hubo un problema al registrar la asistencia, por favor comuníquese con el administrador' ;
    END IF;
		RETURN nombre;
END $$

delimiter ;

SELECT * FROM asistencias;
delete from asistencias;

/**marcaAsistenciaPorDNI( dni_asistencia INT, 
						   horarioProgramado INT) 
**/
SELECT marcaAsistenciaPorDNI(22222222,11);
SELECT marcaAsistenciaPorDNI(11111111,11);
SELECT marcaAsistenciaPorDNI(22222223,11);


