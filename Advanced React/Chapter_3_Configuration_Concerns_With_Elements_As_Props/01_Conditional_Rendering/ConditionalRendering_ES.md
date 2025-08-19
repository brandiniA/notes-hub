# ✨ Renderizado condicional y rendimiento

> **Resumen rápido:**  
> Crear elementos en React no implica renderizarlos de inmediato. El renderizado solo ocurre cuando el elemento aparece en el `return` de un componente.

---

## ❗ Problema

Imagina que tenemos un componente que acepta elementos como props y lo renderizamos de manera condicional.  
Por ejemplo, `ModalDialog` que solo se muestra cuando `isDialogOpen` es `true`:

```jsx
const App = () => {
    const [isDialogOpen, setIsDialogOpen] = useState(false)

    const footer = <Footer />

    return isDialogOpen ? (
        <ModalDialog footer={footer} />
    ) : null
}
```

La pregunta clave es:  
- ¿El `Footer` se renderiza aunque el diálogo esté cerrado?  
- ¿Esto afecta el rendimiento de la app?  

Muchos desarrolladores, incluso con experiencia, suelen confundirse en este punto.

---

## 📚 Concepto 1 — Creación de elementos vs. Renderizado

Cuando declaramos:

```jsx
const footer = <Footer />
```

👉 Lo único que hacemos es **crear un objeto React Element**.  
No se ejecuta el ciclo de renderizado del componente `Footer`.  
El elemento queda en memoria como un objeto inerte y barato de crear.

El `Footer` **solo se renderizará** cuando el elemento aparezca dentro del `return` de algún componente.  
En nuestro ejemplo, cuando `ModalDialog` lo reciba como prop y lo incluya en su JSX:

```jsx
const ModalDialog = ({ children, footer }) => {
    return (
        <div className="dialog">
            <div className="content">{children}</div>
            {/* El footer solo se renderiza si ModalDialog se renderiza */}
            <div className="footer">{footer}</div>
        </div>
    )
}
```

---

## 🛠️ Concepto 2 — Impacto en el rendimiento

- Crear un **elemento** (`<Footer />`) es muy barato → solo es un objeto en memoria.  
- Renderizar un **componente** (`Footer`) sí implica trabajo → reconciliación, DOM virtual, actualizaciones.  
- React únicamente renderiza cuando el elemento llega al `return` de un componente activo.  

### Ejemplo claro: React Router

```jsx
const App = () => {
    return (
        <>
            <Route path="/some/path" element={<Page />} />
            <Route path="/other/path" element={<OtherPage />} />
        </>
    )
}
```

A primera vista parece que `App` está renderizando `Page` y `OtherPage` al mismo tiempo.  
Pero no es así:  
- `App` solo está creando objetos que describen qué se debería renderizar en cada ruta.  
- El renderizado real ocurre **únicamente** cuando la URL coincide con la ruta.  

> [!TIP]  
> No temas declarar elementos en memoria antes de tiempo: **lo costoso es renderizarlos, no crearlos**.

---

## ✅ Buenas Prácticas

- ✅ Distingue entre **crear un elemento** y **renderizar un componente**.  
- ✅ Usa renderizado condicional para evitar trabajo innecesario en pantalla.  
- ✅ Declara variables de elementos sin miedo: no generan overhead significativo.  
- 🚫 No confundas elementos (objetos en memoria) con componentes montados (renderizados).  

---

## 🚀 Ejemplo Completo

```jsx
const App = () => {
    const [isDialogOpen, setIsDialogOpen] = useState(false)
    const footer = <Footer />

    return (
        <>
            <button onClick={() => setIsDialogOpen(true)}>Abrir</button>
            {isDialogOpen ? <ModalDialog footer={footer} /> : null}
        </>
    )
}
```

### ¿Qué pasa internamente?
1. `footer = <Footer />` crea un objeto inofensivo en memoria.  
2. Mientras `isDialogOpen` sea `false`, el objeto nunca llega al DOM.  
3. Cuando `isDialogOpen` cambia a `true`, `ModalDialog` se renderiza y **recién ahí** React monta el `Footer`.  

---

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto            |
|----------------------|--------------------------------------|
| _Sin palabras nuevas relevantes en esta sección._           |
