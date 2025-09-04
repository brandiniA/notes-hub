# ✨ Reopening Classes

> **Quick summary:**  
> Ruby allows you to **reopen existing classes** (even those in the standard library or third-party code) and add new methods or variables at any time. This technique is known as **monkey-patching**.

---

## 📚 Concept 1 — _What it means to reopen a class_

In Ruby, if you define a class and later declare it again, **no error occurs**: the new definitions are simply **added** to the existing class.

```ruby
class Book
  attr_accessor :title
  # more code...
end
```

Later you can do:

```ruby
class Book
  def uppercase_title
    title.upcase
  end
end
```

✅ The method `uppercase_title` is now part of the `Book` class, along with everything defined earlier.

---

## 🛠️ Concept 2 — _Monkey-patching_

- This process of reopening classes and adding methods is called **monkey-patching**.  
- It even works with classes that are part of Ruby itself.  
- Typically, you’d use it when the class is **not your code**, but you want to extend it with utilities.  
- It’s quite common in frameworks like **Ruby on Rails**.

---

## 🚀 Example in Rails

Rails adds convenience methods to core classes.  
For example, it defines `String#squish`, which removes excessive whitespace:

```ruby
"This   string   has   whitespace".squish
# => "This string has whitespace"
```

Internally, Rails implements it like this:

```ruby
class String
  def squish
    # implementation
  end
end
```

This way, any Ruby string can use `.squish`.

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| monkey-patching | Technique of modifying or extending existing classes (including standard library ones) by reopening them and adding methods. |
