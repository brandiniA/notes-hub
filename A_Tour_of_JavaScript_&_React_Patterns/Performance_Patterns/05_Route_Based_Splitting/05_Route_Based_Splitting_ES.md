# División Basada en Rutas

## Descripción
Si tu aplicación tiene múltiples páginas, puedes utilizar **importaciones dinámicas** para cargar solo los recursos necesarios para la **ruta actual**. En lugar de incluir el código de todas las páginas posibles en el bundle inicial, podemos **dividir el bundle por ruta**. Este enfoque **retrasa** la carga del bundle hasta que el usuario realmente navega a esa página.

---

## Implementación
Si estás utilizando `react-router` para la navegación, puedes envolver el componente `Switch` o `Routes` en un `React.Suspense`, e importar las rutas utilizando `React.lazy`. Esto habilita automáticamente la **división de código basada en rutas**.

### **Ejemplo Básico**
```javascript
import React, { lazy, Suspense } from "react";
import { Switch, Route, BrowserRouter as Router } from "react-router-dom";

const App = lazy(() => import("./App"));
const About = lazy(() => import("./About"));
const Contact = lazy(() => import("./Contact"));

ReactDOM.render(
  <Router>
    <Suspense fallback={<div>Cargando...</div>}>
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

### **Ejemplo con React Router v6**
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
            <span>🏡</span> Casas.
          </Link>
        </h1>
        <ul>
          <li>
            <Link to="/about">Acerca de</Link>
          </li>
          <li>
            <Link to="/contact">Contacto</Link>
          </li>
        </ul>
      </nav>
      <Outlet />
    </div>
  );
}

createRoot(document.getElementById('root')).render(
  <Router>
    <Suspense fallback={<div>Cargando...</div>}>
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

## Ventajas y Desventajas
### **Ventajas**
✅ **Carga Inicial Más Rápida** → Importar dinámicamente las páginas **reduce el tamaño del bundle inicial**, mejorando la velocidad de carga.
✅ **Uso Optimizado del Ancho de Banda** → El cliente **solo descarga y ejecuta las páginas necesarias**, reduciendo el consumo de datos.

> **Mejor Práctica**: Utiliza la división basada en rutas **solo para páginas no esenciales** para optimizar la experiencia del usuario.

