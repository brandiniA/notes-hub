# Patrón Container/Presentational en React

## Introducción
Este README contiene notas sobre el **Patrón Container/Presentational** en React. Este patrón impone la separación de responsabilidades al distinguir entre componentes encargados de obtener datos y componentes responsables de presentarlos.

## Temas Cubiertos
- ¿Qué es el Patrón Container/Presentational?
- ¿Cómo funciona?
- Implementación en React
  - Uso de componentes funcionales
  - Enfoque alternativo con hooks
- Ventajas y desventajas del Patrón Container/Presentational

## ¿Qué es el Patrón Container/Presentational?
Este patrón separa los componentes en:
1. **Componente Contenedor (Container Component)**: Responsable de obtener y gestionar datos. No contiene estilos ni elementos de UI.
2. **Componente de Presentación (Presentational Component)**: Responsable de renderizar la UI. Recibe los datos como props y se enfoca únicamente en la forma en que se muestran.

### ¿Por qué usar el Patrón Container/Presentational?
- Refuerza la **separación de responsabilidades**.
- Hace los componentes más **reutilizables**.
- Mejora la **flexibilidad**, permitiendo que los diseñadores modifiquen los componentes de UI sin afectar la lógica.
- Simplifica **las pruebas**, ya que los componentes de presentación son funciones puras.

## Implementación en React

### Ejemplo: Uso de Componentes Funcionales
```javascript
import React from "react";
import { LoadingListings, Listing, ListingsGrid } from "../components";

function ListingsContainerComponent() {
  const [listings, setListings] = React.useState([]);

  React.useEffect(() => {
    fetch("https://my.cms.com/listings")
      .then((res) => res.json())
      .then((res) => setListings(res.listings));
  }, []);

  return <ListingsPresentationalComponent listings={listings} />;
}

function ListingsPresentationalComponent({ listings }) {
  if (listings.length === 0) {
    return <LoadingListings />;
  }

  return (
    <ListingsGrid>
      {listings.map((listing) => (
        <Listing key={listing.id} listing={listing} />
      ))}
    </ListingsGrid>
  );
}
```

### Enfoque Alternativo: Uso de Hooks para Obtener Datos
Con React Hooks, el Patrón Container/Presentational a menudo no es necesario. Los hooks permiten obtener datos y renderizar componentes condicionalmente dentro del mismo componente funcional.

```javascript
import React from "react";
import useSWR from "swr";
import { LoadingListings, Listing, ListingsGrid } from "../components";

function Listings() {
  const {
    data: listings,
    error,
  } = useSWR("https://my.cms.com/listings", (url) =>
    fetch(url).then((r) => r.json())
  );

  if (!listings) {
    return <LoadingListings />;
  }

  return (
    <ListingsGrid>
      {listings.map((listing) => (
        <Listing key={listing.id} listing={listing} />
      ))}
    </ListingsGrid>
  );
}
```

## Ventajas y Desventajas del Patrón Container/Presentational

### Ventajas
1. **Separación de Responsabilidades**:  
   - Los componentes de presentación manejan la UI, mientras que los componentes contenedores administran el estado y la obtención de datos.

2. **Reutilización**:  
   - Los componentes de presentación pueden reutilizarse en diferentes partes de la aplicación con distintas fuentes de datos.

3. **Flexibilidad**:  
   - Como los componentes de presentación no modifican la lógica de la aplicación, los diseñadores pueden actualizar los estilos sin afectar la funcionalidad.

4. **Facilidad de Pruebas**:  
   - Los componentes de presentación suelen ser funciones puras, lo que los hace predecibles y fáciles de probar.

### Desventajas
1. **No es Necesario con Hooks**:  
   - Hooks como `useSWR`, `useQuery` o `useState` permiten gestionar la obtención de datos dentro de componentes funcionales sin necesidad de componentes contenedores separados.

2. **Excesivo en Aplicaciones Pequeñas**:  
   - Implementar este patrón en una aplicación pequeña puede añadir complejidad innecesaria.

## Conclusión
El Patrón Container/Presentational proporciona una forma estructurada de separar responsabilidades en aplicaciones React, haciendo que los componentes sean más reutilizables, mantenibles y fáciles de probar. Sin embargo, con la llegada de los Hooks en React, este patrón es menos necesario, ya que los hooks permiten obtener y gestionar el estado dentro de componentes funcionales sin requerir una separación explícita.