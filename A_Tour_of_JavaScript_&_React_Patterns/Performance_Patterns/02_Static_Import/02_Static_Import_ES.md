# Importación Estática

## Descripción
Un **módulo importado estáticamente** es un módulo que se importa utilizando la palabra clave `import`.

```javascript
import module1 from "./module1";
import module2 from "./module2";
import module3 from "./module3";
```

En este caso, `module1`, `module2` y `module3` se importan de forma estática.

Cuando un módulo se importa estáticamente, un **bundler** recorre todos los módulos y los incluye en un solo archivo.

---

## Ejemplo de Importación Estática

### **module1.js**
```javascript
export function module1() {
  return "Módulo 1";
}
```

### **module2.js**
```javascript
import { module1 } from "./module1";

export function module2() {
  return `Módulo 2, ${module1()}`;
}
```

### **module3.js**
```javascript
import { module2 } from "./module2";

export function module3() {
  return `Módulo 3, ${module2()}`;
}
```

### **index.js**
```javascript
import { module3 } from "./module3";

console.log(`Todos los módulos importados: ${module3()}`);
```

### **Salida del Bundle (bundle.js)**
```javascript
(() => {
  "use strict";
  function o() {
    return "Módulo 1";
  }
  function n() {
    return "Módulo 2, ".concat(o());
  }
  console.log(
    "Todos los módulos importados: ".concat(
      (function () {
        return "Módulo 3, ".concat(n());
      })()
    )
  );
})();
```

---

## Cómo Funciona el Bundling
Supongamos que tenemos cuatro archivos:

- **`module1.js`** exporta una única función `module1`.
- **`module2.js`** importa estáticamente `module1` y exporta `module2`.
- **`module3.js`** importa estáticamente `module2` y exporta `module3`.
- **`index.js`** importa estáticamente `module3` y registra el valor en la consola.

Cuando `index.js` se agrupa, el **bundler** recorre todas las dependencias y las combina en un solo archivo.

---

## Implementación con Componentes de React
Podemos importar de forma estática componentes de React desde otros archivos.

```javascript
import Header from "./Header";
import Content from "./Content";
import Footer from "./Footer";

export default function BlogPost({ post }) {
  return (
    <div>
      <Header title={post.title} />
      <Content body={post.body} />
      <Footer />
    </div>
  );
}
```

Aquí, `Header` y `Content` se **importan estáticamente**. Los módulos se ejecutan tan pronto como se importan.

Si abres la **consola del navegador**, puedes ver el orden en que se cargan los módulos.

---

## Ventajas y Desventajas
### **Ventajas**
- **Disponibilidad instantánea**: Los componentes importados estáticamente están inmediatamente disponibles para el usuario.
- **Optimización**: Los módulos importados estáticamente pueden analizarse y **tree-shaken** (eliminación automática de código no utilizado).

### **Desventajas**
- **Tamaño de bundle grande**: Importar todos los módulos de una vez puede incluir código innecesario, aumentando el tamaño del bundle.

