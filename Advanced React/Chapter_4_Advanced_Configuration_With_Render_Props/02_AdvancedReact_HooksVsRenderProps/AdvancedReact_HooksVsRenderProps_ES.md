# ✨ Los Hooks reemplazaron Render Props

> **Resumen rápido:**  
> Los hooks reemplazaron la mayoría de los casos de uso de render props al ofrecer una forma más limpia y simple de compartir lógica con estado.

---

## 📚 Concepto 1 — _De render props a hooks_

Tras la llegada de los hooks, muchos patrones de render props dejaron de ser necesarios.

En lugar de construir un `ResizeDetector` con render props, podemos extraer la lógica a un hook:

```jsx
const useResizeDetector = () => {
  const [width, setWidth] = useState()

  useEffect(() => {
    const listener = () => setWidth(window.innerWidth)
    window.addEventListener('resize', listener)
  }, [])

  return width
}
```

Y consumirlo directamente:

```jsx
const Layout = () => {
  const windowWidth = useResizeDetector()
  return windowWidth > 600 ? <WideLayout /> : <NarrowLayout />
}
```

Resultado: menos código y mayor claridad.

---

## 🛠️ Concepto 2 — _Cuándo siguen siendo útiles las render props_

- ✅ **Configuración y flexibilidad:** Brillan cuando el padre pasa configuración/estado explícito a los hijos.
- ✅ **Codebases legacy:** Proyectos previos a hooks las usan mucho (validación de formularios). Varias librerías aún las emplean.
- ✅ **Lógica dependiente del DOM:** Algunos casos son más complicados con hooks, por ejemplo, cuando debes adjuntar listeners a nodos del DOM.

Ejemplo: seguimiento de scroll en un `div`.

```jsx
const ScrollDetector = ({ children }) => {
  const [scroll, setScroll] = useState()

  return (
    <div onScroll={(e) => setScroll(e.currentTarget.scrollTop)}>
      {children(scroll)}
    </div>
  )
}

const Layout = () => {
  return (
    <ScrollDetector>
      {(scroll) => (scroll > 30 ? <SomeBlock /> : null)}
    </ScrollDetector>
  )
}
```

Aquí, las render props simplifican pasar el valor de scroll directamente a los hijos sin refs externos ni hooks complejos.

---

## ⚠️ Nota importante sobre rendimiento

Aunque los hooks son poderosos, pueden introducir **re-renderizados extra**:
- Cada cambio de estado en un hook personalizado (como `useResizeDetector`) puede re-renderizar todo el componente que lo usa.
- Con render props, solo se actualiza el **subárbol** dentro de la función de render.

Por ejemplo:

```jsx
const Layout = () => {
  const windowWidth = useResizeDetector()
  return (
    <>
      {windowWidth > 600 ? <WideLayout /> : <NarrowLayout />}
      <ExpensiveChart />
    </>
  )
}
```

Cada actualización por resize también re-renderizará `<ExpensiveChart />`, aunque no dependa de `windowWidth`.

Con render props, solo lo que está dentro de la función de render se vería afectado.

> ⚠️ **Advertencia:** Úsalo con cuidado en layouts grandes; demasiadas actualizaciones pueden impactar el rendimiento.

---

### 🧪 Ejemplo ilustrativo — re-render de hermanos costosos

Usar un hook dentro de `Layout` implica que **cualquier** cambio de ancho re-renderiza todo el subárbol del layout:

```jsx
const ExpensiveReport = () => {
  // cálculos pesados, tablas y gráficas, etc.
  return <ChartsAndTables />
}

const Layout = () => {
  const windowWidth = useResizeDetector()

  return (
    <>
      {windowWidth > 600 ? <WideLayout /> : <NarrowLayout />}
      <ExpensiveReport />
    </>
  )
}
```

Aquí, `ExpensiveReport` se re-renderiza en **cada** actualización del ancho porque `Layout` se re-renderiza.

Con **render props**, aislamos las actualizaciones solo a la parte que depende del ancho:

```jsx
const Layout = () => {
  return (
    <>
      <ResizeDetector>
        {(width) => (width > 600 ? <WideLayout /> : <NarrowLayout />)}
      </ResizeDetector>
      <ExpensiveReport /> {/* fuera del subárbol reactivo */}
    </>
  )
}
```

> [!TIP]
> Si todo debe vivir en el mismo subárbol, considera `React.memo(ExpensiveReport)`, dividir componentes, o aplicar debounce/throttle para reducir el costo.

---

### 🧭 Alternativa manteniendo el hook — encapsular la parte responsive

Si prefieres **mantener el hook**, encapsula solo la sección responsive en su **propio componente**. Así, solo ese componente se re-renderiza y los hermanos costosos quedan intactos.

```jsx
const ResponsiveSection = React.memo(function ResponsiveSection() {
  const width = useResizeDetector()
  return width > 600 ? <WideLayout /> : <NarrowLayout />
})

const Layout = () => {
  return (
    <>
      <ResponsiveSection />
      <ExpensiveReport /> {/* sin re-render por cambios de ancho */}
    </>
  )
}
```

Notas:
- `React.memo` evita re-render si no cambian su **estado/props** (el hook vive dentro, así que se re-renderiza, pero **no** los hermanos).
- Aún puedes aplicar debounce/throttle dentro de `useResizeDetector` para reducir la frecuencia de updates.
- Este patrón **refleja el aislamiento** logrado con render props, manteniendo la ergonomía de hooks.

---

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto |
|----------------------|---------------------------|
| _No hay palabras nuevas relevantes en esta sección._ |
