
# ✨ React — State Updates & Re-renders

> **Quick summary:**  
> Understanding how state updates trigger re-renders is key to writing efficient, interactive React applications.

---

## 📚 Concept 1 — _Component Lifecycle: Mount, Update, Unmount_

A React component can be:
- **Mounted:** Created for the first time and rendered on screen.
- **Updated (Re-rendered):** Refreshed with new data (usually after state/props change).
- **Unmounted:** Destroyed and removed from the DOM.

```jsx
function Example() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(count + 1)}>Click {count}</button>;
}
```

<details>
<summary>🔍 **How does it work?**</summary>

- On mount: `count` starts at 0.
- On click: `setCount` triggers a re-render.
- On unmount: React cleans up the component.
</details>

---

## 🛠️ Concept 2 — _How State Triggers Re-renders in the Component Tree_

Every state update in React causes the **owning component** and all its children to re-render—even those children that don’t use that piece of state.  
React **never re-renders up** the tree, only “down” from the update point.

### State update at the top (affects all children)

```
           [App]*  ← state changes here!
          /    |     \
   [Dialog]* [VerySlowComponent]* [OtherComponent]*
     /    \
 [Form]* [ExtraOptions]*
```
- **Every component below `[App]` is re-rendered (marked with `*`).**

---

```jsx
function App() {
  const [visible, setVisible] = useState(false);
  return (
    <div>
      <button onClick={() => setVisible((v) => !v)}>
        {visible ? "Hide" : "Show"} Dialog
      </button>
      {visible && <Dialog />}
      <VerySlowComponent />
      <OtherComponent />
    </div>
  );
}
```

- In this example, **updating `visible` in `App` causes _all_ children (`Dialog`, `VerySlowComponent`, `OtherComponent`) to re-render**—even if only `Dialog` actually uses that state.

---

### State update in a mid-level component (only its subtree updates)

```
           [App]
          /    |     \
   [Dialog]* [VerySlowComponent] [OtherComponent]
     /    \
 [Form]* [ExtraOptions]*
   ↑
state changes here!
```
- **Only `[Dialog]` and its children are re-rendered (marked with `*`).**
- Siblings and the parent are untouched.

---

> [!TIP]  
> **Only components below where the state changes re-render!** Components above are untouched.

---

## 📖 Glossary

| 🗝️ English word   | 📝 Meaning / Context                |
|-------------------|-------------------------------------|
| _No new words for glossary in this section._            |

---
