USE owltie_ciistacna_01_copy;
delimiter $$
CREATE FUNCTION marcaAsistenciaPorCodigoQR( codigo_asistencia INT,
                                        horarioProgramado INT) 
RETURNS VARCHAR(250)
BEGIN
	DECLARE nombre VARCHAR(250);
	DECLARE marcaDeAsistencia INT;
 	set marcaDeAsistencia=1;
	SET nombre = (SELECT CONCAT(nombre_usuario,' ',apellido_usuario)
	FROM usuarios u 
    INNER JOIN inscripcion i
	ON u.id_usuario=i.id_usuario 
    WHERE i.cod_asistencia=codigo_asistencia);	
	IF EXISTS 
			(select dni_usuario 
			FROM usuarios u 
			INNER JOIN inscripcion i
			ON u.id_usuario=i.id_usuario 
			WHERE i.cod_asistencia=codigo_asistencia)
            and
                               curdate()<=(select dia_evento 
											  from horario
                                              where id=horarioProgramado)
							   and
                               curtime() >=(select horario_ingreso 
											  from horario
                                              where id=horarioProgramado)
							   and 
                               curtime() <=(select horario_salida 
											  from horario
                                              where id=horarioProgramado)
            THEN
			IF NOT EXISTS 
					(
                     select asistio 
					 FROM   asistencia 
					 WHERE  asistencia.id_usuario= 
						       ( 
							    SELECT     u.id_usuario 
								FROM       usuarios u 
								INNER JOIN inscripcion i 
								ON u.id_usuario=i.id_usuario 
								WHERE i.cod_asistencia=codigo_asistencia
							   ))
                               
                               THEN
							   INSERT INTO asistencia 
												( 
												id_usuario, 
												fecha_asistencia, 
												asistio, 
												hora 
												) 
											VALUES 
												( 
												( 
												 SELECT u.id_usuario 
												 FROM       usuarios u 
												INNER JOIN inscripcion i 
												ON u.id_usuario=i.id_usuario 
												WHERE i.cod_asistencia=codigo_asistencia
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
SELECT marcaAsistenciaPorCodigoQR(1010,11);
SELECT marcaAsistenciaPorCodigoQR(1000,11);
SELECT marcaAsistenciaPorCodigoQR(11111111,11);