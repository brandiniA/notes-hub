# ✨ Capítulo 3. Preocupaciones de Configuración con Elementos como Props

> **Resumen rápido:**  
> La sobreconfiguración de componentes con props puede llevar rápidamente a la complejidad y a funcionalidades rotas. Usar *elementos como props* ofrece un enfoque más limpio y flexible.

---

## ⚠️ El Problema

Imagina implementar un componente `Button`.  
Un requisito común es mostrar un **icono de carga a la derecha** cuando el botón está en un *estado de carga* (por ejemplo, durante el envío de un formulario).

```jsx
const Button = ({ isLoading }) => {
    return <button>Submit {isLoading ? <Loading /> : null}</button>
}
```

Al principio esto funciona bien. Pero luego:  

- Al día siguiente: el botón debe soportar **diferentes iconos**, no solo el de carga.  
- Después: los iconos deben permitir **personalización de color**.  
- Luego: agregar **control de tamaño**.  
- Finalmente: los iconos deben aparecer también en el **lado izquierdo**… e incluso avatares.  

Eventualmente, la mitad de las props existen solo para manejar iconos.  
El componente se vuelve ilegible, difícil de mantener y frágil.  

```jsx
const Button = ({
    isLoading,
    iconLeftName,
    iconLeftColor,
    iconLeftSize,
    isIconLeftAvatar,
}) => {
    // Demasiadas props — difícil de mantener
    return ...
}
```

---

## 📚 Concepto 1 — Pasar Elementos en Lugar de Props

En lugar de configurar iconos mediante múltiples props, acéptalos como *elementos*. El consumidor tiene control total sobre el estilo, color y ubicación.

```jsx
const Button = ({ icon }) => {
    return <button>Submit {icon}</button>
}
```

**Uso:**

```jsx
<Button icon={<Loading />} />
<Button icon={<Error color="red" />} />
<Button icon={<Warning color="yellow" size="large" />} />
<Button icon={<Avatar />} />
```

> [!TIP]  
> Mantén la configuración flexible pero evita ocultar valores por defecto. Documenta claramente cómo los consumidores pueden pasar elementos.

---

## 📚 Concepto 2 — Elementos como Props en Componentes Complejos

Usar props de configuración para componentes complejos (como modales o layouts) rápidamente se vuelve inmanejable.  
Diferentes diálogos pueden necesitar uno, dos o tres botones—algunos primarios, otros enlaces, otros con tooltips o iconos.  
Pasar todo eso mediante props sería caótico.

Con **elementos como props**, esto se simplifica:

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

**Ejemplos de uso:**

```jsx
<ModalDialog content={<SomeFormHere />} footer={<SubmitForm />} />

<ModalDialog 
    content={<SomeFormHere />} 
    footer={<><SubmitForm /><CancelButton /></>} 
/>
```

El mismo patrón aplica a layouts que deben renderizar **cualquier cosa**, como un layout de tres columnas:

```jsx
<ThreeColumnsLayout 
    leftColumn={<Sidebar />}
    middleColumn={<MainContent />}
    rightColumn={<Notifications />}
/>
```

Aquí, el componente no se preocupa por lo que pasas—solo garantiza la **ubicación**.  
Esto lo hace potente y flexible.

---

## 📚 Concepto 3 — `children` como Azúcar Sintáctico

Cuando algo es la **parte principal** del componente (ejemplo: el contenido de un modal o la columna del medio), usar `children` es más limpio que una prop dedicada:

```jsx
// Antes
<ModalDialog content={<SomeFormHere />} footer={<SubmitButton />} />

// Después
<ModalDialog footer={<SubmitButton />}>
    <SomeFormHere />
</ModalDialog>
```

Recuerda siempre:  
- `children` no es más que una prop.  
- La sintaxis anidada es simplemente **azúcar sintáctico** para pasar esa prop.  

---

## 🚀 Ejemplo Completo — Layout de Tres Columnas

Algunos componentes se benefician naturalmente de los elementos como props, como un layout con contenido variable.

```jsx
const ThreeColumnLayout = ({ leftColumn, middleColumn, rightColumn }) => {
    return (
        <div className="three-column">
            <div>{leftColumn}</div>
            <div>{middleColumn}</div>
            <div>{rightColumn}</div>
        </div>
    )
}
```

**Uso:**

```jsx
<ThreeColumnLayout
    leftColumn={<Sidebar />}
    middleColumn={<MainContent />}
    rightColumn={<Notifications />}
/>
```

---

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto |
|----------------------|---------------------------|
| _No new words relevant in this section._ |
