# ✨ React — El peligro de los custom hooks

> **Resumen rápido:**  
> Los custom hooks ayudan a reutilizar lógica con estado, pero esconder el estado dentro de ellos puede provocar re-renderizados inesperados y difíciles de depurar.

---

## 📚 Concepto 1 — _Los custom hooks encapsulan el estado, pero no lo eliminan_

Un custom hook puede ocultar el estado, pero el estado sigue viviendo en el componente que usa el hook.  
Cada actualización de estado dentro de un custom hook **sigue provocando un re-render** del componente que lo usa.

```jsx
const useModalDialog = () => {
  const [isOpen, setIsOpen] = useState(false);
  return {
    isOpen,
    open: () => setIsOpen(true),
    close: () => setIsOpen(false),
  };
};
```

<details>
<summary>🔍 **¿Cómo funciona?**</summary>

- El estado está abstraído, pero sigue existiendo.
- Cualquier actualización (como `open` o `close`) **siempre provoca el re-render del componente padre**.
- Esto puede dificultar la detección de cuellos de botella de performance.
</details>

---

## 🛠️ Concepto 2 — _Los updates de estado dentro de hooks, aunque no se retornen, provocan re-renderizados_

Si tu custom hook (o uno que usa) maneja estado o side effects—aunque **no lo devuelvas**—el **componente padre se re-renderiza** cada vez que ese estado cambia.

```jsx
const useModalDialog = () => {
  const [width, setWidth] = useState(0);
  useEffect(() => {
    const listener = () => setWidth(window.innerWidth);
    window.addEventListener('resize', listener);
    return () => window.removeEventListener('resize', listener);
  }, []);
  // el return es el mismo de antes
  return ...;
};
```
- **Aunque no uses ni devuelvas `width`, cualquier actualización provoca un re-render.**

---

Si mueves ese estado a un custom hook más profundo, **el efecto es el mismo**:

```jsx
const useResizeDetector = () => {
  const [width, setWidth] = useState(0);
  useEffect(() => {
    const listener = () => setWidth(window.innerWidth);
    window.addEventListener('resize', listener);
    return () => window.removeEventListener('resize', listener);
  }, []);
  return null;
};

const useModalDialog = () => {
  // solo llámalo, no uses su return
  useResizeDetector();
  // el return es igual al de antes
  return ...;
};
```

Y luego, en tu App:

```jsx
// Este hook usa useResizeDetector debajo, que provoca updates de estado en cada resize
// ¡Toda la App se re-renderiza en cada resize!
const { isOpen, open, close } = useModalDialog();
return ...; // mismo return
```

---

## 🚀 Solución — _Extrae hooks y estado a un subcomponente_

La solución: **mueve tu lógica con estado y llamadas a hooks personalizados hacia abajo** a un componente pequeño que solo se re-renderiza cuando realmente es necesario:

```jsx
const ButtonWithModalDialog = () => {
  const { isOpen, open, close } = useModalDialog();
  // aquí solo renderiza Button y ModalDialog
  return (
    <>
      <Button onClick={open}>Open dialog</Button>
      {isOpen ? <ModalDialog onClose={close} /> : null}
    </>
  );
};
```
- Ahora, **solo** `ButtonWithModalDialog` se re-renderiza ante eventos del diálogo o resize, no toda la app.

---

> [!TIP]  
> **¡Cualquier update de estado dentro de un hook (aunque esté anidado o no se retorne) provoca un re-render del componente padre que lo usa!**

---

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto            |
|----------------------|--------------------------------------|
| _Sin palabras nuevas relevantes en esta sección._           |

---
