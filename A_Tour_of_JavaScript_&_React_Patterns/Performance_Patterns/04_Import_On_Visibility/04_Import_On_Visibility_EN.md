# Import on Visibility

## Overview
Instead of loading all components immediately, we can **dynamically import components** when they become **visible in the viewport**.

Previously, we saw how to dynamically import components **based on user interaction**. However, we can also dynamically import components **based on their visibility** within the viewport.

### **Example Use Case**
If we display multiple listings on a **smaller viewport**, not all listings are **instantly visible** to the user.

- Instead of loading **all listings at once**, we can **lazy-load** them.
- The listing components **only load** when they become visible as the user scrolls down.

---

## Implementation
We can **dynamically import components** using the **Intersection Observer API**.

In **React**, we can use the `react-intersection-observer` hook to detect whether a component is visible.

### **Example: Lazy Loading a Component on Visibility**

```javascript
import { Suspense, lazy } from "react";
import { useInView } from "react-intersection-observer";

const Listing = lazy(() => import("./components/Listing"));

function ListingCard(props) {
  const { ref, inView } = useInView();

  return (
    <div ref={ref}>
      <Suspense fallback={<div />}>
        {inView && <Listing />}
      </Suspense>
    </div>
  );
}
```

- **`useInView`** detects when the component enters the viewport.
- **`lazy()`** loads `Listing` **only when it's visible**.
- **`Suspense`** ensures a fallback is displayed until the component is loaded.

---

## Trade-offs

### **Advantages**
✅ **Faster Initial Load** → Reduces the initial bundle size, improving page load speed.
✅ **Optimized Bandwidth Usage** → Only downloads components when needed.

### **Disadvantages**
❌ **Layout Shift** → If the fallback component and the final component differ in size, the page layout may shift unexpectedly.

> **Best Practice**: Ensure your fallback component has a similar height to prevent layout shifts.

