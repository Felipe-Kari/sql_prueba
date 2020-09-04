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

--Insertar 10 facturas

--¿Que cliente realizó la compra más cara?

--¿Que cliente pagó sobre 100 de monto?

--¿Cuantos clientes han comprado el producto 6