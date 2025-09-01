# Observer Pattern in JavaScript

## Introduction
This README contains notes on the **Observer Pattern** in JavaScript. The Observer Pattern is a design pattern where an observable object maintains a list of subscribers and notifies them when an event occurs. This is useful for event-driven programming, analytics, and decoupling dependencies in an application.

## Topics Covered
- What is the Observer Pattern?
- How does it work?
- Implementation in JavaScript
  - Creating an observable object
  - Subscribing and unsubscribing functions
  - Notifying subscribers
  - Real use case of unsubscribe
- Trade-offs of the Observer Pattern

## What is the Observer Pattern?
The **Observer Pattern** consists of:
1. **An observable object**: Maintains a list of subscribers and can notify them of changes.
2. **Subscribers (observers)**: Functions or objects that subscribe to the observable and receive notifications when an event occurs.

### Why use the Observer Pattern?
- It enables **event-driven programming**.
- It avoids **repetitive code** by centralizing event handling.
- It helps **decouple components**, making the system more modular and maintainable.

## Implementation in JavaScript
We can implement an observer as a **singleton object** that allows subscribing, unsubscribing, and notifying subscribers.

### Example: Creating an Observable
```javascript
const observers = [];

export default Object.freeze({
  notify: (data) => observers.forEach((observer) => observer(data)),
  subscribe: (func) => observers.push(func),
  unsubscribe: (func) => {
    [...observers].forEach((observer, index) => {
      if (observer === func) {
        observers.splice(index, 1);
      }
    });
  },
});
```

### Subscribing and Notifying Subscribers
We can now use this observable throughout the application to manage event subscriptions.

#### Subscribing a Function
```javascript
import Observable from "./observable";

function logger(data) {
  console.log(`${Date.now()} ${data}`);
}

Observable.subscribe(logger);
```

#### Notifying Subscribers Based on Events
```javascript
import Observable from "./observable";

document.getElementById("my-button").addEventListener("click", () => {
  Observable.notify("Clicked!"); // Notifies all subscribed observers
});
```

### Real Use Case of Unsubscribe
Sometimes, we only want a subscriber to be used once based on a specific condition. For example:
- If a certain event occurs or does not occur.
- Based on external triggers or after a certain period has passed.
- If a timeout happens or an error occurs, we want to ensure the subscriber is removed to prevent unnecessary executions.

By properly handling unsubscriptions, we can ensure that subscribers only receive relevant notifications and avoid performance issues.

### Real-World Example
Suppose we have an application where multiple subscribers (e.g., **analytics tracking, Google Analytics, email notifications**) need to be notified when a user clicks a button. Instead of calling each function separately, we register them as subscribers, and the observable handles event propagation efficiently.

## Trade-offs of the Observer Pattern

### Advantages
1. **Separation of Concerns**:  
   - Observers are **not tightly coupled** to the observable object, making it easier to modify or replace them independently.
   - The observable object simply monitors events, while observers handle the received data as needed.

### Disadvantages
1. **Performance Impact**:  
   - Notifying all subscribers **may take significant time** if the handlers become too complex or if there are too many subscribers.
   - If notification logic involves heavy computations, consider **executing them asynchronously** to avoid blocking execution.

## Conclusion
The Observer Pattern is a powerful design pattern for managing event-driven interactions in JavaScript. By using an observable object, we can **reduce redundancy**, **improve modularity**, and **separate concerns**. However, we should be mindful of **performance trade-offs** when handling a large number of subscribers.

