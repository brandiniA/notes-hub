# ✨ Reading and ’Riting in Ruby: Basic I/O

> **Quick summary:**  
> Being comfortable with Ruby’s built-in input/output methods (`puts`, `p`, `gets`) lets you debug faster and build interactive scripts without extra gems.


## 📚 Concept 1 — _Writing to standard output_

`puts` and `p` both send data to the **standard output stream** (`$stdout`) but with different formatting:

```ruby
puts "Hello"      # => Hello\n         (user-friendly)
p    "Hello"      # => "Hello"         (debug-friendly)
```

<details>
<summary>🔍 **How does it work?**</summary>

- `puts` calls `to_s` on its arguments and appends a newline.  
- `p` calls `inspect`, giving you type information, quotes, etc.—great for debugging.  
- Both accept multiple arguments, writing each on its own line.  
- You can redirect output by passing an explicit IO object: `io.puts "msg"`.
</details>

---

## 🛠️ Concept 2 — _Reading from standard input_

Use `gets` (“get string”) to read one line from **standard input** (`$stdin`).  
It returns `nil` at end-of-file, so it fits naturally in loop conditions.

```ruby
while (line = gets)          # stops when gets returns nil
  print line                 # echoes input
end
```

> [!TIP]  
> **EOF on Windows:** Send _Ctrl+Z_ then *Enter* to signal end-of-file when testing in a terminal.

---


## ✅ Best Practices

- ✅ Prefer `puts` for user-facing messages, `p` for debugging.  
- ✅ Treat I/O objects (`$stdin`, `$stdout`, files, sockets) as interchangeable—write polymorphic code.  
- 🚫 Don’t forget the newline: `print` *doesn’t* add one automatically.

---


## 🚀 Full Example

```ruby
# echo.rb — minimal echo program
puts "Type something (Ctrl-D to quit):"

while (line = gets)
  puts "You said: #{line.chomp}"
end

puts "Goodbye!"
```

**Expected output (sample run):**

```
Type something (Ctrl-D to quit):
hello
You said: hello
42
You said: 42
Goodbye!
```

---


## 📖 Glossary

| 🗝️ English word         | 📝 Meaning / Context                              |
|-------------------------|--------------------------------------------------|
| **I/O (Input/Output)**  | General term for reading and writing data.       |
| **Standard input/output**| Default streams connected to the keyboard and terminal. |
| **EOF (End-of-File)**   | Signal that no more data is available for reading. |
| **Polymorphic code**   | Code that works the same way with different types of objects, as long as they share the same interface (methods). In Ruby I/O, this means you can use the same code for $stdin, $stdout, files, or sockets. |


---

## ❓ Questions / Doubts

- Should I prefer `STDOUT.write` over `puts` in performance-critical code?  
- How can I read binary data (e.g., images) safely?  

