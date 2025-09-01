# Static Import

## Overview
A **statically imported module** is a module that's imported using the `import` keyword.

```javascript
import module1 from "./module1";
import module2 from "./module2";
import module3 from "./module3";
```

In this case, `module1`, `module2`, and `module3` are statically imported.

When a module is statically imported, a **bundler** traverses all the modules and includes them in a single file.

---

## Example of Static Import

### **module1.js**
```javascript
export function module1() {
  return "Module 1";
}
```

### **module2.js**
```javascript
import { module1 } from "./module1";

export function module2() {
  return `Module 2, ${module1()}`;
}
```

### **module3.js**
```javascript
import { module2 } from "./module2";

export function module3() {
  return `Module 3, ${module2()}`;
}
```

### **index.js**
```javascript
import { module3 } from "./module3";

console.log(`All imported modules: ${module3()}`);
```

### **Output Bundle (bundle.js)**
```javascript
(() => {
  "use strict";
  function o() {
    return "Module 1";
  }
  function n() {
    return "Module 2, ".concat(o());
  }
  console.log(
    "All imported modules: ".concat(
      (function () {
        return "Module 3, ".concat(n());
      })()
    )
  );
})();
```

---

## How Bundling Works
Let's say we have four files:

- **`module1.js`** exports a single function `module1`.
- **`module2.js`** statically imports `module1` and exports `module2`.
- **`module3.js`** statically imports `module2` and exports `module3`.
- **`index.js`** statically imports `module3` and logs the value.

When `index.js` is bundled, the **bundler** traverses all dependencies and combines them into a single file.

---

## Implementation with React Components
We can statically import React components from other files.

```javascript
import Header from "./Header";
import Content from "./Content";
import Footer from "./Footer";

export default function BlogPost({ post }) {
  return (
    <div>
      <Header title={post.title} />
      <Content body={post.body} />
      <Footer />
    </div>
  );
}
```

Here, `Header` and `Content` are **statically imported**. The modules are executed as soon as they are imported.

If you open the **browser console**, you can see the order in which the modules are loaded.

---

## Trade-offs
### **Advantages**
- **Instant Availability**: Statically imported components are immediately available to the user.
- **Optimizations**: Statically imported modules can be analyzed and **tree-shaken** (removing unused code automatically).

### **Disadvantages**
- **Large Bundle Size**: Importing all modules at once may include unnecessary code, increasing the bundle size.

