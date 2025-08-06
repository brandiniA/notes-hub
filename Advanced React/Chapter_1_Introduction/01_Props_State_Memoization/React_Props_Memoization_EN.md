# ✨ React — Props, State, and Memoization

> **Quick summary:**  
> Understanding the real relationship between props, state, and memoization in React prevents subtle bugs and unnecessary re-renders.

---

## 📚 Concept 1 — _State updates trigger re-renders, not prop changes alone_

A common misconception: “Components re-render when their props change.”  
**Reality:** React only re-renders a component if its parent re-renders—regardless of whether the props actually change.

```jsx
const App = () => {
  // local variable won't work!
  let isOpen = false;
  return (
    <div>
      {/* nothing will happen */}
      <Button onClick={() => (isOpen = true)}>
        Open dialog
      </Button>
      {/* will never show up */}
      {isOpen ? (
        <ModalDialog onClose={() => (isOpen = false)} />
      ) : null}
    </div>
  );
};
```

<details>
<summary>🔍 **How does it work?**</summary>

- Updating `isOpen` **without React state** doesn't trigger a re-render.
- The UI never updates, so the dialog never appears.
- React only updates the UI in response to state changes or re-renders from above.
</details>

---

## 🛠️ Concept 2 — _When does React check if props have changed?_

Props changes **only matter** for re-rendering if the component is wrapped in `React.memo`.  
Normally, when state changes **high in the tree**, React re-renders all children—even those with the same props.

### Diagram — Memo prevents unnecessary re-renders

```
         [State update]
            /          [React.memo]     [ComponentB]*
      /       [ChildA]   [ChildB]
```

- **Red arrows/components:** re-rendered due to state change.
- **Black (React.memo):** not re-rendered (no prop changes detected).
- Even if state updates at the top, `React.memo` stops re-render if props are unchanged.

> [!TIP]  
> Memoization (`React.memo`) is useful but only prevents re-rendering if the **props stay the same**. If any prop changes, re-renders will continue as usual.

---

### Diagram explanation

A state update at a high level would normally re-render **all descendants**.  
But if a child component is wrapped with `React.memo`, React checks if its props have changed:
- **No prop changes:** The component is not re-rendered.
- **Any prop changes:** Re-render proceeds as normal.

---

Preventing re-renders with memoization is a **complex topic** with several caveats and edge cases.

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context                        |
|-----------------|---------------------------------------------|
| Caveat          | A warning about a particular limitation or quirk. |

---
