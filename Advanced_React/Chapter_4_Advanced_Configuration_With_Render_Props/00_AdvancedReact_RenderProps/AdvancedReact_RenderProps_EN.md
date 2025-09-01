# ✨ Render Props for Rendering Elements

> **Quick summary:**  
> Render props let a parent component **pass elements and state explicitly** without relying on `cloneElement` or guessing a child library’s prop API.

---

## 📚 Concept 1 — _The problem with cloning elements_

`React.cloneElement` can inject defaults (e.g., size/color) into an element prop, but it fails when:
- You need to **share parent state** with that element.
- You change **icon libraries** and their prop names differ.

```jsx
// ❌ Element-as-prop + cloneElement (works only under strict assumptions)
const Button = ({ appearance = 'secondary', size = 'medium', icon }) => {
  const defaultIconProps = {
    size: size === 'large' ? 'large' : 'medium',
    color: appearance === 'primary' ? 'white' : 'black',
  };

  const clonedIcon = React.cloneElement(icon, {
    ...defaultIconProps,
    ...icon.props,
  });

  return <button>Submit {clonedIcon}</button>;
};
```

Now we try to add hover state—but the icon can’t “see” it:

```jsx
// ❌ Hover state exists but is isolated from the icon
const Button = ({ icon }) => {
  const [isHovered, setIsHovered] = React.useState(false);

  return (
    <button
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      Submit {icon}
    </button>
  );
};
```

<details>
<summary>🔍 **Key takeaways**</summary>

- **Rigid assumptions** about child props make your component fragile.
- **State isolation**: elements passed by value can’t consume parent state unless you re-architect.
- **Library churn** is inevitable; avoid coupling your component to a specific child API.

</details>

---

## 🛠️ Concept 2 — _Step by step with render props_

### 1. What is a render prop?
A render prop is simply a **function passed as a prop** that returns a React element. Instead of giving the Button a ready-made element, we give it a function that knows how to render one.

```jsx
const Button = ({ renderIcon }) => {
  return <button>Submit {renderIcon()}</button>;
};

<Button renderIcon={() => <HomeIcon />} />
```

---

### 2. Why is this better?
Instead of cloning and assuming every icon accepts `size` and `color`, we pass those values **directly to the render function**. The consumer then decides how to apply them.

```jsx
const Button = ({ size, appearance, renderIcon }) => {
  const defaultIconProps = {
    size: size === 'large' ? 'large' : 'medium',
    color: appearance === 'primary' ? 'white' : 'black',
  };

  return <button>Submit {renderIcon(defaultIconProps)}</button>;
};
```

---

### 3. How can we consume it?
```jsx
<Button renderIcon={(props) => <HomeIcon {...props} />} />
<Button renderIcon={(props) => <HomeIcon {...props} size="large" color="red" />} />
<Button renderIcon={(props) => <HomeIcon fontSize={props.size} style={{ color: props.color }} />} />
```

Here everything is explicit: no hidden overrides, no assumptions. The consumer maps values however they need.

---

### 4. Sharing state made simple
Now we can also pass state alongside defaults. For example, a hover state:

```jsx
const Button = ({ size, appearance, renderIcon }) => {
  const [isHovered, setIsHovered] = React.useState(false);

  const defaultIconProps = {
    size: size === 'large' ? 'large' : 'medium',
    color: appearance === 'primary' ? 'white' : 'black',
  };

  return (
    <button
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      Submit {renderIcon(defaultIconProps, { isHovered })}
    </button>
  );
};
```

---

### 5. Consumers with state
```jsx
// Swap icons when hovered
<Button
  renderIcon={(props, state) =>
    state.isHovered ? <HomeIconHovered {...props} /> : <HomeIcon {...props} />
  }
/>

// Apply hover styles
<Button
  renderIcon={(props, state) => (
    <HomeIcon {...props} className={state.isHovered ? 'hovered' : ''} />
  )}
/>

// Ignore hover completely
<Button renderIcon={(props) => <HomeIcon {...props} />} />
```

---

## 🚀 Full Example

```jsx
const Button = ({ size = 'medium', appearance = 'secondary', renderIcon }) => {
  const [isHovered, setIsHovered] = React.useState(false);

  const defaultIconProps = {
    size: size === 'large' ? 'large' : 'medium',
    color: appearance === 'primary' ? 'white' : 'black',
  };

  return (
    <button
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      Submit {renderIcon(defaultIconProps, { isHovered })}
    </button>
  );
};
```

**Expected output:**

- The icon **inherits defaults** from the Button (`size`, `color`).
- Consumers can **override** or **translate** those defaults.
- Button state like hover is now **shareable and traceable**.

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| _No new words relevant in this section._ |
