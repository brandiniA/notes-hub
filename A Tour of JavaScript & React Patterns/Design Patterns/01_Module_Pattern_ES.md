
# Notas del Curso de Arquitectura con JavaScript

## Introducción
El objetivo del curso es explorar patrones modernos y mejores prácticas en JavaScript para escribir código limpio, mantenible y modular.

## Temas Cubiertos
- Patrón de "Módulo"
- "ES6 Modules" y sus ventajas
- Encapsulación en JavaScript
- Alcances privados y públicos en "modules"
- Uso de "modules" en HTML y Node.js
- Beneficios y compromisos de la programación modular

## Detalles del Curso
El primer capítulo se centra en comprender cómo estructurar el código JavaScript utilizando el Patrón de "Módulo" y los "ES6 Modules". Los puntos clave incluyen:
1. **Encapsulación**: Mantener valores privados dentro de "modules".
2. **Reutilización**: Definir funcionalidades en un solo lugar y usarlas en todo el proyecto.
3. **Evitar la contaminación del ámbito global**: Usar `type="module"` en HTML y Node.js.

## Notas Detalladas

### Patrón de "Módulo"
- El **Patrón de Módulo** permite dividir el código en piezas más pequeñas y reutilizables.
- La encapsulación se logra manteniendo valores privados a menos que se exporten explícitamente.

### "ES6 Modules"
- Con los "ES6 Modules", puedes:
  - Exportar valores o funciones específicas para hacerlas públicas.
  - Importar solo las funcionalidades necesarias en otros archivos.
- Ejemplo:
  ```javascript
  // math.js
  export function add(a, b) {
      return a + b;
  }

  // index.js
  import { add } from './math.js';
  console.log(add(5, 3)); // Salida: 8
  ```

### Uso de "Modules" en HTML
- HTML soporta "ES6 Modules" al agregar `type="module"` en la etiqueta `<script>`:
  ```html
  <script src="math.js" type="module"></script>
  ```
- Esto encapsula todos los valores dentro del "module", asegurando que los valores privados no sean accesibles globalmente.

### Uso de "Modules" en Node.js
- Hay dos formas de habilitar "modules" en Node.js:
  1. Usar la extensión `.mjs` para los archivos de "module".
  2. Agregar `"type": "module"` en el archivo `package.json`.

### Beneficios y Compromisos de los "Modules"
- **Ventajas**:
  - Encapsulación de valores privados.
  - Código más limpio y reutilizable.
  - Mejor mantenibilidad.
- **Posibles inconvenientes**:
  - Curva de aprendizaje inicial.
  - La gestión de dependencias puede volverse compleja.
  - Consideraciones de rendimiento si se importan muchos "modules".

## Ejemplos Prácticos

### Ejemplo de Encapsulación
```javascript
// myModule.js
const privateValue = "Esto es privado";
export const publicValue = "Esto es público";

export function publicFunction() {
    return privateValue + " y " + publicValue;
}
```

### Ejemplo en Node.js con `"type": "module"`
```javascript
// math.js
export function add(a, b) {
    return a + b;
}

// index.js
import { add } from './math.js';
console.log(add(2, 3)); // Salida: 5
```

## Conclusión
Los "modules" son una herramienta poderosa en JavaScript para organizar el código, mejorar su mantenibilidad y reducir errores. Al aprovechar el Patrón de "Módulo" y los "ES6 Modules", podemos crear aplicaciones escalables y eficientes.
