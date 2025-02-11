# Incremental Static Regeneration
## Pre-render certain pages, and render the other pages on-demand

### Overview
Static rendering comes with many performance benefits, but it can end up in long build times if we have many pages to pre-render. We can also only update the content of our page by redeploying the website, which isn't a great user experience.

Incremental Static Generation allows us to only pre-render a subset of pages, for example pages that are likely to be requested by the user, and render the rest on-demand. When the user requests a page that hasn't been pre-rendered yet, the page gets server-rendered, after which it can get cached by a CDN.

Besides only pre-rendering a subset of pages, we can also automatically invalidate cached pages based on a stale-while-revalidate approach. When a user requests a page that is stale - meaning it's been in cache for longer than the provided number that it should be cached for - a regeneration is triggered in the background. While this is happening, the user gets to see the stale page, but they're able to see the updated content on subsequent requests.

---

### **Step 1**  
**Client requests HTML from server**  

---

### **Step 2**  
**Server returns stale HTML to client.**  

---

### **Step 2.1**  
**Regeneration is triggered**  

---

### **Step 2.2**  
**Page gets regenerated in deployed serverless function**  

---

### **Step 2.3**  
**Cache gets invalidated and replaced with new page**  

---

## Implementation
We can implement Incremental Static Regeneration using Next.js's `getStaticProps` method in combination with the `getStaticPaths` method.

```javascript
import { Listings, ListingsSkeleton } from "../components";

export default function Listing(props) {
  return <ListingLayout listings={props.listing} />
}

export async function getStaticProps(props) {
  const res = await fetch(`https://my.cms.com/listings/${props.params.id}`);
  const { listing } = await res.json();

  return { props: { listing } }
}

export function getStaticPaths() {
  const res = await fetch(`https://my.cms.com/listings?limit=20`);
  const { listings } = await res.json();

  return {
    params: listings.map(listing => ({ id: listing.id })),
    fallback: false
  }
}
```

---

## Tradeoffs
### **Performance**

![alt text](image-5.png)

- **TTFB**: The Time To First Byte can be fast, since the initial HTML does not contain large components.
- **FCP**: The First Contentful Paint can occur once the HTML has been parsed and rendered.
- **LCP**: The Largest Contentful Paint can occur at the same time as the First Contentful Paint, provided there aren't any large components such as large images or videos.
- **TTI**: The Time To Interactive can occur once the HTML has been rendered, and the JavaScript bundle has been downloaded, parsed, and executed its contents to bind the event handlers to the components.

### **Other Considerations**

- **Static benefits**: Since we're still statically generating the HTML files, we can benefit from all the benefits that Plain Static Rendering provided, such as cacheability, good SEO, high availability, and a low backend load.
- **Server costs**: It might happen that our data doesn't update every number of seconds, resulting in an unnecessary cache invalidation and page regeneration.