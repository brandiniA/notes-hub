# Hook Pattern in React

## Overview
The **Hook Pattern** allows the reuse of stateful logic across multiple components in a React application. Hooks are special functions in React that help manage component state and lifecycle methods in functional components.

## Topics Covered
- What are Hooks?
- How do they work?
- Implementation in React
  - Creating a `useHover` Hook
  - Using Hooks for Data Fetching
- Trade-offs of the Hook Pattern

## What are Hooks?
Hooks provide a way to:
- Add **state** to functional components.
- **Reuse stateful logic** across multiple components.
- **Manage component lifecycle** without using class components.

Besides built-in hooks such as `useState`, `useEffect`, and `useReducer`, we can create **custom hooks** to share stateful logic across different components.

## Implementation in React

### Example: Creating a `useHover` Hook
If we want to check whether a component is being hovered, we can create a custom `useHover` hook.

#### **Before: Without a Hook**
```javascript
function Listing() {
  const [isHovering, setIsHovering] = React.useState(false);
  const ref = React.useRef(null);

  const handleMouseOver = () => setIsHovering(true);
  const handleMouseOut = () => setIsHovering(false);

  React.useEffect(() => {
    const node = ref.current;
    if (node) {
      node.addEventListener('mouseover', handleMouseOver);
      node.addEventListener('mouseout', handleMouseOut);
      return () => {
        node.removeEventListener('mouseover', handleMouseOver);
        node.removeEventListener('mouseout', handleMouseOut);
      };
    }
  }, [ref.current]);

  return <div ref={ref}>...</div>;
}
```

#### **After: Using a Hook**
##### `useHover.tsx`
```javascript
export function useHover() {
  const [isHovering, setIsHovering] = React.useState(false);
  const ref = React.useRef(null);

  const handleMouseOver = () => setIsHovering(true);
  const handleMouseOut = () => setIsHovering(false);

  React.useEffect(() => {
    const node = ref.current;
    if (node) {
      node.addEventListener('mouseover', handleMouseOver);
      node.addEventListener('mouseout', handleMouseOut);
      return () => {
        node.removeEventListener('mouseover', handleMouseOver);
        node.removeEventListener('mouseout', handleMouseOut);
      };
    }
  }, [ref.current]);

  return [ref, isHovering];
}
```

##### **Usage in Components**
```javascript
function Listing() {
  const [ref, isHovering] = useHover();

  return <div ref={ref}>...</div>;
}

function Image() {
  const [ref, isHovering] = useHover();

  return <img ref={ref} ... />;
}

function Button() {
  const [ref, isHovering] = useHover();

  return <button ref={ref} ... ></button>;
}
```

By extracting the hover logic into a hook, we can reuse it across multiple components without duplicating code.

---

### Example: Using Hooks for Data Fetching
Hooks allow us to remove the need for **Container Components** by directly fetching data within functional components.

#### **Before: Using a Container Component**
##### `ListingsContainer.tsx`
```javascript
class ListingsContainer extends React.Component {
  constructor() {
    super();
    this.state = {
      listings: [],
    };
  }

  componentDidMount() {
    fetch("https://my.cms.com/listings")
      .then((res) => res.json())
      .then(({ listings }) => this.setState({ listings }));
  }

  render() {
    return <Listings listings={this.state.listings} />;
  }
}
```

##### `Listings.tsx`
```javascript
function Listings({ listings }) {
  return (
    <ListingsLayout>
      {listings.map((listing) => (
        <Listing listing={listing} />
      ))}
    </ListingsLayout>
  );
}
```

#### **After: Using a Hook**
##### `useListings.tsx`
```javascript
export default function useListings() {
  const [listings, setListings] = useState([]);

  useEffect(() => {
    fetch("https://my.cms.com/listings")
      .then((res) => res.json())
      .then(({ listings }) => setListings(listings));
  }, []);

  return listings;
}
```

##### **Usage in Functional Component**
```javascript
import useListings from "./hooks/useListings";

export default function Listings() {
  const listings = useListings();

  return (
    <ListingsLayout>
      {listings.map((listing) => (
        <Listing listing={listing} />
      ))}
    </ListingsLayout>
  );
}
```

## Trade-offs of the Hook Pattern

### Advantages
1. **Simplifies Components**:  
   - Hooks allow adding state to functional components, eliminating the need for class components.

2. **Reusing Stateful Logic**:  
   - Hooks reduce code duplication and errors by allowing reusable logic across multiple components.

3. **Sharing Non-Visual Logic**:  
   - Hooks enable the reuse of logic without relying on HOC or Render Props patterns.

4. **Alternative to Older React Patterns**:  
   - Hooks serve as an effective alternative to the **Presentational/Container Pattern**, which was common in class-based components.

### Disadvantages
1. **Rules of Hooks**:  
   - Hooks require following strict rules, such as only calling hooks at the **top level** and only inside **React function components or other hooks**.
   - Without a linter plugin, it's difficult to catch violations of these rules.

## Conclusion
The Hook Pattern in React provides a powerful way to **reuse stateful logic**, simplify components, and replace older design patterns. By leveraging custom hooks, we can keep our components clean, modular, and more maintainable.

