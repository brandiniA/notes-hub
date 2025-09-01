# ✨ Objetos y Atributos

> **Resumen rápido:**  
> Los objetos en Ruby encapsulan su estado interno (variables de instancia) y exponen métodos para acceder a ese estado. Los métodos que permiten leer valores se llaman **accesores** (*getters*).

---

## 📚 Concepto 1 — _Estado interno y encapsulamiento_

El estado del objeto vive en **variables de instancia** (`@...`) y es **privado**.  
Cada objeto mantiene su **consistencia** y nadie externo accede directamente a `@isbn` o `@price`.  

```ruby
class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price) # Validación y conversión
  end

  def to_s
    "ISBN:#{@isbn}, price:#{@price}"
  end

  def inspect
    "#<BookInStock isbn=#{@isbn.inspect}, price=#{@price.inspect}>"
  end
end
```

<details>
<summary>🔍 **¿Cómo funciona?**</summary>

- `@isbn` y `@price` pertenecen a la **instancia**.  
- Otras piezas del sistema interactúan mediante **métodos**, no tocando `@...` directo.  
- Esto permite cambiar la implementación sin romper a los consumidores.

</details>

---

## 🛠️ Concepto 2 — _Getters escritos a mano_

Define métodos que **devuelven** el valor de las variables de instancia.

```ruby
class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end

  def isbn
    @isbn
  end

  def price
    @price
  end
end

book = BookInStock.new("isbn1", 12.34)
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"
```

**Salida:**
```
ISBN = isbn1
Price = 12.34
```

> Para otros objetos, llamar a un getter es como llamar a cualquier método.  
> **Encapsulamiento:** puedes cambiar la lógica interna sin que el código cliente lo note.

---

## 🛠️ Concepto 3 — _Atajo con `attr_reader`_

`attr_reader :isbn, :price` crea **getters** equivalentes a los anteriores.

```ruby
class BookInStock
  attr_reader :isbn, :price

  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
end

book = BookInStock.new("isbn1", 12.34)
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"
```

**Salida:**
```
ISBN = isbn1
Price = 12.34
```

---

## 🛠️ Concepto 4 — _Símbolos y nombres_

En `attr_reader :isbn`, el **símbolo** `:isbn` representa el **nombre del método**.  
`@isbn` es la variable de instancia; `isbn` es el **getter** que la expone.  

> **Nota:** `attr_reader` **no** declara variables de instancia.  
> Aparecen cuando **asignas** (p. ej., en `initialize`). Si nunca asignas, leer devuelve `nil`.

---

## ✅ Buenas Prácticas

- ✅ Prefiere **getters claros** (a mano o con `attr_reader`) para exponer solo lo necesario.  
- ✅ Mantén las variables de instancia **privadas**; interactúa siempre por métodos.  
- ✅ Usa getters para **aislar cambios internos** sin romper a quienes consumen la clase.  
- 🚫 No asumas que `attr_reader` crea la variable: **inicialízala** tú (p. ej., en `initialize`).  

---

## 🚀 Ejemplo Completo

```ruby
class BookInStock
  attr_reader :isbn, :price

  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end

  def to_s
    "ISBN:#{@isbn}, price:#{@price}"
  end

  def inspect
    "#<BookInStock isbn=#{@isbn.inspect}, price=#{@price.inspect}>"
  end
end

book = BookInStock.new("isbn1", 12.34)

puts "Con getters:"
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"

puts "\nRepresentaciones:"
puts "to_s → #{book}"  # amigable para usuario final
p book                 # detallado para depuración (inspect)
```

**Salida esperada:**
```
Con getters:
ISBN = isbn1
Price = 12.34

Representaciones:
to_s → ISBN:isbn1, price:12.34
#<BookInStock isbn="isbn1", price=12.34>
```

---

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto |
|----------------------|--------------------------|
| **accessor**         | Método de acceso (getter) para leer atributos. |
| **symbol**           | Identificador inmutable (`:nombre`) usado como nombre/clave. |
| **attribute**        | Dato expuesto por la clase a través de métodos. |
| **encapsulation**    | Ocultar detalles internos y exponer solo una interfaz. |
