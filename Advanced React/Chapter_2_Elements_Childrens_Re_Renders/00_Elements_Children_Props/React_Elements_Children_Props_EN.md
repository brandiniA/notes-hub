# ✨ React — Elements, Children as Props, and Re-renders

> **Quick summary:**  
> Understanding how to pass children as props and the difference between elements and components helps optimize React app performance.

---

## 📚 Concept 1 — _The Scrollable Area Problem_

A common scenario:  
You have a large, slow app with a scrollable area and several expensive components rendered inside.

```jsx
const App = () => {
  return (
    <div className="scrollable-block">
      <VerySlowComponent />
      <BunchOfStuff />
      <OtherStuffAlsoComplicated />
    </div>
  );
};
```
*This is just a scrollable `div` with slow children inside.*

---

Suppose you need to implement a **MovingBlock** that animates based on scroll position.  
A basic solution is to add state and a scroll handler in the same component:

```jsx
const MainScrollableArea = () => {
  const [position, setPosition] = useState(300);
  const onScroll = (e) => {
    // calculate position based on the scrolled value
    const calculated = getPosition(e.target.scrollTop);
    setPosition(calculated);
  };
  return (
    <div className="scrollable-block" onScroll={onScroll}>
      {/* pass position value to the new movable component */}
      <MovingBlock position={position} />
      <VerySlowComponent />
      <BunchOfStuff />
      <OtherStuffAlsoComplicated />
    </div>
  );
};
```

- **Problem:**  
  Now every scroll triggers state updates and causes all nested components (including slow ones) to re-render.  
  This makes scrolling laggy—exactly what we want to avoid!

---

## 🛠️ Concept 2 — _Extracting State and Passing Content as Props_

A better approach:  
Extract the state and the logic into a separate component, and pass the slow content as a prop (`children` or `content`).

```jsx
const ScrollableWithMovingBlock = () => {
  const [position, setPosition] = useState(300);
  const onScroll = (e) => {
    const calculated = getPosition(e.target.scrollTop);
    setPosition(calculated);
  };
  return (
    <div className="scrollable-block" onScroll={onScroll}>
      <MovingBlock position={position} />
      {/* slow bunch of stuff used to be here, but not anymore */}
    </div>
  );
};
```

And in your main App:

```jsx
const App = () => {
  const slowComponents = (
    <>
      <VerySlowComponent />
      <BunchOfStuff />
      <OtherStuffAlsoComplicated />
    </>
  );
  return (
    <ScrollableWithMovingBlock content={slowComponents} />
  );
};
```
Or, using `children`:

```jsx
const ScrollableWithMovingBlock = ({ content }) => {
  const [scrollPosition, setScrollPosition] = useState(0);

  const onScroll = (e) => { /* ... */ }

  return (
    <div className="scrollable-block" onScroll={onScroll}>
      <MovingBlock position={scrollPosition} />
      {content}
    </div>
  );
};
```

---

- **Why does this help performance?**  
  Now, when the state in `ScrollableWithMovingBlock` updates, **only this component re-renders**.  
  The “slow” children are outside—passed as props—so React doesn't re-render them, keeping scrolling smooth and fast.

---

> [!TIP]  
> Passing expensive components as props lets you isolate re-renders and dramatically improve performance.

---

## 📖 Glossary

| 🗝️ English word   | 📝 Meaning / Context                |
|-------------------|-------------------------------------|
| _No new words for glossary in this section._            |

---
