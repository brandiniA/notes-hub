# ✨ Sharing Stateful Logic: Children as Render Props

> **Quick summary:**  
> The *children as render props* pattern lets a component share its internal state directly with children, avoiding messy prop/state duplication in consumers.

---

## 📚 Concept 1 — _Children as another form of render props_

Here we continue exploring **render props**, but in a different form: using `children` as the render function.

Normally, `children` are passed as elements:

```jsx
<Parent>
  <Child />
</Parent>

// Equivalent
<Parent children={<Child />} />
```

But nothing stops us from passing a **function as children**:

```jsx
<Parent children={() => <Child />} />
```

Inside the parent, we call it like any render prop:

```jsx
const Parent = ({ children }) => {
  return children()
}
```

---

## 🛠️ Concept 2 — _Why it’s useful_

This shines when a component needs to **share stateful logic** with its children.

Example: a `ResizeDetector` that tracks `window.innerWidth`.

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

To make it reusable, one approach is to expose a callback prop (`onWidthChange`).

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

Consumer side:

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

This works, but forces each consumer to duplicate state handling.

---

## 🚀 Concept 3 — _Children as render props_

Instead, `ResizeDetector` can accept **children as a function** and pass the width directly.

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

Consumer side:

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

## ⚠️ Note on performance

In practice, this would trigger **re-renders on every resize event**. To handle it:
- Debounce the resize listener.
- Or calculate layout logic inside `ResizeDetector`.

Still, the principle remains: children as render props provide a **clean, reusable way to share state**.

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| _No new words relevant in this section._ |
