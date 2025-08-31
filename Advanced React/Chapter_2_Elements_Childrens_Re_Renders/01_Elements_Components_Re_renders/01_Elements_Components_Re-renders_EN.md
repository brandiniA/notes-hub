# ✨ Elements, Components, and Re-renders

> **Quick summary:**  
> Understanding how React elements and components work—and when and why they re-render—is key to building efficient, maintainable React apps.

---

## 📚 Concept 1 — _What is a React Component?_

A **component** is just a function that returns elements (JSX). What makes it special is that React interprets what it returns and creates UI from it.

```jsx
// Minimal functional component
const Parent = () => {
  return <Child />;
};
```

<details>
<summary>🔍 **How does it work?**</summary>

- A component is a function that returns React **elements** (JSX or via `React.createElement`).
- If it receives **props**, they are just its first argument.
- The returned JSX is turned into objects that React later converts into real DOM elements.

</details>

---

## 🛠️ Concept 2 — _What is a React Element?_

A **React Element** is a plain object representing what should appear in the UI. It can represent a DOM tag or another component.

### Example 1: Returning a Component

```jsx
// Returns a Child component
const Parent = () => {
  return <Child />;
};
```

**Element Object:**

```js
{
  type: Child,
  props: {},
  // ...other internal React stuff
}
```

---

### Example 2: Returning a DOM Element

```jsx
// Returns an <h1> element
const Child = () => {
  return <h1>Child</h1>;
};
```

**Element Object:**

```js
{
  type: 'h1',
  props: { children: 'Child' },
  // ...other internal React stuff
}
```

---

**Quick Comparison Table**

| Example returns      | `type`        | `props`                 | Typical use      |
|---------------------|---------------|-------------------------|------------------|
| `<Child />`         | `Child`       | `{}`                    | Component        |
| `<h1>Child</h1>`    | `'h1'`        | `{ children: 'Child' }` | DOM Element      |

> [!TIP]  
> The only difference is the `type`: string for DOM elements, function for components. Everything else is just internal React handling.

---

## 🧠 Concept 3 — _How Re-renders Work (and When They Happen)_

Whenever a component’s state or props change, React calls its function again (re-render). It builds a **virtual tree** of all elements before and after, then compares ("diffs") them to decide what changes in the real DOM.

```jsx
const Parent = () => {
  const [state, setState] = React.useState(0);
  return <Child />;
};
```

React compares the *previous* and *next* element objects for each component:

- **If the object references are the same** (`Object.is` returns `true`):  
  React skips updating this component and its subtree.
- **If the references are different** (`Object.is` returns `false`):  
  React checks the `type` property:
  - **If `type` is the same**: React will update (re-render) the component, possibly updating props or children.
  - **If `type` is different**:  
    React will **remove** (unmount) the old component and **mount** the new one—losing any local state in the process.

**Decision table:**

| Comparison              | What React does                           |
|-------------------------|-------------------------------------------|
| Reference equal         | Skip (no update to DOM or subtree)        |
| Reference different     | → Check type:                             |
| &nbsp;&nbsp;Type equal  | Update/re-render component                |
| &nbsp;&nbsp;Type differs| Unmount old, mount new (replace subtree)  |

---

## 🔀 Passing Elements as Props (and Why it Matters)

If you pass an element as a **prop**—instead of creating it inline—it keeps the same object reference between renders, so React can skip unnecessary re-renders:

```jsx
const Parent = ({ child }) => {
  const [state, setState] = React.useState();
  return child;
};

// Usage:
<Parent child={<Child />} />
```

- Here, `<Child />` is created **outside** the Parent's render, so React sees it as "the same" object every time.

---

## 🚀 Full Example

```jsx
const SlowComponent = React.memo(() => {
  // Simulate expensive rendering
  return <div>Very slow...</div>;
});

const ParentInline = () => {
  const [count, setCount] = React.useState(0);
  return (
    <div>
      <button onClick={() => setCount((c) => c + 1)}>Inc</button>
      <Child />
      <SlowComponent />
    </div>
  );
};

const ParentWithProp = ({ child }) => {
  const [count, setCount] = React.useState(0);
  return (
    <div>
      <button onClick={() => setCount((c) => c + 1)}>Inc</button>
      {child}
      <SlowComponent />
    </div>
  );
};

// Usage with prop:
<ParentWithProp child={<Child />} />
```

**Visualization of what re-renders:**

| Scenario                      | Parent State Changes | Child Re-renders | SlowComponent Re-renders |
|-------------------------------|:-------------------:|:----------------:|:------------------------:|
| **Child created inline**      |         Yes         |       Yes        |         Yes\*            |
| **Child passed as prop**      |         Yes         |       No         |         Yes\*            |

> \* If `SlowComponent` is wrapped in `React.memo`, it will only re-render if its props change.

---

## 📖 Glossary

| 🗝️ English word     | 📝 Meaning / Context                          |
|---------------------|-----------------------------------------------|
| Element             | Object representing what React should render. |
| Component           | Function returning elements (UI pieces).      |
| JSX                 | Syntax sugar for `React.createElement`.       |
| Props               | Data passed to components as arguments.       |
| Fiber Tree          | React's internal representation of UI.        |
| Diffing             | Comparing trees to determine UI updates.      |
| Reconciliation      | Process of updating the real DOM efficiently. |
| Immutable           | Cannot be changed after creation.             |
| Reference           | The identity of an object in memory.          |

---

## ❓ Questions / Doubts

- When is it better to memoize a component or pass it as a prop for optimization?
- Does this behavior change in React 19+ or with new features like Server Components?