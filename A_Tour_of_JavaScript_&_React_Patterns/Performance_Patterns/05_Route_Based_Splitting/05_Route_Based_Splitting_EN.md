# Route-Based Splitting

## Overview
If your application has multiple pages, you can use **dynamic imports** to load only the resources needed for the **current route**. Instead of including code for all possible pages in the initial bundle, we can **split the bundle by route**. This approach **defers** loading the bundle until the user actually navigates to that page.

---

## Implementation
If you are using `react-router` for navigation, you can wrap the `Switch` or `Routes` component in a `React.Suspense`, and import the routes using `React.lazy`. This automatically enables **route-based code splitting**.

### **Basic Example**
```javascript
import React, { lazy, Suspense } from "react";
import { Switch, Route, BrowserRouter as Router } from "react-router-dom";

const App = lazy(() => import("./App"));
const About = lazy(() => import("./About"));
const Contact = lazy(() => import("./Contact"));

ReactDOM.render(
  <Router>
    <Suspense fallback={<div>Loading...</div>}>
      <Switch>
        <Route exact path="/">
          <App />
        </Route>
        <Route path="/about">
          <About />
        </Route>
        <Route path="/contact">
          <Contact />
        </Route>
      </Switch>
    </Suspense>
  </Router>,
  document.getElementById("root")
);
```

---

### **Example with React Router v6**
```javascript
import React, { lazy, Suspense } from 'react';
import { createRoot } from 'react-dom/client';
import {
  Routes,
  Route,
  BrowserRouter as Router,
  Link,
  Outlet,
} from 'react-router-dom';
import './styles.css';

const App = lazy(() => import('./pages/App'));
const About = lazy(() => import('./pages/About'));
const Contact = lazy(() => import('./pages/Contact'));

export function Nav() {
  return (
    <div>
      <nav>
        <h1>
          <Link to="/">
            <span>🏡</span> Houses.
          </Link>
        </h1>
        <ul>
          <li>
            <Link to="/about">About</Link>
          </li>
          <li>
            <Link to="/contact">Contact</Link>
          </li>
        </ul>
      </nav>
      <Outlet />
    </div>
  );
}

createRoot(document.getElementById('root')).render(
  <Router>
    <Suspense fallback={<div>Loading...</div>}>
      <Routes>
        <Route path="/" element={<Nav />}>
          <Route
            index
            path="/"
            element={
              <React.Suspense fallback={<div />}>
                <App />
              </React.Suspense>
            }
          />
          <Route
            path="/about"
            element={
              <React.Suspense fallback={<div />}>
                <About />
              </React.Suspense>
            }
          />
          <Route
            path="/contact"
            element={
              <React.Suspense fallback={<div />}>
                <Contact />
              </React.Suspense>
            }
          />
        </Route>
      </Routes>
    </Suspense>
  </Router>
);
```

---

## Trade-offs
### **Advantages**
✅ **Faster Initial Load** → Dynamically importing pages **reduces the initial bundle size**, improving page load speed.
✅ **Optimized Bandwidth Usage** → The client **only downloads and executes necessary pages**, reducing bandwidth usage.

> **Best Practice**: Use route-based splitting **only for non-essential pages** to optimize user experience.