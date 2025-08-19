# ✨ Elementos como Props

> **Resumen rápido:**  
> Reemplazar props de configuración con elementos como props reduce la complejidad, mantiene los componentes más limpios y da control total al consumidor.

---

## ❗ Problema

Al construir componentes reutilizables, es común agregar una prop por cada nuevo requisito.  
Por ejemplo, un `Button` que muestre un estado de carga puede empezar simple:

```jsx
const Button = ({ isLoading }) => {
    return <button>Submit {isLoading ? <Loading /> : null}</button>
}
```

Pero pronto aparecen más necesidades:  
- Soportar distintos íconos (no solo `Loading`).  
- Controlar **color**, **tamaño** y **posición** del ícono.  
- Permitir **avatares** u otros elementos personalizados.  

El componente termina sobrecargado de props:

```jsx
const Button = ({
    isLoading,
    iconLeftName,
    iconLeftColor,
    iconLeftSize,
    isIconLeftAvatar,
}) => {
    // demasiadas props, difícil de entender
    return ...
}
```

⚠️ Problemas:  
- La mitad de las props son solo para manejar íconos.  
- Cada cambio arriesga romper funcionalidades existentes.  
- Se vuelve difícil de mantener y poco claro para el usuario.

---

## 📚 Concepto 1 — Pasar Elementos como Props

En lugar de múltiples props de configuración, deja que el consumidor pase un **elemento ya listo**:

```jsx
const Button = ({ icon }) => {
    return <button>Submit {icon}</button>
}
```

### Uso

```jsx
<Button icon={<Loading />} />
<Button icon={<Error color="red" />} />
<Button icon={<Warning color="yellow" size="large" />} />
<Button icon={<Avatar />} />
```

<details>
<summary>🔍 **¿Cómo funciona?**</summary>

- Las props ya no son *instrucciones*, sino el **elemento mismo**.  
- El botón solo se encarga de *dónde colocarlo*.  
- La configuración (color, tamaño, tipo) queda en manos del consumidor.  

</details>

---

## 🛠️ Concepto 2 — Elementos en Layouts Complejos

Este enfoque brilla en **contenedores**, como diálogos o layouts.  
Si intentaras resolver todo con props de configuración, sería inmanejable.

```jsx
const ModalDialog = ({ content, footer }) => {
    return (
        <div className="modal-dialog">
            <div className="content">{content}</div>
            <div className="footer">{footer}</div>
        </div>
    )
}
```

### Uso

```jsx
<ModalDialog content={<SomeFormHere />} footer={<SubmitButton />} />

<ModalDialog
    content={<SomeFormHere />}
    footer={<><SubmitButton /> <CancelButton /></>}
/>
```

O en layouts:

```jsx
<ThreeColumnLayout 
    leftColumn={<Something />}
    middleColumn={<OtherThing />}
    rightColumn={<SomethingElse />}
/>
```

✅ En vez de props infinitas (`footerButtonCount`, `isPrimary`, `footerLinks`…), el padre pasa directamente los elementos.

> [!TIP]  
> Usa elementos como props cuando el padre solo necesita **definir la estructura** y no los detalles internos.

---

## ✅ Buenas Prácticas

- ✅ Usa **elementos como props** cuando se requiera personalización.  
- ✅ Mantén el componente padre enfocado en *estructura y ubicación*.  
- ✅ Delega la configuración (color, tamaño, contenido) al consumidor.  
- 🚫 No abuses de props de configuración para casos que pueden resolverse con elementos.  

---

## 🚀 Ejemplo Completo — Usando `children`

La prop `children` es simplemente azúcar sintáctica para pasar elementos.  
Es ideal para el *contenido principal* de un contenedor, como el cuerpo de un modal.

```jsx
// antes
<ModalDialog 
    content={<SomeFormHere />}
    footer={<SubmitButton />}
/>

// después
<ModalDialog footer={<SubmitButton />}>
    <SomeFormHere />
</ModalDialog>
```

### Implementación

```jsx
const ModalDialog = ({ children, footer }) => {
    return (
        <div className="dialog">
            <div className="content">{children}</div>
            <div className="footer">{footer}</div>
        </div>
    )
}
```

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto            |
|----------------------|--------------------------------------|
| _Sin palabras nuevas relevantes en esta sección._           |
