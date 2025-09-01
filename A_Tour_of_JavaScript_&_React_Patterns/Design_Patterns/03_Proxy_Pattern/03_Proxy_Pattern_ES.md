# Patrón Proxy en JavaScript

## Introducción
El Patrón Proxy nos permite interceptar y modificar las interacciones con un objeto, proporcionando una capa adicional de control y funcionalidad. Esto es útil para tareas como validación, registro (logging) y depuración.

## Temas Cubiertos
- ¿Qué es un Patrón Proxy?
- ¿Cómo funciona?
- Implementación en JavaScript
  - Uso del objeto `Proxy`
  - Agregar funcionalidad con los manejadores `get` y `set`
  - Uso de `Reflect` para mejor legibilidad
- Ventajas y desventajas de los Proxies

## ¿Qué es un Patrón Proxy?
Un **Patrón Proxy** es un patrón de diseño donde un objeto proxy se encuentra entre un cliente y el objeto objetivo. En lugar de interactuar directamente con el objeto objetivo, el cliente interactúa con el proxy, que intercepta y controla las solicitudes y respuestas.

### Características Clave
- Un proxy actúa como intermediario entre el cliente y el objeto objetivo.
- Proporciona una forma de controlar el acceso al objeto objetivo interceptando operaciones como acceso y modificación de propiedades.

### ¿Por qué usar un Proxy?
- Agregar funcionalidades como:
  - Validación
  - Registro (Logging)
  - Depuración
  - Notificaciones
- Encapsular el control sobre las interacciones con un objeto.

## Implementación en JavaScript
En JavaScript, el objeto incorporado `Proxy` nos permite crear proxies fácilmente. El objeto `Proxy` toma dos argumentos:
1. **El objeto objetivo**: El objeto que será proxy.
2. **El objeto manejador**: Un objeto que contiene trampas (funciones) como `get` y `set` que definen cómo el proxy debe manejar las interacciones.

### Ejemplo: Proxy Básico
```javascript
const person = {
  name: "John Doe",
  age: 42,
  email: "john@doe.com",
  country: "Canadá",
};

const personProxy = new Proxy(person, {
  get: (target, prop) => {
    console.log(`El valor de ${prop} es ${target[prop]}`);
    return target[prop];
  },
  set: (target, prop, value) => {
    console.log(`Cambiado ${prop} de ${target[prop]} a ${value}`);
    target[prop] = value;
    return true;
  },
});

// Accediendo a una propiedad
personProxy.name;
// Salida: El valor de name es John Doe

// Modificando una propiedad
personProxy.age += 1;
// Salida: Cambiado age de 42 a 43
```

### Uso de `Reflect` para Mejor Legibilidad
En lugar de modificar directamente el objeto objetivo (`target[prop]`), podemos usar la API `Reflect`. Esta proporciona métodos como `Reflect.get` y `Reflect.set`, que mejoran la legibilidad y consistencia del código.

```javascript
const personProxy = new Proxy(person, {
  get: (target, prop) => {
    return Reflect.get(target, prop);
  },
  set: (target, prop, value) => {
    return Reflect.set(target, prop, value);
  },
});
```

### Métodos Adicionales Incorporados en Proxy
El objeto `Proxy` soporta muchas trampas además de `get` y `set`, incluyendo:
- `has`: Intercepta el operador `in`.
- `deleteProperty`: Intercepta operaciones de `delete`.
- `apply`: Intercepta llamadas a funciones.
- `construct`: Intercepta llamadas al operador `new`.

## Ventajas y Desventajas de los Proxies

### Ventajas
1. **Control**:  
   - Los proxies facilitan agregar funcionalidad al interactuar con un objeto, como validación, registro, formateo, notificaciones o depuración.

2. **Encapsulación**:  
   - Proporcionan una forma limpia de encapsular la lógica que se ejecuta durante las interacciones con el objeto objetivo.

### Desventajas
1. **Impacto en el Rendimiento**:  
   - Los manejadores se ejecutan cada vez que ocurre una interacción con el objeto objetivo. Si estos manejadores implican lógica compleja, podría causar una degradación del rendimiento.

2. **Ejecución Asíncrona**:  
   - Para evitar retrasos causados por procesos largos en los manejadores (por ejemplo, enviar datos a múltiples métodos), es mejor ejecutar dichos procesos de manera asíncrona.

### Mejores Prácticas
- Mantener las funciones de los manejadores pequeñas y rápidas para reducir el impacto en el rendimiento.
- Usar `Reflect` para un código más legible y mantenible.

## Conclusión
El Patrón Proxy es un patrón de diseño poderoso en JavaScript, que proporciona un control detallado sobre las interacciones con un objeto. Al usar proxies, podemos mejorar los objetos con funcionalidades adicionales como validación, registro y depuración. Sin embargo, es importante considerar las desventajas, especialmente en cuanto al rendimiento, y diseñar proxies cuidadosamente para asegurar mantenibilidad y eficiencia.

