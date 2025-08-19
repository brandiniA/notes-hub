# ✨ Conditional Rendering and Performance

> **Quick summary:**  
> Creating React elements does not render components. Rendering happens only when the element appears in a component’s `return`.

---

## ❗ Problem

Consider a component that accepts elements as props and is rendered conditionally.  
For example, a `ModalDialog` that is shown only when `isDialogOpen` is `true`:

```jsx
const App = () => {
    const [isDialogOpen, setIsDialogOpen] = useState(false)

    const footer = <Footer />

    return isDialogOpen ? (
        <ModalDialog footer={footer} />
    ) : null
}
```

Key questions:  
- Is `Footer` rendered while the dialog is closed?  
- Does this hurt performance?  

Even experienced developers sometimes mix up these concepts.

---

## 📚 Concept 1 — Element Creation vs. Rendering

When we write:

```jsx
const footer = <Footer />
```

👉 We only **create a React Element object**.  
The `Footer` component does **not** render yet. This element is just an inert, cheap-to-create object in memory.

`Footer` is rendered **only when** the element appears inside the `return` of some component.  
In our example, when `ModalDialog` receives it and includes it in its JSX:

```jsx
const ModalDialog = ({ children, footer }) => {
    return (
        <div className="dialog">
            <div className="content">{children}</div>
            {/* The footer renders only if ModalDialog renders */}
            <div className="footer">{footer}</div>
        </div>
    )
}
```

---

## 🛠️ Concept 2 — Performance Impact

- Creating an **element** (`<Footer />`) is cheap → it’s just an object in memory.  
- Rendering a **component** (`Footer`) does real work → reconciliation, virtual DOM, updates.  
- React renders only when the element reaches the `return` of an active component.

### Clear example: React Router

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

At first glance it looks like `App` is rendering `Page` and `OtherPage` simultaneously.  
But it’s not:  
- `App` only creates objects describing what to render for each route.  
- Actual rendering happens **only** when the URL matches a route.

> [!TIP]  
> Don’t worry about creating elements early: **rendering is the expensive step, not element creation**.

---

## ✅ Best Practices

- ✅ Distinguish between **creating an element** and **rendering a component**.  
- ✅ Use conditional rendering to avoid unnecessary work on screen.  
- ✅ Storing elements in variables is fine; they don’t add meaningful overhead.  
- 🚫 Don’t confuse elements (plain objects) with mounted components (rendered).  

---

## 🚀 Full Example

```jsx
const App = () => {
    const [isDialogOpen, setIsDialogOpen] = useState(false)
    const footer = <Footer />

    return (
        <>
            <button onClick={() => setIsDialogOpen(true)}>Open</button>
            {isDialogOpen ? <ModalDialog footer={footer} /> : null}
        </>
    )
}
```

### What happens internally?
1. `footer = <Footer />` creates a harmless object in memory.  
2. While `isDialogOpen` is `false`, the object never reaches the DOM.  
3. When `isDialogOpen` becomes `true`, `ModalDialog` renders and **only then** React mounts `Footer`.  

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| _No new words relevant in this section._ |
