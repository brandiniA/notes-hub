# Container/Presentational Pattern in React

## Introduction
This README contains notes on the **Container/Presentational Pattern** in React. This pattern enforces the separation of concerns by distinguishing between components responsible for retrieving data and components responsible for presenting that data.

## Topics Covered
- What is the Container/Presentational Pattern?
- How does it work?
- Implementation in React
  - Using functional components
  - Alternative approach using hooks
- Trade-offs of the Container/Presentational Pattern

## What is the Container/Presentational Pattern?
This pattern separates components into:
1. **Container Component**: Responsible for fetching and managing data. It does not contain any styles or UI elements.
2. **Presentational Component**: Responsible for rendering the UI. It receives data as props and focuses solely on how the data is displayed.

### Why use the Container/Presentational Pattern?
- Enforces **separation of concerns**.
- Makes components more **reusable**.
- Improves **flexibility**, as designers can modify UI components without affecting logic.
- Simplifies **testing** since presentational components are pure functions.

## Implementation in React

### Example: Using Functional Components
```javascript
import React from "react";
import { LoadingListings, Listing, ListingsGrid } from "../components";

function ListingsContainerComponent() {
  const [listings, setListings] = React.useState([]);

  React.useEffect(() => {
    fetch("https://my.cms.com/listings")
      .then((res) => res.json())
      .then((res) => setListings(res.listings));
  }, []);

  return <ListingsPresentationalComponent listings={listings} />;
}

function ListingsPresentationalComponent({ listings }) {
  if (listings.length === 0) {
    return <LoadingListings />;
  }

  return (
    <ListingsGrid>
      {listings.map((listing) => (
        <Listing key={listing.id} listing={listing} />
      ))}
    </ListingsGrid>
  );
}
```

### Alternative: Using Hooks for Fetching Data
With React Hooks, the Container/Presentational Pattern is often unnecessary. Hooks allow us to fetch data and conditionally render components within the same functional component.

```javascript
import React from "react";
import useSWR from "swr";
import { LoadingListings, Listing, ListingsGrid } from "../components";

function Listings() {
  const {
    data: listings,
    error,
  } = useSWR("https://my.cms.com/listings", (url) =>
    fetch(url).then((r) => r.json())
  );

  if (!listings) {
    return <LoadingListings />;
  }

  return (
    <ListingsGrid>
      {listings.map((listing) => (
        <Listing key={listing.id} listing={listing} />
      ))}
    </ListingsGrid>
  );
}
```

## Trade-offs of the Container/Presentational Pattern

### Advantages
1. **Separation of Concerns**:  
   - Presentational components handle UI, while container components manage state and data fetching.

2. **Reusability**:  
   - Presentational components can be reused in different parts of the application with different data sources.

3. **Flexibility**:  
   - Since presentational components don’t modify application logic, designers can update styles without affecting functionality.

4. **Easy Testing**:  
   - Presentational components are often pure functions, making them predictable and easier to test.

### Disadvantages
1. **Not Necessary with Hooks**:  
   - Hooks like `useSWR`, `useQuery`, or `useState` allow us to manage data fetching inside functional components without needing separate container components.

2. **Overkill for Small Applications**:  
   - Introducing this pattern in a small application may add unnecessary complexity.

## Conclusion
The Container/Presentational Pattern provides a structured way to separate concerns in React applications, making components more reusable, maintainable, and testable. However, with the advent of React Hooks, this pattern is often unnecessary, as hooks allow fetching and managing state within functional components without requiring explicit separation.

