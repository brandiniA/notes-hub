# Compound Pattern in React

## Overview
The **Compound Pattern** allows multiple components to work together to perform a single task. This pattern is particularly useful when combined with the **Provider Pattern** to manage state efficiently.

### Key Benefits:
- **Encapsulation of logic**: The parent component manages state, while child components consume it.
- **Better reusability**: Child components can be structured flexibly.
- **Cleaner API**: No need to manually pass multiple props between deeply nested components.

## Example Use Case: Search Input with FlyOut Popup
Imagine a **Search Input** component where clicking the input field triggers a **SearchPopup** displaying suggested locations.

We can implement this using a **FlyOut** compound component.

```javascript
import React from "react";
import { FlyOut } from "./FlyOut";

export default function SearchInput() {
  return (
    <FlyOut>
      <FlyOut.Input placeholder="Enter an address, city, or ZIP code" />
      <FlyOut.List>
        <FlyOut.ListItem value="San Francisco, CA">San Francisco, CA</FlyOut.ListItem>
        <FlyOut.ListItem value="Seattle, WA">Seattle, WA</FlyOut.ListItem>
        <FlyOut.ListItem value="Austin, TX">Austin, TX</FlyOut.ListItem>
      </FlyOut.List>
    </FlyOut>
  );
}
```

Here, the `FlyOut` component manages state, while its sub-components consume and modify the state.

## Implementation
There are two ways to implement the **Compound Pattern** in React:

### 1. Using the **Provider Pattern** (Context API)
In this approach, a **Context** object is used to manage and share the state.

#### **Step 1: Create the Context and Provider**
```javascript
const FlyOutContext = React.createContext();

export function FlyOut(props) {
  const [open, setOpen] = React.useState(false);
  const [value, setValue] = React.useState("");
  const toggle = React.useCallback(() => setOpen((state) => !state), []);

  return (
    <FlyOutContext.Provider value={{ open, toggle, value, setValue }}>
      <div>{props.children}</div>
    </FlyOutContext.Provider>
  );
}
```

#### **Step 2: Create Child Components**
```javascript
function Input(props) {
  const { value, toggle } = React.useContext(FlyOutContext);
  return <input onFocus={toggle} onBlur={toggle} value={value} {...props} />;
}

function List({ children }) {
  const { open } = React.useContext(FlyOutContext);
  return open && <ul>{children}</ul>;
}

function ListItem({ children, value }) {
  const { setValue } = React.useContext(FlyOutContext);
  return <li onMouseDown={() => setValue(value)}>{children}</li>;
}

FlyOut.Input = Input;
FlyOut.List = List;
FlyOut.ListItem = ListItem;
```

Using this pattern, `FlyOut` acts as the **stateful component**, while `FlyOut.Input`, `FlyOut.List`, and `FlyOut.ListItem` consume the state.

---

### 2. Using `React.Children.map` and `React.cloneElement`
An alternative to using the Context API is leveraging `React.Children.map` and `React.cloneElement`. This approach allows the parent component to pass props to direct children dynamically.

#### **Step 1: Implement the Parent Component**
```javascript
export function FlyOut(props) {
  const [open, setOpen] = React.useState(false);
  const [value, setValue] = React.useState("");
  const toggle = React.useCallback(() => setOpen((state) => !state), []);

  return (
    <div>
      {React.Children.map(props.children, (child) =>
        React.cloneElement(child, { open, toggle, value, setValue })
      )}
    </div>
  );
}
```

#### **Step 2: Implement Child Components**
```javascript
function Input(props) {
  const { value, toggle } = props;
  return <input onFocus={toggle} onBlur={toggle} value={value} {...props} />;
}

function List({ children, open }) {
  return open && <ul>{children}</ul>;
}

function ListItem({ children, value, setValue }) {
  return <li onMouseDown={() => setValue(value)}>{children}</li>;
}

FlyOut.Input = Input;
FlyOut.List = List;
FlyOut.ListItem = ListItem;
```

With this approach, `FlyOut` clones its children and injects state and event handlers as props.

## Trade-offs

### **Advantages**
1. **State Management**: Compound components manage their internal state, which is shared among children. This reduces the need for passing state manually.
2. **Single Import**: When using compound components, you only need to import the parent component.

### **Disadvantages**
1. **Nested Components Limitation**: When using `React.Children.map`, only direct children of `FlyOut` receive props. If you wrap a component inside another element, it won’t receive `open` and `toggle` props.

   ```javascript
   function FlyoutMenu() {
     return (
       <FlyOut>
         {/* This breaks, since the direct child of FlyOut is now a div */}
         <div>
           <FlyOut.Input />
           <FlyOut.List>
             <FlyOut.ListItem>San Francisco, CA</FlyOut.ListItem>
             <FlyOut.ListItem>Seattle, WA</FlyOut.ListItem>
           </FlyOut.List>
         </div>
       </FlyOut>
     );
   }
   ```

2. **Naming Collisions**: Using `React.cloneElement` performs a shallow merge. If props like `open` or `toggle` exist on a child component, they may get **overwritten**, leading to unexpected behavior.

## Conclusion
The **Compound Pattern** is a powerful way to structure reusable, stateful components in React. It works well with the **Provider Pattern** and offers a clean API while avoiding **prop drilling**. However, care must be taken to avoid **naming collisions** and **limitations with deeply nested components**.

