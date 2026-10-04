---
name: coding-standards
description: Estándares generales para escribir código limpio, claro, mantenible y consistente.
---

# Estándares de Código

## Principios

- Priorizar la legibilidad.
- Mantener el código simple.
- Evitar complejidad innecesaria.
- Evitar duplicación.
- Evitar abstracciones prematuras.
- Mantener funciones pequeñas.
- Mantener módulos cohesivos.
- Hacer explícitas las dependencias.
- Evitar efectos secundarios ocultos.

## Responsabilidad Única

Cada función, clase y módulo debe tener una responsabilidad clara.

## Naming

Los nombres deben expresar intención.

Evitar nombres genéricos como:

- `data`
- `result`
- `temp`
- `obj`
- `item`

cuando exista un nombre más descriptivo.

## Complejidad

Evitar:

- Funciones excesivamente grandes.
- Clases con demasiadas responsabilidades.
- Anidamiento excesivo.
- Condicionales innecesariamente complejos.
- Abstracciones sin necesidad real.