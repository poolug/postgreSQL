-- Día2 Desafío top100

DROP DATABASE top100;

CREATE DATABASE top100;

\c top100

CREATE TABLE peliculas (
    id SERIAL,
    pelicula VARCHAR(100),
    anio_estreno CHAR(4),
    director VARCHAR(30),
    PRIMARY KEY (id)
);

\copy peliculas FROM 'peliculas.csv' csv header;

CREATE TABLE reparto (
    id INT,
    actor VARCHAR(50),
    FOREIGN KEY (id) REFERENCES peliculas(id)
);

\copy reparto FROM 'reparto.csv' csv;

SELECT id FROM peliculas WHERE pelicula = 'Titanic';

SELECT actor FROM reparto WHERE id= 2;

SELECT COUNT(id) FROM reparto WHERE actor = 'Harrison Ford';

SELECT pelicula FROM peliculas WHERE anio_estreno BETWEEN '1990' and '1999' ORDER BY pelicula ASC;

SELECT pelicula, LENGTH(pelicula) as longitud_titulo FROM peliculas;

SELECT MAX(LENGTH(pelicula)) as longitud_maxima FROM peliculas;

SELECT actor, pelicula FROM reparto
INNER JOIN peliculas
ON reparto.id = peliculas.id
WHERE peliculas.id = 2
LIMIT 1;