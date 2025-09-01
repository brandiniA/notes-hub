# ✨ Objects and Attributes

> **Quick summary:**  
> Objects in Ruby encapsulate their internal state (instance variables) and expose methods to access that state. Methods that allow reading values are called **accessors** (*getters*).

---

## 📚 Concept 1 — _Internal state and encapsulation_

An object's state lives in **instance variables** (`@...`) and is **private**.  
Each object maintains its **consistency**, and no external code can directly access `@isbn` or `@price`.  

```ruby
class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price) # Validation and conversion
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
<summary>🔍 **How does it work?**</summary>

- `@isbn` and `@price` belong to the **instance**.  
- Other parts of the system interact via **methods**, not by touching `@...` directly.  
- This allows changing the implementation without breaking consumers.

</details>

---

## 🛠️ Concept 2 — _Manually written getters_

Define methods that **return** the value of instance variables.

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

**Output:**
```
ISBN = isbn1
Price = 12.34
```

> For other objects, calling a getter is the same as calling any method.  
> **Encapsulation:** you can change internal logic without consumers noticing.

---

## 🛠️ Concept 3 — _Shortcut with `attr_reader`_

`attr_reader :isbn, :price` creates **getters** equivalent to the manually written ones.

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

**Output:**
```
ISBN = isbn1
Price = 12.34
```

---

## 🛠️ Concept 4 — _Symbols and names_

In `attr_reader :isbn`, the **symbol** `:isbn` represents the **method name**.  
`@isbn` is the instance variable; `isbn` is the **getter** that exposes it.  

> **Note:** `attr_reader` does **not** declare instance variables.  
> They come into existence when **assigned** (e.g., in `initialize`). If never assigned, reading them returns `nil`.

---

## ✅ Best Practices

- ✅ Prefer **clear getters** (manually or via `attr_reader`) to expose only what's necessary.  
- ✅ Keep instance variables **private**; interact only through methods.  
- ✅ Use getters to **isolate internal changes** without breaking class consumers.  
- 🚫 Do not assume `attr_reader` creates the variable: **initialize it** yourself (e.g., in `initialize`).  

---

## 🚀 Full Example

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

puts "With getters:"
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"

puts "\nRepresentations:"
puts "to_s → #{book}"  # user-friendly
p book                 # detailed for debugging (inspect)
```

**Expected output:**
```
With getters:
ISBN = isbn1
Price = 12.34

Representations:
to_s → ISBN:isbn1, price:12.34
#<BookInStock isbn="isbn1", price=12.34>
```

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| **accessor**    | Access method (getter) to read attributes. |
| **symbol**      | Immutable identifier (`:name`) used as a name/key. |
| **attribute**   | Data exposed by the class through methods. |
| **encapsulation**| Hiding internal details and exposing only an interface. |
