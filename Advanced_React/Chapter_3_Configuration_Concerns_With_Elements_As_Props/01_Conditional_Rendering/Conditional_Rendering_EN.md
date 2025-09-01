# ✨ Conditional Rendering and Performance

> **Quick summary:**  
> A React element (the result of `<Component />`) is just a lightweight **object**; it does **not** render until some component **returns** it. Declaring it outside a condition does not imply DOM work.

---

## 📚 Concept 1 — The initial concern

The concern appears when we use a component that **accepts elements as props** under a condition.  
A common example: show a `ModalDialog` only when `isDialogOpen` is `true`.

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

The questions:  
- We declare `footer` **before** the modal is shown.  
- Does this mean `Footer` **always renders**, even when the dialog is closed?  
- Are there performance implications? Does `App` slow down?

---

## 🛠️ Concept 2 — What actually happens

In React, `const footer = <Footer />` creates a **React element** — a lightweight object in memory that describes what we want to render.  

This **does not execute** the `Footer` function yet.  
The actual rendering happens only when `ModalDialog` returns it in its `return`.

```jsx
const ModalDialog = ({ children, footer }) => {
  return (
    <div className="dialog">
      <div className="content">{children}</div>
      {/* This is rendered *only* when ModalDialog renders */}
      <div className="footer">{footer}</div>
    </div>
  )
}
```

<details>
<summary>🔍 <b>How does it work?</b></summary>

- JSX creates **elements (objects)** → very cheap.  
- **Rendering** = running the component function and producing UI.  
- While `isDialogOpen` is `false`, `Footer` never runs.  
- That’s why this pattern is safe and does not degrade performance.  

</details>

---

## 📚 Concept 3 — Practical application: Routes

This same principle explains why patterns like `React Router` are safe.  
It looks like we declare multiple pages at once, but those are just **objects** until one route matches.

```jsx
const App = () => {
  return (
    <>
      <Route path="/some/path" element={<Page />} />
      <Route path="/other/path" element={<OtherPage />} />
    </>
  )
}

// Only the active route returns its element and renders.
```

Even without an explicit condition, **only the matching route returns its element and renders**.

---

## ✅ Best Practices

- ✅ Don’t confuse “creating an element” with “rendering a component”.  
- ✅ Elements created outside the condition are lightweight and safe.  
- ✅ If you need heavy computations for props, guard them with a condition or `useMemo`.  
- 🚫 Avoid running expensive logic inside JSX if the component will not be shown.  

---

## 🚀 Full Example — Optimized modal

```jsx
import { useMemo, useState } from "react"

const App = () => {
  const [isDialogOpen, setIsDialogOpen] = useState(false)
  const [items, setItems] = useState([1,2,3,4,5])

  // ✅ Compute only when the modal is open
  const footer = useMemo(() => {
    if (!isDialogOpen) return null
    const total = expensiveSum(items)   // ← heavy computation
    return <Footer total={total} />
  }, [isDialogOpen, items])

  return (
    <>
      <button onClick={() => setIsDialogOpen(v => !v)}>
        {isDialogOpen ? "Close" : "Open"} dialog
      </button>

      {isDialogOpen ? (
        <ModalDialog footer={footer}>
          <p>Form content…</p>
        </ModalDialog>
      ) : null}
    </>
  )
}
```

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| _No new words relevant in this section._ |
