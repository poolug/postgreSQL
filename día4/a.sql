-- Desactivado el autocommit
\set AUTOCOMMIT off

-- Inicia la transacción para
BEGIN;

-- Inserta la compra del usuario01
INSERT INTO compra (cliente_id, fecha)
VALUES (1, NOW());

INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES (9, (SELECT MAX(id) FROM compra), 5);

-- Actualiza el stock del producto9, restándole 5.
-- Generará error, ya que el stock del producto9 es 4
UPDATE producto SET stock = stock - 5 WHERE id = 9;

-- Cierra la transacción y hace ROLLBACK automáticamente y no actualiza el stock
COMMIT;

-- Muestra el stock del producto9
SELECT id, descripcion, stock FROM producto WHERE descripcion = 'producto9';

-- Muestra el stock de los productos con id 1,2,8
SELECT id, descripcion, stock FROM producto
WHERE descripcion = 'producto1'
OR descripcion = 'producto2'
OR descripcion = 'producto8'
ORDER BY id ASC;

--Ingresando las compras del usuario02
BEGIN;
SAVEPOINT check_one;

UPDATE producto SET stock = stock -3 WHERE id = 1;
INSERT INTO compra (cliente_id, fecha)
VALUES (2, NOW());
INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES (1, (SELECT MAX(id) FROM compra), 3);

SAVEPOINT check_one;

UPDATE producto SET stock = stock -3 WHERE id = 2;
INSERT INTO compra (cliente_id, fecha)
VALUES (2, NOW());
INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES (2, (SELECT MAX(id) FROM compra), 3);

SAVEPOINT check_one;

UPDATE producto SET stock = stock - 3 WHERE id = 8;
INSERT INTO compra (cliente_id, fecha)
VALUES (2, NOW());
INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES (8, (SELECT MAX(id) FROM compra), 3);

ROLLBACK TO check_one;

COMMIT;

--Chequea el stock de los productos con id 1,2,8
SELECT id, descripcion, stock FROM producto
WHERE descripcion = 'producto1'
OR descripcion = 'producto2'
OR descripcion = 'producto8'
ORDER BY id ASC;

\set AUTOCOMMIT off

BEGIN;
INSERT INTO cliente (nombre, email)
VALUES ('Usuario011', 'usuario11@gmail.com');
SELECT * FROM cliente ORDER BY id ASC;
ROLLBACK;
SELECT * FROM cliente ORDER BY id ASC;
COMMIT;

\set AUTOCOMMIT on

\echo :AUTOCOMMIT