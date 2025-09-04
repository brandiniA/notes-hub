# ✨ Variables

> **Quick summary:**  
> In Ruby, variables are not objects themselves; they are **references** to objects that live in memory (the heap). This means multiple variables can point to the same object.

---

## 📚 Concept 1 — _Variables reference objects_

Each variable holds a reference to an object.  
We can confirm this:

```ruby
person = "Tim"
puts "The object in 'person' is a #{person.class}"
puts "The object has an id of #{person.object_id}"
puts "and a value of '#{person}'"
```

**Expected output:**
```
The object in 'person' is a String
The object has an id of 60
and a value of 'Tim'
```

🔎 Here:
- Ruby creates a `String` object with the value `"Tim"`.  
- A reference to this object is assigned to the variable `person`.  
- The variable “takes on the personality” of the object: class, id, value.

> [!NOTE]  
> A variable is **not an object**, only a reference to an object in the heap.

---

## 🛠️ Concept 2 — _Variable aliasing_

Let’s see a more complex example:

```ruby
person1 = "Tim"
person2 = person1
person1[0] = 'J'

puts "person1 is #{person1}"
puts "person2 is #{person2}"
```

**Expected output:**
```
person1 is Jim
person2 is Jim
```

**Explanation:**
- We changed the first character of `person1`.  
- Since Ruby strings are **mutable**, the change is also reflected in `person2`.  
- Assigning `person1` to `person2` **does not create a new object**, only copies the reference.  
- Both variables are now **aliases to the same object**.

---

## 🔄 Concept 3 — _Avoiding aliasing with `dup`_

We can create a **new** object with the same content using `.dup`:

```ruby
person1 = "Tim"
person2 = person1.dup
person1[0] = 'J'

puts "person1 is #{person1}"
puts "person2 is #{person2}"
```

**Expected output:**
```
person1 is Jim
person2 is Tim
```

👉 Here, `person2` points to a different object, even though it initially has the same content.

---

## ❄️ Concept 4 — _Freezing objects with `freeze`_

We can prevent modifications to an object by calling `.freeze`:

```ruby
person1 = "Tim"
person2 = person1.freeze
person1[0] = 'J'
```

**Expected output:**
```
prog.rb:4:in `<main>': can't modify frozen String: "Tim" (FrozenError)
```

**Explanation:**
- `freeze` marks the object as **immutable**.  
- Any attempt to modify it raises a `FrozenError`.  

> [!TIP]  
> Numbers and symbols in Ruby are always frozen, so they are **immutable** by default.

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| heap            | Memory area managed by the operating system where objects are dynamically stored during runtime. |
