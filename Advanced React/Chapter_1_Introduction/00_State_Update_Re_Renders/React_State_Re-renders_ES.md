
# ✨ React — Actualizaciones de estado y re-renderizados

> **Resumen rápido:**  
> Entender cómo las actualizaciones de estado provocan re-renderizados es clave para escribir aplicaciones React eficientes e interactivas.

---

## 📚 Concepto 1 — _Ciclo de vida del componente: Montaje, actualización, desmontaje_

Un componente de React puede:
- **Montarse:** Crearse por primera vez y renderizarse en pantalla.
- **Actualizarse (re-renderizarse):** Refrescarse con nuevos datos (normalmente tras un cambio de estado o props).
- **Desmontarse:** Destruirse y eliminarse del DOM.

```jsx
function Example() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(count + 1)}>Click {count}</button>;
}
```

<details>
<summary>🔍 **¿Cómo funciona?**</summary>

- Al montar: `count` inicia en 0.
- Al hacer click: `setCount` provoca un re-renderizado.
- Al desmontar: React limpia el componente.
</details>

---

## 🛠️ Concepto 2 — _Cómo el estado provoca re-renderizados en el árbol de componentes_

Cada actualización de estado en React provoca que el **componente propietario** y todos sus hijos se re-rendericen, incluso aquellos hijos que no usan ese estado.  
React **nunca re-renderiza hacia arriba** en el árbol, solo “hacia abajo” desde el punto donde se actualizó el estado.

### Actualización de estado en el nivel superior (afecta a todos los hijos)

```
           [App]*  ← aquí cambia el estado
          /    |     \
   [Dialog]* [VerySlowComponent]* [OtherComponent]*
     /    \
 [Form]* [ExtraOptions]*
```
- **Todos los componentes debajo de `[App]` se re-renderizan (marcados con `*`).**

---

```jsx
function App() {
  const [visible, setVisible] = useState(false);
  return (
    <div>
      <button onClick={() => setVisible((v) => !v)}>
        {visible ? "Ocultar" : "Mostrar"} Dialog
      </button>
      {visible && <Dialog />}
      <VerySlowComponent />
      <OtherComponent />
    </div>
  );
}
```

- En este ejemplo, **al actualizar `visible` en `App` _todos_ los hijos (`Dialog`, `VerySlowComponent`, `OtherComponent`) se re-renderizan**, aunque solo `Dialog` use ese estado.

---

### Actualización de estado en un componente intermedio (solo su subárbol se actualiza)

```
           [App]
          /    |     \
   [Dialog]* [VerySlowComponent] [OtherComponent]
     /    \
 [Form]* [ExtraOptions]*
   ↑
¡aquí cambia el estado!
```
- **Solo `[Dialog]` y sus hijos se re-renderizan (marcados con `*`).**
- Los hermanos y el padre no se ven afectados.

---

> [!TIP]  
> **Solo los componentes por debajo de donde cambia el estado se re-renderizan.** Los de arriba permanecen igual.

---

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto            |
|----------------------|--------------------------------------|
| _Sin palabras nuevas relevantes en esta sección._           |

---
