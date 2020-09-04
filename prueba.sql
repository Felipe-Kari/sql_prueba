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

--Insertar 8 productos

--Insertar 3 categorias

--Insertar 10 facturas

--¿Que cliente realizó la compra más cara?

--¿Que cliente pagó sobre 100 de monto?

--¿Cuantos clientes han comprado el producto 6