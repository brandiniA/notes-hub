
# 🖥️ Command Line Arguments in Ruby

> **Quick summary:**  
> You can pass arguments to your Ruby scripts from the command line, making your programs more flexible and interactive.

---

## 📚 Concept — _Accessing Command Line Arguments_

When you execute a Ruby program from the command line, any arguments you provide after the script name are accessible from your code.

- **ARGV** is a global array containing each argument as a string.
- **ARGV.size** returns the number of arguments.

---

### **Example**

<details>
<summary>💻 <b>cmd_line.rb</b></summary>

```ruby
puts "You gave #{ARGV.size} arguments"

p ARGV
```
</details>

**Usage in terminal:**

```sh
ruby cmd_line.rb ant bee cat dog
```

**Output:**
```
You gave 4 arguments
["ant", "bee", "cat", "dog"]
```

---

## ✅ Best Practices

- ✅ Use `ARGV` for simple scripts or quick utilities.
- ✅ Validate and handle missing or unexpected arguments to avoid errors.
- 🚫 Don’t rely on ARGV for complex options—prefer argument parsing libraries for advanced use cases.

---

## 🚀 Full Example

```ruby
# greet.rb — Greets each name provided as argument

if ARGV.empty?
  puts "No names provided. Usage: ruby greet.rb Alice Bob Carol"
else
  ARGV.each { |name| puts "Hello, #{name}!" }
end
```

**Example run:**
```sh
ruby greet.rb Alice Bob Carol
```
_Output:_
```
Hello, Alice!
Hello, Bob!
Hello, Carol!
```

---

## 📖 Glossary

| 🗝️ English word     | 📝 Meaning / Context                             |
|---------------------|-------------------------------------------------|
| **Command line**    | Where you type and run commands/programs.       |
| **Argument**        | A value passed to a program/script when running.|
| **ARGV**            | Global array in Ruby with command line arguments.|
| **Global variable** | A variable accessible from anywhere in the code. |

---

## ❓ Questions / Doubts

- How do I handle flags (like `-v` or `--help`) in Ruby scripts?
- What libraries help with parsing complex command line options?
