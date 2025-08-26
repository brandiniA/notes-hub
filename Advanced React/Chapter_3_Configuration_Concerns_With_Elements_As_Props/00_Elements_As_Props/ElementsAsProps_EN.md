# ✨ Chapter 3. Configuration Concerns with Elements as Props

> **Quick summary:**  
> Over-configuring components with props can quickly lead to complexity and broken functionality. Using *elements as props* provides a cleaner and more flexible approach.

---

## ⚠️ The Problem

Imagine implementing a `Button` component.  
A common requirement is to show a **loading icon on the right** when the button is in a *loading state* (e.g., during form submission).

```jsx
const Button = ({ isLoading }) => {
    return <button>Submit {isLoading ? <Loading /> : null}</button>
}
```

At first this works fine. But then:  

- Next day: button must support **different icons**, not just loading.  
- Then: icons must allow **color customization**.  
- Then: add **size control**.  
- Then: icons must appear on the **left side** too… maybe even avatars.  

Eventually, half the props exist only to manage icons.  
The component becomes unreadable, hard to maintain, and fragile.  

```jsx
const Button = ({
    isLoading,
    iconLeftName,
    iconLeftColor,
    iconLeftSize,
    isIconLeftAvatar,
}) => {
    // Too many props — hard to maintain
    return ...
}
```

---

## 📚 Concept 1 — Passing Elements Instead of Props

Instead of configuring icons through multiple props, accept them as *elements*. The consumer has full control over styling, color, and placement.

```jsx
const Button = ({ icon }) => {
    return <button>Submit {icon}</button>
}
```

**Usage:**

```jsx
<Button icon={<Loading />} />
<Button icon={<Error color="red" />} />
<Button icon={<Warning color="yellow" size="large" />} />
<Button icon={<Avatar />} />
```

> [!TIP]  
> Keep configuration flexible but avoid hiding defaults. Document clearly how consumers can pass elements.

---

## 📚 Concept 2 — Elements as Props in Complex Components

Using configuration props for complex components (like modals or layouts) quickly becomes unmanageable.  
Different dialogs might need one, two, or three buttons—some primary, some links, some with tooltips or icons.  
Passing all of that through props would be chaotic.

With **elements as props**, this becomes simple:

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

**Usage examples:**

```jsx
<ModalDialog content={<SomeFormHere />} footer={<SubmitForm />} />

<ModalDialog 
    content={<SomeFormHere />} 
    footer={<><SubmitForm /><CancelButton /></>} 
/>
```

The same pattern applies to layouts that should render **anything** inside, such as a three-column layout:

```jsx
<ThreeColumnsLayout 
    leftColumn={<Sidebar />}
    middleColumn={<MainContent />}
    rightColumn={<Notifications />}
/>
```

Here, the component doesn’t care what you pass—it only guarantees **placement**.  
This makes it both powerful and flexible.

---

## 📚 Concept 3 — `children` as Syntax Sugar

When something is the **main part** of the component (e.g., modal content or the middle column), using `children` is cleaner than a dedicated prop:

```jsx
// Before
<ModalDialog content={<SomeFormHere />} footer={<SubmitButton />} />

// After
<ModalDialog footer={<SubmitButton />}>
    <SomeFormHere />
</ModalDialog>
```

Always remember:  
- `children` is nothing more than a prop.  
- The nested syntax is just **syntax sugar** for passing that prop.  

---

## 🚀 Full Example — Three Column Layout

Some components naturally benefit from element props, such as a layout with variable content.

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

**Usage:**

```jsx
<ThreeColumnLayout
    leftColumn={<Sidebar />}
    middleColumn={<MainContent />}
    rightColumn={<Notifications />}
/>
```

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| _No new words relevant in this section._ |
