# Patrón Observer en JavaScript

## Introducción
Este README contiene notas sobre el **Patrón Observer** en JavaScript. El Patrón Observer es un patrón de diseño donde un objeto observable mantiene una lista de suscriptores y los notifica cuando ocurre un evento. Esto es útil para la programación basada en eventos, análisis y la desacoplamiento de dependencias en una aplicación.

## Temas Cubiertos
- ¿Qué es el Patrón Observer?
- ¿Cómo funciona?
- Implementación en JavaScript
  - Creación de un objeto observable
  - Suscripción y cancelación de suscriptores
  - Notificación de suscriptores
  - Caso de uso real de desuscripción
- Ventajas y desventajas del Patrón Observer

## ¿Qué es el Patrón Observer?
El **Patrón Observer** consta de:
1. **Un objeto observable**: Mantiene una lista de suscriptores y puede notificarlos sobre cambios.
2. **Suscriptores (observadores)**: Funciones u objetos que se suscriben al observable y reciben notificaciones cuando ocurre un evento.

### ¿Por qué usar el Patrón Observer?
- Facilita la **programación basada en eventos**.
- Evita la **duplicación de código** centralizando la gestión de eventos.
- Ayuda a **desacoplar componentes**, haciendo el sistema más modular y mantenible.

## Implementación en JavaScript
Podemos implementar un observador como un **objeto singleton** que permite suscribirse, cancelar la suscripción y notificar a los suscriptores.

### Ejemplo: Creación de un Observable
```javascript
const observers = [];

export default Object.freeze({
  notify: (data) => observers.forEach((observer) => observer(data)),
  subscribe: (func) => observers.push(func),
  unsubscribe: (func) => {
    [...observers].forEach((observer, index) => {
      if (observer === func) {
        observers.splice(index, 1);
      }
    });
  },
});
```

### Suscribiendo y Notificando Suscriptores
Podemos usar este observable en toda la aplicación para gestionar suscripciones a eventos.

#### Suscribiendo una Función
```javascript
import Observable from "./observable";

function logger(data) {
  console.log(`${Date.now()} ${data}`);
}

Observable.subscribe(logger);
```

#### Notificando Suscriptores Basado en Eventos
```javascript
import Observable from "./observable";

document.getElementById("my-button").addEventListener("click", () => {
  Observable.notify("Clickeado!"); // Notifica a todos los suscriptores
});
```

### Caso de Uso Real de Desuscripción
A veces, queremos que un suscriptor se use una sola vez en base a una condición específica. Por ejemplo:
- Si ocurre o no ocurre cierto evento.
- Basado en eventos externos o después de un cierto tiempo.
- Si ocurre un tiempo de espera (timeout) o un error, queremos asegurarnos de que el suscriptor se elimine para evitar ejecuciones innecesarias.

Al manejar correctamente las desuscripciones, nos aseguramos de que los suscriptores solo reciban notificaciones relevantes y evitamos problemas de rendimiento.

### Ejemplo del Mundo Real
Supongamos que tenemos una aplicación donde múltiples suscriptores (por ejemplo, **seguimiento de análisis, Google Analytics, notificaciones por correo electrónico**) necesitan ser notificados cuando un usuario hace clic en un botón. En lugar de llamar a cada función por separado, los registramos como suscriptores y el observable maneja la propagación del evento de manera eficiente.

## Ventajas y Desventajas del Patrón Observer

### Ventajas
1. **Separación de Responsabilidades**:  
   - Los observadores **no están acoplados** directamente al objeto observable, lo que facilita modificarlos o reemplazarlos independientemente.
   - El objeto observable simplemente monitorea los eventos, mientras que los observadores manejan los datos recibidos según sea necesario.

### Desventajas
1. **Impacto en el Rendimiento**:  
   - Notificar a todos los suscriptores **puede tomar tiempo significativo** si los manejadores son muy complejos o hay demasiados suscriptores.
   - Si la lógica de notificación implica cálculos pesados, considere **ejecutarlos de forma asíncrona** para evitar bloqueos en la ejecución.

## Conclusión
El Patrón Observer es un patrón de diseño poderoso para gestionar interacciones basadas en eventos en JavaScript. Mediante el uso de un objeto observable, podemos **reducir la redundancia**, **mejorar la modularidad** y **separar las responsabilidades**. Sin embargo, es importante ser consciente de los **compromisos de rendimiento** al manejar un gran número de suscriptores.

