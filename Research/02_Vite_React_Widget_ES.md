# Creando un Widget Embebible de React con Vite, Rollup y Tailwind

Esta guía proporciona un tutorial **completo** para crear un **widget de React listo para producción y embebible**, desde cero. Cubriremos todo, desde la **configuración del proyecto** con Vite hasta el **empaquetado** con Rollup, la **estilización** con Tailwind CSS, la **gestión de entornos** y la **inserción** de tu widget en cualquier sitio web.

---
## 1. Configuración de Proyecto

### 1.1 Creando un Proyecto con Vite

```bash
npm create vite@latest react-widget -- --template react-ts
cd react-widget
```

Esto configura un nuevo proyecto de React + TypeScript usando Vite.

### 1.2 Instalando Dependencias

Necesitaremos dependencias **core** y **de desarrollo**:

```bash
# Dependencias principales
npm install react react-dom

# Dependencias de desarrollo
npm install -D tailwindcss@3 postcss tslib @rollup/plugin-babel @rollup/plugin-commonjs @rollup/plugin-node-resolve @rollup/plugin-typescript @rollup/plugin-terser rollup rollup-plugin-postcss @babel/preset-react @babel/preset-typescript @types/react @types/react-dom typescript @types/node @rollup/plugin-replace rollup-plugin-polyfill-node rollup-plugin-tsconfig-paths rollup-plugin-visualizer rollup-plugin-inject-process-env dotenv
```

---
## 2. Estructura del Proyecto

Una posible distribución de carpetas para mayor claridad y mantenibilidad:

```plaintext
react-embeddable-widget/
├── src/
│   ├── widget/
│   │   ├── components/
│   │   ├── lib/
│   │   ├── styles/
│   │   ├── index.tsx         (Punto de entrada del widget)
│   ├── App.tsx              (Aplicación de prueba)
│   ├── App.css
│   ├── main.tsx             (Entrada para Vite)
│   ├── index.css
├── public/
├── index.html
├── package.json
├── tsconfig.json
├── vite.config.ts
├── .env.development
├── .env.production
├── rollup.config.mjs
├── tailwind.config.mjs
└── postcss.config.cjs
```

- **`src/widget/`**: Código principal del widget (componentes, librerías, estilos, etc.).
- **`src/`**: Aplicación basada en Vite para desarrollo/pruebas, no se incluye en el bundle final del widget.
- **`public/`**: Archivos estáticos.
- **`.env.*`**: Variables de entorno para desarrollo y producción.
- **`rollup.config.mjs`**: Configuración de Rollup para empaquetar el widget.
- **`tailwind.config.mjs` & `postcss.config.cjs`**: Configs para Tailwind y PostCSS.

---
## 3. Agregando Tailwind CSS

### 3.1 Inicializando Tailwind

```bash
npx tailwindcss init -p
```

Esto crea un archivo **`tailwind.config.js`** o **`tailwind.config.cjs`** (en este caso lo renombramos a **`tailwind.config.mjs`** para compatibilidad con ESM) y un archivo **`postcss.config.js`**.

### 3.2 Configuración de Tailwind (`tailwind.config.mjs`)

```js
export default {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}"
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
```

Especifica las rutas a tus componentes para que Tailwind pueda purgar estilos no utilizados.

### 3.3 Configuración de PostCSS (`postcss.config.cjs`)

```js
module.exports = {
  plugins: {
    tailwindcss: "./tailwind.config.mjs",
  },
};
```

### 3.4 Archivo CSS Principal

Crea **`src/widget/styles/style.css`** (o el nombre que prefieras) para importar las capas de Tailwind:

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Opcionalmente, agrega estilos personalizados para tu widget */
.widget-container {
  @apply fixed bottom-5 right-5 w-[300px] h-[400px] bg-white border border-gray-200 text-black rounded-lg shadow-lg z-[9999];
}

.widget-button {
  @apply fixed bottom-5 right-5 px-6 py-3 bg-indigo-600 text-white border-none rounded-lg cursor-pointer z-[9999];
}

.widget-header {
  @apply p-3 border-b border-gray-200 flex justify-between items-center;
}

.widget-content {
  @apply p-4;
}
```

Luego, importa este CSS en **el archivo de entrada del widget** (por ejemplo, `src/widget/index.tsx`) o en el componente contenedor del widget:

```tsx
import "./styles/style.css";
```

---
## 4. Archivos de Configuración

### 4.1 Configuración de Rollup (`rollup.config.mjs`)

A continuación se muestra una configuración **completa** de Rollup que maneja TypeScript, Babel, commonJS, resolución de módulos, variables de entorno, polyfills, PostCSS y minificación.

```js
import babel from '@rollup/plugin-babel';
import commonjs from '@rollup/plugin-commonjs';
import nodeResolve from '@rollup/plugin-node-resolve';
import replace from '@rollup/plugin-replace';
import terser from '@rollup/plugin-terser';
import typescript from '@rollup/plugin-typescript';
import { config } from 'dotenv';
import { parseArgs } from 'node:util';
import injectProcessEnv from 'rollup-plugin-inject-process-env';
import nodePolyfills from 'rollup-plugin-polyfill-node';
import postcss from 'rollup-plugin-postcss';
import tsConfigPaths from 'rollup-plugin-tsconfig-paths';
import { visualizer } from 'rollup-plugin-visualizer';

const args = parseArgs({
  options: {
    environment: {
      type: 'string',
      short: 'e',
      default: 'development',
    },
    configuration: {
      type: 'string',
      short: 'c',
    },
  },
});

const env = args.values.environment;
const production = env === 'production';
console.log(`Compilando el widget para el entorno ${env}...`);

// Cargar variables de entorno
const ENV_VARIABLES = config({
  path: production ? './.env.production' : './.env.development',
}).parsed;

// Nombre del archivo generado del widget
const fileName = ENV_VARIABLES.WIDGET_NAME || 'widget.js';

export default {
  input: './src/index.tsx',
  output: {
    file: `dist/${fileName}`,
    format: 'iife', // Immediately Invoked Function Expression
    sourcemap: false,
    inlineDynamicImports: true,
    globals: {
      'react/jsx-runtime': 'jsxRuntime',
      'react-dom/client': 'ReactDOM',
      react: 'React',
    },
  },
  plugins: [
    tsConfigPaths({ tsconfig: './tsconfig.json' }),
    replace({ preventAssignment: true }),
    typescript({ tsconfig: './tsconfig.json' }),
    nodeResolve({
      extensions: ['.tsx', '.ts', '.json', '.js', '.jsx', '.mjs'],
      browser: true,
      dedupe: ['react', 'react-dom'],
    }),
    babel({
      babelHelpers: 'bundled',
      presets: [
        '@babel/preset-typescript',
        [
          '@babel/preset-react',
          {
            runtime: 'automatic',
            targets: '>0.1%, not dead, not op_mini all',
          },
        ],
      ],
      extensions: ['.js', '.jsx', '.ts', '.tsx', '.mjs'],
    }),
    postcss({
      extensions: ['.css'],
      minimize: true,
      extract: true,
      inject: { insertAt: 'top' },
    }),
    commonjs(),
    nodePolyfills({ exclude: ['crypto'] }),
    injectProcessEnv(ENV_VARIABLES),
    terser({
      ecma: 2020,
      mangle: { toplevel: true },
      compress: {
        module: true,
        toplevel: true,
        unsafe_arrows: true,
        drop_console: true,
        drop_debugger: true,
      },
      output: { quote_style: 1 },
    }),
    visualizer(),
  ],
};
```

Esta configuración garantiza:
- Compilación **TypeScript**
- Transpilación **Babel**
- **PostCSS** para Tailwind
- **Minificación** y **Optimizaciones**
- Inyección de **variables de entorno** vía `.env.*`
- **Análisis de bundle** con `rollup-plugin-visualizer`

### 4.2 Scripts en `package.json`

```json
{
  "scripts": {
    "build": "vite build",
    "dev": "vite",
    "build:widget": "rollup -c ./rollup.config.mjs",
    "build:widget:production": "rollup -c ./rollup.config.mjs --environment=production",
    "serve": "npx http-server ./ --cors -p 3333",
    "serve:widget": "npx http-server ./dist --cors -p 3334"
  }
}
```

- **`build:widget`**: Empaqueta el widget para **desarrollo** (usando `.env.development`).
- **`build:widget:production`**: Empaqueta para **producción** (usando `.env.production`).
- **`serve`**: Sirve el proyecto completo en el puerto `3333`.
- **`serve:widget`**: Sirve el widget empaquetado desde `./dist` en el puerto `3334`.

---
## 5. Construyendo los Componentes del Widget

A continuación, un ejemplo detallado de cómo estructurar el código de tu widget.

### 5.1 Crear un Context (`src/widget/lib/context.ts`)

```ts
import { createContext } from 'react';

interface WidgetContextType {
  isOpen: boolean;
  setIsOpen: (isOpen: boolean) => void;
}

export const WidgetContext = createContext<WidgetContextType>({
  isOpen: false,
  setIsOpen: () => undefined,
});
```

### 5.2 Contenedor Principal del Widget (`src/widget/components/widget-container.tsx`)

```tsx
import { useState, useEffect } from 'react';
import { WidgetContext } from '../lib/context';
import { Widget } from './widget';

interface WidgetContainerProps {
  clientKey: string;
}

export function WidgetContainer({ clientKey }: WidgetContainerProps) {
  const [mounted, setMounted] = useState(false);
  const [isOpen, setIsOpen] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) {
    return null;
  }

  return (
    <WidgetContext.Provider value={{ isOpen, setIsOpen }}>
      <Widget clientKey={clientKey} />
    </WidgetContext.Provider>
  );
}
```

### 5.3 Ejemplo de Componente del Widget (`src/widget/components/widget.tsx`)

```tsx
import { useContext } from 'react';
import { WidgetContext } from '../lib/context';

interface WidgetProps {
  clientKey: string;
}

export function Widget({ clientKey }: WidgetProps) {
  const { isOpen, setIsOpen } = useContext(WidgetContext);

  return (
    <div>
      <button
        onClick={() => setIsOpen(!isOpen)}
        className="widget-button"
      >
        Toggle Widget
      </button>
      {isOpen && (
        <div className="widget-container">
          <div className="widget-header">
            <span>My Widget</span>
            <button onClick={() => setIsOpen(false)}>&times;</button>
          </div>
          <div className="widget-content">
            <p>Client Key: {clientKey}</p>
            <p>¡Este es algo de contenido dentro del widget!</p>
          </div>
        </div>
      )}
    </div>
  );
}
```

---
## 6. Punto de Entrada e Inicialización

### 6.1 Archivo Principal de Entrada (`src/widget/index.tsx`)

Este archivo inicializa React cuando el widget se carga y **sirve como el punto de entrada principal** para Rollup.

```tsx
import { hydrateRoot } from 'react-dom/client';
import { WidgetContainer } from './components/widget-container';
import './styles/style.css';

function initializeWidget() {
  if (document.readyState !== 'loading') {
    onReady();
  } else {
    document.addEventListener('DOMContentLoaded', onReady);
  }
}

function onReady() {
  try {
    const element = document.createElement('div');
    const shadow = element.attachShadow({ mode: 'open' });
    const shadowRoot = document.createElement('div');
    const clientKey = getClientKey();

    shadowRoot.id = 'widget-root';

    const component = (
      <WidgetContainer clientKey={clientKey} />
    );

    shadow.appendChild(shadowRoot);
    injectStyle(shadowRoot);
    hydrateRoot(shadowRoot, component);

    document.body.appendChild(element);
  } catch (error) {
    console.warn('Widget initialization failed:', error);
  }
}

function injectStyle(shadowRoot: HTMLElement) {
  const link = document.createElement('link');
  link.rel = 'stylesheet';
  // This URL can be set via environment variables
  link.href = process.env.WIDGET_CSS_URL || '/style.css';
  shadowRoot.appendChild(link);
}

function getClientKey() {
  // Retrieve the data-client-key from the script tag
    const script = document.currentScript as HTMLScriptElement;
  const clientKey = script?.getAttribute('data-client-key');
  
  if (!clientKey) {
    throw new Error('Missing data-client-key attribute');
  }
  
  return clientKey;
}

initializeWidget();

```

- **`onReady()`**: Se llama cuando el DOM está listo; crea un shadow root y renderiza el widget.
- **`injectStyle()`**: Agrega el CSS compilado del widget dentro del shadow root.
- **`getClientKey()`**: Recupera `data-client-key` desde la etiqueta `<script>` que carga el widget.

---
## 7. Gestión de Entornos y Scripts

### 7.1 `.env.development` & `.env.production`

Define variables de entorno en estos archivos. Ejemplo:

```
# .env.development
WIDGET_CSS_URL=http://localhost:3334/style.css
WIDGET_NAME=widget.js
```

```
# .env.production
WIDGET_CSS_URL=https://your-cdn.com/widget.css
WIDGET_NAME=widget.js
```

### 7.2 Comandos de Build

- **`npm run build:widget`** usa `.env.development`.
- **`npm run build:widget:production`** usa `.env.production`.

### 7.3 Pruebas Locales

**Sirviendo el proyecto principal**:

```bash
npm run serve   # Sirve desde ./ en el puerto 3333
```

**Sirviendo el bundle del widget**:

```bash
npm run serve:widget  # Sirve ./dist en el puerto 3334
```

---
## 8. Usar Vite como Entorno de Desarrollo

Mientras que la **compilación con Rollup** es para producción, aún puedes desarrollar el widget usando el servidor dev de Vite:

```bash
npm run dev
```

Dentro de tu App en Vite (ej. `src/App.tsx`), puedes importar y renderizar el componente del widget:

```tsx
import './App.css';
import './widget/styles/style.css';
import { WidgetContainer } from './widget/components/widget-container';

function App() {
  return (
    <>
      <h1>Probando el Widget en Vite</h1>
      <WidgetContainer clientKey="test-key" />
    </>
  );
}

export default App;
```

Este enfoque permite **hot module replacement** y una iteración más rápida durante el desarrollo.

---
## 9. Compilación y Pruebas en Producción

### 9.1 Compilación de Producción

```bash
npm run build:widget:production
```

Esto crea un `dist/widget.js` (y posiblemente `widget.css`) optimizado para producción, referenciando `.env.production`.

### 9.2 Probando el Widget Empaquetado

Crea una **página de prueba** simple (por ejemplo, `test/index.html`) para cargar tu widget empaquetado:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Página de Prueba de Widget</title>
</head>
<body>
  <h1>Página de Prueba</h1>
  <p>Esta página prueba la integración del widget.</p>
  <script async src="../dist/widget.js" data-client-key="test-key"></script>
</body>
</html>
```

Lanza un servidor local:

```bash
npm run serve &    # Sirve tu directorio raíz
npm run serve:widget &    # Sirve el widget desde dist
```

Luego abre [http://localhost:3333/test/index.html](http://localhost:3333/test/index.html) para ver tu widget en acción.

---
## 10. Uso en Producción

Una vez que tu widget esté compilado y desplegado (por ejemplo, en un CDN), puedes embeberlo en **cualquier** sitio web con una sola etiqueta `<script>`:

```html
<script
  src="https://your-cdn.com/widget.js"
  data-client-key="YOUR_CLIENT_KEY"
></script>
```

- El **`data-client-key`** identifica al cliente o entorno particular.
- La variable de entorno **`WIDGET_CSS_URL`** asegura que se use el archivo CSS correcto.

---
## 11. Mejores Prácticas

1. **Rendimiento**
   - Carga diferida (lazy load) de componentes no críticos.
   - Implementa división de código (code splitting).
   - Optimiza el tamaño del bundle.

2. **Compatibilidad**
   - Prueba en diferentes navegadores.
   - Considera polyfills para navegadores antiguos.
   - Maneja degradación elegante (graceful degradation).

3. **Seguridad**
   - Implementa cabeceras CORS adecuadas.
   - Sanitiza entradas de usuario.
   - Usa Content Security Policy (CSP).

4. **Manejo de Errores**
   - Implementa error boundaries.
   - Agrega logs y monitoreo.
   - Maneja fallas de inicialización de forma adecuada.

---
## 12. Conclusión

Ahora cuentas con una guía **integral** para construir un widget de React embebible utilizando **Vite** para desarrollo, **Rollup** para empaquetado de producción y **Tailwind CSS** para un estilo eficiente. Esta arquitectura asegura:

- **Organización modular** del código (código del widget vs. app de prueba)
- **Compilaciones basadas en entornos** (`.env.development` vs. `.env.production`)
- **Inserción sencilla** mediante `<script>`
- Aislamiento de estilos con **Shadow DOM**

Con estos pasos, podrás desarrollar, probar y desplegar un widget **listo para producción** que cualquier sitio web puede embeber. **¡Feliz codificación!**

Fuente https://makerkit.dev/blog/tutorials/embeddable-widgets-react