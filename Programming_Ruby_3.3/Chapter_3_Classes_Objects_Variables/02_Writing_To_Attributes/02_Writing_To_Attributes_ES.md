# ✨ Escritura en atributos

> **Resumen rápido:**  
> Ruby permite definir métodos especiales para asignar valores a atributos de un objeto, simulando asignación directa (`obj.attr = valor`) y manteniendo encapsulamiento y control.

---

## 📚 Concepto 1 — _Setters en Ruby_

En Ruby, un método cuyo nombre termina en `=` puede usarse como destino de una asignación. Esto habilita el patrón `obj.attr = valor` y se invoca como `obj.attr=(valor)` (el espacio antes/después de `=` no afecta).

```ruby
class BookInStock
  attr_reader :isbn, :price

  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end

  def price=(new_price)
    @price = new_price
  end
end

book = BookInStock.new("isbn1", 33.80)
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"
book.price = book.price * 0.75
puts "New price = #{book.price}"
```

**Salida esperada:**
```
ISBN = isbn1
Price = 33.8
New price = 25.349999999999998
```

<details>
<summary>🔍 <strong>¿Cómo funciona?</strong></summary>

- `book.price = x` se interpreta como `book.price=(x)`.
- El parser ignora espacios alrededor del `=`.
- También puedes escribir `book.price=(1.50)`, aunque es menos idiomático.
- Nota: si ves `O.75`, es un error tipográfico; debe ser `0.75`.
</details>

---

## 🛠️ Concepto 2 — _Uso de `attr_accessor`_

Ruby ofrece atajos para generar accessors:
- `attr_writer :attr` → solo setter (poco común).
- `attr_accessor :attr` → getter + setter (lo más común).

```ruby
class BookInStock
  attr_reader :isbn
  attr_accessor :price

  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
end

book = BookInStock.new("isbn1", 33.80)
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"
book.price = book.price * 0.75
puts "New price = #{book.price}"
```

**Salida esperada:**
```
ISBN = isbn1
Price = 33.8
New price = 25.349999999999998
```

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
end

book = BookInStock.new("isbn1", 33.80)
puts "ISBN = #{book.isbn}"
puts "Precio original = #{book.price}"

# Aplicar descuento del 25%
book.price = book.price * 0.75
puts "Nuevo precio = #{book.price}"
```

**Salida esperada:**
```
ISBN = isbn1
Precio original = 33.8
Nuevo precio = 25.349999999999998
```

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| _No new words relevant in this section._ |
