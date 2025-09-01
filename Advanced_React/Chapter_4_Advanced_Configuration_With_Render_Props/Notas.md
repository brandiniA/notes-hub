Chapter 4. Advanced configuration with render props

If a component that accepts other components through props needs to influence 
their props or pass some state to them in some explicit non-magical way, then
elements as props and the cloneElement function are no help here.

This is where the pattern known as "render props".

The problem

Button component that we implemented in the previous chapter:

```jsx
const Button = ({ appearance = 'secondary', size = 'medium', icon }) => {
  // Assume `icon` is a valid React element
  const defaultIconProps = {
    size: size === 'large' ? 'large' : 'medium',
    color: appearance === 'primary' ? 'white' : 'black',
  };

  const mergedProps = { ...defaultIconProps, ...icon.props };
  const clonedIcon = React.cloneElement(icon, mergedProps);

  return (
    <button>
      Submit {clonedIcon}
    </button>
  );
};
```

The Button accepts an Element and sets its size and color props by
default.

This approach works pretty well for simple cases, it is not that good
for something more complicated. 

What if I want to introduce some state to
the Button and give Button 's consumers access to that state? Like adjusting
the icon while the button is hovered, for example? It's easy enough to
implement that state in the button:

```jsx

const Button = ({...}) => {
    const [hovered, setIsHovered] = useState(false)
    // Rest of the code
    return <button onMouseOver={() => setIsHovered(true)} />
}

```

How do we share it with the icon?

Another problem
We're making some major
assumptions about the Element that comes through the icon prop. We
expect it to have at least size and color props. What ifwe wanted to use a
different library for icons, and those icons didn't have those exact props?
Our default props logic Will just stop working with no way of fixing it.

title: Render props for renderin Elements

In this case, instead of passing elements as a
prop, we can pass them as a render prop (or renderfunction). A render prop is
nothing more than just a function that returns an Element.

how the button would look like with the render function:

```jsx

const Button = ({ renderIcon }) => {
    // rest of the code
    return <button>Submit {renderIcon()}</button>
}

```

We accept a ren erlcon ctlon an justc Itw eret e Icon IS suppose
to go. And then, on the consumer side, wetd pass the function that returns
the icon instead of passing the icon directly:


```jsx
<Button renderIcon={() = > <HomeIcon />} />
```

And we can Still adjust that icon to our needs, of course, same as the regular
Element:

And we can Still adjust that icon to our needs, of course, same as the regular
Element:

```jsx
<Button renderIcon={() = > <HomeIcon color="red" />} />
<Button renderIcon={() = > <HomeIcon size="large" />} />
```

Now, instead of cloning elements, we can just pass the object to the function.

```jsx

const Button = ({ size, appearance, renderIcon }) => {
    const defaultIconProps = {
        size: size === 'large' ? 'large' : 'medium',
        color: appearance === "priamry" ? 'white' : 'white',
    }

    return <button>Submit {renderIcon(defaultIconProps)}</button>
}
```

And then, on the icon's side, we can accept them and spread them over the
icon:

```jsx
<Button renderIcon={(props) => <HomeIcon {...props} />}>
```

We can override some of them:


```jsx
<Button renderIcon={(props) => <HomeIcon {...props} size="large" color="red" />}>
```

Or convert them to the props our icon actually accepts


```jsx
<Button renderIcon={(props) => <HomeIcon fontSize={props.size} style={{ color: props.color }} />}>
```

Everything is explicit, and nothing overrides anything by some hidden
magic. The flow of data, although a bit loopy, is visible and traceable.

Sharing state is also not a problem anymore. We can simply merge that state value into the object we're passing to the icon:

```jsx
const Button = ({ size, appearance, renderIcon }) => {
    const [isHovered, setIsHovered] = useState(false)
    const defaultIconProps = {
        size: size === 'large' ? 'large' : 'medium',
        color: appearance === "priamry" ? 'white' : 'white',
        isHovered
    }

    return <button ...>Submit {renderIcon(defaultIconProps)}</button>
}
```

Or we can even go fancy and pass it as a second argument to clearly separat
state and props. Whatever makes sense for our codebase:

```jsx
const Button = ({ size, appearance, renderIcon }) => {
    const [isHovered, setIsHovered] = useState(false)
    const defaultIconProps = {
        size: size === 'large' ? 'large' : 'medium',
        color: appearance === "priamry" ? 'white' : 'white',
    }

    return <button ...>Submit {renderIcon(defaultIconProps, { isHovered })}</button>
}
```

And then on the icon side, we can again do whatever we want with that
hovered state. We can render another icon:

```jsx
const icon = (props, state) state.isHovered ? <HomelconHovered {...props} /> : <HomeIcon {...props} />

<Button renderIcon={icon} />
```

```jsx
const icon = (prop, state) => <HomeIcon {...props} className={state.isHovered ? 'hovered' : ''} />

<Button renderIcon={icon} />
```

Or just ignore it completely.