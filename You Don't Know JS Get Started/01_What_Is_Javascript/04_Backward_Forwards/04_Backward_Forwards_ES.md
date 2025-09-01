
# **📌 Capítulo 1: ¿Qué es JavaScript?**  

---

# **Hacia Atrás y Hacia Adelante**  

## **🔹 Compatibilidad Hacia Atrás en JavaScript**  
Uno de los **principios fundamentales** de JavaScript es mantener **compatibilidad hacia atrás**.  

### **¿Qué es la Compatibilidad Hacia Atrás?**  
Un lenguaje es **compatible hacia atrás** si el **código antiguo sigue funcionando en versiones futuras** del lenguaje.  

- **Una vez que algo es válido en JavaScript, siempre será válido**.  
- **Código escrito en 1995 aún debería ejecutarse hoy**, aunque esté obsoleto.  
- TC39 sigue estrictamente este principio: **"No rompemos la web"**.  

📌 **¿Por qué es importante?**  
- Los desarrolladores pueden **confiar en que su código seguirá funcionando en el futuro**.  
- Usar JavaScript para un proyecto es una **inversión segura a largo plazo**.  

---

## **🔹 Los Desafíos de la Compatibilidad Hacia Atrás**  
Garantizar compatibilidad con **25+ años** de JavaScript genera:  
- **Una gran cantidad de desafíos únicos** (técnicamente complejos).  
- **Un estándar muy alto** para introducir cambios en el lenguaje.  
- **El compromiso de nunca eliminar características**, incluso si son defectuosas.  

📌 **Ejemplo:**  
Algunas peculiaridades de JavaScript (ej. `with`, `var` hoisting, coerción con `==`) **no pueden eliminarse**, aunque causen problemas, porque millones de sitios web las utilizan.  

🔹 **TC39 casi nunca introduce cambios incompatibles**. Cuando lo hacen:  
- **Analizan datos de los navegadores** para estimar el impacto.  
- **Los navegadores votan** si el cambio vale la pena.  
- **El objetivo es minimizar interrupciones** y mejorar el lenguaje.  

---

## **🔹 Compatibilidad Hacia Adelante: El Concepto Opuesto**  
La **compatibilidad hacia atrás** permite que **código viejo funcione en versiones nuevas** de JavaScript.  
La **compatibilidad hacia adelante** permitiría que **código nuevo funcione en motores antiguos**, pero **JavaScript no la soporta**.  

### **Ejemplo: HTML & CSS vs JavaScript**  
| **Característica** | **Compatible Hacia Atrás?** | **Compatible Hacia Adelante?** |
|------------|------------------------|------------------------|
| **JavaScript** | ✅ Sí | ❌ No |
| **HTML & CSS** | ❌ No | ✅ Sí |

📌 **¿Qué significa esto?**  
- **HTML/CSS antiguos pueden no funcionar hoy** (no compatibles hacia atrás).  
- **Nuevas características de HTML/CSS son ignoradas por navegadores viejos** sin romper la página (compatibles hacia adelante).  
- **Nuevas características de JavaScript generan errores en motores antiguos**, ya que no reconocen la nueva sintaxis.  

🔹 **Conclusión clave:** **JavaScript debe mantener compatibilidad hacia atrás**, incluso si eso significa conservar características obsoletas.  

---

# **📌 Cómo Manejar la Falta de Compatibilidad Hacia Adelante en JavaScript**  

## **🔹 El Problema de la Compatibilidad Hacia Adelante**  
Si una **nueva característica de JavaScript** (ej. un método de ES2019) se ejecuta en un **motor JS antiguo (ej. de 2016)**, el programa:  
- **Fallará completamente** si usa una nueva sintaxis.  
- **Lanzará un error en tiempo de ejecución** si usa una API no soportada.  

📌 **Ejemplo:**  
```js
// Funciona en ES2019+
console.log(Object.fromEntries([["a", 1], ["b", 2]]));  
```
✅ **Funciona en navegadores modernos (ES2019+)**.  
❌ **Falla en motores JavaScript antiguos (pre-ES2019)**.  

🔹 **Solución:** Usar **transpilación** o **polyfills**.  

---

## **🔹 Solución 1: Transpilación**  
### **¿Qué es la Transpilación?**  
- **La transpilación** convierte **código moderno de JavaScript** en una versión más antigua.  
- El **transpiler más común** es **Babel** ([babeljs.io](https://babeljs.io)).  
- Permite a los desarrolladores escribir **JavaScript moderno** mientras soportan **entornos antiguos**.  

📌 **Ejemplo: Cómo Babel Maneja el Alcance de `let`**  

**Código ES6 Original:**  
```js
if (algo) {
    let x = 3;
    console.log(x);
} else {
    let x = 4;
    console.log(x);
}
```
✅ **Funciona en ES6+**  
❌ **Falla en entornos pre-ES6**  

**Código Transpilado (Versión Antigua de JavaScript):**  
```js
var x$0, x$1;
if (algo) {
    x$0 = 3;
    console.log(x$0);
} else {
    x$1 = 4;
    console.log(x$1);
}
```
🔹 **Babel renombra variables (`x$0`, `x$1`) para simular el alcance de bloque**, asegurando compatibilidad.  

### **¿Por qué usar Transpiladores?**  
✅ Los desarrolladores escriben **código moderno y limpio**.  
✅ El transpilador **lo convierte** para entornos antiguos.  
✅ No es necesario **modificar el código manualmente** para soportar navegadores viejos.  

---

## **🔹 Solución 2: Polyfills (Shims)**  
Si falta una **API de JavaScript** en un entorno antiguo, se puede agregar con un **polyfill**.  

### **¿Qué es un Polyfill?**  
Un **polyfill** es un script que **agrega características faltantes** en motores JavaScript antiguos.  

📌 **Ejemplo: `Promise.prototype.finally()` (Característica de ES2019)**  
```js
// JavaScript moderno (ES2019)
pr
  .then(renderRecords)
  .catch(showError)
  .finally(hideSpinner);  // Siempre se ejecuta
```
✅ **Funciona en ES2019+**  
❌ **Falla en entornos antiguos**  

**Polyfill para `finally()` en entornos pre-ES2019:**  
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
✅ **Esto asegura que `.finally()` funcione incluso en navegadores antiguos**.  

### **¿Por qué usar Polyfills?**  
✅ Permiten que **las nuevas características de JavaScript** funcionen en entornos antiguos.  
✅ Evitan **errores de sintaxis** y **fallos en tiempo de ejecución**.  
✅ Herramientas como **Babel detectan automáticamente los polyfills necesarios**.  

---

# **📖 Notas de Vocabulario**  

| **Palabra/Frase** | **Definición (Inglés)** | **Definición (Español)** | **Ejemplo** |
|-----------------|------------------------|-------------------------|-------------|
| **Whole slew of** | A large number of something. | Gran cantidad de algo. | La nueva actualización introdujo **una gran cantidad de** características. |
| **Hard pressed** | Facing difficulty achieving something. | Dificultado para lograr algo. | Te sería **difícil** encontrar un framework mejor. |
| **Commitment** | A strong dedication or responsibility. | Compromiso. | Aprender JavaScript requiere tiempo y **compromiso**. |
| **Very high bar** | A demanding standard or requirement. | Estándar muy alto. | TC39 tiene un **estándar muy alto** para aprobar nuevas características. |
| **Corner cases** | Unusual or extreme scenarios. | Casos límite. | Debemos probar todos los **casos límite** para garantizar estabilidad. |

---

# **📌 Resumen**  
✅ **JavaScript es compatible hacia atrás, pero no hacia adelante**.  
✅ **Los transpiladores (Babel) convierten código moderno en versiones antiguas**.  
✅ **Los polyfills agregan APIs faltantes en navegadores viejos**.  
✅ **Ambas técnicas son esenciales** para soportar navegadores antiguos y usar JavaScript moderno.  
