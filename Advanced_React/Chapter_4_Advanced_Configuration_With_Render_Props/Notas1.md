title: Sharing stateful logic: children as render props

Another useful application for render props is sharing stateful logic
between components, and it usually goes in combination with the "children
as props" pattern.

```jsx
<Parent>
    <Child />
</Parent>

<Parent children={<Child />}>
```

So nothing actually stops us from making children a function as well.

We don't even have to prefix it with render. renderSomething is just a naming
convention. It would look like this:

```jsx
<Parent children={() => <Child />}>
```

And in Parent , you'd call it like any other render prop:

```jsx
const Paren = ({ children }) => {
    return children()
}

```

Why can it be useful? Imagine, for example, you're implementing a "resize
detector" component. A component that tracks the resize event on the
browser window:

```jsx
const ResizeDetector = () => {
    const [width, setWidth] = useState()

    useEffect(() => {
        const listener = () => {
            const width = window.innerWidth;
            setWidth(width)
        }

        window.addEventListener('resize', listener);
    }, [])

    return ...
}

```

And you want to make it generic so that different components throughout
the app can track the window width without implementing that code
everywhere. So ResizeDetector needs to share that state with other
components somehow. Technically, we could do this through props, just by
adding the onWidthChange prop to the detector:


```jsx
const ResizeDetector = ({ onWidthChange }) => {
    const [width, setWidth] = useState()

    useEffect(() => {
        const listener = () => {
            const width = window.innerWidth;
            setWidth(width)
            onWidthChange(width)
        }

        window.addEventListener('resize', listener);
    }, [])

    return ...
}

```

But this would mean that any component that wants to use it would have to
maintain its own state for it:

```jsx
const Layout = () => {
    const [windowWidth, setWindowWidth] = useState(0)

    return (
        <>
            <ResizeDetector onWindowWidth={setWindowWidth} />
            {windowWidth > 600 ? (
                <WideLayout />
            ) : (
                <NarrowLayout />
            )}
        </>
    )
}
```

A bit messy.

What we can do instead is just make ResizeDetector accept children as a
function and pass that width to children directly:

```jsx
const ResizeDetector = ({ children }) => {
    const [width, setWidth] = useState()

    useEffect(() => {
        const listener = () => {
            const width = window.innerWidth;
            setWidth(width)
            onWidthChange(width)
        }

        window.addEventListener('resize', listener);
    }, [])

    return children(width)
}
```

```jsx
const Layout = () => {
    return (
        <>
            <ResizeDetector>
                {(windowWidth) => {
                    return windowWidth > 600 ? (
                <WideLayout />
            ) : (
                <NarrowLayout />
            )
                }}
            </ResizeDetector>
        </>
    )
}
```

In real life, o course, we'd have a re-renders problem here: we're triggering
state updates on every width change. So we'd have to either calculate the
layout inside the detector or debounce it. But the principle of sharing state
Will remain the same.

