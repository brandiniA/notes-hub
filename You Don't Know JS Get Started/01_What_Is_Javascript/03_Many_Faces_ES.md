
# **📌 Capítulo 1: ¿Qué es JavaScript?**  

---

# **Muchas Caras**  

## **🔹 ¿Qué es un Paradigma de Programación?**  
En programación, un **paradigma** se refiere a un **enfoque general** o **mentalidad** para estructurar código. Define **cómo se diseña, escribe y organiza un programa**.  

Dentro de un paradigma, existen **innumerables** variaciones de **estilo y estructura**, que pueden verse influenciadas por:  
- **Diferentes lenguajes de programación**.  
- **Distintas bibliotecas y frameworks**.  
- **Convenciones de codificación y preferencias personales**.  

📌 **Conclusión clave:** Un paradigma define **la estructura general de un programa**, pero dentro de esa estructura, hay muchas maneras únicas de implementarlo.  

---

## **🔹 Paradigmas de Programación Comunes**  
Los lenguajes de programación generalmente siguen uno o más de estos **paradigmas**:  

### **1️⃣ Programación Procedimental**  
Organiza el código en una **secuencia de pasos**, ejecutando instrucciones **de manera ordenada**.  
- Utiliza **funciones (procedimientos)** para estructurar operaciones.  
- Común en **C, Pascal y JavaScript (cuando se usan funciones tradicionales)**.  

**🔹 Ejemplo en JavaScript (Estilo Procedimental):**  
```js
function saludar(nombre) {
    console.log("¡Hola, " + nombre + "!");
}

saludar("Alice");  // Output: ¡Hola, Alice!
```
Este enfoque **procesa tareas de forma secuencial** y es común en scripts simples.  

---

### **2️⃣ Programación Orientada a Objetos (OOP)**  
Agrupa **datos y comportamiento juntos** en **objetos** y **clases**.  
- Se basa en **encapsulación, herencia y polimorfismo**.  
- Común en **Java, C++ y JavaScript (mediante clases y prototipos)**.  

**🔹 Ejemplo en JavaScript (Estilo OOP):**  
```js
class Persona {
    constructor(nombre) {
        this.nombre = nombre;
    }

    saludar() {
        console.log(`Hola, mi nombre es ${this.nombre}.`);
    }
}

const alice = new Persona("Alice");
alice.saludar(); // Output: Hola, mi nombre es Alice.
```
Aquí, **los métodos (`saludar()`) y propiedades (`nombre`)** forman parte de la **clase Persona**.  

---

### **3️⃣ Programación Funcional (FP)**  
Se basa en **funciones puras** (sin efectos secundarios) y **trata las funciones como valores**.  
- Usa **inmutabilidad** y evita modificar el estado compartido.  
- Común en **JavaScript, Haskell y Lisp**.  

**🔹 Ejemplo en JavaScript (Estilo FP):**  
```js
const saludar = nombre => `¡Hola, ${nombre}!`;

console.log(saludar("Alice"));  // Output: ¡Hola, Alice!
```
Aquí, **las funciones devuelven valores** en lugar de modificar el estado, lo que las hace **predecibles y reutilizables**.  

---

## **🔹 Lenguajes Multi-Paradigma**  
Algunos lenguajes **soportan múltiples paradigmas**, permitiendo mezclar diferentes estilos de programación. Estos se conocen como **lenguajes multi-paradigma**.  

📌 **Ejemplo:**  
- **C** es **estrictamente procedimental**.  
- **Java** es **principalmente orientado a objetos**.  
- **Python** y **JavaScript** son **multi-paradigma**, lo que significa que soportan **programación procedimental, orientada a objetos y funcional**.  

---

## **🔹 JavaScript: Un Lenguaje Totalmente Multi-Paradigma**  
JavaScript **soporta completamente** la programación procedimental, orientada a objetos y funcional.  

🔹 **¿Qué hace a JavaScript único?**  
- **No obliga a usar un solo paradigma**.  
- **Se puede escribir código procedimental en una función y código funcional en otra**.  
- **La programación basada en clases es opcional, no obligatoria**.  
- **JS permite mezclar paradigmas incluso en la misma línea de código**, en lugar de imponer un único estilo.  

📌 **Ejemplo: Mezcla de Paradigmas en JavaScript**  
```js
class Persona {
    constructor(nombre) {
        this.nombre = nombre;
    }

    saludar() {
        return `Hola, mi nombre es ${this.nombre}.`;
    }
}

// Función FP usando un objeto OO
const presentar = persona => persona.saludar();

const alice = new Persona("Alice");
console.log(presentar(alice));  // Output: Hola, mi nombre es Alice.
```
Aquí, **se combinan OOP (clase) y FP (función pura `presentar`) en el mismo programa**.  

Esta flexibilidad es una de las **mayores fortalezas de JavaScript**, haciéndolo **adaptable a diversas necesidades de programación**.  

---

# **📖 Notas de vocabulario**  

| **Palabra/Frase** | **Definición (Inglés)** | **Definición (Español)** | **Ejemplo en contexto** |
|-----------------|------------------------|-------------------------|----------------------|
| **Paradigm** | A general approach to structuring code. | Paradigma: Un enfoque general para estructurar código. | La programación funcional es un **paradigma** popular en el desarrollo moderno. |
| **Myriad** | A large and diverse quantity of something. | Incontable o innumerable. | Los desarrolladores enfrentan una **myriad** de desafíos al optimizar el rendimiento web. |
| **Procedural** | A step-by-step method of programming. | Procedimental: Código estructurado en una secuencia de pasos. | C es un lenguaje **procedimental** que ejecuta instrucciones en orden. |
| **Object-Oriented (OO)** | A programming style using objects and classes. | Orientado a objetos: Código basado en clases y objetos. | Java es **orientado a objetos**, lo que requiere que todo código esté dentro de clases. |
| **Functional (FP)** | A programming style that emphasizes functions as pure computations. | Programación funcional: Se enfoca en funciones y evita estados mutables. | JavaScript soporta **programación funcional** con funciones de orden superior. |
| **Multi-paradigm** | A language that supports multiple styles of programming. | Multi-paradigma: Soporta múltiples estilos de programación. | Python es un lenguaje **multi-paradigma** que permite tanto OOP como FP. |

---

# **📌 Resumen**  
✅ Un **paradigma** es un **enfoque general** para organizar el código.  
✅ Los tres principales paradigmas de programación son **procedimental, orientado a objetos y funcional**.  
✅ Los **lenguajes multi-paradigma** permiten mezclar diferentes estilos dentro del mismo programa.  
✅ **JavaScript es un lenguaje completamente multi-paradigma**, permitiendo a los desarrolladores elegir cómo estructurar su código.  
✅ **JavaScript permite mezclar paradigmas**, ofreciendo tanto flexibilidad como potencia.