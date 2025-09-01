# Dynamic Import

## Overview
**Dynamically importing** parts of your code allows you to **load components on demand** instead of including everything in the initial bundle.

**Problem with Static Imports**:
- Statically imported modules are **included in the final bundle**, even if they aren't needed immediately.
- This can result in **larger initial bundle sizes**, leading to **slower initial load times**.

**Solution**:
- Dynamically **import modules when they are actually needed**, reducing the initial bundle size.

### **Example Use Case**
Consider a **Search Input** component that displays a `SearchPopup` when clicked. If the user never clicks, the `SearchPopup` component **is never needed**. Using dynamic imports, we load `SearchPopup` **only when required**, reducing the initial bundle size.

---

## Implementation
In **React**, dynamic imports are achieved using `React.Suspense` with `React.lazy`.

- `Suspense` displays a **fallback** (e.g., a loading message) while the module is being loaded.
- `lazy()` dynamically loads the component **only when required**.

### **Example**

In this example:
- `Card1` and `Card2` are **statically imported**.
- `Card3` and `Card4` are **dynamically loaded** when the user interacts with them.

```javascript
import React, { Suspense, lazy } from 'react';
import './styles.css';

import { Card } from './components/Card';
import Card1 from './components/Card1';
import Card2 from './components/Card2';
const Card3 = lazy(() =>
  import(/* webpackChunkName: "card3" */ './components/Card3')
);
const Card4 = lazy(() =>
  import(/* webpackChunkName: "card4" */ './components/Card4')
);

const App = () => {
  return (
    <div className="App">
      <Card1 />
      <Card2 />
      <DynamicCard component={Card3} name="Card3" />
      <DynamicCard component={Card4} name="Card4" />
    </div>
  );
};

function DynamicCard(props) {
  const [open, toggle] = React.useReducer((s) => !s, false);
  const Component = props.component;

  return (
    <Suspense fallback={<p id="loading">Loading...</p>}>
      {open ? (
        <Component />
      ) : (
        <Card rendered={false} onClick={toggle}>
          <p>
            Click here to dynamically import <code>{props.name}</code> component
          </p>
        </Card>
      )}
    </Suspense>
  );
}

export default App;
```

---

### **Webpack Optimization**

```javascript
import(/* webpackChunkName: "card3" */ './components/Card3');
```

> **`webpackChunkName`**: This is a **magic comment** that assigns a readable name (`card3.bundle.js`) instead of a generic name like `0.bundle.js` or `1.bundle.js`. This makes it easier to debug in the **Network tab**.

---

## Tradeoffs

### **Advantages**
✅ **Faster initial load** → Smaller initial bundle size since unnecessary modules aren’t downloaded immediately.
✅ **Improves performance** → Reduces bandwidth usage.

### **Disadvantages**
❌ **Layout shift** → If the fallback component has a different size than the loaded component, it can cause layout jumps.
❌ **User experience** → Lazy-loading a component **needed immediately** can cause a delay in rendering.

> **Best Practice**: **Only lazy load components that aren’t visible on the initial render**.

