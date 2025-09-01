# ✨ Attributes Are Just Methods without Arguments

> **Quick summary:**  
> In Ruby, attributes are simply methods. This allows exposing internal state as if they were variables, while keeping the flexibility of calculations or transformations.

---

## 📚 Concept 1 — _Attributes as read-only methods_

An attribute doesn’t have to be a simple wrapper around an instance variable. It can return a calculated value, like price in cents instead of a float in dollars.

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

**Expected output:**
```
Price = 33.8
Price in cents = 3380
```

<details>
<summary>🔍 <strong>How does it work?</strong></summary>

- Multiply the float price by 100 to get cents.  
- Use `round` because `Float` cannot always represent values exactly (`33.8 * 100` produces `3379.9999…`).  
- `round` ensures a consistent integer.  
- For financial calculations, prefer `BigDecimal` instead of `Float`.  
</details>

---

## 🛠️ Concept 2 — _Virtual attributes with reader and writer_

We can create a writer method parallel to the reader, producing a “virtual attribute.”

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

**Expected output:**
```
Price = 33.8
Price in cents = 3380
Price = 12.34
Price in cents = 1234
```

> [!TIP]  
> Virtual attributes let you expose a different representation of state. The user of the class doesn’t need to know how it’s stored internally.

---

## 🚀 Full Example

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
puts "Price in dollars = #{book.price}"
puts "Price in cents = #{book.price_in_cents}"

book.price_in_cents = 1234
puts "New price in dollars = #{book.price}"
puts "New price in cents = #{book.price_in_cents}"
```

**Expected output:**
```
ISBN = isbn1
Price in dollars = 33.8
Price in cents = 3380
New price in dollars = 12.34
New price in cents = 1234
```

---

## 🔎 Attributes, instance variables, and methods

In Ruby, an **attribute** is really just a method.  
The difference between an attribute and a regular method is not technical but about **design intent**:

- It may return an instance variable.  
- It may calculate a value on the fly.  
- It may be a `=` method that updates state.

There’s no strict boundary between attributes and methods. What matters is how you decide to **expose state** to the outside:  
- **Internal state** is stored in instance variables.  
- **External state** is exposed via attributes.  
- Other behaviors are just regular methods.

Calling these methods “attributes” helps signal which parts represent **visible state** versus which are just **actions**.

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| Landmark        | Reference point or significant event; here it refers to the historical importance of a work or concept. |
