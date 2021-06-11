DROP DATABASE posts;

CREATE DATABASE posts;

\c posts;

CREATE TABLE post(id SERIAL,
nombre_usuario VARCHAR(20),
fecha_creacion TIMESTAMP,
contenido VARCHAR(50),
descripcion VARCHAR(50),
PRIMARY KEY (id));

INSERT INTO post (nombre_usuario, fecha_creacion, contenido, descripcion)
VALUES
('Pamela', '2021-06-08', '1Post de Pamela', 'Descripcion post1 Pamela');

INSERT INTO post (nombre_usuario, fecha_creacion, contenido, descripcion)
VALUES
('Pamela', '2021-06-09', '2Post de Pamela', 'Descripcion post2 Pamela');

INSERT INTO post (nombre_usuario, fecha_creacion, contenido, descripcion)
VALUES
('Carlos', '2021-06-10', '1Post de Carlos', 'Descripcion post1 Carlos');

ALTER TABLE post
ADD titulo VARCHAR(25);

UPDATE post SET titulo = 'titulo1 Pamela'
WHERE id = 1;

UPDATE post SET titulo = 'titulo2 Pamela'
WHERE id = 2;

UPDATE post SET titulo = 'titulo1 Carlos'
WHERE id = 3;

INSERT INTO post (nombre_usuario, fecha_creacion, contenido, descripcion, titulo)
VALUES
('Pedro', '2021-06-11', 'Post de Pedro', 'Descripcion post1 Pedro', 'titulo Pedro');

DELETE FROM post WHERE nombre_usuario = 'Carlos';

INSERT INTO post (nombre_usuario, fecha_creacion, contenido, descripcion, titulo)
VALUES
('Carlos', '2021-06-12', 'Post de Carlos', 'Descripcion post2 Carlos', 'titulo Carlos');

CREATE TABLE comentarios(id SERIAL,
post_id INT,
hora_de_creacion TIME,
contenido VARCHAR(50),
PRIMARY KEY (id),
FOREIGN KEY (post_id) REFERENCES post(id));

INSERT INTO comentarios (post_id, hora_de_creacion, contenido)
VALUES
(1, '10:25', '1Comentario Post de Pamela');

INSERT INTO comentarios (post_id, hora_de_creacion, contenido)
VALUES
(1, '11:25', '2Comentario Post de Pamela');

INSERT INTO comentarios (post_id, hora_de_creacion, contenido)
VALUES
(4, '12:25', 'Post de Carlos');

INSERT INTO comentarios (post_id, hora_de_creacion, contenido)
VALUES
(4, '13:25', 'Post de Carlos');

INSERT INTO comentarios (post_id, hora_de_creacion, contenido)
VALUES
(4, '14:25', 'Post de Carlos');

INSERT INTO comentarios (post_id, hora_de_creacion, contenido)
VALUES
(4, '15:25', 'Post de Carlos');

INSERT INTO post (nombre_usuario, fecha_creacion, contenido, descripcion, titulo)
VALUES
('Margarita', '2021-08-11', 'Post de Margarita', 'Descripcion post1 Margarita', 'titulo Margarita');

INSERT INTO comentarios (post_id, hora_de_creacion, contenido)
VALUES
(6, '16:25', '1Comentario de Margarita');

INSERT INTO comentarios (post_id, hora_de_creacion, contenido)
VALUES
(6, '16:45', '2Comentario de Margarita');

INSERT INTO comentarios (post_id, hora_de_creacion, contenido)
VALUES
(6, '17:00', '3Comentario de Margarita');

INSERT INTO comentarios (post_id, hora_de_creacion, contenido)
VALUES
(6, '17:25', '4Comentario de Margarita');

INSERT INTO comentarios (post_id, hora_de_creacion, contenido)
VALUES
(6, '18:25', '5Comentario de Margarita');

SELECT * FROM post;

SELECT * FROM comentarios;