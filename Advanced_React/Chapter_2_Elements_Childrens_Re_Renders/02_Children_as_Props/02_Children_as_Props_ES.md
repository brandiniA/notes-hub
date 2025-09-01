# ✨ Children como Props

> **Resumen rápido:**  
> Usar `children` como prop es una forma poderosa e idiomática de componer componentes en React, haciendo tu código más flexible y legible.

---

## 📚 Concepto 1 — _¿Qué significa “children como prop”?_

En React, los props son solo un objeto pasado como primer argumento al componente. El prop `children` no es especial, solo es una convención.  
Puedes nombrarlo como quieras, pero `children` habilita la composición natural en JSX.

```jsx
// Antes: usando un prop 'child' personalizado
const Parent = ({ child }) => {
  return child;
};

// Después: usando el prop estándar 'children'
const Parent = ({ children }) => {
  return children;
};
```

<details>
<summary>🔍 **¿Cómo funciona?**</summary>

- Cualquier prop, incluido `children`, es solo una llave del objeto props.
- JSX reconoce `children` y habilita el anidamiento:  
  `<Parent><Child /></Parent>` es equivalente a `<Parent children={<Child />} />`
- Cambiar a `children` hace la composición natural y familiar.

</details>

---

## 🛠️ Concepto 2 — _Children explícito vs. JSX anidado_

Puedes pasar los children explícitamente o usando anidamiento JSX—ambos resultan en la misma estructura de objeto.

```jsx
// Pasando explícitamente como prop
<Parent children={<Child />} />

// Usando anidamiento JSX (más común)
<Parent>
  <Child />
</Parent>
```

**Ambos generan:**

```js
{
  type: Parent,
  props: {
    children: {
      type: Child,
      // ...otros datos internos de React
    }
  }
}
```

> [!TIP]  
> El anidamiento en JSX es solo azúcar sintáctico para establecer el prop `children` directamente.

---

## ⚡ Comparativa rápida

| Sintaxis                              | Cómo lo escribes                | Cómo lo interpreta React               |
|---------------------------------------|----------------------------------|----------------------------------------|
| Prop personalizada                    | `<Parent child={<Child/>} />`    | `{ props: { child: ... } }`            |
| Prop explícita `children`             | `<Parent children={<Child/>}/>`  | `{ props: { children: ... } }`         |
| Children anidados con JSX             | `<Parent><Child/></Parent>`      | `{ props: { children: ... } }`         |

---

## 🧠 Concepto 3 — _¿Por qué usar children? (composición y performance)_

Usar `children` hace que la composición de componentes sea natural y clara visualmente, parecido a HTML.

- Mejora la legibilidad y la estructura.
- Al pasar elementos como props (incluyendo `children`), mantienen su referencia de objeto. Esto significa que los re-renders en el padre **no** desencadenarán re-renders del hijo, a menos que el objeto del elemento cambie.
- Esto habilita patrones como wrappers de layout, slots y render props.

---

## 🚀 Ejemplo real: migrar de `content` a `children`

Supón que tenías este patrón:

```jsx
// Versión antigua: content como prop
const App = () => {
  const slowComponents = (
    <>
      <VerySlowComponent />
      <BunchOfStuff />
      <OtherStuffAlsoComplicated />
    </>
  );
  return (
    <ScrollableWithMovingBlock content={slowComponents} />
  );
};

// ...dentro del componente
const ScrollableWithMovingBlock = ({ content }) => {
  // ...resto del código
  return (
    <div>
      ...
      {content}
    </div>
  );
};
```

Con `children` (nueva versión):

```jsx
const App = () => {
  return (
    <ScrollableWithMovingBlock>
      <VerySlowComponent />
      <BunchOfStuff />
      <OtherStuffAlsoComplicated />
    </ScrollableWithMovingBlock>
  );
};

const ScrollableWithMovingBlock = ({ children }) => {
  // ...resto del código
  return (
    <div>
      ...
      {children}
    </div>
  );
};
```