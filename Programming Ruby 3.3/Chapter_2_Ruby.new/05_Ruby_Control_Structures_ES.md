
# Estructuras de Control

Ruby cuenta con todas las estructuras de control habituales, como sentencias `if` y bucles `while`. A diferencia de otros lenguajes, no es necesario delimitar el cuerpo de estas estructuras con llaves `{}`; en Ruby se utiliza la palabra clave `end` para marcar el final del bloque de código.

---

## Sentencias If

La sintaxis de una sentencia `if` en Ruby es muy clara y concisa. Por ejemplo:

```ruby
today = Time.now

if today.saturday?
  puts "Do chores around the house"
elsif today.sunday?
  puts "Relax"
else
  puts "Go to work"
end
```

**Salida:**

```
Go to work
```

> **Nota:** Ruby utiliza la palabra clave `elsif` (todo junto) para las condiciones adicionales. Dividirla en `else if` ocasionará un error de sintaxis.

---

## Bucles While

Los bucles `while` se utilizan para repetir un bloque de código mientras una condición se cumpla. La estructura se termina con la palabra clave `end`. Por ejemplo:

```ruby
num_pallets = 0
weight = 0

while weight < 100 && num_pallets <= 5
  pallet = next_pallet()
  weight += pallet.weight
  num_pallets += 1
end
```

En este ejemplo, el bucle continuará ejecutándose mientras la variable `weight` sea menor que 100 y el número de palets (`num_pallets`) sea como máximo 5.

La mayoría de las líneas en Ruby son expresiones que devuelven un valor, lo que permite usarlas directamente como condiciones. Por ejemplo, el método `gets` (del módulo Kernel) devuelve la siguiente línea del flujo de entrada estándar o `nil` al llegar al final del archivo. Dado que Ruby trata `nil` como falso en condiciones, este comportamiento se puede aprovechar:

```ruby
while (line = gets)
  puts line.downcase
end
```

Aquí, la asignación a la variable `line` se evalúa en la condición del `while`. Cuando `gets` devuelve `nil` (al alcanzar el final de la entrada), la condición se evalúa como falsa y el bucle termina.

---

## El Módulo Kernel

El módulo **Kernel** es una parte fundamental de Ruby y está incluido en todas las clases de forma predeterminada. Esto significa que sus métodos están disponibles globalmente sin necesidad de referenciar explícitamente al módulo. Métodos esenciales como `puts`, `gets`, `print`, entre otros, provienen de Kernel. Este módulo proporciona muchas de las funcionalidades básicas para la entrada/salida, manejo de excepciones y otras operaciones esenciales en Ruby.

---

## Modificadores de Sentencias

Ruby permite utilizar modificadores de sentencias para simplificar el código cuando el cuerpo de una estructura `if` o `while` es una sola expresión. La sintaxis consiste en escribir la expresión seguida de la palabra clave (`if` o `while`) y la condición.

### Ejemplo con If

Una sentencia `if` tradicional:

```ruby
if radiation > 3000
  puts "Danger, Will Robinson"
end
```

Se puede reescribir de forma más concisa como:

```ruby
puts "Danger, Will Robinson" if radiation > 3000
```

### Ejemplo con While

De forma similar, este bucle `while`:

```ruby
square = 4
while square < 1000
  square = square * square
end
```

Puede resumirse como:

```ruby
square = 4
square = square * square while square < 1000
```

El modificador `if` es particularmente común para usar como cláusula de guarda al comienzo de un método, por ejemplo:

```ruby
return nil if user.nil?
```

El modificador `while` se utiliza con menos frecuencia.
