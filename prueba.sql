-- Crear Modelo en DB

CREATE DATABASE prueba;

\c prueba;

CREATE TABLE clientes(
id SERIAL PRIMARY KEY,
nombre VARCHAR(150) NOT NULL,
rut VARCHAR(10) UNIQUE NOT NULL,
direccion VARCHAR(150) NOT NULL
);

CREATE TABLE facturas(
n_factura SERIAL PRIMARY KEY,
fecha_factura DATE NOT NULL,
subtotal INT NOT NULL,
iva INT NOT NULL,
precio_total INT NOT NULL
);

CREATE TABLE cliente_factura(
cliente_id INT NOT NULL,
factura_nf INT NOT NULL,
FOREIGN KEY(cliente_id) REFERENCES clientes(id),
FOREIGN KEY(factura_nf) REFERENCES facturas(n_factura)
);

CREATE TABLE productos(
id SERIAL PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
descripcion VARCHAR(250),
valor_unitario INT NOT NULL
);

CREATE TABLE categorias(
id SERIAL PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
descripcion VARCHAR(250)
);

CREATE TABLE categoria_producto(
categoria_id INT NOT NULL,
producto_id INT NOT NULL,
FOREIGN KEY(categoria_id) REFERENCES categorias(id),
FOREIGN KEY(producto_id) REFERENCES productos(id)
);

CREATE TABLE listado_productos(
n_factura INT NOT NULL,
producto_id INT NOT NULL,
producto_valor_unitario INT NOT NULL,
cantidad INT NOT NULL,
valor_total_pproducto INT NOT NULL,
FOREIGN KEY(n_factura) REFERENCES facturas(n_factura)
);

--Insertar 5 Clientes

INSERT INTO clientes(nombre, rut, direccion)
VALUES('Alejandra Flores', '7710295-6', 'Av Irrarazabal 1245'),
('Sergio Alarcon', '10223176-9', 'Agustinas 3542'),
('Leonor Vazquez', '8204495-k', 'Jose Arrieta 9245'),
('Ricardo Collado', '15507031-0', 'Av España 523'),
('Karen Huerta', '12811828-4', 'San Francisco 4231');

--Insertar 8 productos

INSERT INTO productos(nombre, descripcion, valor_unitario)
VALUES('Pepsi', 'Botella 3L', 1490),
('Coca Cola', 'Botella 3L', 1915),
('Sprite', 'Botella 1.5L', 1350),
('Mani MP', '430g', 1665),
('Papas Fritas MP', '250g', 1030),
('Ramitas MP', '270g', 1030),
('Cusqueña', 'Lata 473cc six pack', 3220),
('Bear Beer', 'Lata 500cc six pack', 2580);

--Insertar 3 categorias

INSERT INTO categorias(nombre, descripcion)
VALUES('bebidas', 'bebestibles'),
('snaks', 'cosas pa picar'),
('alcohol', 'pa no tomarse el agua del florero');

--(Relacion categoria_producto)

INSERT INTO categoria_producto(categoria_id, producto_id)
VALUES(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(2, 6),
(3, 7),
(3, 8);

--Insertar 10 facturas

INSERT INTO facturas(fecha_factura, subtotal, iva, precio_total)
VALUES('2020-08-24', 69600, 13224, 82824),
('2020-08-25', 53900, 10241, 64141),
('2020-08-26', 38040, 7228, 45268),
('2020-08-27', 23200, 4408, 27608),
('2020-08-28', 22350, 4247, 26597),
('2020-08-29', 35760, 6794, 42554),
('2020-08-30', 46400, 8816, 55216),
('2020-08-31', 228240, 43366, 271606),
('2020-09-01', 130680, 24829, 155509),
('2020-09-02', 51520, 9789, 61309);

INSERT INTO listado_productos(n_factura, producto_id, producto_valor_unitario, cantidad, valor_total_pproducto)
VALUES(1, 7, 3220, 12, 38640),
(1, 8, 2580, 12, 30960),
(2, 4, 1665, 20, 33300),
(2, 5, 1030, 20, 20600),
(2, 6, 1030, 20, 20600),
(3, 1, 1490, 8, 11920),
(3, 2, 1915, 8, 15320),
(3, 3, 1350, 8, 10800),
(4, 7, 3220, 4, 12880),
(4, 8, 2580, 4, 10320),
(5, 4, 1665, 6, 9990),
(5, 5, 1030, 6, 6180),
(5, 6, 1030, 6, 6180),
(6, 1, 1490, 24, 35760),
(7, 7, 3220, 8, 25760),
(7, 8, 2580, 8, 20640),
(8, 1, 1490, 48, 71520),
(8, 2, 1915, 48, 91920),
(8, 3, 1350, 48, 64800),
(9, 4, 1665, 24, 39960),
(9, 5, 1030, 24, 24720),
(9, 6, 1030, 24, 24720),
(9, 8, 2580, 16, 41280);

--(Relacion cliente_facturas)

INSERT INTO cliente_factura(cliente_id, factura_nf)
VALUES(1, 1),
(1, 2),
(2, 3),
(2, 4),
(2, 5),
(3, 6),
(4, 7),
(4, 8),
(4, 9),
(4, 10);

--¿Que cliente realizó la compra más cara?

SELECT clientes.nombre FROM clientes
INNER JOIN cliente_factura ON clientes.id = cliente_factura.cliente_id
INNER JOIN facturas ON cliente_factura.factura_nf = facturas.n_factura
ORDER BY facturas.precio_total DESC
LIMIT(1);

--¿Que cliente pagó sobre 100 de monto?

SELECT clientes.nombre FROM clientes
INNER JOIN cliente_factura ON clientes.id = cliente_factura.cliente_id
INNER JOIN facturas ON cliente_factura.factura_nf = facturas.n_factura
WHERE facturas.precio_total > 100
GROUP BY clientes.nombre;

--¿Cuantos clientes han comprado el producto 6

SELECT COUNT(clientes) FROM(SELECT clientes.nombre FROM clientes
INNER JOIN cliente_factura ON clientes.id = cliente_factura.cliente_id
INNER JOIN facturas ON cliente_factura.factura_nf = facturas.n_factura
INNER JOIN listado_productos ON facturas.n_factura = listado_productos.n_factura
WHERE listado_productos.producto_id = 6
GROUP BY clientes.nombre) AS clientes;