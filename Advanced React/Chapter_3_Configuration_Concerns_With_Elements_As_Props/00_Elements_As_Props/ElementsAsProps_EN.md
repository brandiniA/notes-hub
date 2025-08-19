# ✨ Elements as Props

> **Quick summary:**  
> Replacing configuration props with elements as props reduces complexity, keeps components cleaner, and gives consumers full control over customization.

---

## ❗ Problem

When building reusable components, it’s tempting to add a new prop for every new requirement.  
For example, a `Button` that should display a loading state might start simple:

```jsx
const Button = ({ isLoading }) => {
    return <button>Submit {isLoading ? <Loading /> : null}</button>
}
```

But soon, new demands appear:  
- Support different icons (not just loading).  
- Control icon **color**, **size**, and **position**.  
- Allow **avatars** or custom visuals instead of icons.  

The component explodes with configuration props:

```jsx
const Button = ({
    isLoading,
    iconLeftName,
    iconLeftColor,
    iconLeftSize,
    isIconLeftAvatar,
}) => {
    // too many props, unclear behavior
    return ...
}
```

⚠️ At this point:  
- Half the props exist *just to manage icons*.  
- Each new feature risks breaking existing functionality.  
- The component is hard to maintain and confusing to use.

---

## 📚 Concept 1 — Passing Elements as Props

Instead of piling up configuration props, allow the consumer to **pass a ready-made element**:

```jsx
const Button = ({ icon }) => {
    return <button>Submit {icon}</button>
}
```

This drastically simplifies the component. The parent doesn’t need to know *how* the icon is configured — only *where* to place it.

### Usage examples

```jsx
<Button icon={<Loading />} />
<Button icon={<Error color="red" />} />
<Button icon={<Warning color="yellow" size="large" />} />
<Button icon={<Avatar />} />
```

<details>
<summary>🔍 **How does it work?**</summary>

- Props no longer act as *instructions*; they carry the **element itself**.  
- The button only decides *placement* (`before` or `after` the text).  
- Consumers configure the element (icon, avatar, tooltip, etc.) however they want.  

</details>

---

## 🛠️ Concept 2 — Elements in Complex Layouts

This idea shines in **container components** like dialogs or layouts.  
If you tried to handle every variation with configuration props, things would get unmanageable.

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

### Usage

```jsx
<ModalDialog content={<SomeFormHere />} footer={<SubmitButton />} />

<ModalDialog
    content={<SomeFormHere />}
    footer={<><SubmitButton /> <CancelButton /></>}
/>
```

And for layouts:

```jsx
<ThreeColumnLayout 
    leftColumn={<Something />}
    middleColumn={<OtherThing />}
    rightColumn={<SomethingElse />}
/>
```

✅ Instead of forcing endless props (`footerButtonCount`, `isPrimary`, `footerLinks`…), the parent just **passes the elements directly**.

> [!TIP]  
> Use elements as props when the parent only needs to **define structure** and not dictate the internal details.

---

## ✅ Best Practices

- ✅ Use **elements as props** when customization is critical.  
- ✅ Keep parent components focused on *layout/placement*.  
- ✅ Delegate configuration (color, size, content) to consumers.  
- 🚫 Don’t overuse config props for things that could be passed as elements.  

---

## 🚀 Full Example — Using `children`

The `children` prop is just syntactic sugar for passing elements.  
It’s perfect for the *main content* of a container, like the body of a modal.

```jsx
// before
<ModalDialog 
    content={<SomeFormHere />}
    footer={<SubmitButton />}
/>

// after
<ModalDialog footer={<SubmitButton />}>
    <SomeFormHere />
</ModalDialog>
```

### Implementation

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

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| _No new words relevant in this section._ |
