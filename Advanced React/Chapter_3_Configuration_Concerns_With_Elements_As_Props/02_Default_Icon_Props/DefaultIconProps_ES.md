
# ✨ Valores por defecto para elementos pasados como props

> **Resumen rápido:**  
> Podemos mantener la **flexibilidad** de pasar elementos como props y, a la vez, dar **valores por defecto** controlados por el componente (p. ej., `Button`) usando `React.cloneElement` sin romper la API del elemento.

---

## ❗ Problema

En componentes como `Button`, pasar un `icon` como elemento brinda flexibilidad… quizá **demasiada**.  
Queremos control por defecto (colores, tamaños, estado “disabled”) sin obligar al consumidor a recordarlo siempre:

```jsx
<Button appearance="primary" icon={<Loading color="white" />} />
<Button appearance="secondary" icon={<Loading color="black" />} />
<Button appearance="large" icon={<Loading size="large" />} />
```

La mitad del tiempo se olvidará o se malentenderá. Necesitamos **valores por defecto** que el `Button` pueda aplicar sin perder la capacidad de que el consumidor los **sobre-escriba**.

---

## 📚 Concepto 1 — Clonar el elemento y fusionar props

Usa `React.cloneElement(icon, newProps)` para **inyectar props por defecto** y **respetar** las props originales del ícono.

```jsx
const Button = ({ appearance, size, icon }) => {
  // Assume `icon` is a valid React element (no checks needed)
  const defaultIconProps = {
    size: size === 'large' ? 'large' : 'medium',
    color: appearance === 'primary' ? 'white' : 'black',
  };

  // Defaults first, then consumer props → consumer overrides win
  const mergedProps = { ...defaultIconProps, ...icon.props };

  const clonedIcon = React.cloneElement(icon, mergedProps);

  return <button>Submit {clonedIcon}</button>;
};
```

<details>
<summary>🔍 <b>¿Cómo funciona?</b></summary>

- Paso 1: Define `defaultIconProps` a partir de `appearance`/`size` del `Button`.  
- Paso 2: **Fusiona**: primero defaults y luego `icon.props` (el orden permite que el consumidor sobre-escriba).  
- Paso 3: Clona con `cloneElement` y renderiza el ícono clonado.
</details>

---

## 🛠️ Concepto 2 — Por qué NO abusar de los valores por defecto

Si aplicas solo defaults y **no** fusionas con las props del ícono, **rompes su API**:

```jsx
const Button = ({ appearance, size, icon }) => {
  // Assume `icon` is a valid React element
  const defaultIconProps = {
    size: size === 'large' ? 'large' : 'medium',
    color: appearance === 'primary' ? 'white' : 'black',
  };

  // ❌ BAD: this ignores the icon's own props forever
  const clonedIcon = React.cloneElement(icon, defaultIconProps);

  return <button>Submit {clonedIcon}</button>;
};

// "red" won't work here because defaults overwrite user intent
<Button appearance="secondary" icon={<Loading color="red" />} /> 
```

> [!TIP]  
> **Regla de oro:** defaults primero, props del elemento después (`{ ...defaults, ...icon.props }`). Así el consumidor siempre puede anular el default.

---

## ✅ Buenas Prácticas

- ✅ Deriva los defaults desde el **estado/props** del padre (p. ej., `appearance`, `size`, `disabled`).  
- ✅ Deja que el **consumidor** tenga la última palabra al sobre-escribir.  
- 🚫 No “congeles” la API del ícono aplicando defaults sin fusionar.  

---

## 🚀 Ejemplo Completo

```jsx
const Loading = ({ color = 'black', size = 'medium' }) => {
  // Example-only: imagine SVG uses color/size
  return <span>{`Loading [color=${color}, size=${size}]`}</span>;
};

const Button = ({ appearance = 'secondary', size = 'medium', icon }) => {
  // Assume `icon` is a valid React element
  const defaultIconProps = {
    size: size === 'large' ? 'large' : 'medium',
    color: appearance === 'primary' ? 'white' : 'black',
  };

  const mergedProps = { ...defaultIconProps, ...icon.props };
  const clonedIcon = React.cloneElement(icon, mergedProps);

  return (
    <button aria-disabled={appearance === 'disabled'}>
      Submit {clonedIcon}
    </button>
  );
};

// Usage
<>
  <Button appearance="primary" icon={<Loading />} />
  <Button appearance="secondary" icon={<Loading />} />
  <Button appearance="large" icon={<Loading />} />
  {/* Consumer override still wins */}
  <Button appearance="secondary" icon={<Loading color="red" />} />
</>;
```

**Salida esperada (conceptual):**
```
Submit Loading [color=white, size=medium]
Submit Loading [color=black, size=medium]
Submit Loading [color=black, size=large]
Submit Loading [color=red, size=medium]
```

---

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto            |
|----------------------|--------------------------------------|
| _Sin palabras nuevas relevantes en esta sección._           |
