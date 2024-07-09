-- Creación de la base de datos si no existe
CREATE DATABASE IF NOT EXISTS steam_database;
USE steam_database;

-- Tabla Generos
CREATE TABLE Generos (
    id_genero INT PRIMARY KEY,
    genero VARCHAR(100) NOT NULL
);

-- Tabla Juegos
CREATE TABLE Juegos (
    id_juego INT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    desarrollador VARCHAR(255) NOT NULL,
    fecha_lanzamiento DATE NOT NULL,
    id_genero INT,
    acceso_anticipado BOOLEAN NOT NULL,
    precio DECIMAL(7, 2) NOT NULL,
    FOREIGN KEY (id_genero) REFERENCES Generos(id_genero)
);

-- Tabla Usuarios
CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    fecha_registro DATE NOT NULL,
    pais VARCHAR(100) NOT NULL,
    nivel_cuenta INT NOT NULL
);

-- Tabla Bibliotecas
CREATE TABLE Bibliotecas (
    id_biblioteca INT PRIMARY KEY,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- Tabla Juegos_Generos
CREATE TABLE Juegos_Generos (
    id_juego INT,
    id_genero INT,
    PRIMARY KEY (id_juego, id_genero),
    FOREIGN KEY (id_juego) REFERENCES Juegos(id_juego),
    FOREIGN KEY (id_genero) REFERENCES Generos(id_genero)
);

-- Tabla Juegos_Bibliotecas
CREATE TABLE Juegos_Bibliotecas (
    id_juego INT,
    id_biblioteca INT,
    fecha_adquisicion DATE NOT NULL,
    PRIMARY KEY (id_juego, id_biblioteca),
    FOREIGN KEY (id_juego) REFERENCES Juegos(id_juego),
    FOREIGN KEY (id_biblioteca) REFERENCES Bibliotecas(id_biblioteca)
);

-- Tabla Reseñas
CREATE TABLE Reseñas (
    id_resena INT PRIMARY KEY,
    id_juego INT,
    id_usuario INT,
    puntuacion INT NOT NULL,
    comentario TEXT,
    votos_positivos INT NOT NULL,
    fecha_resena DATE NOT NULL,
    FOREIGN KEY (id_juego) REFERENCES Juegos(id_juego),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);
