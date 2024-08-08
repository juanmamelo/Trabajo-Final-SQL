-- VISTAS
-- vista_juegos_acceso_anticipado
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `steam_database`.`vista_juegos_acceso_anticipado` AS
    SELECT 
        `j`.`titulo` AS `Juego`,
        `g`.`genero` AS `Genero`,
        `j`.`desarrollador` AS `Desarrollador`,
        `j`.`fecha_lanzamiento` AS `Fecha de lanzamiento`,
        `j`.`precio` AS `Precio`
    FROM
        (`steam_database`.`juegos` `j`
        JOIN `steam_database`.`generos` `g` ON ((`j`.`id_genero` = `g`.`id_genero`)))
    WHERE
        (`j`.`acceso_anticipado` = TRUE);
        
-- vista_juegos_generos
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `steam_database`.`vista_juegos_generos` AS
    SELECT 
        `j`.`titulo` AS `Juego`,
        `g`.`genero` AS `Genero`,
        `j`.`desarrollador` AS `Desarrollador`,
        `j`.`fecha_lanzamiento` AS `Fecha de lanzamiento`,
        `j`.`precio` AS `Precio`
    FROM
        (`steam_database`.`juegos` `j`
        JOIN `steam_database`.`generos` `g` ON ((`j`.`id_genero` = `g`.`id_genero`)));
        
-- vista_juegos_populares
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `steam_database`.`vista_juegos_populares` AS
    SELECT 
        `j`.`titulo` AS `Juego`,
        `g`.`genero` AS `Genero`,
        `j`.`desarrollador` AS `Desarrollador`,
        COUNT(`r`.`id_resena`) AS TotalDeReseñas,
        AVG(r.puntuacion) AS PuntuacionPromedio
    FROM
        ((steam_database.juegos j
        LEFT JOIN steam_database.reseñas r ON ((`j`.id_juego = `r`.id_juego)))
        JOIN steam_database.generos g ON ((`j`.id_genero = `g`.id_genero)))
    GROUP BY `j`.titulo , `g`.genero , `j`.desarrollador
    ORDER BY PuntuacionPromedio DESC;
    
-- vista_ranking_nivel_cuenta
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `steam_database`.`vista_ranking_nivel_cuenta` AS
    SELECT 
        `steam_database`.`usuarios`.`nombre` AS `Usuario`,
        `steam_database`.`usuarios`.`pais` AS `Pais`,
        `steam_database`.`usuarios`.`nivel_cuenta` AS `NivelDeCuenta`
    FROM
        `steam_database`.`usuarios`
    ORDER BY `steam_database`.`usuarios`.`nivel_cuenta` DESC;
    
-- vista_resenas_detalladas
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `steam_database`.`vista_resenas_detalladas` AS
    SELECT 
        `j`.`titulo` AS `Juego`,
        `g`.`genero` AS `Genero`,
        `u`.`nombre` AS `Usuario`,
        `r`.`puntuacion` AS `Puntuacion`,
        `r`.`comentario` AS `Comentario`,
        `r`.`fecha_resena` AS FechaDeReseña,
        r.votos_positivos AS VotosPositivos
    FROM
        (((steam_database.reseñas r
        JOIN steam_database.juegos j ON ((`r`.id_juego = `j`.id_juego)))
        JOIN steam_database.generos g ON ((`j`.id_genero = `g`.id_genero)))
        JOIN steam_database.usuarios u ON ((`r`.id_usuario = `u`.id_usuario)));
        
-- vista_usuarios_bibliotecas
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `steam_database`.`vista_usuarios_bibliotecas` AS
    SELECT 
        `u`.`nombre` AS `Username`,
        `j`.`titulo` AS `Juego`,
        `g`.`genero` AS `Genero`,
        `jb`.`fecha_adquisicion` AS `Fecha de adquisicion`
    FROM
        ((((`steam_database`.`usuarios` `u`
        JOIN `steam_database`.`bibliotecas` `b` ON ((`u`.`id_usuario` = `b`.`id_usuario`)))
        JOIN `steam_database`.`juegos_bibliotecas` `jb` ON ((`b`.`id_biblioteca` = `jb`.`id_biblioteca`)))
        JOIN `steam_database`.`juegos` `j` ON ((`jb`.`id_juego` = `j`.`id_juego`)))
        JOIN `steam_database`.`generos` `g` ON ((`j`.`id_genero` = `g`.`id_genero`)));
        
-- FUNCIONES
-- ContarJuegosEnBiblioteca
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `ContarJuegosEnBiblioteca`(id_usuario INT) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE conteo INT;
    SELECT COUNT(jb.id_juego)
    INTO conteo
    FROM Juegos_Bibliotecas jb
    JOIN Bibliotecas b ON jb.id_biblioteca = b.id_biblioteca
    WHERE b.id_usuario = id_usuario;
    RETURN conteo;
END
DELIMITER ;

-- STORED PROCEDURES
-- AgregarJuegoABiblioteca
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarJuegoABiblioteca`(
    IN p_id_juego INT,
    IN p_id_biblioteca INT,
    IN p_fecha_adquisicion DATE
)
BEGIN
    INSERT INTO Juegos_Bibliotecas (id_juego, id_biblioteca, fecha_adquisicion)
    VALUES (p_id_juego, p_id_biblioteca, p_fecha_adquisicion);
END
DELIMITER ;

-- TRIGGERS
-- juegos_bibliotecas_BEFORE_INSERT
DELIMITER //
CREATE TRIGGER `juegos_bibliotecas_BEFORE_INSERT` BEFORE INSERT ON `juegos_bibliotecas` FOR EACH ROW BEGIN
IF NEW.fecha_adquisicion > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de adquisición no puede ser una fecha futura.';
    END IF;
END
DELIMITER ;



