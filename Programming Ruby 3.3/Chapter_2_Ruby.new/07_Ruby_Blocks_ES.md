
# Bloques

Uno de los grandes puntos fuertes de Ruby son los **bloques**. Un bloque de código es un fragmento que puedes pasar a un método, como si fuera otro parámetro. Esta característica poderosa permite que los métodos sean extremadamente flexibles.

## Creación de Bloques

Sintácticamente, los bloques se pueden delimitar de dos maneras:

- Con llaves `{}` para bloques de una sola línea.
- Con las palabras clave `do` y `end` para bloques de varias líneas.

**Ejemplo:**

```ruby
foo.each { puts "Hello" }
```

Este es otro ejemplo con bloque delimitado por `do/end`:

```ruby
foo.each do
  club.enroll(person)
  person.socialize
end
```

Las llaves tienen mayor *precedence* que la pareja `do/end`, lo que significa que en expresiones complejas se evalúan con mayor prioridad. En la práctica, se usa la convención de llaves para bloques de una sola línea y `do/end` para bloques de varias líneas.

## Pasar Bloques a Métodos

Puedes pasar un bloque como argumento a cualquier método, incluso si el método no utiliza el bloque explícitamente. El bloque se coloca al final de la llamada al método, después de cualquier otro parámetro.

**Ejemplo:**

```ruby
greet { puts "Hi" }
```

Si el método tiene parámetros, estos se colocan antes del bloque:

```ruby
verbose_greet("Dave", "loyal customer") { puts "Hi" }
```

Recuerda que solo se puede pasar un bloque por método.

## Invocar Bloques con `yield`

Un método puede ejecutar el bloque asociado una o más veces utilizando la instrucción `yield`. Esta instrucción transfiere el control al código dentro del bloque.

**Ejemplo:**

```ruby
def call_block
  puts "Start of method"
  yield
  yield
  puts "End of method"
end

call_block { puts "In the block" }
```

**Salida:**

```
Start of method
In the block
In the block
End of method
```

En este ejemplo, el bloque se ejecuta dos veces, una por cada llamada a `yield`.

También puedes pasar argumentos a `yield`, que serán recibidos en el bloque. Dentro del bloque se definen los parámetros entre barras verticales (`| |`).

**Ejemplo:**

```ruby
def who_says_what
  yield("Dave", "Hello")
  yield("Andy", "Hi")
end

who_says_what { |person, phrase| puts "#{person} says #{phrase}" }
```

**Salida:**

```
Dave says Hello
Andy says Hi
```

## Bloques para Callbacks y Enumeración

Los bloques se utilizan para empaquetar fragmentos de código que se pueden ejecutar posteriormente (callbacks) y se emplean ampliamente en la biblioteca estándar de Ruby para realizar operaciones sobre cada elemento de una colección.

En Ruby, el proceso de recorrer los elementos de una colección se conoce como **enumeration**, que equivale a la iteración en otros lenguajes.

**Ejemplo:**

```ruby
animals = ["ant", "bee", "cat", "dog"]

animals.each { |animal| puts animal }
```

**Salida:**

```
ant
bee
cat
dog
```

Además, muchas construcciones de bucle que en otros lenguajes son parte intrínseca del lenguaje se implementan en Ruby como llamadas a métodos que invocan un bloque asociado cero o más veces. Por ejemplo:

```ruby
["cat", "dog", "horse"].each { |name| print name, " " }
5.times { print "*" }
3.upto(6) { |i| print i }
("a".."e").each { |char| print char }
```

**Salida:**

```
cat dog horse *****3456abcde
```

---

## Vocabulario

**Precedence (precedencia):**  
**Significado (según el diccionario):** El orden de prioridad en que se evalúan las operaciones en una expresión o en una secuencia de acciones.  
**Ejemplos:**  
1. En la expresión matemática `3 + 4 * 5`, la multiplicación se evalúa antes que la suma debido a la precedencia de los operadores.  
2. En Ruby, cuando se combinan bloques delimitados por llaves y por `do/end` en una misma expresión, el bloque con llaves se evalúa primero por tener mayor precedencia.

**Yield:**  
**Significado (según el diccionario):** Ceder, dar paso o rendir.  
**Ejemplos:**  
1. En el ámbito financiero, el "yield" se refiere al rendimiento o ganancia que produce una inversión, por ejemplo, un yield anual del 5% en un bono.  
2. En el tráfico, una señal de "yield" indica que el conductor debe ceder el paso a otros vehículos.