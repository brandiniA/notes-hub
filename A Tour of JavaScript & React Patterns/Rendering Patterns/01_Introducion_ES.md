# Patrones de Renderizado

El contenido en la web puede renderizarse de muchas maneras. La decisión de cómo y dónde obtener y renderizar el contenido es clave para el rendimiento de una aplicación.

Los frameworks y bibliotecas disponibles permiten implementar diferentes patrones de renderizado como **Renderizado en el Cliente (CSR), Renderizado Estático (SSG), Regeneración Estática Incremental (ISR), Renderizado Progresivo, Renderizado en el Servidor (SSR),** entre otros. Comprender los compromisos y casos de uso de estos patrones puede mejorar drásticamente el rendimiento de la aplicación, resultando en una mejor experiencia tanto para el usuario como para el desarrollador.

## Web Vitals
Para medir el rendimiento de un sitio web, se puede utilizar un conjunto de métricas útiles llamadas **Web Vitals**. Un subconjunto de estas métricas, conocidas como **Core Web Vitals**, se usa generalmente para determinar el rendimiento de una página y puede afectar el SEO del sitio web.

### **Métricas de Core Web Vitals**

- **TTFB** (Time To First Byte) → Tiempo que tarda un cliente en recibir el primer byte del contenido de la página.
- **FCP** (First Contentful Paint) → Tiempo que tarda el navegador en renderizar el primer contenido después de la navegación.
- **LCP** (Largest Contentful Paint) → Tiempo que tarda en cargarse y renderizarse el contenido principal de la página.
- **TTI** (Time To Interactive) → Tiempo desde que la página comienza a cargarse hasta que responde de manera fiable a la entrada del usuario.
- **CLS** (Cumulative Layout Shift) → Mide la estabilidad visual para evitar cambios inesperados en el diseño.
- **FID** (First Input Delay) → Tiempo desde que el usuario interactúa con la página hasta que los controladores de eventos pueden ejecutarse.

## Términos Clave
Los siguientes términos serán útiles al analizar las diferentes técnicas de renderizado:

- **Compilación** → Conversión de JavaScript en código máquina nativo.
- **Tiempo de Ejecución** → Tiempo que tarda en ejecutarse la información previamente obtenida, analizada y compilada.
- **Hidratación** → Proceso de adjuntar controladores a un nodo del DOM cuyo contenido HTML fue renderizado en el servidor, volviendo el componente interactivo.
- **Inactividad** → Estado del navegador cuando no está realizando ninguna acción.
- **Tiempo de Carga** → Tiempo que tarda en obtener los datos desde el servidor.
- **Hilo Principal** → Hilo donde el navegador ejecuta todo el JavaScript, realiza el diseño, los reflows y la recolección de basura.
- **Parsing** → Conversión de un código fuente HTML en nodos del DOM y generación de un Árbol de Sintaxis Abstracta (AST).
- **Procesamiento** → Análisis, compilación y ejecución de los datos previamente obtenidos.
- **Tiempo de Procesamiento** → Tiempo que tarda en analizar y compilar los datos previamente obtenidos.

