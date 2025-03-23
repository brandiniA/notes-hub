
# Ruby: Un Lenguaje Puramente Orientado a Objetos

Ruby es un lenguaje orientado a objetos en el que **todo es un objeto**. Esto significa que no existe la distinción tradicional entre tipos primitivos y objetos; incluso números y cadenas son objetos completos.

---

## Modelado con Clases e Instancias

- **Clases e Instancias:**  
  En la programación orientada a objetos, modelas conceptos del mundo real o de tu dominio mediante clases. Por ejemplo, en un sistema de jukebox podrías definir una clase llamada `Song` para representar una canción. Cada clase define la estructura (estado) y el comportamiento (métodos) que comparten sus instancias.

  ```ruby
  song1 = Song.new("Ruby Tuesday")
  song2 = Song.new("Enveloped in Python")
  ```

  Cada instancia tiene un identificador único (`object_id`) y mantiene su estado mediante variables de instancia (por ejemplo, el título de la canción).

- **Variables de Instancia:**  
  Estas variables almacenan el estado único de cada objeto. Por ejemplo, cada canción puede tener una variable de instancia que almacene su título.

---

## Métodos y Envío de Mensajes

- **Definición de Métodos:**  
  Dentro de una clase defines métodos de instancia, bloques de código que realizan acciones sobre el objeto. Por ejemplo, la clase `Song` podría incluir un método `play` que simule la reproducción de la canción.

- **Invocación de Métodos y Sintaxis:**  
  Los métodos se invocan usando la notación de punto:

  ```ruby
  "gin joint".length    #=> 9
  "Rick".index("c")     #=> 2
  42.even?              #=> true
  sam.play              # Invoca el método 'play' en el objeto 'sam'
  ```

  El objeto antes del punto se denomina **receptor**, y lo que sigue es el nombre del método a invocar.

- **Envío de Mensajes:**  
  En Ruby se dice que se "envía un mensaje" a un objeto. El mensaje contiene el nombre del método y los argumentos (si los hay). El objeto busca en su clase el método correspondiente y lo ejecuta si lo encuentra. Este concepto, inspirado en Smalltalk, es fundamental en Ruby.

---

## Diferencias Clave con Otros Lenguajes OO

- **Todo es un Objeto:**  
  A diferencia de lenguajes como Java o Python, en Ruby cada valor es un objeto. Esto proporciona una uniformidad que hace al lenguaje más intuitivo.

- **Ejemplo de Consistencia: Valor Absoluto**  
  En Java, para obtener el valor absoluto de un número, se llama a una función separada y se le pasa el número como argumento:

  ```java
  num = Math.abs(num); // Código en Java
  ```

  En Ruby, la capacidad de obtener el valor absoluto está integrada en el objeto numérico. Simplemente se envía el mensaje `abs` al objeto:

  ```ruby
  num = -1234
  positive = num.abs   # => 1234
  ```

  Esta uniformidad implica que, en Ruby, métodos como `abs` se invocan directamente en los objetos, en lugar de utilizar funciones separadas.

- **Consistencia en el Diseño:**  
  Operaciones que en otros lenguajes se implementan como funciones (por ejemplo, `len(name)` en Python) se realizan como métodos de los objetos en Ruby (por ejemplo, `name.length`).

---

## Vocabulario

- **Jukebox:**  
  Un jukebox es una máquina de discos que reproduce música, permitiendo al usuario seleccionar canciones almacenadas en medios físicos. En el contexto de la programación orientada a objetos, el ejemplo del jukebox se utiliza para ilustrar cómo modelar entidades (como canciones) y sus comportamientos en el código.
