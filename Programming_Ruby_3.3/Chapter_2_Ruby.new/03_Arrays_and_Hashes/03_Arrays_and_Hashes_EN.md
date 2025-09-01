
# Arrays and Hashes

Ruby provides several ways to combine objects into collections. Two of the most common are **arrays** and **hashes**.

---

## Arrays

An **array** is a linear list of objects. You access its elements by their index—the number representing the element's position in the array, starting at zero for the first element.

Arrays can hold objects of different types; for example, an array can contain an integer, then a string, then a floating-point number.

**Example:**

```ruby
a = [1, 'cat', 3.14]  # array with three elements
puts "The first element is #{a[0]}"

# Set the third element to nil
a[2] = nil
puts "The array is now #{a.inspect}"
```

**Output:**

```
The first element is 1
The array is now [1, "cat", nil]
```

In many languages, the concept of `nil` (or `null`) means "no object." In Ruby, however, `nil` is an object just like any other—it represents the idea of nothing.

---

## Hashes

A **hash** is an association, or dictionary, meaning it is a key/value store where each entry has a unique key and an associated value. You retrieve the value by its key.

The syntax for creating a hash is similar to that of an array, but instead of a list of elements, you supply pairs of objects separated by `=>`.

**Example:**

```ruby
instrument_section = {
  "cello"    => "string",
  "clarinet" => "woodwind",
  "drum"     => "percussion",
  "oboe"     => "woodwind",
  "trumpet"  => "brass",
  "violin"   => "string"
}
```

In this example, the left side of each `=>` is the key, and the right side is the corresponding value. Keys in a hash must be unique; you cannot have two entries for the same key (for example, two entries for "drum").

The keys and values in a hash can be **arbitrary objects**. This means you can use any kind of object—numbers, strings, arrays, other hashes, or even custom objects—as keys or values.

You can also have hashes where the values are arrays, other hashes, and so on. The order of keys in a hash is stable and will always match the order in which the keys were added. If you assign a new value to an existing key, the old value is overwritten.

**Example of Hash Lookup:**

```ruby
instrument_section["oboe"]    # => "woodwind"
instrument_section["cello"]   # => "string"
instrument_section["bassoon"] # => nil
```

The default value of a hash, when you index a key that it does not contain, is `nil`, which represents the absence of a value.

---

## Default Values in Hashes

Sometimes you may want to change this default behavior. For instance, if you're using a hash to count the number of times each different word occurs in a file, it's convenient to have the default value be zero. This way, you can use the word as the key and increment its corresponding value without worrying about whether you've seen that word before.

You can do this by specifying a default value when creating a new empty hash:

```ruby
histogram = Hash.new(0)
histogram["ruby"]   # => 0
histogram["ruby"] = histogram["ruby"] + 1
histogram["ruby"]   # => 1
```

---

## What Does "Arbitrary Objects" Mean?

When we say that keys and values in a hash can be **arbitrary objects**, we mean that they can be of any type: numbers, strings, symbols, arrays, hashes, or even instances of user-defined classes. There are no strict restrictions on the kind of object you can use—what matters most is that, for keys, they remain unique and comparable.

---