---
name: architecture
description: Principios arquitectónicos utilizados en los proyectos.
---

# Arquitectura

## Principios

Los sistemas deben ser:

- Modulares.
- Mantenibles.
- Testeables.
- Cohesivos.
- Desacoplados.

## Regla de Dependencias

Las dependencias deben apuntar hacia las reglas de negocio y las capas más estables.

La lógica de negocio no debe depender directamente de infraestructura.

## Separación

Separar claramente:

- Dominio.
- Aplicación.
- Infraestructura.
- Presentación.

## Dominio

El dominio no debe depender directamente de:

- Frameworks.
- Bases de datos.
- APIs externas.
- Servicios cloud.

## Módulos

Cada módulo debe tener:

- Responsabilidad clara.
- Interfaz definida.
- Dependencias explícitas.
- Límites claros.