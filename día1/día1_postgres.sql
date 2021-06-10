DROP DATABASE posts;

CREATE DATABASE posts;

\c posts;

CREATE TABLE post(id SERIAL UNIQUE,
nombre_usuario VARCHAR(20),
fecha_creacion TIMESTAMP,
contenido VARCHAR(50),
descripcion VARCHAR(50),
PRIMARY KEY (contenido));

INSERT INTO post (nombre_usuario, fecha_creacion, contenido, descripcion)
VALUES
('Pamela', '2021-06-08', 'Post de Pamela', 'Descripcion post1 Pamela');

INSERT INTO post (nombre_usuario, fecha_creacion, contenido, descripcion)
VALUES
('Pamela', '2021-06-09', 'Post de Pamela', 'Descripcion post2 Pamela');

INSERT INTO post (nombre_usuario, fecha_creacion, contenido, descripcion)
VALUES
('Carlos', '2021-06-10', 'Post de Carlos', 'Descripcion post1 Carlos');

ALTER TABLE post
ADD titulo VARCHAR(25);

UPDATE post SET titulo = 'titulo1 Pamela'
WHERE id = 1;

UPDATE post SET titulo = 'titulo2 Pamela'
WHERE id = 2;

UPDATE post SET titulo = 'titulo1 Carlos'
WHERE id = 3;

INSERT INTO post (nombre_usuario, fecha_creacion, contenido, descripcion)
VALUES
('Pedro', '2021-06-11', 'Post de Pedro', 'Descripcion post1 Pedro');

DELETE FROM post WHERE nombre_usuario = 'Carlos';

INSERT INTO post (nombre_usuario, fecha_creacion, contenido, descripcion)
VALUES
('Carlos', '2021-06-12', 'Post de Carlos', 'Descripcion post2 Carlos');

CREATE TABLE comentarios(id SERIAL UNIQUE,
hora_de_creacion TIME,
contenido VARCHAR(50),
FOREIGN KEY (contenido) REFERENCES post(contenido));

INSERT INTO comentarios (hora_de_creacion, contenido)
VALUES
('10:25', 'Post de Pamela');

INSERT INTO comentarios (hora_de_creacion, contenido)
VALUES
('11:25', 'Post de Pamela');

INSERT INTO comentarios (hora_de_creacion, contenido)
VALUES
('12:25', 'Post de Carlos');

INSERT INTO comentarios (hora_de_creacion, contenido)
VALUES
('13:25', 'Post de Carlos');

INSERT INTO comentarios (hora_de_creacion, contenido)
VALUES
('14:25', 'Post de Carlos');

INSERT INTO comentarios (hora_de_creacion, contenido)
VALUES
('15:25', 'Post de Carlos');

INSERT INTO post (nombre_usuario, fecha_creacion, contenido, descripcion)
VALUES
('Margarita', '2021-08-11', 'Post de Margarita', 'Descripcion post1 Margarita');

INSERT INTO comentarios (hora_de_creacion, contenido)
VALUES
('16:25', 'Post de Margarita');

INSERT INTO comentarios (hora_de_creacion, contenido)
VALUES
('16:45', 'Post de Margarita');

INSERT INTO comentarios (hora_de_creacion, contenido)
VALUES
('17:00', 'Post de Margarita');

INSERT INTO comentarios (hora_de_creacion, contenido)
VALUES
('17:25', 'Post de Margarita');

INSERT INTO comentarios (hora_de_creacion, contenido)
VALUES
('18:25', 'Post de Margarita');