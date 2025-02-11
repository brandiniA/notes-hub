# Client-Side Rendering
### Render your application's UI on the client

## Overview
The contents of a client-side rendered application get rendered in the browser.

### **Step 1**
**Client requests HTML from server**

---

### **Step 2**
**Server returns barebones HTML**  
*Barebones* refers to a minimal HTML structure, typically containing only the essential elements like the basic document structure (`<html>`, `<head>`, `<body>`) and placeholders for dynamic content. It may include links to stylesheets and JavaScript files, but without fully rendered content.

---

### **Step 3**
**Browser parses and renders HTML**

---

### **Step 4**
**Client requests and downloads JavaScript**

---

### **Step 5**
**Browser executes JS, renders content**

When a user requests a client-side rendered application, the server initially responds with the barebones HTML file.

Once the client receives this HTML file, the HTML parser parses the content and fetches the JavaScript bundle when it reaches the script tag.

When the client has downloaded the JavaScript, it executes its contents. This contains DOM methods to dynamically append content to the DOM tree, which results in rendered content to the user's screen.

---

## Implementation
A basic client-side application consists of at least two files.

First, we need to have a barebones HTML file, which contains the element that the JavaScript file can use to dynamically append content to.

```html
<html>
  <body>
    <div id="root"></div>
    <script src="/bundle.js"></script>
  </body>
</html>
```

We also need a JavaScript file, which contains methods to update the DOM tree and dynamically render data. This file gets fetched after (or during) the HTML parsing.

```javascript
const root = document.getElementById("root");

// DOM manipulation
root.appendChild(...)
```

---

## Tradeoffs

![alt text](image.png)

- **TTFB (Time To First Byte)**: Can be fast, since the initial HTML does not contain large components.
- **FCP (First Contentful Paint)**: Occurs once the JavaScript bundle has downloaded, parsed, and executed its contents.
- **TTI (Time To Interactive)**: Occurs once the JavaScript bundle has downloaded, parsed, and executed its contents to bind the event handlers to the components.
- **LCP (Largest Contentful Paint)**: Can occur at the same time as the First Contentful Paint, provided there aren't any large components such as large images or videos.

### **Pros & Cons**
✅ **Interactivity**: The rendered content is instantly interactive. The fetched JavaScript bundle can directly add Event Listeners to the DOM nodes. Unlike other rendering patterns, users are never left with a visible but non-interactive page.

✅ **Single server roundtrip**: The entire web application is loaded on the first request. As the user navigates by clicking on links, no new request is generated to the server to render these pages.

❌ **Bundle size**: Modern applications, which usually contain multiple pages, can easily have large JavaScript bundles. The larger the bundle, the longer it takes to download and execute the JavaScript before the first content is visible and interactive.

❌ **SEO Limitations**: Large bundles and a waterfall of API requests may result in content not being rendered fast enough for a crawler to index it. Workarounds are required to make a client-rendered website SEO-friendly and bypass the limitations of a crawler's ability to understand JavaScript.

