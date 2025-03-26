
# Symbols

Often, when programming, you need to use the same string repeatedly. For example, that string might be used as a key in a hash or as the name of a method. In such cases, you want the value to be immutable (to prevent accidental modifications) and you want access to be as fast and memory-efficient as possible.

---

## Symbols in Ruby

Symbols are not merely optimized strings—they are special strings that are:

- **Immutable:** Once created, they cannot be changed.
- **Unique:** They are created only once, so the same symbol used anywhere in your program is the same internal object.
- **Fast to Lookup:** Since they are unique and immutable, Ruby can quickly compare and retrieve them.

Symbols are intended to be used as keys and identifiers, while strings are used to hold data.

A symbol literal begins with a colon (`:`) followed by a name:

```ruby
walk(:north)
look(:east)
```

In this example, `:north` and `:east` represent constant values within the code. You don’t need to declare symbols or assign them a value—Ruby handles that automatically. Ruby guarantees that no matter where symbols appear in your program, those with the same name will have the same value (i.e., they are the same internal object). This allows you to safely write code like:

```ruby
def walk(direction)
  if direction == :north
    # ...
  end
end
```

---

## Using Symbols as Hash Keys

Symbols are frequently used as keys in hashes. Consider the following example:

```ruby
instrument_section = {
  :cello    => "string",
  :clarinet => "woodwind",
  :drum     => "percussion",
  :oboe     => "woodwind",
  :trumpet  => "brass",
  :violin   => "string"
}

puts instrument_section[:oboe]    # => "woodwind"
puts instrument_section[:cello]   # => "string"
puts instrument_section["cello"]  # => nil
```

In this case, note that a symbol key is different from a string key; accessing one with a string will not return the value associated with the symbol.

Because symbols are so frequently used as hash keys, Ruby offers a shortcut syntax. Instead of using `name => value` when the key is a symbol, you can use `name: value`:

```ruby
instrument_section = {
  cello:    "string",
  clarinet: "woodwind",
  drum:     "percussion",
  oboe:     "woodwind",
  trumpet:  "brass",
  violin:   "string"
}

puts "An oboe is a #{instrument_section[:oboe]} instrument"
```

**Output:**

```
An oboe is a woodwind instrument
```

This shorthand syntax was introduced partly to make the language more approachable for programmers familiar with JavaScript and Python, both of which use a colon as a separator in key/value pairs.
