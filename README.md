
# Sistema de Gestión de Préstamos de Equipos

Este proyecto consiste en una base de datos relacional para gestionar el préstamo de equipos dentro de la Universidad. 
Incluye el diseño del modelo entidad-relación, scripts SQL para la creación de tablas y funciones adicionales como vistas, triggers y procedimientos.

## 📁 Estructura del Proyecto

- `prestamos_lab.sql`: Script para la creación de la base de datos y sus tablas.
- `índices, vistas, funciones y triggers.sql`: Contiene índices, vistas, funciones y triggers adicionales.
- `Entregable_BD_Sistema_Prestamos.PDF`: Documento con la descripción completa del proyecto.
- `DER.png`: Diagrama Entidad-Relación (MER).

## 🧠 Descripción General

- **Dominio**: Préstamo de equipos.
- **Actores**: Administrador, Usuario, Sistema.
- **Objetivo**: Registrar usuarios, equipos, préstamos y devoluciones.

## 🛠️ Instrucciones de Ejecución

1. Abre MySQL Workbench o consola de MySQL.
2. Ejecuta el script `prestamos_lab.sql` para crear las tablas y relaciones.
3. Ejecuta `índices, vistas, funciones y triggers.sql` para agregar funcionalidades adicionales.

## 🗃️ Modelo Lógico

Tablas principales:

- `usuarios(id, nombre, correo)`
- `equipos(id, nombre, descripcion, serial, estado)`
- `prestamos(id, equipo_id, usuario_id, fecha_prestamo, fecha_devolucion, devuelto)`

## 🔧 Tecnologías Usadas

- MySQL 

## ✅ Estado del Proyecto

Proyecto finalizado y funcional.

---


