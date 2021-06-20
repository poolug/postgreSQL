-- Desactivado el autocommit
\set AUTOCOMMIT off

-- Inicia la transacción para la compra del usuario01
BEGIN;

-- Inserta la compra
INSERT INTO compra (cliente_id, fecha)
VALUES (1, NOW());

-- Inserta el detalle de la compra
INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES (9, (SELECT MAX(id) FROM compra), 5);

-- Actualiza el stock del producto9, restándole 5.
-- Generará error, ya que el stock del producto9 es 4
UPDATE producto SET stock = stock -5 WHERE id = 9;

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
INSERT INTO compra (cliente_id, fecha)
VALUES (2, NOW());
INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES (1, (SELECT MAX(id) FROM compra), 3);
UPDATE producto SET stock = stock -3 WHERE id = 1;

SAVEPOINT check_one;
INSERT INTO compra (cliente_id, fecha)
VALUES (2, NOW());
INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES (2, (SELECT MAX(id) FROM compra), 3);
UPDATE producto SET stock = stock -3 WHERE id = 2;

SAVEPOINT check_one;
INSERT INTO compra (cliente_id, fecha)
VALUES (2, NOW());
INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES (8, (SELECT MAX(id) FROM compra), 3);
UPDATE producto SET stock = stock -3 WHERE id = 8;

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
VALUES ('Usuario011', 'usuario011@gmail.com');
SELECT * FROM cliente ORDER BY id ASC;
ROLLBACK;
SELECT * FROM cliente ORDER BY id ASC;
COMMIT;

\set AUTOCOMMIT on

\echo :AUTOCOMMIT