Here is the continuation of **Streaming Server-Side Rendering** and the next rendering patterns.

---

### **Streaming Server-Side Rendering**  
**Generate HTML on every request, sending it down piece by piece**  

---

### **Overview**  
Streaming Server-Side Rendering (SSR) allows us to send components to the client as soon as they are generated, rather than waiting for the entire page to be completed.  

With traditional SSR, the user must wait for the server to generate the full HTML before receiving anything. Hydration cannot begin until the JavaScript bundle is downloaded and executed.  

With **Streaming SSR**, however, the components are streamed down as they become ready, improving the **Time To First Byte (TTFB)** and providing a **faster perceived loading experience** for users.  

---

### **Implementation**  

### **Tradeoffs**  

#### **Performance**

![alt text](image-7.png)

- **Faster TTFB:** Since the first byte is sent early, users see content much sooner.
- **Streaming Benefits:** Large pages no longer block rendering because components load progressively.
- **Efficient Resource Usage:** **Network backpressure handling** prevents large requests from blocking smaller ones.

#### **Limitations**
- **Not all runtimes support HTTP streaming** → Some serverless environments (e.g., AWS Lambda) may not support it.
- **Hydration Complexity** → Components must hydrate correctly as they arrive.

---

### **Next: Progressive Hydration**  
Would you like to continue with **Progressive Hydration** next? 🚀