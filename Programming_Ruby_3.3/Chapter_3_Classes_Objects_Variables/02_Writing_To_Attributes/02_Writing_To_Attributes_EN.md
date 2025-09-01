# ✨ Writing to Attributes

> **Quick summary:**  
> Ruby lets you define special methods to assign values to object attributes, mimicking direct assignment (`obj.attr = value`) while keeping encapsulation and control.

---

## 📚 Concept 1 — _Setters in Ruby_

In Ruby, any method whose name ends with `=` can be used as an assignment target. This enables `obj.attr = value`, which Ruby calls as `obj.attr=(value)` (whitespace around `=` is ignored).

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

**Expected output:**
```
ISBN = isbn1
Price = 33.8
New price = 25.349999999999998
```

<details>
<summary>🔍 <strong>How does it work?</strong></summary>

- `book.price = x` is parsed as `book.price=(x)`.
- Whitespace before/after `=` is ignored by the parser.
- You can also write `book.price=(1.50)`, though it’s less idiomatic.
- Note: if you see `O.75`, that’s a typo; it should be `0.75`.
</details>

---

## 🛠️ Concept 2 — _Using `attr_accessor`_

Ruby provides shortcuts for accessors:
- `attr_writer :attr` → setter only (rare in practice).
- `attr_accessor :attr` → getter + setter (most common).

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

**Expected output:**
```
ISBN = isbn1
Price = 33.8
New price = 25.349999999999998
```

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
end

book = BookInStock.new("isbn1", 33.80)
puts "ISBN = #{book.isbn}"
puts "Original price = #{book.price}"

# Apply 25% discount
book.price = book.price * 0.75
puts "New price = #{book.price}"
```

**Expected output:**
```
ISBN = isbn1
Original price = 33.8
New price = 25.349999999999998
```

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| _No new words relevant in this section._ |
