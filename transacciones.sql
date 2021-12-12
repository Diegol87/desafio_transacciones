-- 1. Cargar el respaldo de la base de datos unidad2.sql

--Crear la base de datos donde vamos a importar el archivo unidad2.sql
CREATE DATABASE desafio_transacciones;

-- Importando el archivo
psql -U postgres desafio_transacciones < c:\unidad2.sql

-- 2. El cliente usuario01 ha realizado la siguiente compra "producto: producto9", "cantidad: 5","fecha: fecha del sistema", mediante el uso de transacciones, realiza las consultas correspondientes para este requerimiento y luego consulta la tabla para validar si fue efectivamente descontado en el stock

BEGIN;
INSERT INTO public.compra(id, cliente_id, fecha) VALUES(((SELECT MAX(id) FROM public.compra) + 1), 1, CURRENT_DATE);

 id | cliente_id |   fecha
----+------------+------------
  1 |          4 | 2020-02-12
  2 |          5 | 2020-03-14
  3 |         10 | 2020-02-07
  4 |          9 | 2020-04-25
  5 |          7 | 2020-04-03
  6 |          2 | 2020-03-23
  7 |          9 | 2020-03-11
  8 |          3 | 2020-04-21
  9 |          2 | 2020-02-24
 10 |         10 | 2020-04-18
 11 |          3 | 2020-04-22
 12 |          8 | 2020-03-22
 13 |         10 | 2020-02-20
 14 |          9 | 2020-02-07
 15 |          3 | 2020-04-25
 16 |          4 | 2020-03-20
 17 |          9 | 2020-02-22
 18 |          8 | 2020-02-17
 19 |         10 | 2020-03-14
 20 |          9 | 2020-03-07
 21 |          6 | 2020-04-28
 22 |          5 | 2020-02-06
 23 |         10 | 2020-01-31
 24 |          3 | 2020-02-15
 25 |          9 | 2020-03-12
 26 |          1 | 2020-01-31
 27 |         10 | 2020-04-08
 28 |          3 | 2020-03-20
 29 |          9 | 2020-03-16
 30 |          5 | 2020-04-09
 31 |          1 | 2020-03-29
 32 |          2 | 2020-03-29
 33 |          1 | 2021-12-12
(33 filas)

INSERT INTO public.detalle_compra(id, producto_id, compra_id, cantidad) VALUES(((SELECT MAX(id) FROM public.detalle_compra) + 1), 9, (SELECT MAX(id) FROM public.compra), 5);

 id | producto_id | compra_id | cantidad
----+-------------+-----------+----------
  1 |           2 |         2 |        9
  2 |           7 |         6 |        5
  3 |          16 |        23 |        1
  4 |          10 |        13 |        4
  5 |           7 |         8 |        2
  6 |           2 |        14 |        6
  7 |          19 |         8 |        7
  8 |           7 |        19 |        5
  9 |          17 |         3 |        5
 10 |           2 |         3 |        5
 11 |          16 |        27 |        8
 12 |          16 |        10 |        8
 13 |          13 |        14 |        8
 14 |           3 |        30 |        4
 15 |          13 |        15 |        2
 16 |          20 |        21 |        5
 17 |          15 |        21 |        2
 18 |          15 |        16 |        3
 19 |          16 |        19 |        9
 20 |           1 |         6 |       10
 21 |          17 |         1 |        7
 22 |          18 |         1 |        9
 23 |          20 |         4 |        8
 24 |          16 |         4 |        9
 25 |          14 |         5 |        6
 26 |          17 |         7 |        2
 27 |          17 |         9 |        6
 28 |          18 |        11 |        4
 29 |          20 |        12 |        7
 30 |           3 |        17 |        5
 31 |           2 |        18 |       10
 32 |          20 |        20 |        1
 33 |          10 |        22 |       10
 34 |          18 |        24 |        2
 35 |           3 |        25 |       10
 36 |           3 |        26 |        4
 37 |           3 |        28 |        2
 38 |          11 |        29 |        7
 39 |           9 |        31 |        5
 40 |           1 |        32 |        3
 41 |           2 |        32 |        3
 42 |           8 |        32 |        3
 43 |           9 |        33 |        5
(43 filas)

UPDATE public.producto SET stock = stock - 5 WHERE id = 9;
COMMIT;

SELECT * FROM public.producto WHERE id = 9;

 id | cliente_id |   fecha
----+------------+------------
  1 |          4 | 2020-02-12
  2 |          5 | 2020-03-14
  3 |         10 | 2020-02-07
  4 |          9 | 2020-04-25
  5 |          7 | 2020-04-03
  6 |          2 | 2020-03-23
  7 |          9 | 2020-03-11
  8 |          3 | 2020-04-21
  9 |          2 | 2020-02-24
 10 |         10 | 2020-04-18
 11 |          3 | 2020-04-22
 12 |          8 | 2020-03-22
 13 |         10 | 2020-02-20
 14 |          9 | 2020-02-07
 15 |          3 | 2020-04-25
 16 |          4 | 2020-03-20
 17 |          9 | 2020-02-22
 18 |          8 | 2020-02-17
 19 |         10 | 2020-03-14
 20 |          9 | 2020-03-07
 21 |          6 | 2020-04-28
 22 |          5 | 2020-02-06
 23 |         10 | 2020-01-31
 24 |          3 | 2020-02-15
 25 |          9 | 2020-03-12
 26 |          1 | 2020-01-31
 27 |         10 | 2020-04-08
 28 |          3 | 2020-03-20
 29 |          9 | 2020-03-16
 30 |          5 | 2020-04-09
 31 |          1 | 2020-03-29
 32 |          2 | 2020-03-29
 33 |          1 | 2021-12-12
(33 filas)


-- 3. El cliente usuario02 ha realizado la siguiente compra "producto: producto1, producto2, producto8", "cantidad: 3 de cada producto", "fecha: fecha del sistema", mediante el uso de transacciones, realiza las consultas correspondientes para este requerimiento y luego consulta la tabla del producto para validar que si alguno de ellos se queda sin stock, no se realice la compra.

BEGIN;
INSERT INTO public.compra(id, cliente_id, fecha) VALUES(((SELECT MAX(id) FROM public.compra) + 1), 2, CURRENT_DATE);

 id | cliente_id |   fecha
----+------------+------------
  1 |          4 | 2020-02-12
  2 |          5 | 2020-03-14
  3 |         10 | 2020-02-07
  4 |          9 | 2020-04-25
  5 |          7 | 2020-04-03
  6 |          2 | 2020-03-23
  7 |          9 | 2020-03-11
  8 |          3 | 2020-04-21
  9 |          2 | 2020-02-24
 10 |         10 | 2020-04-18
 11 |          3 | 2020-04-22
 12 |          8 | 2020-03-22
 13 |         10 | 2020-02-20
 14 |          9 | 2020-02-07
 15 |          3 | 2020-04-25
 16 |          4 | 2020-03-20
 17 |          9 | 2020-02-22
 18 |          8 | 2020-02-17
 19 |         10 | 2020-03-14
 20 |          9 | 2020-03-07
 21 |          6 | 2020-04-28
 22 |          5 | 2020-02-06
 23 |         10 | 2020-01-31
 24 |          3 | 2020-02-15
 25 |          9 | 2020-03-12
 26 |          1 | 2020-01-31
 27 |         10 | 2020-04-08
 28 |          3 | 2020-03-20
 29 |          9 | 2020-03-16
 30 |          5 | 2020-04-09
 31 |          1 | 2020-03-29
 32 |          2 | 2020-03-29
 33 |          1 | 2021-12-12
 34 |          2 | 2021-12-12
(34 filas)

INSERT INTO public.detalle_compra(id, producto_id, compra_id, cantidad) VALUES(((SELECT MAX(id) FROM public.detalle_compra) + 1), 1, (SELECT MAX(id) FROM public.compra), 3);
INSERT INTO public.detalle_compra(id, producto_id, compra_id, cantidad) VALUES(((SELECT MAX(id) FROM public.detalle_compra) + 1), 2, (SELECT MAX(id) FROM public.compra), 3);
INSERT INTO public.detalle_compra(id, producto_id, compra_id, cantidad) VALUES(((SELECT MAX(id) FROM public.detalle_compra) + 1), 8, (SELECT MAX(id) FROM public.compra), 3);

 id | producto_id | compra_id | cantidad
----+-------------+-----------+----------
  1 |           2 |         2 |        9
  2 |           7 |         6 |        5
  3 |          16 |        23 |        1
  4 |          10 |        13 |        4
  5 |           7 |         8 |        2
  6 |           2 |        14 |        6
  7 |          19 |         8 |        7
  8 |           7 |        19 |        5
  9 |          17 |         3 |        5
 10 |           2 |         3 |        5
 11 |          16 |        27 |        8
 12 |          16 |        10 |        8
 13 |          13 |        14 |        8
 14 |           3 |        30 |        4
 15 |          13 |        15 |        2
 16 |          20 |        21 |        5
 17 |          15 |        21 |        2
 18 |          15 |        16 |        3
 19 |          16 |        19 |        9
 20 |           1 |         6 |       10
 21 |          17 |         1 |        7
 22 |          18 |         1 |        9
 23 |          20 |         4 |        8
 24 |          16 |         4 |        9
 25 |          14 |         5 |        6
 26 |          17 |         7 |        2
 27 |          17 |         9 |        6
 28 |          18 |        11 |        4
 29 |          20 |        12 |        7
 30 |           3 |        17 |        5
 31 |           2 |        18 |       10
 32 |          20 |        20 |        1
 33 |          10 |        22 |       10
 34 |          18 |        24 |        2
 35 |           3 |        25 |       10
 36 |           3 |        26 |        4
 37 |           3 |        28 |        2
 38 |          11 |        29 |        7
 39 |           9 |        31 |        5
 40 |           1 |        32 |        3
 41 |           2 |        32 |        3
 42 |           8 |        32 |        3
 43 |           9 |        33 |        5
 44 |           1 |        34 |        3
 45 |           2 |        34 |        3
 46 |           8 |        34 |        3
(46 filas)

UPDATE public.producto SET stock = stock - 3 WHERE id = 1 OR id = 2 OR id = 8;

ERROR:  el nuevo registro para la relación «producto» viola la restricción «check» «stock_valido»
DETALLE:  La fila que falla contiene (8, producto8, -3, 8923).

COMMIT;

ROLLBACK;

SELECT * FROM public.producto;

 id | descripcion | stock | precio
----+-------------+-------+--------
  3 | producto3   |     9 |   9449
  4 | producto4   |     8 |    194
  5 | producto5   |    10 |   3764
  6 | producto6   |     6 |   8655
  7 | producto7   |     4 |   2875
 10 | producto10  |     1 |   3001
 11 | producto11  |     9 |   7993
 12 | producto12  |     3 |   8504
 13 | producto13  |    10 |   2415
 14 | producto14  |     5 |   3824
 15 | producto15  |    10 |   7358
 16 | producto16  |     7 |   3631
 17 | producto17  |     3 |   4467
 18 | producto18  |     2 |   9383
 19 | producto19  |     6 |   1140
 20 | producto20  |     4 |    102
  1 | producto1   |     6 |   9107
  2 | producto2   |     5 |   1760
  8 | producto8   |     0 |   8923
  9 | producto9   |     3 |   4219
(20 filas)

-- 4. Realizar las siguientes consultas: 
-- a. Deshabilitar al AUTOCOMMIT.

\set AUTOCOMMIT off
\echo :AUTOCOMMIT
off

-- b. Insertar un nuevo cliente.

BEGIN;
INSERT INTO public.cliente(id, nombre, email) VALUES(((SELECT MAX(id) FROM public.cliente) + 1), 'usuario011', 'usuario011@gmail.com');
-- c. Confirmar que fue agregado en la tabla cliente.

SELECT * FROM public.cliente WHERE nombre = 'usuario011';

 id |   nombre   |         email
----+------------+-----------------------
 11 | usuario011 | ususario011@gmail.com
(1 fila)

-- d. Realizar un ROLLBACK.

ROLLBACK;

-- e. Confirmar que se restauró la información, sin considerar la inserción del punto b.

SELECT * FROM public.cliente WHERE nombre = 'usuario011';

 id | nombre | email
----+--------+-------
(0 filas)

-- f. Habilitar de nuevo el AUTOCOMMIT

\set AUTOCOMMIT on

\echo :AUTOCOMMIT
on

