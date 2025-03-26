
# Control Structures

Ruby provides all the usual control structures, such as `if` statements and `while` loops. Unlike some other languages, you do not need to enclose the body of these structures in curly braces (`{}`); instead, Ruby uses the keyword `end` to signal the conclusion of a block.

---

## If Statements

Ruby's `if` statement syntax is both clear and concise. For example:

```ruby
today = Time.now

if today.saturday?
  puts "Do chores around the house"
elsif today.sunday?
  puts "Relax"
else
  puts "Go to work"
end
```

**Output:**

```
Go to work
```

> **Note:** Ruby uses the keyword `elsif` (as one word) for additional conditions. Splitting it as `else if` will result in a syntax error.

---

## While Loops

`while` loops repeat a block of code as long as a condition is true. The loop is terminated with the keyword `end`. For example:

```ruby
num_pallets = 0
weight = 0

while weight < 100 && num_pallets <= 5
  pallet = next_pallet()
  weight += pallet.weight
  num_pallets += 1
end
```

In this example, the loop continues to execute as long as the variable `weight` is less than 100 and the number of pallets (`num_pallets`) is at most 5.

Most lines in Ruby are expressions that return a value, which allows you to use them directly as conditions. For instance, the `gets` method (from the Kernel module) returns the next line from the standard input stream or `nil` when the end of the file is reached. Since Ruby treats `nil` as false in conditions, this behavior can be exploited:

```ruby
while (line = gets)
  puts line.downcase
end
```

Here, the assignment to the variable `line` is evaluated as the condition for the `while` loop. When `gets` returns `nil` (indicating the end of input), the condition evaluates as false, and the loop terminates.

---

## The Kernel Module

The **Kernel** module is a fundamental part of Ruby that is mixed into every class by default. This means its methods are available globally without needing to explicitly reference the module. Essential methods such as `puts`, `gets`, and `print`, among others, come from Kernel. This module provides many of the core functionalities for input/output, exception handling, and other basic operations in Ruby.

---

## Statement Modifiers

Ruby allows you to use statement modifiers as a shorthand when the body of an `if` or `while` statement is a single expression. The syntax involves writing the expression, followed by the keyword (`if` or `while`) and the condition.

### Example with `if`

A traditional `if` statement:

```ruby
if radiation > 3000
  puts "Danger, Will Robinson"
end
```

Can be more concisely written as:

```ruby
puts "Danger, Will Robinson" if radiation > 3000
```

### Example with `while`

Similarly, this `while` loop:

```ruby
square = 4
while square < 1000
  square = square * square
end
```

Can be shortened to:

```ruby
square = 4
square = square * square while square < 1000
```

The `if` modifier is commonly used as a guard clause at the beginning of a method, for example:

```ruby
return nil if user.nil?
```

The `while` modifier is less frequently used.
