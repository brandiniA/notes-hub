# ✨ React — Elementos, children como props y re-renderizados

> **Resumen rápido:**  
> Entender cómo pasar children como props y la diferencia entre elementos y componentes ayuda a optimizar el rendimiento de las apps en React.

---

## 📚 Concepto 1 — _El problema del área con scroll_

Escenario común:  
Tienes una app grande y lenta con una zona con scroll y varios componentes costosos renderizados dentro.

```jsx
const App = () => {
  return (
    <div className="scrollable-block">
      <VerySlowComponent />
      <BunchOfStuff />
      <OtherStuffAlsoComplicated />
    </div>
  );
};
```
*Esto es solo un `div` con scroll y componentes lentos dentro.*

---

Supón que necesitas implementar un **MovingBlock** que se anime según la posición de scroll.  
La solución básica es agregar estado y un handler de scroll en el mismo componente:

```jsx
const MainScrollableArea = () => {
  const [position, setPosition] = useState(300);
  const onScroll = (e) => {
    // calcular posición según el scroll
    const calculated = getPosition(e.target.scrollTop);
    setPosition(calculated);
  };
  return (
    <div className="scrollable-block" onScroll={onScroll}>
      {/* pasar el valor de posición al nuevo bloque movable */}
      <MovingBlock position={position} />
      <VerySlowComponent />
      <BunchOfStuff />
      <OtherStuffAlsoComplicated />
    </div>
  );
};
```

- **Problema:**  
  Ahora cada scroll dispara un update de estado y provoca que todos los componentes hijos (incluyendo los lentos) se re-rendericen.  
  ¡Esto hace que el scroll sea lento, justo lo que queremos evitar!

---

## 🛠️ Concepto 2 — _Extraer estado y pasar contenido como prop_

Mejor enfoque:  
Extrae el estado y la lógica a un componente aparte, y pasa los componentes lentos como prop (`children` o `content`).

```jsx
const ScrollableWithMovingBlock = () => {
  const [position, setPosition] = useState(300);
  const onScroll = (e) => {
    const calculated = getPosition(e.target.scrollTop);
    setPosition(calculated);
  };
  return (
    <div className="scrollable-block" onScroll={onScroll}>
      <MovingBlock position={position} />
      {/* el bloque de componentes lentos solía estar aquí, pero ya no */}
    </div>
  );
};
```

Y en tu App principal:

```jsx
const App = () => {
  const slowComponents = (
    <>
      <VerySlowComponent />
      <BunchOfStuff />
      <OtherStuffAlsoComplicated />
    </>
  );
  return (
    <ScrollableWithMovingBlock content={slowComponents} />
  );
};
```
O usando `children`:

```jsx
const ScrollableWithMovingBlock = ({ content }) => {
  const [scrollPosition, setScrollPosition] = useState(0);

  const onScroll = (e) => { /* ... */ }

  return (
    <div className="scrollable-block" onScroll={onScroll}>
      <MovingBlock position={scrollPosition} />
      {content}
    </div>
  );
};
```

---

- **¿Por qué ayuda esto al rendimiento?**  
  Ahora, cuando el estado de `ScrollableWithMovingBlock` cambia, **solo este componente se re-renderiza**.  
  Los hijos “lentos” están afuera—pasados como props—y React no los vuelve a renderizar, así que el scroll se mantiene fluido.

---

> [!TIP]  
> Pasar componentes costosos como props te permite aislar los re-renderizados y mejorar drásticamente el rendimiento.

---

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto            |
|----------------------|--------------------------------------|
| _Sin palabras nuevas relevantes en esta sección._           |

---
