# ✨ React — The Danger of Custom Hooks

> **Quick summary:**  
> Custom hooks help you reuse stateful logic, but hiding state inside them can lead to unexpected, hard-to-debug re-render issues.

---

## 📚 Concept 1 — _Custom hooks encapsulate state, but don’t eliminate it_

A custom hook may hide state, but the state still lives in the component using the hook.  
Every state update inside a custom hook **still triggers a re-render** of the component using it.

```jsx
const useModalDialog = () => {
  const [isOpen, setIsOpen] = useState(false);
  return {
    isOpen,
    open: () => setIsOpen(true),
    close: () => setIsOpen(false),
  };
};
```

<details>
<summary>🔍 **How does it work?**</summary>

- The state is abstracted away, but it's still there.
- Any update (like `open` or `close`) **will always cause the parent component to re-render**.
- This can make performance bottlenecks harder to spot.
</details>

---

## 🛠️ Concept 2 — _State updates inside hooks, even if not returned, can trigger full re-renders_

If your custom hook (or one it uses) manages state or side effects—even those **not returned**—the **parent component will re-render** every time that state changes.

```jsx
const useModalDialog = () => {
  const [width, setWidth] = useState(0);
  useEffect(() => {
    const listener = () => setWidth(window.innerWidth);
    window.addEventListener('resize', listener);
    return () => window.removeEventListener('resize', listener);
  }, []);
  // return is the same as before
  return ...;
};
```
- **Even if you don’t use `width` anywhere or return it, any update triggers a re-render.**

---

If you move that state to a deeper custom hook, **the effect is the same**:

```jsx
const useResizeDetector = () => {
  const [width, setWidth] = useState(0);
  useEffect(() => {
    const listener = () => setWidth(window.innerWidth);
    window.addEventListener('resize', listener);
    return () => window.removeEventListener('resize', listener);
  }, []);
  return null;
};

const useModalDialog = () => {
  // just call it, don't use its return value
  useResizeDetector();
  // same return as before
  return ...;
};
```

And then, in your App:

```jsx
// This hook uses useResizeDetector underneath that triggers state update on resize
// The entire App will re-render on every resize!
const { isOpen, open, close } = useModalDialog();
return ...; // same return
```

---

## 🚀 Solution — _Extract hooks and state into a subcomponent_

The fix: **move your stateful logic and custom hook calls down** into a small component that only re-renders when actually needed:

```jsx
const ButtonWithModalDialog = () => {
  const { isOpen, open, close } = useModalDialog();
  // render only Button and ModalDialog here
  return (
    <>
      <Button onClick={open}>Open dialog</Button>
      {isOpen ? <ModalDialog onClose={close} /> : null}
    </>
  );
};
```
- Now, **only** `ButtonWithModalDialog` re-renders on dialog or resize events, not your entire app.

---

> [!TIP]  
> **Any state update inside a hook (even deeply nested or unused) triggers a re-render of the parent component using the hook!**

---

## 📖 Glossary

| 🗝️ English word   | 📝 Meaning / Context                |
|-------------------|-------------------------------------|
| _No new words for glossary in this section._            |

---
