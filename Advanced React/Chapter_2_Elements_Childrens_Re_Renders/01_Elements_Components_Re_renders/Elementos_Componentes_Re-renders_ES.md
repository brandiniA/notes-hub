# ✨ Elementos, Componentes y re-renderización

> **Resumen rápido:**  
> Entender cómo funcionan los elementos y componentes en React—y cuándo/por qué se re-renderizan—es clave para crear apps eficientes y mantenibles.

---

## 📚 Concepto 1 — _¿Qué es un componente en React?_

Un **componente** es simplemente una función que retorna elementos (JSX). Lo especial es que React interpreta su retorno y genera la interfaz a partir de ello.

```jsx
// Componente funcional mínimo
const Parent = () => {
  return <Child />;
};
```

<details>
<summary>🔍 **¿Cómo funciona?**</summary>

- Un componente es una función que retorna **elementos** de React (JSX o usando `React.createElement`).
- Si recibe **props**, son el primer argumento.
- El JSX retornado se convierte en objetos que React usará para crear nodos DOM reales.

</details>

---

## 🛠️ Concepto 2 — _¿Qué es un elemento de React?_

Un **elemento de React** es un objeto simple que describe lo que debe verse en la UI. Puede representar una etiqueta del DOM o un componente.

### Ejemplo 1: Retornando un Componente

```jsx
// Retorna un componente Child
const Parent = () => {
  return <Child />;
};
```

**Objeto Elemento:**

```js
{
  type: Child,
  props: {},
  // ...otros datos internos de React
}
```

---

### Ejemplo 2: Retornando un Elemento del DOM

```jsx
// Retorna un elemento <h1>
const Child = () => {
  return <h1>Child</h1>;
};
```

**Objeto Elemento:**

```js
{
  type: 'h1',
  props: { children: 'Child' },
  // ...otros datos internos de React
}
```

---

**Tabla Comparativa Rápida**

| Devuelve el ejemplo   | `type`     | `props`                    | Uso típico    |
|----------------------|------------|----------------------------|--------------|
| `<Child />`          | `Child`    | `{}`                       | Componente   |
| `<h1>Child</h1>`     | `'h1'`     | `{ children: 'Child' }`    | Elemento DOM |

> [!TIP]  
> La única diferencia es el `type`: string para elementos DOM, función para componentes. Todo lo demás lo gestiona React internamente.

---

## 🧠 Concepto 3 — _¿Cómo funcionan los re-renders (y cuándo ocurren)?_

Cada vez que el estado o las props de un componente cambian, React ejecuta de nuevo su función (re-render). Construye un **árbol virtual** de todos los elementos antes y después, y los compara ("diffing") para decidir qué cambia en el DOM real.

```jsx
const Parent = () => {
  const [state, setState] = React.useState(0);
  return <Child />;
};
```

React compara los objetos elemento *anteriores* y *nuevos* de cada componente:

- **Si las referencias de objeto son iguales** (`Object.is` retorna `true`):  
  React omite la actualización de este componente y su subárbol.
- **Si las referencias son diferentes** (`Object.is` retorna `false`):  
  React revisa la propiedad `type`:
  - **Si `type` es igual**: React actualizará (re-renderizará) el componente, posiblemente actualizando props o hijos.
  - **Si `type` es diferente**:  
    React **elimina** (desmonta) el componente anterior y **monta** el nuevo—perdiendo cualquier estado local en el proceso.

**Tabla de decisión:**

| Comparación              | ¿Qué hace React?                               |
|-------------------------|------------------------------------------------|
| Referencia igual        | Omite (no actualiza DOM ni subárbol)           |
| Referencia diferente    | → Revisa type:                                 |
| &nbsp;&nbsp;Type igual  | Actualiza/re-renderiza el componente           |
| &nbsp;&nbsp;Type difiere| Desmonta viejo, monta nuevo (reemplaza subárbol)|

---

## 🔀 Pasar elementos como props (y por qué importa)

Si pasas un elemento como **prop**—en vez de crearlo inline—mantienes la misma referencia de objeto entre renders, así React puede evitar re-renderizaciones innecesarias:

```jsx
const Parent = ({ child }) => {
  const [state, setState] = React.useState();
  return child;
};

// Uso:
<Parent child={<Child />} />
```

- Aquí, `<Child />` se crea **fuera** del render de Parent, por lo que React lo considera "el mismo" objeto siempre.

---

## 🚀 Ejemplo Completo

```jsx
const SlowComponent = React.memo(() => {
  // Simula render costoso
  return <div>Muy lento...</div>;
});

const ParentInline = () => {
  const [count, setCount] = React.useState(0);
  return (
    <div>
      <button onClick={() => setCount((c) => c + 1)}>Inc</button>
      <Child />
      <SlowComponent />
    </div>
  );
};

const ParentWithProp = ({ child }) => {
  const [count, setCount] = React.useState(0);
  return (
    <div>
      <button onClick={() => setCount((c) => c + 1)}>Inc</button>
      {child}
      <SlowComponent />
    </div>
  );
};

// Uso con prop:
<ParentWithProp child={<Child />} />
```

**Visualización de qué se re-renderiza:**

| Escenario                 | ¿Cambia estado en Parent? | ¿Child se re-renderiza? | ¿SlowComponent se re-renderiza? |
|---------------------------|:------------------------:|:----------------------:|:-------------------------------:|
| **Child creado inline**   |           Sí             |         Sí             |             Sí\*                |
| **Child pasado como prop**|           Sí             |         No             |             Sí\*                |

> \* Si `SlowComponent` está envuelto en `React.memo`, solo se re-renderiza si cambian sus props.

---

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto                       |
|----------------------|------------------------------------------------|
| Element              | Objeto que representa lo que React debe renderizar.|
| Component            | Función que retorna elementos (piezas de UI).  |
| JSX                  | Azúcar sintáctico para `React.createElement`.  |
| Props                | Datos que reciben los componentes como argumento|
| Fiber Tree           | Representación interna de la UI en React.      |
| Diffing              | Comparación de árboles para determinar cambios.|
| Reconciliation       | Proceso de actualizar el DOM eficientemente.   |
| Immutable            | No se puede modificar después de crearse.      |
| Reference            | Identidad de un objeto en memoria.             |

---

## ❓ Preguntas / Dudas

- ¿Cuándo conviene más memoizar un componente o pasarlo como prop para optimizar?
- ¿Este comportamiento cambia en React 19+ o con Server Components?