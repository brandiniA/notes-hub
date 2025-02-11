Renderizado en el Servidor (Server-Side Rendering)
Generar HTML en cada solicitud

Visión general
Con el renderizado en el servidor, podemos generar HTML en el servidor (o función sin servidor) en cada solicitud.

---

### **Paso 1**  
**El cliente solicita HTML desde la función lambda**  

---

### **Paso 2**  
**Lambda genera la página HTML**  

---

### **Paso 3**  
**El navegador analiza y renderiza el contenido**  

---

### **Paso 4**  
**El cliente solicita el paquete JS desde el servidor**  

---

### **Paso 5**  
**El navegador hidrata los elementos**  

Cuando un usuario solicita una aplicación renderizada en el servidor, el servidor genera el HTML y lo devuelve al cliente.

El navegador renderiza este contenido, que inicialmente solo contiene elementos HTML no interactivos. Para vincular manejadores de eventos a los componentes, el cliente envía una solicitud adicional para obtener el paquete JavaScript y realizar la hidratación de los componentes.

Implementación
Cuando renderizamos una aplicación en el servidor, necesitamos un método para renderizar HTML desde nuestros componentes de React en el servidor e hidratar el HTML no interactivo en el cliente. Una forma de renderizar HTML en el servidor es utilizando el método `renderToString`. Esta función devuelve una cadena HTML correspondiente al elemento de React. El HTML puede ser renderizado en el cliente para una carga más rápida y luego hidratado con el método `hydrateRoot` en el cliente.

Aquí tienes la transcripción del código que aparece en la imagen:

---

### **client.js**
```javascript
ReactDOM.hydrateRoot(<App />, container)
```

---

### **server.js**
```javascript
ReactDOMServer.renderToString(<App />)
```

---

### **Explicación**  
Este código ilustra el proceso de **Renderizado en el Servidor (SSR) con React** y la posterior **hidratación en el cliente**:

1. **server.js**  
   - Usa `ReactDOMServer.renderToString(<App />)` para generar una cadena de HTML en el servidor.  
   - Este HTML se envía al navegador para un renderizado rápido.  

2. **client.js**  
   - Usa `ReactDOM.hydrateRoot(<App />, container)` para **hidratar** la aplicación en el cliente.  
   - Esto vincula los eventos de React a los elementos HTML ya renderizados, evitando un nuevo render completo.  

Los frameworks de React como Next.js, Remix y Astro facilitan el renderizado en el servidor (o de partes de la aplicación).

Cuando usamos Next.js, podemos renderizar una página en el servidor utilizando el método `getServerSideProps`.

```javascript
import { Listings, ListingsSkeleton } from "../components";

export default function Home(props) {
  return <Listings listings={props.listings} />;
}

export async function getServerSideProps({ req, res }) {
  const res = await fetch("https://my.cms.com/listings");
  const listings = await res.json();

  return {
    props: { listings },
  };
}
```

```javascript
import * as React from 'react';
import { Listings } from '../components/Listings';

export default function App(props) {
  return <Listings listings={props.listings} />;
}

export const getServerSideProps = async () => {
  const res = await fetch('https://house-lydiahallie.vercel.app/api/listings');

  const { listings } = await res.json();

  return {
    props: { listings },
  };
};
```

Compensaciones
Rendimiento

TTFB: El TTFB puede ser lento, ya que la página aún debe generarse a demanda.
FCP: El First Contentful Paint puede ocurrir una vez que el HTML ha sido analizado y renderizado.
LCP: El Largest Contentful Paint puede ocurrir al mismo tiempo que el First Contentful Paint, siempre que no haya componentes grandes como imágenes o videos.
TTI: El Time To Interactive puede ocurrir una vez que el HTML ha sido renderizado y el paquete JavaScript ha sido descargado, analizado y ejecutado para vincular los manejadores de eventos a los componentes.

Páginas personalizadas: El renderizado en el servidor es útil para páginas que necesitan datos basados en la solicitud, como cookies de usuario.

Bloqueo de renderizado: El renderizado en el servidor puede bloquear la generación de páginas que dependen de autenticación.

Carga inicial: Dado que la página aún debe generarse cuando el usuario la solicita, puede tardar un tiempo antes de que el usuario vea algo en su pantalla. Para optimizar el SSR, puedes:

- Optimizar las consultas a la base de datos. Si la distancia entre tu servidor y la base de datos es larga, puede llevar tiempo establecer una conexión y recuperar datos. Considera mover tu base de datos o servidor más cerca entre sí.
- Agregar encabezados `Cache-Control` a tus respuestas.

Disponibilidad: Si tu servidor o región se cae, tu sitio web también dejará de estar disponible.

