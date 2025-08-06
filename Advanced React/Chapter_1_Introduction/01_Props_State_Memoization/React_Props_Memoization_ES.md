# ✨ React — Props, estado y memoización

> **Resumen rápido:**  
> Entender la relación real entre props, estado y memoización en React previene bugs sutiles y re-renderizados innecesarios.

---

## 📚 Concepto 1 — _Las actualizaciones de estado provocan re-renderizados, no solo los cambios en props_

Un error común: “Los componentes se re-renderizan cuando sus props cambian.”  
**La realidad:** React solo re-renderiza un componente si su padre se re-renderiza—sin importar si las props realmente cambiaron.

```jsx
const App = () => {
  // ¡una variable local no funcionará!
  let isOpen = false;
  return (
    <div>
      {/* no pasará nada */}
      <Button onClick={() => (isOpen = true)}>
        Open dialog
      </Button>
      {/* nunca se mostrará */}
      {isOpen ? (
        <ModalDialog onClose={() => (isOpen = false)} />
      ) : null}
    </div>
  );
};
```

<details>
<summary>🔍 **¿Cómo funciona?**</summary>

- Cambiar `isOpen` **sin estado de React** no provoca un re-renderizado.
- La UI nunca se actualiza, así que el diálogo nunca aparece.
- React solo actualiza la UI en respuesta a cambios de estado o re-renderizados desde arriba.
</details>

---

## 🛠️ Concepto 2 — _¿Cuándo revisa React si las props cambiaron?_

Los cambios en las props **solo importan** para el re-renderizado si el componente está envuelto en `React.memo`.  
Normalmente, cuando el estado cambia **alto en el árbol**, React re-renderiza todos los hijos—aunque tengan las mismas props.

### Diagrama — Memo evita re-renderizados innecesarios

```
         [State update]
            /          [React.memo]     [ComponentB]*
      /       [ChildA]   [ChildB]
```

- **Flechas/componentes rojos:** re-renderizados por el cambio de estado.
- **Negro (React.memo):** no se re-renderiza (no hay cambios en las props).
- Incluso si el estado cambia arriba, `React.memo` detiene el re-render si las props no cambiaron.

> [!TIP]  
> Memoización (`React.memo`) solo evita el re-renderizado si las **props permanecen iguales**. Si cambia alguna prop, el re-renderizado ocurre normalmente.

---

### Explicación del diagrama

Una actualización de estado en un nivel alto normalmente re-renderizaría **todos los descendientes**.  
Pero si un hijo está envuelto en `React.memo`, React revisa si sus props han cambiado:
- **Sin cambios en props:** el componente no se re-renderiza.
- **Con cambios en props:** el re-renderizado procede como siempre.

---

Evitar re-renderizados con memoización es un tema **complejo** con varios caveats y edge cases.

---

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto                        |
|----------------------|--------------------------------------------------|
| Caveat               | Advertencia sobre una limitación o peculiaridad. |

---
