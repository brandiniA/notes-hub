# Importación Basada en Visibilidad

## Descripción
En lugar de cargar todos los componentes inmediatamente, podemos **importarlos dinámicamente** cuando se **vuelven visibles en el viewport**.

Anteriormente, vimos cómo importar dinámicamente componentes **basados en la interacción del usuario**. Sin embargo, también podemos importar componentes dinámicamente **según su visibilidad** en el viewport.

### **Ejemplo de Caso de Uso**
Si mostramos múltiples listados en una **pantalla pequeña**, no todos los listados son **visibles de inmediato** para el usuario.

- En lugar de cargar **todos los listados al mismo tiempo**, podemos **cargarlos de forma diferida**.
- Los componentes de listado **se cargan solo** cuando se vuelven visibles a medida que el usuario hace scroll.

---

## Implementación
Podemos **importar dinámicamente los componentes** utilizando la **API de Intersection Observer**.

En **React**, podemos usar el hook `react-intersection-observer` para detectar si un componente es visible.

### **Ejemplo: Carga Diferida de un Componente Basado en Visibilidad**

```javascript
import { Suspense, lazy } from "react";
import { useInView } from "react-intersection-observer";

const Listing = lazy(() => import("./components/Listing"));

function ListingCard(props) {
  const { ref, inView } = useInView();

  return (
    <div ref={ref}>
      <Suspense fallback={<div />}>
        {inView && <Listing />}
      </Suspense>
    </div>
  );
}
```

- **`useInView`** detecta cuándo el componente entra en el viewport.
- **`lazy()`** carga `Listing` **solo cuando es visible**.
- **`Suspense`** asegura que se muestre un componente de respaldo hasta que se complete la carga.

---

## Ventajas y Desventajas

### **Ventajas**
✅ **Carga Inicial Más Rápida** → Reduce el tamaño del bundle inicial, mejorando la velocidad de carga de la página.
✅ **Uso Optimizado del Ancho de Banda** → Solo descarga los componentes cuando son necesarios.

### **Desventajas**
❌ **Cambio de Diseño (Layout Shift)** → Si el componente de respaldo y el componente final tienen tamaños diferentes, la página puede experimentar un cambio inesperado en su diseño.

> **Mejor Práctica**: Asegurar que el componente de respaldo tenga una altura similar para evitar cambios en el diseño.

