
# **📌 Chapter 1: What Is JavaScript?**  

---

# **Backwards & Forwards**  

## **🔹 Backwards Compatibility in JavaScript**  
One of JavaScript’s **core principles** is maintaining **backwards compatibility**.  

### **What is Backwards Compatibility?**  
A programming language is **backwards-compatible** if **older code remains functional in future versions** of the language.  

- **Once something is valid JavaScript, it stays valid JavaScript forever**.  
- **Code written in 1995 should still work today**, even if it's outdated.  
- TC39 follows this principle strictly: **"We don’t break the web!"**  

📌 **Why is this important?**  
- Developers can **trust that their JS code will work indefinitely**.  
- Choosing JavaScript for a project is a **safe investment** for long-term development.  

---

## **🔹 The Challenges of Backwards Compatibility**  
Ensuring backwards compatibility over **25+ years** of JavaScript creates:  
- **A whole slew of unique challenges** (numerous technical difficulties).  
- **A very high bar** for introducing changes to the language.  
- **The commitment to never remove features**, even if they are flawed.  

📌 **Example:**  
Some old JavaScript quirks (e.g., `with` statements, `var` hoisting, `==` coercion) **cannot be removed**, even if they cause problems, because they exist in millions of websites.  

🔹 **TC39 rarely introduces breaking changes**. When they do:  
- They **analyze browser data** to estimate the impact.  
- Browsers **vote** on whether the change is worth the risk.  
- The **goal is to minimize disruption** while improving the language.  

---

## **🔹 Forward Compatibility: The Opposite Concept**  
Backwards compatibility means **old code still runs in new JS engines**.  
**Forward compatibility** means **new code runs in old JS engines**—and JavaScript **does not support this**.  

### **Example: HTML & CSS vs JavaScript**  
| **Feature** | **Backwards-Compatible?** | **Forwards-Compatible?** |
|------------|------------------------|------------------------|
| **JavaScript** | ✅ Yes | ❌ No |
| **HTML & CSS** | ❌ No | ✅ Yes |

📌 **What does this mean?**  
- **Old HTML/CSS might not work today** (not backwards-compatible).  
- **New HTML/CSS features are ignored in older browsers** but don’t break pages (forwards-compatible).  
- **New JavaScript features crash older JS engines** because they don’t recognize new syntax.  

🔹 **Key takeaway:** **JavaScript must always ensure backwards compatibility**, even if it means keeping outdated features.  

---

# **📌 Handling JavaScript’s Lack of Forward Compatibility**  

## **🔹 The Forward Compatibility Problem**  
If a **new JavaScript feature** (e.g., an ES2019 method) runs in an **old JS engine (e.g., from 2016)**, the program will:  
- **Completely fail** if the feature introduces new syntax.  
- **Throw a runtime error** if it uses an unsupported API.  

📌 **Example:**  
```js
// This works in ES2019+
console.log(Object.fromEntries([["a", 1], ["b", 2]]));  
```
✅ **Works in modern browsers** (ES2019+).  
❌ **Crashes in older JS engines** (before ES2019).  

🔹 **Solution:** Use **transpilation** or **polyfills**.  

---

## **🔹 Solution 1: Transpilation**  
**What is Transpiling?**  
- **Transpiling** means converting **modern JS code** into **an older JS version**.  
- The most common **transpiler** is **Babel** ([babeljs.io](https://babeljs.io)).  
- It allows developers to write **modern JS** while supporting **older environments**.  

📌 **Example: How Babel Handles `let` Scope Issues**  

**Original ES6 Code:**  
```js
if (something) {
    let x = 3;
    console.log(x);
} else {
    let x = 4;
    console.log(x);
}
```
✅ **Works in ES6+**  
❌ **Breaks in pre-ES6 environments**  

**Transpiled Code (Older JavaScript Version):**  
```js
var x$0, x$1;
if (something) {
    x$0 = 3;
    console.log(x$0);
} else {
    x$1 = 4;
    console.log(x$1);
}
```
🔹 **Babel renames variables (`x$0`, `x$1`) to mimic block scope**, ensuring compatibility.  

### **Why Use Transpilers?**  
✅ Developers write **clean modern JS**.  
✅ The transpiler **converts it** for older JS environments.  
✅ No need to manually adjust for **older browsers**.  

---

## **🔹 Solution 2: Polyfills (Shims)**  
If a **new JS API** (not syntax) is missing in an old environment, a **polyfill** can add it manually.  

### **What is a Polyfill?**  
A **polyfill** is a script that **adds missing features** to old JavaScript engines.  

📌 **Example: `Promise.prototype.finally()` (ES2019 Feature)**  
```js
// Modern JS (ES2019)
pr
  .then(renderRecords)
  .catch(showError)
  .finally(hideSpinner);  // Always executes
```
✅ **Works in ES2019+**  
❌ **Breaks in older environments**  

**Polyfill for `finally()` in Pre-ES2019 Environments:**  
```js
if (!Promise.prototype.finally) {
  Promise.prototype.finally = function (fn) {
    return this.then(
      function (v) { return v; },
      function (e) {
        return Promise.resolve(fn()).then(function () { throw e; });
      }
    );
  };
}
```
✅ **This ensures `.finally()` works even in older browsers**.  

### **Why Use Polyfills?**  
✅ Allows **new JS features** to work in **old environments**.  
✅ Prevents **syntax errors** and **runtime crashes**.  
✅ Tools like **Babel automatically detect needed polyfills**.  

---

# **📖 Vocabulary Notes**  

| **Word/Phrase** | **Definition (English)** | **Definition (Spanish)** | **Example Sentence** |
|-----------------|------------------------|-------------------------|----------------------|
| **Whole slew of** | A large number of something. | Gran cantidad de algo. | The new update introduced a **whole slew of** new features. |
| **Hard pressed** | Facing difficulty achieving something. | Dificultado para lograr algo. | You’d be **hard pressed** to find a better framework. |
| **Commitment** | A strong dedication or responsibility. | Compromiso. | Learning JavaScript requires time and **commitment**. |
| **Very high bar** | A demanding standard or requirement. | Estándar muy alto. | TC39 has a **very high bar** for approving new features. |
| **Corner cases** | Unusual or extreme scenarios. | Casos límite. | We must test all **corner cases** to ensure stability. |
| **Non-determinism** | Unpredictable behavior in execution. | No determinismo. | JavaScript’s event loop introduces **non-determinism**. |

---

# **📌 Summary**  
✅ **Backwards compatibility** ensures old JS code works forever.  
✅ **JavaScript is not forwards-compatible**—new features break in old JS engines.  
✅ **Transpiling (Babel)** converts new JS syntax into older JS versions.  
✅ **Polyfills (shims)** manually add missing JS APIs to older environments.  
✅ **Both techniques are essential** for supporting old browsers while using modern JavaScript.  
