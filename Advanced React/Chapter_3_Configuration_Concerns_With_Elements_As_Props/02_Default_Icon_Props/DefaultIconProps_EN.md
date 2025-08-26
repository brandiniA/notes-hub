
# ✨ Default values for elements passed as props

> **Quick summary:**  
> Keep the **flexibility** of passing elements as props and still provide **component-controlled defaults** (e.g., in `Button`) using `React.cloneElement` without breaking the element’s API.

---

## ❗ Problem

In components like `Button`, passing an `icon` as an element offers flexibility—sometimes **too much**.  
We want default control (colors, sizes, disabled state) without forcing the consumer to remember it:

```jsx
<Button appearance="primary" icon={<Loading color="white" />} />
<Button appearance="secondary" icon={<Loading color="black" />} />
<Button appearance="large" icon={<Loading size="large" />} />
```

Half the time it’ll be forgotten or misapplied. We need **default values** that `Button` can apply while still allowing consumers to **override** them.

---

## 📚 Concept 1 — Clone the element and merge props

Use `React.cloneElement(icon, newProps)` to **inject default props** while **respecting** the icon’s original props.

```jsx
const Button = ({ appearance, size, icon }) => {
  // Assume `icon` is a valid React element (no checks needed)
  const defaultIconProps = {
    size: size === 'large' ? 'large' : 'medium',
    color: appearance === 'primary' ? 'white' : 'black',
  };

  // Defaults first, then consumer props → consumer overrides win
  const mergedProps = { ...defaultIconProps, ...icon.props };

  const clonedIcon = React.cloneElement(icon, mergedProps);

  return <button>Submit {clonedIcon}</button>;
};
```

<details>
<summary>🔍 <b>How does it work?</b></summary>

- Step 1: Derive `defaultIconProps` from `appearance`/`size` of `Button`.  
- Step 2: **Merge** defaults first, then `icon.props` (order ensures consumer overrides win).  
- Step 3: Clone with `cloneElement` and render the cloned icon.
</details>

---

## 🛠️ Concept 2 — Why not go overboard with defaults

If you apply only defaults and **don’t** merge with the icon’s props, you **break its API**:

```jsx
const Button = ({ appearance, size, icon }) => {
  // Assume `icon` is a valid React element
  const defaultIconProps = {
    size: size === 'large' ? 'large' : 'medium',
    color: appearance === 'primary' ? 'white' : 'black',
  };

  // ❌ BAD: this ignores the icon's own props forever
  const clonedIcon = React.cloneElement(icon, defaultIconProps);

  return <button>Submit {clonedIcon}</button>;
};

// "red" won't work here because defaults overwrite user intent
<Button appearance="secondary" icon={<Loading color="red" />} /> 
```

> [!TIP]  
> **Golden rule:** defaults first, element props after (`{ ...defaults, ...icon.props }`). This guarantees consumers can override defaults.

---

## ✅ Best Practices

- ✅ Derive defaults from the parent’s **state/props** (e.g., `appearance`, `size`, `disabled`).  
- ✅ Let the **consumer** have the final say by overriding.  
- 🚫 Don’t “freeze” the icon’s API by applying defaults without merging.  

---

## 🚀 Full Example

```jsx
const Loading = ({ color = 'black', size = 'medium' }) => {
  // Example-only: imagine SVG uses color/size
  return <span>{`Loading [color=${color}, size=${size}]`}</span>;
};

const Button = ({ appearance = 'secondary', size = 'medium', icon }) => {
  // Assume `icon` is a valid React element
  const defaultIconProps = {
    size: size === 'large' ? 'large' : 'medium',
    color: appearance === 'primary' ? 'white' : 'black',
  };

  const mergedProps = { ...defaultIconProps, ...icon.props };
  const clonedIcon = React.cloneElement(icon, mergedProps);

  return (
    <button>
      Submit {clonedIcon}
    </button>
  );
};

// Usage
<>
  <Button appearance="primary" icon={<Loading />} />
  <Button appearance="secondary" icon={<Loading />} />
  <Button appearance="large" icon={<Loading />} />
  {/* Consumer override still wins */}
  <Button appearance="secondary" icon={<Loading color="red" />} />
</>;
```

**Expected output (conceptual):**
```
Submit Loading [color=white, size=medium]
Submit Loading [color=black, size=medium]
Submit Loading [color=black, size=large]
Submit Loading [color=red, size=medium]
```

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| _No new words relevant in this section._ |
