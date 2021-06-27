DROP DATABASE biblioteca;

CREATE DATABASE biblioteca;

\c biblioteca

CREATE TABLE socios(
rut VARCHAR(12),
nombre VARCHAR(50),
apellido VARCHAR(50),
direccion VARCHAR(100),
telefono INT,
PRIMARY KEY (rut)
);

\copy socios from 'socios.csv' csv header;

CREATE TABLE libros(
isbn VARCHAR(15),
titulo VARCHAR(50),
pag INT,
dias_prestamo INT,
PRIMARY KEY (isbn)
);

\copy libros from 'libros.csv' csv header;

CREATE TABLE autores(
cod_autor SERIAL,
nombre VARCHAR(50),
apellido VARCHAR(50),
nacimiento INT,
muerte INT,
tipo_autor VARCHAR(9),
PRIMARY KEY (cod_autor)
);

\copy autores from 'autores.csv' csv header;

CREATE TABLE historial_prestamos(
rut_socio VARCHAR(12),
isbn_libros VARCHAR(15),
fecha_prestamo DATE,
fecha_devolucion DATE,
FOREIGN KEY (rut_socio) REFERENCES socios(rut),
FOREIGN KEY (isbn_libros) REFERENCES libros(isbn)
);

\copy historial_prestamos from 'historial.csv' csv header;

CREATE TABLE libros_autores(
isbn_libros VARCHAR(15),
cod_autor INT,
FOREIGN KEY (isbn_libros) REFERENCES libros(isbn),
FOREIGN KEY (cod_autor) REFERENCES autores(cod_autor)
);

INSERT INTO libros_autores(isbn_libros, cod_autor)
VALUES ('111-1111111-111', 3),
('111-1111111-111', 4),
('222-2222222-222', 1),
('333-3333333-333', 2),
('444-4444444-444', 5);

-- -- a. Mostrar todos los libros que posean menos de 300 páginas.
SELECT * FROM libros WHERE pag < '300';

-- -- b. Mostrar todos los autores que hayan nacido después del 01-01-1970.
SELECT * FROM autores WHERE nacimiento > '1970';

-- -- c. ¿Cuál es el libro más solicitado?
SELECT isbn_libros, COUNT(*) FROM historial_prestamos
GROUP BY isbn_libros
HAVING COUNT(*) = (SELECT MAX(c)
FROM (SELECT COUNT(*) AS c
FROM historial_prestamos
GROUP BY isbn_libros) AS q);

-- -- d. Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto
-- -- debería pagar cada usuario por atraso.
SELECT CONCAT(nombre, apellido) AS socio, titulo AS libro, dias_prestamo AS días_permitido, fecha_devolucion - fecha_prestamo AS días_prestado, (fecha_devolucion - fecha_prestamo) - libros.dias_prestamo AS días_retraso, ((fecha_devolucion - fecha_prestamo) - (libros.dias_prestamo)) * 100 AS multa FROM historial_prestamos
INNER JOIN libros
ON historial_prestamos.isbn_libros = libros.isbn
INNER JOIN socios
ON historial_prestamos.rut_socio = socios.rut
WHERE fecha_devolucion - fecha_prestamo > libros.dias_prestamo;