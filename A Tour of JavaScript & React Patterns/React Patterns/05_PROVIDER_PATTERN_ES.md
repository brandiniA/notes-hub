# Patrón Provider en React

## Descripción
El **Patrón Provider** aprovecha la API de Contexto de React para compartir datos fácilmente entre múltiples componentes dentro de una aplicación.

### Beneficios Clave:
- Evita el **prop drilling** al hacer que los datos sean accesibles globalmente.
- Mejora la **escalabilidad** y el **rendimiento** al reducir re-renderizados innecesarios.
- Facilita la **gestión del estado** centralizando los datos del contexto.

## Problema del Prop Drilling
Antes de la API de Contexto de React, compartir datos entre múltiples componentes resultaba en **prop drilling**, donde las props debían pasarse manualmente a través de múltiples niveles de la jerarquía de componentes. Este enfoque:
- **Aumenta la complejidad** a medida que la aplicación crece.
- **Disminuye la flexibilidad**, dificultando renombrar o reestructurar componentes.
- **Impacta el rendimiento**, ya que todos los componentes hijos se vuelven a renderizar incluso si no consumen los datos.

![alt text](image-1.png)

El **Patrón Provider** soluciona esto al exponer valores de contexto a nivel global para los componentes que optan por consumir los datos.

## Implementación
Un **Provider** es un **Componente de Orden Superior (HOC)** creado mediante `React.createContext`.

### Paso 1: Crear un Contexto
```javascript
export const ThemeContext = React.createContext(null);
```

### Paso 2: Implementar el Componente Provider
```javascript
export function ThemeProvider({ children }) {
  const [theme, setTheme] = React.useState("light");

  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}
```

Ahora, cualquier componente envuelto en `ThemeProvider` puede acceder a `theme` y `setTheme`.

### Paso 3: Consumir el Contexto usando `<ThemeContext.Consumer>`
```javascript
import { ThemeProvider, ThemeContext } from "../context";

const LandingPage = () => (
  <ThemeProvider>
    <TopNav />
    <Main />
  </ThemeProvider>
);

const TopNav = () => (
  <ThemeContext.Consumer>
    {({ theme }) => (
      <div style={{ backgroundColor: theme === "light" ? "#fff" : "#000" }}>
        ...
      </div>
    )}
  </ThemeContext.Consumer>
);

const Toggle = () => (
  <ThemeContext.Consumer>
    {({ theme, setTheme }) => (
      <button
        onClick={() => setTheme(theme === "light" ? "dark" : "light")}
        style={{
          backgroundColor: theme === "light" ? "#fff" : "#000",
          color: theme === "light" ? "#000" : "#fff",
        }}
      >
        Usar {theme === "light" ? "Modo Oscuro" : "Modo Claro"}
      </button>
    )}
  </ThemeContext.Consumer>
);
```

## Alternativa: Usando el Hook `useContext`
En lugar de envolver los componentes con `<ThemeContext.Consumer>`, podemos usar el hook `useContext` para mejorar la legibilidad y rendimiento.

### Paso 1: Modificar el Provider
```javascript
export function useThemeContext() {
  return React.useContext(ThemeContext);
}

export function ThemeProvider({ children }) {
  const [theme, setTheme] = React.useState("light");

  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}
```

### Paso 2: Consumir el Contexto con `useThemeContext`
```javascript
import { useThemeContext } from "../context";

const TopNav = () => {
  const { theme } = useThemeContext();
  return (
    <div style={{ backgroundColor: theme === "light" ? "#fff" : "#000" }}>
      ...
    </div>
  );
};

const Toggle = () => {
  const { theme, setTheme } = useThemeContext();
  return (
    <button
      onClick={() => setTheme(theme === "light" ? "dark" : "light")}
      style={{
        backgroundColor: theme === "light" ? "#fff" : "#000",
        color: theme === "light" ? "#000" : "#fff",
      }}
    >
      Usar {theme === "light" ? "Modo Oscuro" : "Modo Claro"}
    </button>
  );
};
```

El uso del hook `useContext` hace que el código sea más limpio y fácil de mantener.

## Ventajas y Desventajas

### Ventajas
1. **Escalabilidad**:  
   - **Evita el prop drilling**, facilitando la gestión del estado a medida que crece la aplicación.
   - **Facilita la refactorización**, ya que renombrar valores o reestructurar componentes es sencillo.

2. **Rendimiento**:  
   - **Solo los componentes necesarios se re-renderizan** cuando cambia el estado.
   - **Evita renders innecesarios** en componentes que no consumen el contexto.

### Desventajas
1. **Consideraciones de Rendimiento**:  
   - **Todos los componentes que usan el contexto se re-renderizan** cuando cambia el valor, lo que puede afectar el rendimiento si no se optimiza.
   - **Usar técnicas de memoización como `useMemo` o `React.memo`** para evitar renders innecesarios.

## Conclusión
El **Patrón Provider** es una forma escalable de compartir datos en múltiples componentes, mejorando el mantenimiento y evitando el **prop drilling**. Al combinarlo con **React Hooks (`useContext`)**, podemos mejorar el rendimiento y simplificar la gestión del estado.

