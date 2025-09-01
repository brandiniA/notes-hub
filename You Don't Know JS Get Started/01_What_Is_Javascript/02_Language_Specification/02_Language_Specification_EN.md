
# **📌 Chapter 1: What Is JavaScript?**  

# **Language Specification**  

## **🔹 TC39 and the JavaScript Specification**  
JavaScript’s official **language specification** is managed by **TC39**, a **technical steering committee** composed of representatives from various **web-invested companies** such as:  
- **Browser vendors**: Mozilla, Google, Apple, etc.  
- **Device manufacturers**: Samsung and others.  

### **How TC39 Operates**  
- The **committee consists of 50 to 100 members**, most of whom are **volunteers** (though they may be employees of these companies and receive compensation).  
- They **meet every two months**, usually for three days, to:  
  - Review work done since the last meeting.  
  - Discuss technical issues.  
  - Vote on new proposals.  
- Meeting locations **rotate among member companies** willing to host.  

---

## **🔹 The TC39 Proposal Process**  
TC39 proposals progress through **five stages**:  

| **Stage** | **Description** |
|-----------|---------------|
| **Stage 0** | Someone in TC39 finds an idea worth pursuing and **champions** it. |
| **Stage 1** | The proposal is formally presented and discussed. |
| **Stage 2** | The proposal is refined and starts taking concrete form. |
| **Stage 3** | Final reviews and refinements before approval. |
| **Stage 4** | The proposal is **eligible** for inclusion in the next ECMAScript version. |

📌 **Pre-Stage 0 Ideas**:  
Many ideas come from the community (social media, blog posts, etc.), but for them to reach **Stage 0**, they must be **championed by a TC39 member**.  

**Timeframe for Approval**:  
A proposal can take **several months to years** to progress through these stages.  

📝 **TC39 proposals are managed publicly on GitHub**:  
🔗 [https://github.com/tc39/proposals](https://github.com/tc39/proposals)  

---

## **🔹 Is There More Than One Version of JavaScript?**  
A common **misconception** is that there are **multiple versions of JavaScript**, but this is **false**.  

- **There is only one official JavaScript**, standardized by **TC39** and **ECMA**.  
- In the early 2000s, **Microsoft maintained a forked version** of JS called **JScript**, which created **multiple incompatible versions** of JS.  
- However, **those days are long gone**.  
- Today, **all major browsers and device manufacturers comply with the single ECMAScript standard**.  

📌 While **JS engines may implement features at different times**, they all adhere to the **same specification** to ensure compatibility.  

---

## **🔹 The Web Rules Everything About JS**  
Although JavaScript runs in **many environments** (e.g., browsers, Node.js, Deno), **the web is the dominant environment** that dictates JavaScript’s evolution.  

- **Web browsers dictate JavaScript’s priorities** because they are the most widely used JS environment.  
- Even though **JavaScript follows a standard (ECMAScript)**, browser engines may **introduce deviations** due to legacy behaviors and compatibility constraints.  

---

## **🔹 JavaScript vs Browser-Specific APIs**  
Not everything **commonly associated with JavaScript is part of the language itself**.  

| **Feature** | **JavaScript Standard?** |
|------------|---------------------|
| `alert("Hello!")` | ❌ **No**, it's a web API (not defined in ECMAScript). |
| `console.log(..)` | ❌ **No**, but nearly all environments include it. |
| `fetch(..)` | ❌ **No**, it's a Web API. |
| `setTimeout(..)` | ❌ **No**, it's provided by the browser and Node.js. |

These features are **added by the environment** (e.g., browsers, Node.js) but **must still follow JavaScript syntax rules**.  

---

## **🔹 JavaScript Specification vs Browser Implementation**  
Although JavaScript is **defined in the ECMAScript specification**, browser-based implementations **sometimes diverge** due to:  

1. **Historical reasons** – Browsers have 20+ years of JavaScript behavior that web content relies on.  
2. **Backward compatibility** – Changing existing behaviors may break older websites.  

💡 **Example of TC39 adjusting the specification to reality**:  
- TC39 **planned to introduce** `Array.prototype.contains(..)`.  
- However, it **conflicted with an old JS framework** still in use.  
- To avoid breaking legacy websites, they **renamed it** `includes(..)`.  
- A similar situation led to **"SmooshGate"**, where `flatten(..)` was renamed to `flat(..)`.  

---

## **🔹 Appendix B: Special Cases for Web JavaScript**  
Since some **browser-specific JavaScript behaviors cannot be changed**, TC39 created **Appendix B** in the specification.  

### **What is Appendix B?**  
- **It lists exceptions** where browser JavaScript does **not fully conform** to ECMAScript.  
- These features **exist only in web environments**, but **not in Node.js or other JS runtimes**.  
- **Examples of Appendix B quirks**:
  - **`escape(..)` and `unescape(..)` functions** (legacy utilities).
  - **Octal literals (`075` instead of `0o75`)**.
  - **Deprecated String methods (`anchor(..)`, `blink()`, etc.).**  

🔹 **Best Practice**: **Avoid using Appendix B features**, as they may not work in all JavaScript environments.  

---

## **🔹 Browser DevTools Console ≠ Pure JavaScript**  
Although browser **Developer Tools consoles** feel like a **JavaScript environment**, they **don’t strictly follow ECMAScript behavior**.  

⚠️ **Gotchas in browser consoles**:  
1. **Variables declared at the global scope may behave differently**.  
2. **Using `"use strict";` may not enable strict mode in the same way as in a `.js` file**.  
3. **Hoisting and scope behaviors may differ across multiple line entries**.  

📌 **Lesson**: **Don’t assume the browser console exactly reflects native JavaScript behavior.**  

---

# **📖 Vocabulary Notes**  

| **Word/Phrase** | **Definition (English)** | **Definition (Spanish)** | **Example Sentence** |
|-----------------|------------------------|-------------------------|----------------------|
| **Comprised** | Composed of several elements. | Compuesto por varias partes. | The team is **comprised** of experts from different fields. |
| **Broad** | Wide or extensive in scope. | Amplio o extenso. | The company offers a **broad** range of services. |
| **Invested** | Having a significant interest in something. | Involucrado o comprometido. | She is deeply **invested** in her work. |
| **Proposal** | A suggested idea for consideration. | Propuesta o idea sugerida. | The committee reviewed new **proposals** for the project. |
| **Champion** | To advocate or promote an idea. | Defender o promover. | He **championed** the project until it was approved. |
| **Eligible** | Meeting the necessary requirements. | Elegible o apto. | Only top students are **eligible** for the scholarship. |
| **Mismatch** | A lack of alignment or compatibility. | Desajuste o discordancia. | There was a **mismatch** between the expected and actual results. |
| **Forked** | Copied and modified separately. | Bifurcado o derivado. | The open-source project was **forked** to add new features. |
| **Conform** | To comply with a standard or rule. | Ajustarse o cumplir. | The software must **conform** to security regulations. |
| **Quirk** | An unusual or unexpected behavior. | Peculiaridad o comportamiento inesperado. | JavaScript has some **quirks** that surprise new developers. |

---

# **📌 Summary**  
✅ **TC39 manages the JavaScript specification** and follows a **five-stage proposal process**.  
✅ **There is only one JavaScript**, not multiple versions.  
✅ **Browser APIs (alert, console, fetch, etc.) are not part of the JS specification**.  
✅ **Appendix B covers browser-specific exceptions** to the JavaScript standard.  
✅ **The browser console is not a pure JavaScript environment**—it has quirks.  
