
# Blocks

One of Ruby's great strengths is its **blocks**. A code block is a snippet of code that you can pass to a method, much like another parameter. This powerful feature allows methods to be extremely flexible.

## Creating Blocks

Syntactically, blocks can be delimited in two ways:

- Using curly braces `{}` for single-line blocks.
- Using the keywords `do` and `end` for multi-line blocks.

**Example:**

```ruby
foo.each { puts "Hello" }
```

This is another example using a block delimited by `do/end`:

```ruby
foo.each do
  club.enroll(person)
  person.socialize
end
```

Curly braces have higher *precedence* than the `do/end` pair, meaning that in complex expressions they are evaluated with greater priority. In practice, the convention is to use braces for single-line blocks and `do/end` for multi-line blocks.

## Passing Blocks to Methods

You can pass a block as an argument to any method—even if the method doesn't explicitly use the block. The block is placed at the end of the method call, after any other parameters.

**Example:**

```ruby
greet { puts "Hi" }
```

If the method has parameters, they are placed before the block:

```ruby
verbose_greet("Dave", "loyal customer") { puts "Hi" }
```

Remember that only one block can be passed per method.

## Invoking Blocks with `yield`

A method can execute the associated block one or more times using the `yield` statement. This statement transfers control to the code within the block.

**Example:**

```ruby
def call_block
  puts "Start of method"
  yield
  yield
  puts "End of method"
end

call_block { puts "In the block" }
```

**Output:**

```
Start of method
In the block
In the block
End of method
```

In this example, the block is executed twice—once for each call to `yield`.

You can also pass arguments to `yield`, which will be received by the block. Inside the block, the parameters are specified between vertical bars (`| |`).

**Example:**

```ruby
def who_says_what
  yield("Dave", "Hello")
  yield("Andy", "Hi")
end

who_says_what { |person, phrase| puts "#{person} says #{phrase}" }
```

**Output:**

```
Dave says Hello
Andy says Hi
```

## Blocks for Callbacks and Enumeration

Blocks are used to package chunks of code that can be executed later (callbacks) and are widely employed in Ruby’s standard library to perform operations on each element of a collection.

In Ruby, the process of traversing the elements of a collection is known as **enumeration**, which is equivalent to iteration in other languages.

**Example:**

```ruby
animals = ["ant", "bee", "cat", "dog"]

animals.each { |animal| puts animal }
```

**Output:**

```
ant
bee
cat
dog
```

Additionally, many looping constructs that in other languages are built into the language are implemented in Ruby as method calls that invoke an associated block zero or more times. For example:

```ruby
["cat", "dog", "horse"].each { |name| print name, " " }
5.times { print "*" }
3.upto(6) { |i| print i }
("a".."e").each { |char| print char }
```

**Output:**

```
cat dog horse *****3456abcde
```

---

## Vocabulary

**Precedence (precedence):**  
**Definition (according to the dictionary):** The order of priority in which operations are evaluated within an expression or sequence of actions.  
**Examples:**  
1. In the mathematical expression `3 + 4 * 5`, multiplication is evaluated before addition due to the precedence of the operators.  
2. In Ruby, when combining blocks delimited by braces and `do/end` in the same expression, the block with braces is evaluated first because it has higher precedence.

**Yield:**  
**Definition (according to the dictionary):** To yield, give way, or surrender.  
**Examples:**  
1. In finance, "yield" refers to the return or profit produced by an investment, for example, an annual yield of 5% on a bond.  
2. In traffic, a "yield" sign indicates that a driver must give way to other vehicles.