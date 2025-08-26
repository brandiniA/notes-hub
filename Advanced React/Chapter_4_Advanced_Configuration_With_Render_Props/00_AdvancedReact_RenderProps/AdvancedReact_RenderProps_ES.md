# ✨ Render Props para Renderizar Elementos

> **Resumen rápido:**  
> Render props permiten que un componente padre **pase elementos y estado de forma explícita**, sin depender de `cloneElement` ni adivinar la API de props de un componente hijo.

---

## 📚 Concepto 1 — _El problema con clonar elementos_

`React.cloneElement` puede inyectar props por defecto (ej. size/color) en un elemento, pero falla cuando:
- Necesitas **compartir estado** con ese elemento.
- Cambias de **librería de íconos** y sus props son diferentes.

```jsx
// ❌ Elemento como prop + cloneElement (solo funciona bajo supuestos estrictos)
const Button = ({ appearance = 'secondary', size = 'medium', icon }) => {
  const defaultIconProps = {
    size: size === 'large' ? 'large' : 'medium',
    color: appearance === 'primary' ? 'white' : 'black',
  };

  const clonedIcon = React.cloneElement(icon, {
    ...defaultIconProps,
    ...icon.props,
  });

  return <button>Submit {clonedIcon}</button>;
};
```

Ahora intentamos agregar estado de hover — pero el ícono no puede “verlo”:

```jsx
// ❌ El estado hover existe pero está aislado del ícono
const Button = ({ icon }) => {
  const [isHovered, setIsHovered] = React.useState(false);

  return (
    <button
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      Submit {icon}
    </button>
  );
};
```

<details>
<summary>🔍 **Conclusiones clave**</summary>

- **Supuestos rígidos** sobre los props del hijo vuelven frágil al componente.
- **Aislamiento de estado**: los elementos pasados por valor no pueden consumir estado del padre.
- **Cambio de librerías** es inevitable; evita acoplar tu componente a una API específica.

</details>

---

## 🛠️ Concepto 2 — _Paso a paso con render props_

### 1. ¿Qué es un render prop?
Un render prop es simplemente una **función pasada como prop** que retorna un elemento de React. En lugar de darle al Button un elemento listo, le damos una función que sabe cómo renderizarlo.

```jsx
const Button = ({ renderIcon }) => {
  return <button>Submit {renderIcon()}</button>;
};

<Button renderIcon={() => <HomeIcon />} />
```

---

### 2. ¿Por qué es mejor?
En lugar de clonar y asumir que cada ícono acepta `size` y `color`, pasamos esos valores **directamente a la función render**. El consumidor decide cómo aplicarlos.

```jsx
const Button = ({ size, appearance, renderIcon }) => {
  const defaultIconProps = {
    size: size === 'large' ? 'large' : 'medium',
    color: appearance === 'primary' ? 'white' : 'black',
  };

  return <button>Submit {renderIcon(defaultIconProps)}</button>;
};
```

---

### 3. ¿Cómo podemos consumirlo?
```jsx
<Button renderIcon={(props) => <HomeIcon {...props} />} />
<Button renderIcon={(props) => <HomeIcon {...props} size="large" color="red" />} />
<Button renderIcon={(props) => <HomeIcon fontSize={props.size} style={{ color: props.color }} />} />
```

Aquí todo es explícito: no hay sobrescrituras ocultas, ni supuestos. El consumidor adapta los valores según necesite.

---

### 4. Compartir estado de forma sencilla
Ahora también podemos pasar el estado junto con los valores por defecto. Ejemplo, el estado hover:

```jsx
const Button = ({ size, appearance, renderIcon }) => {
  const [isHovered, setIsHovered] = React.useState(false);

  const defaultIconProps = {
    size: size === 'large' ? 'large' : 'medium',
    color: appearance === 'primary' ? 'white' : 'black',
  };

  return (
    <button
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      Submit {renderIcon(defaultIconProps, { isHovered })}
    </button>
  );
};
```

---

### 5. Consumidores con estado
```jsx
// Cambiar íconos cuando hay hover
<Button
  renderIcon={(props, state) =>
    state.isHovered ? <HomeIconHovered {...props} /> : <HomeIcon {...props} />
  }
/>

// Aplicar estilos al hacer hover
<Button
  renderIcon={(props, state) => (
    <HomeIcon {...props} className={state.isHovered ? 'hovered' : ''} />
  )}
/>

// Ignorar completamente el hover
<Button renderIcon={(props) => <HomeIcon {...props} />} />
```

---

## 🚀 Ejemplo Completo

```jsx
const Button = ({ size = 'medium', appearance = 'secondary', renderIcon }) => {
  const [isHovered, setIsHovered] = React.useState(false);

  const defaultIconProps = {
    size: size === 'large' ? 'large' : 'medium',
    color: appearance === 'primary' ? 'white' : 'black',
  };

  return (
    <button
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      Submit {renderIcon(defaultIconProps, { isHovered })}
    </button>
  );
};
```

**Salida esperada:**

- El ícono **hereda los valores por defecto** del Button (`size`, `color`).
- Los consumidores pueden **sobrescribir** o **traducir** esos valores.
- El estado del Button como hover ahora es **compartible y trazable**.

---

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto |
|----------------------|---------------------------|
| _No new words relevant in this section._ |
