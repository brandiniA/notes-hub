# ✨ Children as Props

> **Quick summary:**  
> Using `children` as a prop is a powerful and idiomatic way to compose React components, making your code more flexible and readable.

---

## 📚 Concept 1 — _What does "children as props" mean?_

In React, props are just an object passed as the first argument to a component. The `children` prop is not special—it's just a convention.  
You can name it anything, but `children` unlocks JSX's built-in composition syntax.

```jsx
// Before: Using a custom 'child' prop
const Parent = ({ child }) => {
  return child;
};

// After: Using 'children' prop (standard)
const Parent = ({ children }) => {
  return children;
};
```

<details>
<summary>🔍 **How does it work?**</summary>

- Any prop, including `children`, is just a key on the props object.
- JSX recognizes `children` and enables nesting:  
  `<Parent><Child /></Parent>` is equivalent to `<Parent children={<Child />} />`
- Switching to `children` makes composition natural and familiar.

</details>

---

## 🛠️ Concept 2 — _Explicit vs. JSX children_

You can pass children explicitly or use JSX nesting—both result in the same object structure.

```jsx
// Passing as a prop explicitly
<Parent children={<Child />} />

// Using JSX nesting (more common)
<Parent>
  <Child />
</Parent>
```

**Both produce:**

```js
{
  type: Parent,
  props: {
    children: {
      type: Child,
      // ...other internal React stuff
    }
  }
}
```

> [!TIP]  
> JSX nesting is just syntactic sugar for setting the `children` prop directly.

---

## ⚡ Quick Comparison

| Syntax                                   | How you write it           | How React sees it                   |
|-------------------------------------------|----------------------------|-------------------------------------|
| Custom prop                              | `<Parent child={<Child/>} />`   | `{ props: { child: ... } }`     |
| Explicit `children` prop                 | `<Parent children={<Child/>}/>` | `{ props: { children: ... } }`  |
| JSX nested children                      | `<Parent><Child/></Parent>`     | `{ props: { children: ... } }`  |

---

## 🧠 Concept 3 — _Why use children? (composition & performance)_

Using `children` makes component composition natural and visually clear, similar to HTML.

- It improves readability and structure.
- When you pass elements as props (including `children`), they retain their object reference. This means that re-renders in the parent will **not** trigger re-renders of the child, unless the actual element object changes.
- This enables patterns like layout wrappers, slots, and render props.

---

## 🚀 Real Example: Migrating from `content` to `children`

Suppose you had this pattern:

```jsx
// Old version: content as a prop
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

// ...inside the component
const ScrollableWithMovingBlock = ({ content }) => {
  // ...rest of the code
  return (
    <div>
      ...
      {content}
    </div>
  );
};
```

With `children` (new version):

```jsx
const App = () => {
  return (
    <ScrollableWithMovingBlock>
      <VerySlowComponent />
      <BunchOfStuff />
      <OtherStuffAlsoComplicated />
    </ScrollableWithMovingBlock>
  );
};

const ScrollableWithMovingBlock = ({ children }) => {
  // ...rest of the code
  return (
    <div>
      ...
      {children}
    </div>
  );
};
```