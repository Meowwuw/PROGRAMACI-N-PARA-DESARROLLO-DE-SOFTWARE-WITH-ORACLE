##John Benjamin Abarca Diaz
## 1. Necesidad

**Obtener reservas**

Se requiere obtener todas las reservas de la base de datos.

## 2. Endpoint

**GET** /api/reservas

## 3. Modelo

**Reserva**

##tabla

CREATE TABLE reserva (
    id_reserva SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL REFERENCES cliente(id_cliente),
    id_cancha INT NOT NULL REFERENCES cancha(id_cancha),
    id_horario INT NOT NULL REFERENCES horario(id_horario),
    fecha_reserva DATE NOT NULL,
    estado VARCHAR(50)DEFAULT 'Pendiente',
    total DECIMAL(10,2) NOT NULL
);

##Jhoau Zegarra Lopez 

## 1. Necesidad

**Obtener horarios**

Se requiere obtener todos los horarios disponibles
de la base de datos.

## 2. Endpoint

**GET** /api/horarios

## 3. Modelo

**Horario**

##tabla 
CREATE TABLE horario (
    id_horario SERIAL PRIMARY KEY,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

##Esteban Arevalo Villacorta

const productService = require('../services/product.service');

const createProduct = async (req, res) => {
  try {
    const { name, price, stock, category_id } = req.body;

    // Validación básica de entrada
    if (!name || price == null || stock == null || !category_id) {
      return res.status(400).json({ error: 'Todos los campos son obligatorios' });
    }

    if (price <= 0 || stock < 0) {
      return res.status(400).json({ error: 'El precio y el stock deben ser valores válidos' });
    }

    const newProduct = await productService.createProduct({ name, price, stock, category_id });
    return res.status(201).json(newProduct);
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

module.exports = { createProduct };

##Clara Luz Chero Rios
## 1. Necesidad

**Obtener pagos**

Se requiere obtener todos los pagos de la base de datos.

## 2. Endpoint

**GET** /api/pagos

## 3. Modelo

**Pago**

##tabla
CREATE TABLE pago (
    id_pago SERIAL PRIMARY KEY,
    id_reserva INT NOT NULL REFERENCES reserva(id_reserva),
    fecha_pago DATE,
    monto DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    estado VARCHAR(50) DEFAULT 'Pendiente'
);

##Susan Aracely Ñahuinripa Quispe

## 1. Necesidad

**Obtener cliente** \

Se requiere obtener todos los clientes 
de la base de datos
 
## 2. Endpoint

**POST** /api/clientes

## 3. Modelo

**Cliente**

##tabla

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(20) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

## Las tablas 