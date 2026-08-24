-- =====================================================
-- TEMA DE BASE DE DATOS: HARRY POTTER
-- =====================================================

CREATE DATABASE IF NOT EXISTS harry_potter_db;
USE harry_potter_db;

-- -----------------------------------------------------
-- Tabla: Casas
-- -----------------------------------------------------
CREATE TABLE Casas (
    id_casa INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fundador VARCHAR(50),
    animal_simbolo VARCHAR(50),
    colores VARCHAR(50)
);

-- -----------------------------------------------------
-- Tabla: Personajes
-- -----------------------------------------------------
CREATE TABLE Personajes (
    id_personaje INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    especie VARCHAR(50) DEFAULT 'Humano',
    anio_nacimiento INT,
    id_casa INT,
    FOREIGN KEY (id_casa) REFERENCES Casas(id_casa)
);

-- -----------------------------------------------------
-- Tabla: Libros
-- -----------------------------------------------------
CREATE TABLE Libros (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(120) NOT NULL,
    anio_publicacion INT,
    numero_paginas INT
);

-- -----------------------------------------------------
-- Tabla: Hechizos
-- -----------------------------------------------------
CREATE TABLE Hechizos (
    id_hechizo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    efecto VARCHAR(150)
);

-- -----------------------------------------------------
-- Tabla intermedia: Personaje_Hechizo (relación N:M)
-- Un personaje puede usar varios hechizos,
-- y un hechizo puede ser usado por varios personajes.
-- -----------------------------------------------------
CREATE TABLE Personaje_Hechizo (
    id_personaje INT NOT NULL,
    id_hechizo INT NOT NULL,
    PRIMARY KEY (id_personaje, id_hechizo),
    FOREIGN KEY (id_personaje) REFERENCES Personajes(id_personaje),
    FOREIGN KEY (id_hechizo) REFERENCES Hechizos(id_hechizo)
);

-- =====================================================
-- DATOS DE EJEMPLO
-- =====================================================

INSERT INTO Casas (nombre, fundador, animal_simbolo, colores) VALUES
('Gryffindor', 'Godric Gryffindor', 'León', 'Rojo y dorado'),
('Slytherin', 'Salazar Slytherin', 'Serpiente', 'Verde y plata'),
('Ravenclaw', 'Rowena Ravenclaw', 'Águila', 'Azul y bronce'),
('Hufflepuff', 'Helga Hufflepuff', 'Tejón', 'Amarillo y negro');

INSERT INTO Personajes (nombre, especie, anio_nacimiento, id_casa) VALUES
('Harry Potter', 'Humano', 1980, 1),
('Hermione Granger', 'Humano', 1979, 1),
('Draco Malfoy', 'Humano', 1980, 2),
('Luna Lovegood', 'Humano', 1981, 3),
('Cedric Diggory', 'Humano', 1977, 4);

INSERT INTO Libros (titulo, anio_publicacion, numero_paginas) VALUES
('La Piedra Filosofal', 1997, 223),
('La Cámara Secreta', 1998, 251),
('El Prisionero de Azkaban', 1999, 317);

INSERT INTO Hechizos (nombre, efecto) VALUES
('Expelliarmus', 'Desarma al oponente'),
('Expecto Patronum', 'Invoca un patronus protector'),
('Lumos', 'Ilumina la punta de la varita'),
('Wingardium Leviosa', 'Hace levitar objetos');

INSERT INTO Personaje_Hechizo (id_personaje, id_hechizo) VALUES
(1, 1), 
(1, 2), 
(2, 4), 
(2, 3), 
(4, 2); 

-- =====================================================
-- CONSULTAS DE EJEMPLO 
-- =====================================================

-- Personajes con su casa
SELECT p.nombre AS personaje, c.nombre AS casa
FROM Personajes p
JOIN Casas c ON p.id_casa = c.id_casa;

-- Hechizos que sabe cada personaje
SELECT p.nombre AS personaje, h.nombre AS hechizo
FROM Personaje_Hechizo ph
JOIN Personajes p ON ph.id_personaje = p.id_personaje
JOIN Hechizos h ON ph.id_hechizo = h.id_hechizo
ORDER BY p.nombre;
