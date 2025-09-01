Whether doing something like this for a Button is a good idea or not is
sometimes debatable, of course. It highly depends on how strict your design
is and how much deviation it allows for those who implement product
features.

But imagine implementing something like a modal dialog with a header,
content area and footer with some buttons.

Unless your designers are very strict and powerful, chances are youid need to
have different configurations of those buttons in different dialogs: one, two,
three buttons, one button is a link, one button is "primary," different texts
on those of course, different icons, different tooltips, etc. Imagine passing all
of that through configuration props!
But with elements as props, it couldn't be easier: just create a footer prop on
the dialog

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

and then pass whatever is needed:

```jsx
<ModalDialog content={<SomeFormHere />} footer={<SubmitForm />} />

<ModalDialog content={<SomeFormHere />} footer={<><SubmitForm /><CancelButton /></>} />
```

Or something like a ThreeColumnsLayout component, which renders three
columns with some content on the screen. In this case, you can't even do any
configuration: it literally can and should render anything in those columns.

```jsx
<ThreeColumnsLayout 
    leftColumn={<Something />}
    middleColumn={<OtherThing />}
    rightColumn={<SomethingElse />}
/>
```

Essentially, an element as a prop for a component is a way to tell the
consumer: give me whatever you want, I don't know or care what it is, I am
just responsible for putting it in the right place. The rest is up to you.

And, of course, the "children" as props pattern, described in the previous
chapter, is very useful here as well. Ifwe want to pass something that we
consider a "main" part of that component, like the "content" area in the
modal dialog, or the middle column in the three columns layout, we can just
use the nested syntax for that:

```jsx 
// before 
<ModalDialog content={<SomeFormHere />} footer={<SubmitButton />} /> 
// after 
<ModalDialog footer={<SubmitButton />}> <SomeFormHere /> </ModalDialog>

```

Always remember: "children" in this context are nothing more than a prop,
and the "nested" syntax is just syntax sugar for it!