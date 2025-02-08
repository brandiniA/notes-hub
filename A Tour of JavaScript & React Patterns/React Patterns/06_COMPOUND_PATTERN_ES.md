# Patrón Compound en React

## Descripción
El **Patrón Compound** permite que múltiples componentes trabajen juntos para realizar una única tarea. Este patrón es especialmente útil cuando se combina con el **Patrón Provider** para gestionar el estado de manera eficiente.

### Beneficios Clave:
- **Encapsulación de lógica**: El componente padre gestiona el estado, mientras que los componentes hijos lo consumen.
- **Mejor reutilización**: Los componentes hijos pueden estructurarse de manera flexible.
- **API más limpia**: No es necesario pasar múltiples props entre componentes anidados.

## Ejemplo: Input de Búsqueda con Desplegable (FlyOut)
Imaginemos un **campo de búsqueda** donde al hacer clic en el input se muestra un **desplegable** con ubicaciones populares.

Podemos implementar esto utilizando un **componente compuesto FlyOut**.

```javascript
import React from "react";
import { FlyOut } from "./FlyOut";

export default function SearchInput() {
  return (
    <FlyOut>
      <FlyOut.Input placeholder="Ingresa una dirección, ciudad o código postal" />
      <FlyOut.List>
        <FlyOut.ListItem value="San Francisco, CA">San Francisco, CA</FlyOut.ListItem>
        <FlyOut.ListItem value="Seattle, WA">Seattle, WA</FlyOut.ListItem>
        <FlyOut.ListItem value="Austin, TX">Austin, TX</FlyOut.ListItem>
      </FlyOut.List>
    </FlyOut>
  );
}
```

Aquí, `FlyOut` gestiona el estado, mientras que sus subcomponentes lo consumen y lo modifican.

## Implementación
Existen dos maneras de implementar el **Patrón Compound** en React:

### 1. Usando el **Patrón Provider** (Context API)
En este enfoque, se utiliza un **Contexto** para gestionar y compartir el estado.

#### **Paso 1: Crear el Contexto y el Proveedor**
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

#### **Paso 2: Crear los Componentes Hijos**
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

En este patrón, `FlyOut` actúa como el **componente con estado**, mientras que `FlyOut.Input`, `FlyOut.List` y `FlyOut.ListItem` consumen ese estado.

---

### 2. Usando `React.Children.map` y `React.cloneElement`
Una alternativa al uso del Context API es aprovechar `React.Children.map` y `React.cloneElement`. Esto permite que el componente padre pase props dinámicamente a sus hijos.

#### **Paso 1: Implementar el Componente Padre**
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

#### **Paso 2: Implementar los Componentes Hijos**
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

Con este enfoque, `FlyOut` clona sus hijos e inyecta estado y manejadores de eventos como props.

## Ventajas y Desventajas

### **Ventajas**
1. **Gestión de Estado**: Los componentes compuestos administran su estado interno y lo comparten entre los hijos, reduciendo la necesidad de pasar props manualmente.
2. **Importación Única**: Solo se necesita importar el componente padre, sin necesidad de importar explícitamente los subcomponentes.

### **Desventajas**
1. **Limitaciones con Componentes Anidados**: Cuando se usa `React.Children.map`, solo los hijos directos de `FlyOut` reciben props. Si envolvemos un componente dentro de otro elemento, no recibirá `open` ni `toggle`.

   ```javascript
   function FlyoutMenu() {
     return (
       <FlyOut>
         {/* Esto rompe la funcionalidad, ya que el hijo directo ahora es un div */}
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

2. **Colisiones de Nombres**: `React.cloneElement` realiza un **merge superficial** de las props. Si un prop como `open` o `toggle` ya existe en un hijo, podría ser **sobrescrito**, causando un comportamiento inesperado.

## Conclusión
El **Patrón Compound** es una forma poderosa de estructurar componentes reutilizables con estado en React. Funciona bien con el **Patrón Provider** y ofrece una API más limpia, evitando el **prop drilling**. Sin embargo, es importante tener en cuenta las **colisiones de nombres** y las **limitaciones con componentes anidados**.