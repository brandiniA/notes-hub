# ✨ React — Moviendo el estado hacia abajo

> **Resumen rápido:**  
> Mover el estado hacia abajo en el árbol de componentes evita re-renderizados innecesarios y mantiene tu app rápida y predecible.

---

## 📚 Concepto 1 — _Re-renderizados innecesarios por estado en la parte alta_

Cuando el estado vive alto en el árbol de componentes, **cada actualización de estado hace que todos los descendientes se re-rendericen**, incluso si la mayoría no necesita ese valor.  
Esto puede volver tu UI mucho más lenta.

```jsx
const App = () => {
  // aquí se declara el estado
  const [isOpen, setIsOpen] = useState(false);
  return (
    <div className="layout">
      {/* el estado se usa aquí */}
      <Button onClick={() => setIsOpen(true)}>
        Open dialog
      </Button>
      {/* el estado se usa aquí */}
      {isOpen ? (
        <ModalDialog onClose={() => setIsOpen(false)} />
      ) : null}
      <VerySlowComponent />
      <BunchOfStuff />
      <OtherStuffAlsoComplicated />
    </div>
  );
};
```

<details>
<summary>🔍 **¿Cómo funciona?**</summary>

- El estado `isOpen` solo se usa en `<Button>` y `<ModalDialog>`.
- Todos los demás componentes se re-renderizan cada vez que cambia `isOpen`, **aunque no les importe ese estado**.
- Esto lleva a re-renderizados innecesarios.
</details>

---

## 🛠️ Concepto 2 — _Extraer la lógica con estado a un componente más pequeño_

La mejor manera: **mueve el estado hacia abajo** al componente más pequeño que realmente lo necesita.  
Esto aísla los re-renderizados y mantiene el resto de la app rápido.

```jsx
const ButtonWithModalDialog = () => {
  const [isOpen, setIsOpen] = useState(false);
  // aquí solo renderiza Button y ModalDialog
  return (
    <>
      <Button onClick={() => setIsOpen(true)}>
        Open dialog
      </Button>
      {isOpen ? (
        <ModalDialog onClose={() => setIsOpen(false)} />
      ) : null}
    </>
  );
};
```

Y en tu componente principal:

```jsx
const App = () => {
  return (
    <div className="layout">
      {/* aquí va el componente con el estado dentro */}
      <ButtonWithModalDialog />
      <VerySlowComponent />
      <BunchOfStuff />
      <OtherStuffAlsoComplicated />
    </div>
  );
};
```

---

### **Diagrama — Antes y después de mover el estado hacia abajo**

#### Antes (Estado arriba, todos los hijos se re-renderizan):

```
        [Actualización de estado]
          /          [Button/Modal]*   [Componentes lentos]*
        /      [Otros...]* [Más...]*

* = re-renderizados innecesarios
```

#### Después (Estado abajo, solo el subárbol relevante se re-renderiza):

```
        [App]
         /   |    [ButtonWithModalDialog]* [Componentes lentos] [Otros...]

  (El estado está aquí)
```
- Ahora solo `ButtonWithModalDialog` y sus hijos se re-renderizan cuando cambia el estado del diálogo.
- “Componentes lentos” y otras partes de la app no se ven afectados.

---

> [!TIP]  
> Mover el estado cerca de donde se usa suele ser **mejor que depender de React.memo**. Es más simple y tiene menos caveats.

---

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto            |
|----------------------|--------------------------------------|
| _Sin palabras nuevas relevantes en esta sección._           |

---
