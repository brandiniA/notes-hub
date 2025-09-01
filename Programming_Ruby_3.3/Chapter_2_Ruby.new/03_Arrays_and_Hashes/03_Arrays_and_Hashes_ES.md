
# Arreglos y Hashes

Ruby ofrece varias formas de combinar objetos en colecciones. Dos de las más comunes son los **arreglos** y los **hashes**.

---

## Arreglos

Un **arreglo** es una lista lineal de objetos. Se accede a sus elementos mediante un índice, que es la posición del elemento en el arreglo, comenzando en cero para el primer elemento.

Los arreglos pueden contener objetos de tipos diferentes; por ejemplo, un arreglo puede tener un entero, una cadena y un número flotante en distintos elementos.

**Ejemplo:**

```ruby
a = [1, 'cat', 3.14]  # arreglo con tres elementos
puts "El primer elemento es #{a[0]}"

# Se asigna nil al tercer elemento
a[2] = nil
puts "El arreglo ahora es #{a.inspect}"
```

**Salida:**

```
El primer elemento es 1
El arreglo ahora es [1, "cat", nil]
```

En muchos lenguajes, el concepto de `nil` (o `null`) significa "no hay objeto". En Ruby, eso no es así; `nil` es un objeto, como cualquier otro, que representa la idea de "nada".

---

## Hashes

Un **hash** es una estructura de asociación o diccionario, es decir, un almacén de pares clave/valor. Cada entrada en un hash tiene una clave única y un valor asociado, y se recupera el valor utilizando la clave.

La sintaxis para definir un hash es similar a la de un arreglo, pero en lugar de una lista de elementos se especifican pares clave/valor separados por `=>`.

**Ejemplo:**

```ruby
instrument_section = {
  "cello"    => "string",
  "clarinet" => "woodwind",
  "drum"     => "percussion",
  "oboe"     => "woodwind",
  "trumpet"  => "brass",
  "violin"   => "string"
}
```

En este ejemplo, el lado izquierdo de cada `=>` es la clave, y el lado derecho es el valor correspondiente.  
Las claves en un hash deben ser únicas; no puedes tener dos entradas con la misma clave (por ejemplo, dos entradas para "drum").

Las claves y los valores en un hash pueden ser **objetos arbitrarios**. Esto significa que puedes usar cualquier tipo de objeto (números, cadenas, arreglos, hashes, o incluso objetos personalizados) como clave o valor.

Además, es común tener hashes donde los valores sean otros arreglos, hashes, etc.  
El orden de las claves en un hash es estable y siempre coincide con el orden en que se agregaron. Si asignas un nuevo valor a una clave existente, el valor anterior se sobrescribe.

**Ejemplos de consulta:**

```ruby
instrument_section["oboe"]    # => "woodwind"
instrument_section["cello"]   # => "string"
instrument_section["basson"]  # => nil
```

El valor predeterminado de un hash, cuando se consulta una clave que no existe, es `nil`, lo que representa la ausencia de valor.

---

## Valores Predeterminados en Hashes

A veces es útil cambiar el comportamiento predeterminado. Por ejemplo, si usas un hash para contar la cantidad de veces que aparece cada palabra en un archivo, es conveniente que el valor predeterminado sea cero. Así, puedes utilizar la palabra como clave e incrementar el valor del hash sin preocuparte por si ya has visto esa palabra antes.

Esto se puede lograr especificando un valor predeterminado al crear un hash vacío:

```ruby
histogram = Hash.new(0)
histogram["ruby"]   # => 0
histogram["ruby"] = histogram["ruby"] + 1
histogram["ruby"]   # => 1
```

---

## ¿Qué Significa "Objetos Arbitrarios"?

Cuando decimos que las claves y los valores en un hash pueden ser **objetos arbitrarios**, nos referimos a que pueden ser de cualquier tipo: números, cadenas, símbolos, arreglos, hashes o incluso instancias de clases definidas por el usuario. No existe una restricción estricta sobre el tipo de objeto que se puede utilizar; lo importante es que, en el caso de las claves, sean únicas y comparables.

---