
# Símbolos

A menudo, al programar, necesitas usar la misma cadena de texto repetidamente. Por ejemplo, puede que esa cadena se use como clave en un hash o como el nombre de un método. En esos casos, es deseable que dicho valor sea inmutable (para evitar modificaciones) y que su acceso sea rápido y consuma poca memoria.

---

## Los Símbolos en Ruby

Los **símbolos** no son simplemente cadenas optimizadas; son cadenas especiales que:

- Son **inmutables**.
- Se crean **una única vez**.
- Se pueden buscar muy rápidamente.

Los símbolos están diseñados para ser utilizados como claves e identificadores, mientras que las cadenas se emplean para almacenar datos.

Un literal de símbolo comienza con dos puntos (`:`) seguido de un nombre:

```ruby
walk(:north)
look(:east)
```

En este ejemplo, `:north` y `:east` representan valores constantes dentro del código. No es necesario declarar o asignar explícitamente un valor a un símbolo; Ruby se encarga de ello. Además, Ruby garantiza que, sin importar dónde aparezcan en el programa, los símbolos con el mismo nombre serán el mismo objeto internamente.

Esto permite escribir código de manera segura, por ejemplo:

```ruby
def walk(direction)
  if direction == :north
    # ...
  end
end
```

---

## Uso de Símbolos como Claves en Hashes

Los símbolos se utilizan frecuentemente como claves en los hashes. Considera el siguiente ejemplo:

```ruby
instrument_section = {
  :cello    => "string",
  :clarinet => "woodwind",
  :drum     => "percussion",
  :oboe     => "woodwind",
  :trumpet  => "brass",
  :violin   => "string"
}

puts instrument_section[:oboe]   # => "woodwind"
puts instrument_section[:cello]  # => "string"
puts instrument_section["cello"] # => nil
```

En este caso, se observa que una clave símbolo es distinta de una clave cadena; acceder a una con una cadena no devolverá el valor asociado a la misma clave escrita como símbolo.

Debido a su uso frecuente como claves, Ruby ofrece una sintaxis abreviada para crear hashes. En lugar de usar `name => value` cuando la clave es un símbolo, puedes utilizar la sintaxis `name: value`.

**Ejemplo con sintaxis abreviada:**

```ruby
instrument_section = {
  cello:    "string",
  clarinet: "woodwind",
  drum:     "percussion",
  oboe:     "woodwind",
  trumpet:  "brass",
  violin:   "string"
}

puts "An oboe is a #{instrument_section[:oboe]} instrument"
```

**Salida:**

```
An oboe is a woodwind instrument
```

Esta sintaxis fue introducida, en parte, para facilitar el trabajo a los programadores familiarizados con JavaScript y Python, que también usan dos puntos como separador en pares clave/valor.
