# Patrón Render Props en React

## Descripción
El **Patrón Render Props** permite pasar elementos JSX a los componentes a través de props. Los componentes que reciben estas props pueden, a su vez, pasar datos a ellos, facilitando la reutilización de lógica en múltiples componentes.

## Temas Cubiertos
- ¿Qué es el Patrón Render Props?
- ¿Cómo funciona?
- Implementación en React
  - Ejemplo: Conversión de Temperatura
- Ventajas y Desventajas del Patrón Render Props

## ¿Qué es el Patrón Render Props?
Un **Render Prop** es una prop que se define como una función y que un componente usa para saber qué renderizar. Este patrón es útil para:
- **Reutilizar lógica** en varios componentes.
- **Separar responsabilidades**, manteniendo la lógica separada de la renderización.
- **Solucionar problemas de los Componentes de Orden Superior (HOC)** al pasar props explícitamente.

### ¿Por qué usar Render Props?
- **Flexibilidad**: Permite renderizar contenido dinámico basado en los datos pasados a un componente.
- **Flujo de datos explícito**: A diferencia de los HOC, todas las props son visibles en la lista de argumentos de la función de renderizado.

## Implementación en React

### Ejemplo: Conversión de Temperatura
Si queremos implementar un campo de entrada donde un usuario pueda convertir una temperatura de **Celsius** a **Kelvin** y **Fahrenheit**, podemos usar `renderKelvin` y `renderFahrenheit` como props de renderizado.

```javascript
import React, { useState } from "react";

function Input(props) {
  const [value, setValue] = useState("");

  return (
    <>
      <input value={value} onChange={(e) => setValue(e.target.value)} />
      {props.renderKelvin({ value: parseFloat(value) + 273.15 })}
      {props.renderFahrenheit({ value: (parseFloat(value) * 9) / 5 + 32 })}
    </>
  );
}

export default function App() {
  return (
    <Input
      renderKelvin={({ value }) => <div className="temp">{value}K</div>}
      renderFahrenheit={({ value }) => <div className="temp">{value}°F</div>}
    />
  );
}
```

## Ventajas y Desventajas del Patrón Render Props

### Ventajas
1. **Reutilización de Código**:  
   - Los componentes que usan render props pueden reutilizarse en múltiples casos de uso.

2. **Separación de Responsabilidades**:  
   - El componente principal maneja la lógica, mientras que las props de renderizado se encargan de la visualización.

3. **Solución a Problemas de HOC**:  
   - Al pasar props de forma explícita, no se inyectan implícitamente como en los HOC.
   - Todas las props que se pasan son visibles en la lista de argumentos de la función de renderizado, facilitando la depuración.

### Desventajas
1. **Innecesario con Hooks**:  
   - Los Hooks han cambiado la forma en la que agregamos reutilización y compartición de datos en los componentes, reemplazando en muchos casos la necesidad de Render Props.

## Conclusión
El Patrón Render Props proporciona una forma flexible de reutilizar lógica y separar responsabilidades en aplicaciones React. Sin embargo, con la introducción de Hooks, muchos casos de uso de render props ahora pueden manejarse de manera más eficiente con hooks personalizados.

