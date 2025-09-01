Title Hooks replaced render props

Anyone whois done any coding in React in the last two years is probably
thinking something like this right now: "Hey, what you're saying doesn't
make sense. Why do you do something as complicated as this when we have
hooks for sharing stateful logic?"

And you're absolutely right! Hooks replaced that pattern in almost 99% of
cases. And rightfully so. Exactly the same use case can be rewritten with
hooks like this:

```js
const useResizeDetector = () => {
   const [width, setWidth] = useState()

    useEffect(() => {
        const listener = () => {
            const width = window.innerWidth;
            setWidth(width)
            onWidthChange(width)
        }

        window.addEventListener('resize', listener);
    }, [])

    return width
}
```

Just extract the entire logic of the ResizeDetector component into a hook
and then use it everywhere:

```jsx
const Layout = () => {
    const windowWidth = useResizeDetector()
    return windowWidth > 600 ? (
        <WideLayout />
    ) : (
        <NarrowLayout />
    )
}
```

Less code, and much easier to understand what's going on.

• Render props for configuration and flexibility use cases, described at the
beginning, are Still very viable.
• If you are working on a project that is a few years old, this pattern Will
be all over the codebase. It was really popular before the introduction of
hooks, especially for encapsulating form validation logic. A few popular
libraries Still use it to this day.
• It can Still be useful for specific scenarios, such as when the logic and
state that you want to share depend on a DOM element.

A very common example of the last use case would be tracking scroll in an
area:

```jsx
const ScrollDetector = ({children}) => {
    const [scroll, setScroll] = useState()

    return (
        <div
            onScroll={(e) => setScroll(e.currentTarget.scrollTop)}
        >
            {children}
        </div>
    );
}
```

Exactly the same situation as before: you have some value, and you want
to share that value with other components. Props again Will be messy. And
extracting it to a hook won't be as straightforward as before: you need to
attach the onScroll listener to a div, this time, not So you'd need
to either introduce a Ref and pass it around (more about Refs in Chapter 9.
Refs:from storing data to imperative API). Or just use the render prop pattern:


```jsx
const ScrollDetector = ({children}) => {
    const [scroll, setScroll] = useState()

    return (
        <div
            onScroll={(e) => setScroll(e.currentTarget.scrollTop)}
        >
            {children(scroll)}
        </div>
    );
}
```

And use it where you need to do something based on how much the user
scrolled:

```jsx

const Layout = () => {
    return (
        <ScrollDetector>
            {(scroll) => {
                return (
                    <>{scroll > 30 ? <SomeBlock /> : null }</>
                )
            }}
        </ScrollDetector>
    )
}

<>
{windowWidth > 600 ? <WideLayout /> : <NarrowLayout />}
<ComplicatedComponente />
</>