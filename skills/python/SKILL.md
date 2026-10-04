---
name: python
description: Estándares de Python, arquitectura, buenas prácticas y documentación.
---

# Estándares de Desarrollo en Python

## Principios Generales

- Seguir los principios y convenciones de PEP 8.
- Escribir código explícito, claro y fácil de leer.
- Utilizar type hints en el código.
- Nombre de variables debe ser en snake_case
- Nombre de clases debe ser con camelCase
- Preferir composición sobre herencia.
- Evitar abstracciones innecesarias.
- Mantener las funciones pequeñas y enfocadas en una única responsabilidad.
- Mantener los módulos cohesivos y con responsabilidades bien definidas.
- Evitar el uso de estado global mutable.
- Preferir inyección de dependencias cuando sea apropiado.
- Priorizar la legibilidad y mantenibilidad sobre soluciones excesivamente complejas.
- Evitar código duplicado.
- Evitar optimizaciones prematuras.
- Mantener las responsabilidades claramente separadas.

## Type Hints

Todas las funciones públicas deben utilizar type hints.

Deben definir:

- Los tipos de todos sus parámetros.
- El tipo de retorno.
