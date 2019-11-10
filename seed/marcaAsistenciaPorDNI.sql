USE owltie_ciistacna_01_copy;
delimiter $$
CREATE FUNCTION marcaAsistenciaPorDNI( dni_asistencia INT)
RETURNS VARCHAR(250)
BEGIN
	DECLARE horarioProgramado INT;
	DECLARE nombre VARCHAR(250);
	DECLARE marcaDeAsistencia INT;

	SET horarioProgramado = (SELECT id
	FROM horario
	WHERE 
		dia_evento = CURDATE() AND CURTIME() >= horario_ingreso AND CURTIME() <= horario_salida
	);
 	set marcaDeAsistencia=1;
	SET nombre = (SELECT CONCAT(nombre_usuario,' ',apellido_usuario)
	FROM usuarios 
   WHERE dni_usuario=dni_asistencia);	
	IF EXISTS 
			(select dni_usuario 
			 FROM usuarios 
			 WHERE dni_usuario=dni_asistencia
			)
         THEN
			IF ( 
					SELECT dia_evento 
					FROM horario 
					WHERE 
					dia_evento = CURDATE()
				  	AND CURTIME() >= horario_ingreso 
				  	AND CURTIME() <= horario_salida
				) IS NOT NULL                   
            THEN
            IF  (select asistio 
					 FROM   asistencia 
					 WHERE  asistencia.id_usuario= 
						       ( 
							    SELECT     id_usuario 
								 FROM       usuarios 
								 WHERE dni_usuario=dni_asistencia
							   )) IS null
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
												 SELECT id_usuario 
												 FROM       usuarios  
												WHERE dni_usuario=dni_asistencia
												),
                                                curdate(),
                                                marcaDeAsistencia,
												curtime() 
												);
								
				ELSE
					RETURN Concat(nombre,' ya marco asistencia en este horario');
			 END IF; 
			 
			 ELSE
					RETURN (' no es hora de ponencia');
			 END IF; 
	ELSE 
			RETURN (' DNI no registrado');
    END IF;
		RETURN nombre;
END $$

delimiter ;


SELECT * FROM asistencia;
delete from asistencia;

SELECT marcaAsistenciaPorDNI(76507579);


/**marcaAsistenciaPorDNI( dni_asistencia INT, 
						   horarioProgramado INT) 
**/
SELECT marcaAsistenciaPorCodigoQR(1011);
SELECT marcaAsistenciaPorCodigoQR(1000,11);
SELECT marcaAsistenciaPorCodigoQR(11111111,11);

SELECT CURTIME()