# Importación Dinámica

## Descripción
La **importación dinámica** de código permite **cargar componentes bajo demanda**, en lugar de incluirlos todos en el bundle inicial.

### **Problema con las Importaciones Estáticas**
- Los módulos importados estáticamente están **incluidos en el bundle final**, aunque no sean necesarios de inmediato.
- Esto puede provocar **bundles más grandes**, lo que reduce la velocidad de carga inicial.

### **Solución**
- Importar dinámicamente los módulos **solo cuando se necesiten**, lo que reduce el tamaño del bundle inicial.

### **Caso de Uso**
Imaginemos un componente de **entrada de búsqueda** (`SearchInput`). Cuando un usuario hace clic, se muestra un componente `SearchPopup` con ubicaciones populares.

- `SearchPopup` **no es visible inmediatamente**, por lo que no debería cargarse con el bundle inicial.
- Con la importación dinámica, `SearchPopup` **se carga solo cuando se requiere**, optimizando el rendimiento.

---

## Implementación
En **React**, se logra la importación dinámica con `React.Suspense` y `React.lazy`.

- `Suspense` muestra un **componente de fallback** mientras se carga el módulo.
- `lazy()` carga el componente **solo cuando sea necesario**.

### **Ejemplo**

En este caso:
- `Card1` y `Card2` se **importan estáticamente**.
- `Card3` y `Card4` se **cargan dinámicamente** tras la interacción del usuario.

```javascript
import React, { Suspense, lazy } from 'react';
import './styles.css';

import { Card } from './components/Card';
import Card1 from './components/Card1';
import Card2 from './components/Card2';
const Card3 = lazy(() =>
  import(/* webpackChunkName: "card3" */ './components/Card3')
);
const Card4 = lazy(() =>
  import(/* webpackChunkName: "card4" */ './components/Card4')
);

const App = () => {
  return (
    <div className="App">
      <Card1 />
      <Card2 />
      <DynamicCard component={Card3} name="Card3" />
      <DynamicCard component={Card4} name="Card4" />
    </div>
  );
};

function DynamicCard(props) {
  const [open, toggle] = React.useReducer((s) => !s, false);
  const Component = props.component;

  return (
    <Suspense fallback={<p id="loading">Cargando...</p>}>
      {open ? (
        <Component />
      ) : (
        <Card rendered={false} onClick={toggle}>
          <p>
            Haz clic aquí para importar dinámicamente el componente
            <code>{props.name}</code>
          </p>
        </Card>
      )}
    </Suspense>
  );
}

export default App;
```

---

### **Optimización con Webpack**

```javascript
import(/* webpackChunkName: "card3" */ './components/Card3');
```

> **`webpackChunkName`**: Este es un **comentario mágico** que asigna un nombre legible al bundle (`card3.bundle.js`), en lugar de nombres genéricos como `0.bundle.js` o `1.bundle.js`. Esto facilita la depuración en la **pestaña de red**.

---

## Ventajas y Desventajas

### **Ventajas**
✅ **Carga inicial más rápida** → Reduce el tamaño del bundle inicial, descargando solo lo necesario.
✅ **Mejora el rendimiento** → Menos consumo de ancho de banda.

### **Desventajas**
❌ **Cambio en el diseño** → Si el componente de fallback tiene un tamaño diferente, puede causar saltos en la interfaz.
❌ **Experiencia del usuario** → Cargar un componente **necesario de inmediato** de forma diferida puede ralentizar la renderización.

> **Mejor práctica**: **Solo carga de forma diferida los componentes que no son visibles en la renderización inicial**.

