# Patrón de Hooks en React

## Descripción
El **Patrón de Hooks** permite reutilizar lógica con estado en múltiples componentes dentro de una aplicación React. Los Hooks son funciones especiales en React que ayudan a gestionar el estado y los métodos del ciclo de vida en componentes funcionales.

## Temas Cubiertos
- ¿Qué son los Hooks?
- ¿Cómo funcionan?
- Implementación en React
  - Creación de un Hook `useHover`
  - Uso de Hooks para obtener datos
- Ventajas y desventajas del Patrón de Hooks

## ¿Qué son los Hooks?
Los Hooks proporcionan una forma de:
- Agregar **estado** a los componentes funcionales.
- **Reutilizar lógica con estado** en varios componentes.
- **Gestionar el ciclo de vida de los componentes** sin necesidad de componentes de clase.

Además de los Hooks incorporados como `useState`, `useEffect` y `useReducer`, podemos crear **Hooks personalizados** para compartir lógica con estado en diferentes componentes.

## Implementación en React

### Ejemplo: Creación de un Hook `useHover`
Si queremos detectar si un componente está siendo **hovered**, podemos crear un Hook personalizado `useHover`.

#### **Antes: Sin un Hook**
```javascript
function Listing() {
  const [isHovering, setIsHovering] = React.useState(false);
  const ref = React.useRef(null);

  const handleMouseOver = () => setIsHovering(true);
  const handleMouseOut = () => setIsHovering(false);

  React.useEffect(() => {
    const node = ref.current;
    if (node) {
      node.addEventListener('mouseover', handleMouseOver);
      node.addEventListener('mouseout', handleMouseOut);
      return () => {
        node.removeEventListener('mouseover', handleMouseOver);
        node.removeEventListener('mouseout', handleMouseOut);
      };
    }
  }, [ref.current]);

  return <div ref={ref}>...</div>;
}
```

#### **Después: Usando un Hook**
##### `useHover.tsx`
```javascript
export function useHover() {
  const [isHovering, setIsHovering] = React.useState(false);
  const ref = React.useRef(null);

  const handleMouseOver = () => setIsHovering(true);
  const handleMouseOut = () => setIsHovering(false);

  React.useEffect(() => {
    const node = ref.current;
    if (node) {
      node.addEventListener('mouseover', handleMouseOver);
      node.addEventListener('mouseout', handleMouseOut);
      return () => {
        node.removeEventListener('mouseover', handleMouseOver);
        node.removeEventListener('mouseout', handleMouseOut);
      };
    }
  }, [ref.current]);

  return [ref, isHovering];
}
```

##### **Uso en Componentes**
```javascript
function Listing() {
  const [ref, isHovering] = useHover();
  return <div ref={ref}>...</div>;
}

function Image() {
  const [ref, isHovering] = useHover();
  return <img ref={ref} ... />;
}

function Button() {
  const [ref, isHovering] = useHover();
  return <button ref={ref} ... ></button>;
}
```

Al extraer la lógica de hover en un Hook, podemos reutilizarla en varios componentes sin duplicar código.

---

### Ejemplo: Uso de Hooks para Obtener Datos
Los Hooks eliminan la necesidad de **Componentes Contenedores**, ya que podemos obtener datos directamente en componentes funcionales.

#### **Antes: Usando un Componente Contenedor**
##### `ListingsContainer.tsx`
```javascript
class ListingsContainer extends React.Component {
  constructor() {
    super();
    this.state = {
      listings: [],
    };
  }

  componentDidMount() {
    fetch("https://my.cms.com/listings")
      .then((res) => res.json())
      .then(({ listings }) => this.setState({ listings }));
  }

  render() {
    return <Listings listings={this.state.listings} />;
  }
}
```

##### `Listings.tsx`
```javascript
function Listings({ listings }) {
  return (
    <ListingsLayout>
      {listings.map((listing) => (
        <Listing listing={listing} />
      ))}
    </ListingsLayout>
  );
}
```

#### **Después: Usando un Hook**
##### `useListings.tsx`
```javascript
export default function useListings() {
  const [listings, setListings] = useState([]);

  useEffect(() => {
    fetch("https://my.cms.com/listings")
      .then((res) => res.json())
      .then(({ listings }) => setListings(listings));
  }, []);

  return listings;
}
```

##### **Uso en Componente Funcional**
```javascript
import useListings from "./hooks/useListings";

export default function Listings() {
  const listings = useListings();

  return (
    <ListingsLayout>
      {listings.map((listing) => (
        <Listing listing={listing} />
      ))}
    </ListingsLayout>
  );
}
```

## Ventajas y Desventajas del Patrón de Hooks

### Ventajas
1. **Simplifica Componentes**:  
   - Los Hooks permiten agregar estado a componentes funcionales, eliminando la necesidad de componentes de clase.

2. **Reutilización de Lógica con Estado**:  
   - Los Hooks reducen la duplicación de código y los errores al permitir lógica reutilizable en múltiples componentes.

3. **Compartir Lógica No-Visual**:  
   - Los Hooks permiten reutilizar lógica sin depender de patrones como HOC o Render Props.

4. **Alternativa a Patrones Antiguos de React**:  
   - Los Hooks reemplazan patrones como el **Patrón Presentacional/Contenedor**, común en componentes de clase.

### Desventajas
1. **Reglas de los Hooks**:  
   - Se deben seguir reglas estrictas, como llamar Hooks solo en el **nivel superior** y solo dentro de **componentes funcionales de React o en otros Hooks**.
   - Sin un plugin de linter, es difícil detectar violaciones a estas reglas.

## Conclusión
El Patrón de Hooks en React proporciona una forma poderosa de **reutilizar lógica con estado**, simplificar componentes y reemplazar patrones de diseño antiguos. Al aprovechar Hooks personalizados, podemos mantener nuestros componentes más limpios, modulares y mantenibles.

