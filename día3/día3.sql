-- Desafío - Creando y analizando nuestro propio blog
DROP DATABASE blog;

-- 1. Crear base de datos llamada blog.
CREATE DATABASE blog;

\c blog

-- 2. Crear las tablas indicadas de acuerdo al modelo de datos.
CREATE TABLE usuarios (
    id INT,
    email VARCHAR,
    PRIMARY KEY (id)
);

CREATE TABLE posts (
    id INT,
    usuario_id INT,
    titulo VARCHAR,
    fecha DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
);

CREATE TABLE comentarios (
    id INT,
    usuario_id INT,
    post_id INT,
    texto VARCHAR,
    fecha DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (post_id) REFERENCES posts (id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
);

-- 3. Insertar los siguientes registros.
\copy usuarios from 'usuarios.csv' csv header;
\copy posts from 'posts.csv' csv header;
\copy comentarios from 'comentarios.csv' csv header;

-- 4. Seleccionar el correo, id y título de todos los post publicados por el usuario 5.
SELECT a.email, b.usuario_id, b.titulo
FROM usuarios AS a
INNER JOIN posts AS b
ON a.id = b.usuario_id
WHERE usuario_id = 5;

-- 5. Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com.
SELECT a.email, b.usuario_id, b.texto
FROM usuarios AS a
INNER JOIN comentarios AS b
ON a.id = b.usuario_id
WHERE email <> 'usuario06@hotmail.com';

-- 6. Listar los usuarios que no han publicado ningún post.
SELECT a.id, a.email
FROM usuarios AS a
LEFT JOIN posts AS b
ON a.id = b.usuario_id
WHERE b.usuario_id IS NULL;

-- 7. Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios).
SELECT a.titulo, b.texto
FROM posts AS a
FULL OUTER JOIN comentarios AS b
ON a.id = b.post_id
ORDER BY a.id;

-- 8. Listar todos los usuarios que hayan publicado un post en Junio.
SELECT b.email, a.titulo, a.fecha
FROM posts AS a
LEFT JOIN usuarios AS b
ON b.id = a.usuario_id
WHERE a.fecha BETWEEN '2020-06-01' AND '2020-06-30'
ORDER BY a.fecha ASC;