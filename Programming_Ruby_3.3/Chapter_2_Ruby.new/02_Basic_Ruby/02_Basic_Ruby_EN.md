
# Some Basic Ruby Concepts

We begin with a short Ruby program that defines a method to return a personalized greeting and then invokes it a couple of times.

---

## Example Program

**File:** `intro/hello1.rb`

```ruby
def say_hello_goodbye(name)
  result = "I don't know why you say goodbye " + name + ", I say hello"
  return result
end

puts say_hello_goodbye("Bill")
puts say_hello_goodbye("John")
```

**Execution in the terminal:**

```bash
ruby hello1.rb
```

**Output:**

```
I don't know why you say goodbye Bill, I say hello
I don't know why you say goodbye John, I say hello
```

---

## Characteristics of the Ruby Language

- **Clean Syntax:**  
  Ruby is very readable and does not require semicolons at the end of each statement as long as each statement is on its own line.

- **Comments in Ruby:**  
  Comments in Ruby begin with the `#` character and continue to the end of the line.

  **Example:**

  ```ruby
  # This is a single-line comment.
  ```

- **Code Formatting:**  
  Indentation is not significant to the interpreter, although the Ruby community convention is to use two spaces (not tabs).

- **Method Definition:**  
  Methods are defined using the `def` keyword, followed by the method name and, optionally, its parameters in parentheses. The method definition is closed with the `end` keyword.

  > **Note:** You do not need to declare a variable before assigning a value to it; it is automatically created when assigned.

- **Method Calls:**  
  The line:
  ```ruby
  puts say_hello_goodbye("John")
  ```
  contains two method calls:
  1. A call to `say_hello_goodbye` with the argument `"John"`.
  2. A call to `puts`, whose argument is the result of the first call.

  Ruby allows you to omit parentheses in method calls when they are not required for parsing. For example, these two lines are equivalent:

  ```ruby
  puts say_hello_goodbye("John")
  puts(say_hello_goodbye("John"))
  ```

  **Recommendation:** It is recommended to use parentheses in most cases except in very simple calls or when there is no explicit receiver and only one argument is passed.

---

## Handling Strings

Ruby offers several ways to create string objects. The most common are:

- **String Literals:**  
  Defined between double quotes (`" "`) or single quotes (`' '`).  
  The main difference is that double-quoted strings process escape sequences and interpolation, whereas single-quoted strings perform minimal processing.

### Example of Escape Sequences

```ruby
puts "Hello and goodbye to you, \nGeorge"
```

**Output:**

```
Hello and goodbye to you, 
George
```

> Here, `\n` is replaced with a newline.

### Example of String Interpolation

We can rewrite the previous method to use interpolation:

```ruby
def say_hello_goodbye(name)
  result = "I don't know why you say goodbye #{name}, I say hello"
  return result
end

puts say_hello_goodbye("Ringo")
```

**Output:**

```
I don't know why you say goodbye Ringo, I say hello
```

You can also use more complex expressions within interpolation. For example:

```ruby
def say_hello_goodbye(name)
  result = "I don't know why you say goodbye #{name.capitalize}, I say hello"
  return result
end

puts say_hello_goodbye("john")
```

**Output:**

```
I don't know why you say goodbye John, I say hello
```

The method can be simplified further by eliminating the temporary variable and the explicit `return` (since Ruby returns the value of the last evaluated expression):

```ruby
def say_hello_goodbye(name)
  "I don't know why you say goodbye #{name.capitalize}, I say hello"
end

puts say_hello_goodbye("Paul")
```

**Output:**

```
I don't know why you say goodbye Paul, I say hello
```

This version is considered more idiomatic, as it aligns with the style used by experienced Ruby programmers. For more details on idiomatic Ruby style, see the documentation for the Standard Ruby Style gem at [Standard Ruby Style](https://github.com/standardrb/standard).

---

## Naming Conventions in Ruby

- **Local Variables, Parameters, and Method Names:**  
  They should begin with a lowercase letter or an underscore (`_`).  
  **Examples:**  
  - Local variables: `name`, `fish_and_chips`, `x_axis`  
  - Method names: `calculate_total`, `print_report`

- **Global Variables:**  
  Prefixed with a dollar sign (`$`).  
  **Examples:**  
  - `$debug`, `$CUSTOMER`

- **Instance Variables:**  
  Begin with an at sign (`@`).  
  **Examples:**  
  - `@name`, `@point_1`

- **Class Variables:**  
  Begin with two at signs (`@@`).  
  **Examples:**  
  - `@@total`, `@@symtab`

  > **Note:** Although global and class variables are mentioned, they are rarely used because they can make code harder to maintain.

- **Class and Module Names:**  
  Must begin with an uppercase letter and are written in CamelCase (each word starts with an uppercase letter).  
  **Examples:**  
  - Classes: `String`, `ActiveRecord`, `MyClass`  
  - Modules: `Enumerable`, `MathTools`

- **Constants:**  
  Written in all caps, with words separated by underscores.  
  **Examples:**  
  - `FEET_PER_MILE`, `DEBUG`, `MAX_LIMIT`

- **Method Name Suffixes:**  
  Method names may end with `?`, `!`, or `=` to indicate, respectively, methods that return a boolean value, methods that can modify the object’s state, or methods that act as assignments.  
  **Examples:**  
  - Boolean methods: `empty?`, `valid?`  
  - Methods that modify: `sort!`  
  - Assignment methods: `name=`
