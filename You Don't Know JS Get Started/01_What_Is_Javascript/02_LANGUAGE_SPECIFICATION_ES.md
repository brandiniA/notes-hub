
# **📌 Capítulo 1: ¿Qué es JavaScript?**  

# **Especificación del Lenguaje**  

## **🔹 TC39 y la Especificación de JavaScript**  
La **especificación oficial** del lenguaje JavaScript es gestionada por **TC39**, un **comité de dirección técnica** compuesto por representantes de diversas **empresas involucradas en la web**, como:  
- **Navegadores**: Mozilla, Google, Apple, etc.  
- **Fabricantes de dispositivos**: Samsung y otros.  

### **¿Cómo opera TC39?**  
- **El comité tiene entre 50 y 100 miembros**, la mayoría **voluntarios** (aunque pueden ser empleados de estas empresas y recibir compensación).  
- **Se reúnen cada dos meses**, generalmente durante tres días, para:  
  - Revisar el trabajo realizado desde la última reunión.  
  - Discutir problemas técnicos.  
  - Votar sobre nuevas propuestas.  
- **Las reuniones se realizan en diferentes empresas miembro**, según quién esté dispuesto a recibirlas.  

---

## **🔹 El Proceso de Propuestas de TC39**  
Las propuestas en TC39 avanzan a través de **cinco etapas**:  

| **Etapa** | **Descripción** |
|-----------|---------------|
| **Etapa 0** | Un miembro de TC39 encuentra una idea valiosa y se convierte en su **defensor**. |
| **Etapa 1** | La propuesta se presenta formalmente y se debate. |
| **Etapa 2** | La propuesta se refina y se define con mayor detalle. |
| **Etapa 3** | Revisión final antes de la aprobación. |
| **Etapa 4** | La propuesta es **elegible** para su inclusión en la siguiente versión de ECMAScript. |

📌 **Ideas en Pre-Etapa 0**:  
Muchas ideas provienen de la comunidad (redes sociales, blogs, etc.), pero para alcanzar la **Etapa 0**, deben ser **apoyadas por un miembro de TC39**.  

### **¿Cuánto tiempo toma aprobar una propuesta?**  
El proceso puede durar **varios meses o años**, dependiendo de la complejidad de la propuesta.  

📝 **Las propuestas de TC39 son públicas en GitHub**:  
🔗 [https://github.com/tc39/proposals](https://github.com/tc39/proposals)  

---

## **🔹 ¿Existen múltiples versiones de JavaScript?**  
Un mito común es que hay **varias versiones de JavaScript**, pero esto es **falso**.  

- **Solo existe una versión oficial de JavaScript**, estandarizada por **TC39 y ECMA**.  
- En los años 2000, **Microsoft creó una bifurcación (fork) de JavaScript llamada "JScript"**, lo que sí generó **múltiples versiones incompatibles**.  
- Sin embargo, **ese problema desapareció hace años**.  
- Hoy en día, **todos los navegadores y fabricantes de dispositivos siguen el mismo estándar ECMAScript**.  

📌 **Aunque los motores de JavaScript pueden implementar características en momentos distintos, todos cumplen con la misma especificación** para garantizar la compatibilidad.  

---

## **🔹 La Web Domina la Evolución de JavaScript**  
Aunque JavaScript se ejecuta en **muchos entornos** (ej. navegadores, Node.js, Deno), **la web sigue siendo el entorno principal** que guía su evolución.  

- **Los navegadores tienen la mayor influencia en el desarrollo de JavaScript**, ya que son su entorno más usado.  
- Aunque **JavaScript sigue el estándar ECMAScript**, los motores de los navegadores pueden **introducir pequeñas diferencias** por razones de compatibilidad con código heredado.  

---

## **🔹 JavaScript vs APIs Específicas del Navegador**  
No todo lo que se asocia con JavaScript **forma parte del lenguaje en sí**.  

| **Característica** | **¿Es parte del estándar de JavaScript?** |
|------------|---------------------|
| `alert("Hola!")` | ❌ **No**, es una API del navegador (no está definida en ECMAScript). |
| `console.log(..)` | ❌ **No**, pero está disponible en casi todos los entornos. |
| `fetch(..)` | ❌ **No**, es una API de la Web. |
| `setTimeout(..)` | ❌ **No**, lo proveen los navegadores y Node.js. |

Estas funciones son **agregadas por el entorno** (navegadores, Node.js, etc.), pero **siguen las reglas de sintaxis de JavaScript**.  

---

## **🔹 Diferencias Entre la Especificación de JavaScript y su Implementación en Navegadores**  
Aunque JavaScript está **definido en la especificación de ECMAScript**, los navegadores a veces **tienen pequeñas diferencias** debido a:  

1. **Razones históricas** – Los navegadores han tenido 20+ años de compatibilidad con código antiguo.  
2. **Compatibilidad con versiones anteriores** – Cambiar ciertos comportamientos podría romper sitios web antiguos.  

💡 **Ejemplo: Cuando TC39 ajustó la especificación por compatibilidad**  
- TC39 **planeaba introducir** `Array.prototype.contains(..)`.  
- Pero **un antiguo framework de JS** aún en uso tenía una función con el mismo nombre.  
- Para evitar problemas, cambiaron el nombre a **`includes(..)`**.  
- Algo similar ocurrió con **"SmooshGate"**, donde `flatten(..)` fue renombrado a `flat(..)`.  

---

## **🔹 Apéndice B: Excepciones en JavaScript para la Web**  
Debido a que algunos **comportamientos de JavaScript en navegadores no pueden cambiarse**, TC39 creó el **Apéndice B** en la especificación.  

### **¿Qué es el Apéndice B?**  
- **Lista excepciones** donde JavaScript en navegadores **no sigue completamente ECMAScript**.  
- Estas funciones **existen solo en navegadores**, pero **no en Node.js u otros entornos JS**.  
- **Ejemplos de peculiaridades del Apéndice B**:
  - **Las funciones `escape(..)` y `unescape(..)`** (utilidades obsoletas).  
  - **Líteros octales (`075` en lugar de `0o75`)**.  
  - **Métodos String obsoletos (`anchor(..)`, `blink()`, etc.)**.  

🔹 **Mejor práctica**: **Evita usar características del Apéndice B**, ya que pueden no ser compatibles con todos los entornos.  

---

## **🔹 La Consola del Navegador No es JavaScript Puro**  
Aunque la **consola del navegador** parece un entorno de JavaScript, **no sigue estrictamente ECMAScript**.  

⚠️ **Diferencias en las consolas del navegador**:  
1. **Las variables declaradas en el "global scope" pueden comportarse diferente**.  
2. **Usar `"use strict";` no siempre habilita el modo estricto de la misma forma que en un archivo `.js`**.  
3. **El hoisting y el alcance pueden diferir entre diferentes entradas en la consola**.  

📌 **Conclusión**: **No asumas que la consola del navegador refleja el comportamiento exacto de JavaScript.**  

---

# **📖 Notas de vocabulario**  

| **Palabra/Frase** | **Definición (Inglés)** | **Definición (Español)** | **Ejemplo en contexto** |
|-----------------|------------------------|-------------------------|----------------------|
| **Comprised** | Composed of several elements. | Compuesto por varias partes. | El equipo está **comprised** de expertos en diferentes áreas. |
| **Broad** | Wide or extensive in scope. | Amplio o extenso. | La empresa ofrece una **broad** gama de servicios. |
| **Champion** | To advocate or promote an idea. | Defender o promover. | Él **championed** la propuesta hasta que fue aprobada. |
| **Forked** | Copied and modified separately. | Bifurcado o derivado. | El código fue **forked** para agregar nuevas características. |

---

# **📌 Resumen**  
✅ **TC39 gestiona la especificación de JavaScript** y sigue un **proceso de cinco etapas**.  
✅ **No hay múltiples versiones de JavaScript**, solo ECMAScript.  
✅ **APIs del navegador (alert, console, fetch, etc.) no forman parte de ECMAScript**.  
✅ **El Apéndice B cubre excepciones específicas del navegador**.  
✅ **La consola del navegador no refleja JavaScript puro**.  
