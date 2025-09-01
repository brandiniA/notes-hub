# ✨ Renderizado condicional y rendimiento

> **Resumen rápido:**  
> Una de las mayores preocupaciones con este patrón es el **rendimiento**. Paradójicamente, en el capítulo anterior lo vimos como una mejora de rendimiento. Entonces, ¿qué está pasando realmente?

---

## 📚 Concepto 1 — La preocupación inicial

El problema surge cuando usamos un componente que **acepta elementos como props** de manera condicional.  
Un ejemplo típico: mostrar un `ModalDialog` solo cuando `isDialogOpen` es `true`.

```jsx
import { useState } from "react"

const App = () => {
  const [isDialogOpen, setIsDialogOpen] = useState(false)

  const footer = <Footer />

  return isDialogOpen ? (
    <ModalDialog footer={footer} />
  ) : null
}
```

La duda es:  
- Declaramos `footer` **antes** de que el modal se muestre.  
- ¿Eso significa que `Footer` **siempre se renderiza**, aunque el diálogo esté cerrado?  
- ¿Hay implicaciones de rendimiento? ¿Está más lento el `App`?

---

## 🛠️ Concepto 2 — Lo que realmente ocurre

En React, cuando hacemos `const footer = <Footer />`, lo único que creamos es un **elemento**:  
un objeto ligero en memoria que describe qué queremos renderizar.  

Esto **no ejecuta la función `Footer` todavía**.  
El renderizado real sucede únicamente cuando el `ModalDialog` lo devuelve en su `return`.

```jsx
const ModalDialog = ({ children, footer }) => {
  return (
    <div className="dialog">
      <div className="content">{children}</div>
      {/* Esto solo se renderiza cuando ModalDialog se renderiza */}
      <div className="footer">{footer}</div>
    </div>
  )
}
```

<details>
<summary>🔍 <b>¿Cómo funciona?</b></summary>

- JSX crea **elementos (objetos)** → costo muy bajo.  
- **Renderizar** = ejecutar el componente y pintar UI.  
- Mientras `isDialogOpen` sea `false`, `Footer` nunca se ejecuta.  
- Por eso este patrón es seguro y no degrada el rendimiento.  

</details>

---

## 📚 Concepto 3 — Aplicación práctica: Rutas

Este mismo principio explica por qué patrones como `React Router` son seguros.  
Pareciera que declaramos varias páginas al mismo tiempo, pero en realidad solo son **objetos** hasta que una ruta coincide.

```jsx
const App = () => {
  return (
    <>
      <Route path="/some/path" element={<Page />} />
      <Route path="/other/path" element={<OtherPage />} />
    </>
  )
}

// Solo la ruta activa devolverá su elemento y se renderizará.
```

Aunque no haya condición explícita, **solo la ruta activa devolverá su elemento y se renderizará**.

---

## ✅ Buenas Prácticas

- ✅ No confundas “crear un elemento” con “renderizar un componente”.  
- ✅ Los elementos creados fuera de la condición son objetos livianos y seguros.  
- ✅ Si necesitas cálculos pesados para props, protégelos con condición o `useMemo`.  
- 🚫 Evita ejecutar lógica costosa dentro de JSX si el componente no se va a mostrar.  

---

## 🚀 Ejemplo Completo — Modal optimizado

```jsx
import { useMemo, useState } from "react"

const App = () => {
  const [isDialogOpen, setIsDialogOpen] = useState(false)
  const [items, setItems] = useState([1,2,3,4,5])

  // ✅ Cálculo solo si el modal está abierto
  const footer = useMemo(() => {
    if (!isDialogOpen) return null
    const total = expensiveSum(items)   // ← cálculo costoso
    return <Footer total={total} />
  }, [isDialogOpen, items])

  return (
    <>
      <button onClick={() => setIsDialogOpen(v => !v)}>
        {isDialogOpen ? "Cerrar" : "Abrir"} diálogo
      </button>

      {isDialogOpen ? (
        <ModalDialog footer={footer}>
          <p>Contenido del formulario…</p>
        </ModalDialog>
      ) : null}
    </>
  )
}
```

---

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto |
|----------------------|---------------------------|
| _No new words relevant in this section._ |
