# ✨ Defining Classes

> **Quick summary:**  
> In Ruby, classes represent domain concepts as structures that encapsulate data (state) and behaviors (methods). This chapter explains how to initialize objects, validate data, and customize their text representation.

---

## 📚 Concept 1 — _Identify domain concepts_

In object-oriented design, the first step is to identify the **domain concepts** your system will work with.  
These can be physical objects, processes, or any relevant entity.  

- **Classes** → Represent these concepts in code.  
- **Instances** → Concrete objects created from these classes.  

**Example:**
```ruby
class BookInStock
end

a_book = BookInStock.new
another_book = BookInStock.new
```
Here `a_book` and `another_book` are two different instances of `BookInStock`.  
Although they are the same type, they initially hold no useful data; they only have distinct internal IDs.

<details>
<summary>🔍 **How does it work?**</summary>

- Step 1: Identify key concepts (e.g., "Book in stock").  
- Step 2: Define a class for each concept.  
- Step 3: Create instances representing specific cases.  

</details>

---

## 🛠️ Concept 2 — _Initialization with `initialize`_

To ensure objects have useful data from the start, define the special `initialize` method.  
This method runs automatically right after `new` creates the object in memory.

```ruby
class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price) # Conversion and validation
  end
end
```

🔹 **`new` → `initialize` internal flow:**
1. `new` **allocates memory** for an empty object.  
2. Ruby **automatically calls** `initialize`, passing the arguments given to `new`.  
3. Inside `initialize`, **instance variables** (`@isbn`, `@price`) store data belonging to the object.  

> The `@` (*at sign*) is part of the variable name, making it an **instance variable** (object’s own state).  
> It must not be confused with local variables (`isbn`), which vanish once the method ends.

---

## 🛠️ Concept 3 — _Data validation_

In this example, `Float(price)` converts any compatible value into a decimal number:  
- Accepts `Float`, `Integer`, or `String` containing a valid number.  
- Raises an error and stops the program if the value cannot be converted.  

This ensures `@price` is always a valid number.

---

## 🛠️ Concept 4 — _`puts`, `p`, `to_s`, and `inspect`_

When using `puts` with an object, Ruby tries to convert it to a string by sending it the `to_s` message.  

🔹 **Default behavior:**  
- If `to_s` is not overridden, Ruby uses the implementation from `Object`.  
- Standard format:  
  ```
  #<ClassName:ObjectIDInHex>
  ```
  Example:
  ```
  #<BookInStock:0x0000000104739628>
  ```

🔹 **Overriding `to_s`:**
```ruby
class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end

  def to_s
    "ISBN:#{@isbn}, price:#{@price}"
  end
end

puts BookInStock.new("isbn1", 3)
# → ISBN:isbn1, price:3.0
```
- `to_s` should return a **user-friendly** version of the object.

---

🔹 **Difference between `puts` and `p`:**  
- `puts` → Calls `to_s` (user-oriented output).  
- `p` → Calls `inspect` (developer-oriented output).  

`inspect` usually shows more internal details, useful for debugging.  
By default, `inspect` returns something like:
```
#<BookInStock:0x0000000102f99720 @isbn="isbn1", @price=3.0>
```

You can override `inspect` to provide a clearer debug format.

---

## ✅ Best Practices

- ✅ Use `initialize` to always set a complete and valid object state.  
- ✅ Validate and convert incoming data (e.g., `Float(price)`).  
- ✅ Override `to_s` for a user-friendly display.  
- ✅ Use `inspect` or `p` for debugging internal values.  
- 🚫 Do not confuse local variables (`name`) with instance variables (`@name`).  

---

## 🚀 Full Example

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

b1 = BookInStock.new("isbn1", 3)
b2 = BookInStock.new("isbn2", 3.14)
b3 = BookInStock.new("isbn3", "5.67")

puts "With puts (to_s):"
puts b1
puts b2
puts b3

puts "\nWith p (inspect):"
p b1
p b2
p b3
```

**Expected output:**
```
With puts (to_s):
ISBN:isbn1, price:3.0
ISBN:isbn2, price:3.14
ISBN:isbn3, price:5.67

With p (inspect):
#<BookInStock isbn="isbn1", price=3.0>
#<BookInStock isbn="isbn2", price=3.14>
#<BookInStock isbn="isbn3", price=5.67>
```

---

## 📖 Glossary

| 🗝️ English word   | 📝 Meaning / Context |
|-------------------|----------------------|
| **gang of clerks** | Group of office workers or administrative employees. |
| **trip up**       | To confuse or cause someone to make a mistake. |
| **at**            | In Ruby, refers to the `@` sign used for instance variables. |
| **resilient**     | Able to resist and recover from difficulties or failures. |
