# Patrón Singleton en JavaScript

## Introducción
Un Singleton garantiza que haya únicamente una única instancia de una clase u objeto compartida a lo largo de la aplicación. Este es un patrón de diseño útil para asegurar consistencia en escenarios donde se requiere acceso global a un recurso.

## Temas Cubiertos
- ¿Qué es un Singleton?
- ¿Por qué usar Singletons?
- Implementación en JavaScript
  - Usando Clases de ES2015
  - Usando Objetos Simples
- Ventajas de los Singletons
- Desventajas de los Singletons
- Conclusión

## ¿Qué es un Singleton?
Un **Singleton** asegura que haya sólo una instancia de una clase u objeto compartida en toda la aplicación. Esta instancia puede ser accedida y modificada globalmente.

### Características Clave
- Sólo se crea **una instancia**.
- Las modificaciones a la instancia se reflejan globalmente.
- Los objetos o clases Singleton son frecuentemente **inmutables**.

### ¿Por qué usar Singletons?
- Prevenir múltiples instancias del mismo objeto o clase.
- Proveer un único punto de acceso global a recursos compartidos.

## Implementación en JavaScript

### Usando Clases de ES2015
Para crear un Singleton usando una clase:
```javascript
let instance;

class Counter {
  constructor() {
    if (instance) {
      throw new Error("¡Sólo puedes crear una instancia!");
    }
    this.counter = 0; // Inicializar el contador
    instance = this; // Asignar la instancia
  }

  getCount() {
    return this.counter;
  }

  increment() {
    return ++this.counter;
  }

  decrement() {
    return --this.counter;
  }
}

// Congelar la instancia para hacerla inmutable
const singletonCounter = Object.freeze(new Counter());

export default singletonCounter;
```

### Usando Objetos Simples
Los Singletons también pueden crearse usando objetos:
```javascript
let counter = 0;

const counterObject = {
  getCount: () => counter,
  increment: () => ++counter,
  decrement: () => --counter,
};

// Congelar el objeto para prevenir modificaciones
const singletonCounter = Object.freeze(counterObject);

export default singletonCounter;
```

### Versión Simplificada Basada en Objetos
Una versión más simple:
```javascript
let counter = 0;

export default Object.freeze({
  getCount: () => counter,
  increment: () => ++counter,
  decrement: () => --counter,
});
```

## Ventajas de los Singletons

1. **Eficiencia de Memoria**:  
   Solo se crea una instancia, ahorrando memoria en comparación con la creación de múltiples instancias.

2. **Acceso Global**:  
   Facilita el acceso a la misma instancia desde diferentes partes de la aplicación.

## Desventajas de los Singletons

1. **Innecesarios en Módulos ES2015**:  
   Los módulos de JavaScript ES2015 se comportan como Singletons por defecto. Crear Singletons explícitamente puede no ser necesario.

2. **Ocultación de Dependencias**:  
   Puede no ser evidente para los desarrolladores que un módulo depende de un Singleton. Esto puede conducir a modificaciones inesperadas que se propaguen globalmente.

3. **Contaminación del Ámbito Global**:  
   Similar a las variables globales, los Singletons pueden introducir complejidad en la gestión del estado compartido. A medida que la aplicación crece, rastrear las modificaciones se vuelve complicado.

4. **Dificultades en las Pruebas**:  
   - Los Singletons hacen difícil la realización de pruebas porque la misma instancia es compartida entre todas las pruebas.
   - Las modificaciones de prueba a la instancia pueden afectar a otras pruebas, causando fallos.
   - Es necesario reiniciar la instancia del Singleton después de cada ejecución de pruebas.

## Conclusión
Los Singletons son un patrón poderoso cuando se utilizan correctamente. Aseguran consistencia al compartir una instancia única en toda la aplicación. Sin embargo, pueden introducir complejidad, especialmente en las pruebas y en la gestión del estado global. Dado que los módulos ES2015 ya se comportan como Singletons, la creación explícita de Singletons es menos necesaria en JavaScript moderno. Úse con cuidado para evitar posibles inconvenientes como la contaminación del ámbito global y los desafíos en las pruebas.

