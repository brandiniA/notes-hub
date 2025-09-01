# ✨ Los atributos son solo métodos sin argumentos

> **Resumen rápido:**  
> En Ruby, los atributos son en realidad métodos. Esto permite exponer estado interno como si fueran variables, pero con la flexibilidad de usar cálculos o transformaciones.

---

## 📚 Concepto 1 — _Atributos como métodos de solo lectura_

Un atributo no necesita ser un simple envoltorio de una variable de instancia. Puede devolver un valor calculado, como un precio en centavos en lugar de flotante en dólares.

```ruby
class BookInStock
  attr_reader :isbn
  attr_accessor :price

  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end

  def price_in_cents
    (price * 100).round
  end
end

book = BookInStock.new("isbn1", 33.80)
puts "Price = #{book.price}"
puts "Price in cents = #{book.price_in_cents}"
```

**Salida esperada:**
```
Price = 33.8
Price in cents = 3380
```

<details>
<summary>🔍 <strong>¿Cómo funciona?</strong></summary>

- Multiplicamos el precio flotante por 100 para obtener centavos.  
- Usamos `round` porque `Float` no siempre representa valores exactos (`33.8 * 100` produce `3379.9999…`).  
- Con `round` garantizamos un entero consistente.  
- En cálculos financieros se recomienda usar `BigDecimal` en lugar de `Float`.  
</details>

---

## 🛠️ Concepto 2 — _Atributos virtuales con lector y escritor_

Podemos crear un método de escritura paralelo al de lectura, generando un “atributo virtual”.

```ruby
class BookInStock
  attr_reader :isbn
  attr_accessor :price

  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end

  def price_in_cents
    (price * 100).round
  end

  def price_in_cents=(cents)
    @price = cents / 100.0
  end
end

book = BookInStock.new("isbn1", 33.80)
puts "Price = #{book.price}"
puts "Price in cents = #{book.price_in_cents}"
book.price_in_cents = 1234
puts "Price = #{book.price}"
puts "Price in cents = #{book.price_in_cents}"
```

**Salida esperada:**
```
Price = 33.8
Price in cents = 3380
Price = 12.34
Price in cents = 1234
```

> [!TIP]  
> Estos atributos virtuales permiten exponer un estado distinto al interno. El usuario de la clase no necesita saber cómo se almacena realmente.

---

## 🚀 Ejemplo Completo

```ruby
class BookInStock
  attr_reader :isbn
  attr_accessor :price

  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end

  def price_in_cents
    (price * 100).round
  end

  def price_in_cents=(cents)
    @price = cents / 100.0
  end
end

book = BookInStock.new("isbn1", 33.80)
puts "ISBN = #{book.isbn}"
puts "Precio en dólares = #{book.price}"
puts "Precio en centavos = #{book.price_in_cents}"

book.price_in_cents = 1234
puts "Nuevo precio en dólares = #{book.price}"
puts "Nuevo precio en centavos = #{book.price_in_cents}"
```

**Salida esperada:**
```
ISBN = isbn1
Precio en dólares = 33.8
Precio en centavos = 3380
Nuevo precio en dólares = 12.34
Nuevo precio en centavos = 1234
```

---

## 🔎 Atributos, variables de instancia y métodos

En Ruby, un **atributo** es en realidad un método.  
La diferencia entre un atributo y un método regular no es técnica, sino de **intención de diseño**:

- Puede devolver una variable de instancia.  
- Puede calcular un valor sobre la marcha.  
- Puede ser un método con `=` que actualiza el estado.

No hay una frontera estricta entre “atributo” y “método”. La clave está en cómo decides **mostrar el estado** de tu clase hacia afuera:  
- El **estado interno** se almacena en variables de instancia.  
- El **estado externo** se expone como atributos.  
- El resto de operaciones se consideran métodos normales.

Llamar “atributos” a estos métodos ayuda a que otros entiendan qué representa **estado visible** y qué son simplemente **acciones** de la clase.

---

## 📖 Glosario

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| Landmark        | Punto de referencia o hecho relevante; aquí se refiere a la importancia histórica de una obra o concepto. |
