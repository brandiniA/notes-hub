# ✨ Hooks Replaced Render Props

> **Quick summary:**  
> Hooks replaced most use cases for render props by offering a cleaner, simpler way to share stateful logic.

---

## 📚 Concept 1 — _From render props to hooks_

React developers quickly noticed that many render prop patterns became unnecessary after hooks were introduced.

Instead of building a `ResizeDetector` component with render props, we can simply extract that logic into a hook:

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

And consume it directly:

```jsx
const Layout = () => {
  const windowWidth = useResizeDetector()
  return windowWidth > 600 ? <WideLayout /> : <NarrowLayout />
}
```

This means: less code, and much easier to understand.

---

## 🛠️ Concept 2 — _When render props are still useful_

- ✅ **Configuration & flexibility:** As shown earlier, render props shine when parent components pass configuration/state explicitly to children.
- ✅ **Legacy codebases:** Pre-hooks projects often use render props heavily, especially for form validation. Many libraries still rely on this pattern.
- ✅ **DOM-dependent logic:** Some scenarios are trickier with hooks, like when logic depends on attaching listeners to DOM nodes.

Example: scroll tracking inside a `div`.

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
      {(scroll) => scroll > 30 ? <SomeBlock /> : null}
    </ScrollDetector>
  )
}
```

Here, render props simplify passing the scroll value directly to children without external refs or complex hooks.

---

## ⚠️ Important note on performance

While hooks are powerful, they may also introduce **extra re-renders**:
- Every state change inside a custom hook like `useResizeDetector` can re-render the whole component using it.
- With render props, only the subtree inside the render function gets updated.

For example, imagine this Layout:

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

Every resize update will also trigger a re-render of `<ExpensiveChart />`, even though it doesn’t depend on `windowWidth`.

With a render prop approach, only the parts inside the render function would be affected.

> ⚠️ **Warning:** Be mindful when using hooks like `useResizeDetector` in large layouts. Too many updates can impact performance.

---

### 🧪 Illustrative example — costly sibling re-renders

Using a hook inside `Layout` means **any** width change re-renders the entire `Layout` subtree:

```jsx
const ExpensiveReport = () => {
  // imagine heavy calculations, charts, etc.
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

Here, `ExpensiveReport` re-renders on **every** resize update because `Layout` re-renders.

With **render props**, we can isolate updates to just the part that depends on the width:

```jsx
const Layout = () => {
  return (
    <>
      <ResizeDetector>
        {(width) => (width > 600 ? <WideLayout /> : <NarrowLayout />)}
      </ResizeDetector>
      <ExpensiveReport /> {/* stays out of the reactive subtree */}
    </>
  )
}
```

> [!TIP]
> If you must keep everything in the same subtree, consider `React.memo(ExpensiveReport)`, splitting components, or batching/debouncing updates to reduce re-render cost.

---

### 🧭 Alternative while keeping the hook — encapsulate the responsive part

If you prefer to **keep the hook**, encapsulate only the responsive section in its **own component**. That way, only that component re-renders, and expensive siblings remain untouched.

```jsx
const ResponsiveSection = React.memo(function ResponsiveSection() {
  const width = useResizeDetector()
  return width > 600 ? <WideLayout /> : <NarrowLayout />
})

const Layout = () => {
  return (
    <>
      <ResponsiveSection />
      <ExpensiveReport /> {/* no re-render on width changes */}
    </>
  )
}
```

Notes:
- `React.memo` avoids re-rendering `ResponsiveSection` unless its **own state/props** change (the hook is internal here, so it will re-render, but siblings won’t).
- You can still debounce/throttle inside `useResizeDetector` to reduce frequency of updates.
- This pattern mirrors the isolation you get with render props, while keeping hooks ergonomics.

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| _No new words relevant in this section._ |
