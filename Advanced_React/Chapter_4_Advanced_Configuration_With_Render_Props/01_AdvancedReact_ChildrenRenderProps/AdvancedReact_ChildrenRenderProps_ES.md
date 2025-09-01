# ✨ Compartiendo lógica con estado: Children como Render Props

> **Resumen rápido:**  
> El patrón *children como render props* permite que un componente comparta su estado interno directamente con los hijos, evitando la duplicación de props/estado en los consumidores.

---

## 📚 Concepto 1 — _Children como otra forma de render props_

Aquí continuamos explorando **render props**, pero en una forma distinta: usando `children` como función de renderizado.

Normalmente, `children` se pasan como elementos:

```jsx
<Parent>
  <Child />
</Parent>

// Equivalente
<Parent children={<Child />} />
```

Pero nada nos impide pasar una **función como children**:

```jsx
<Parent children={() => <Child />} />
```

Dentro del padre, la llamamos como cualquier render prop:

```jsx
const Parent = ({ children }) => {
  return children()
}
```

---

## 🛠️ Concepto 2 — _Por qué es útil_

Esto es muy útil cuando un componente necesita **compartir lógica con estado** con sus hijos.

Ejemplo: un `ResizeDetector` que rastrea `window.innerWidth`.

```jsx
const ResizeDetector = () => {
  const [width, setWidth] = useState()

  useEffect(() => {
    const listener = () => setWidth(window.innerWidth)
    window.addEventListener('resize', listener)
  }, [])

  return ...
}
```

Para hacerlo reutilizable, una opción es exponer un callback prop (`onWidthChange`).

```jsx
const ResizeDetector = ({ onWidthChange }) => {
  const [width, setWidth] = useState()

  useEffect(() => {
    const listener = () => {
      const w = window.innerWidth
      setWidth(w)
      onWidthChange(w)
    }
    window.addEventListener('resize', listener)
  }, [])

  return ...
}
```

Consumidor:

```jsx
const Layout = () => {
  const [windowWidth, setWindowWidth] = useState(0)

  return (
    <>
      <ResizeDetector onWidthChange={setWindowWidth} />
      {windowWidth > 600 ? <WideLayout /> : <NarrowLayout />}
    </>
  )
}
```

Esto funciona, pero obliga a cada consumidor a duplicar la gestión de estado.

---

## 🚀 Concepto 3 — _Children como render props_

En su lugar, `ResizeDetector` puede aceptar **children como función** y pasar el ancho directamente.

```jsx
const ResizeDetector = ({ children }) => {
  const [width, setWidth] = useState()

  useEffect(() => {
    const listener = () => setWidth(window.innerWidth)
    window.addEventListener('resize', listener)
  }, [])

  return children(width)
}
```

Consumidor:

```jsx
const Layout = () => {
  return (
    <ResizeDetector>
      {(windowWidth) =>
        windowWidth > 600 ? <WideLayout /> : <NarrowLayout />
      }
    </ResizeDetector>
  )
}
```

---

## ⚠️ Nota sobre rendimiento

En la práctica, esto provocaría **re-renders en cada evento de resize**. Para manejarlo:
- Aplica un debounce al listener de resize.
- O calcula la lógica del layout dentro de `ResizeDetector`.

El principio se mantiene: *children como render props* ofrece una forma **limpia y reutilizable de compartir estado**.

---

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto |
|----------------------|---------------------------|
| _No hay palabras nuevas relevantes en esta sección._ |
