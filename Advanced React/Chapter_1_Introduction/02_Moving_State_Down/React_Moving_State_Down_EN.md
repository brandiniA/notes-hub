# ✨ React — Moving State Down

> **Quick summary:**  
> Moving state down in the component tree avoids unnecessary re-renders and keeps your app fast and predictable.

---

## 📚 Concept 1 — _Unnecessary re-renders from high-up state_

When state lives high in the component tree, **every state update causes all descendants to re-render**, even if most don't need the new value.  
This can seriously slow down your UI.

```jsx
const App = () => {
  // our state is declared here
  const [isOpen, setIsOpen] = useState(false);
  return (
    <div className="layout">
      {/* state is used here */}
      <Button onClick={() => setIsOpen(true)}>
        Open dialog
      </Button>
      {/* state is used here */}
      {isOpen ? (
        <ModalDialog onClose={() => setIsOpen(false)} />
      ) : null}
      <VerySlowComponent />
      <BunchOfStuff />
      <OtherStuffAlsoComplicated />
    </div>
  );
};
```

<details>
<summary>🔍 **How does it work?**</summary>

- State `isOpen` is only used for `<Button>` and `<ModalDialog>`.
- All other components re-render every time `isOpen` changes—**even if they don’t care about that state**.
- This leads to unnecessary re-renders.
</details>

---

## 🛠️ Concept 2 — _Extracting stateful logic into a smaller component_

A better way: **move the state down** into the smallest component that actually needs it.  
This isolates re-renders and keeps the rest of the app fast.

```jsx
const ButtonWithModalDialog = () => {
  const [isOpen, setIsOpen] = useState(false);
  // render only Button and ModalDialog here
  return (
    <>
      <Button onClick={() => setIsOpen(true)}>
        Open dialog
      </Button>
      {isOpen ? (
        <ModalDialog onClose={() => setIsOpen(false)} />
      ) : null}
    </>
  );
};
```

And in your main app:

```jsx
const App = () => {
  return (
    <div className="layout">
      {/* here it goes, component with the state inside */}
      <ButtonWithModalDialog />
      <VerySlowComponent />
      <BunchOfStuff />
      <OtherStuffAlsoComplicated />
    </div>
  );
};
```

---

### **Diagram — Before and After moving state down**

#### Before (State up, all children re-render):

```
        [State update]
          /          [Button/Modal]*   [Slow components]*
        /      [Other...]* [More...]*

* = unnecessary re-renders
```

#### After (State down, only relevant sub-tree re-renders):

```
        [App]
         /   |    [ButtonWithModalDialog]* [Slow components] [Other...]

  (State is here)
```
- Now only `ButtonWithModalDialog` and its children re-render when dialog state changes.
- “Slow components” and other parts of the app stay untouched.

---

> [!TIP]  
> Moving state closer to where it’s used is usually **better than relying on React.memo**. It’s simpler and has fewer caveats.

---

## 📖 Glossary

| 🗝️ English word   | 📝 Meaning / Context                |
|-------------------|-------------------------------------|
| _No new words for glossary in this section._            |

---
