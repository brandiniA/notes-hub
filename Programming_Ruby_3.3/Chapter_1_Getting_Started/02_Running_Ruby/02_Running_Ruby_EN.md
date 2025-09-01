
# Running Ruby

There are two primary ways to run Ruby code:

- **Interactive Input:** Type in Ruby code directly at the command line.
- **Program Files:** Create Ruby files containing your code and run them as scripts.

> **Tip:**  
> Typing code interactively is great for experimenting with the language. However, for more complex projects, you'll want to create program files so you can better organize and manage your code.

---

## Checking Your Ruby Installation

To verify if Ruby is installed on your system, open your terminal and run:

```bash
ruby --version
```

**Example output:**

```
ruby 3.3.0 (2023-12-25 revision 5124f9ac75) [x86_64-linux]
```

---

## Running Ruby Interactively

### Method 1: Directly Running `ruby`

You can run Ruby in interactive mode by simply typing `ruby` in your terminal. This opens an interactive session where you can type Ruby code directly.

**Example:**

```bash
$ ruby
puts "Hello, world"
```

Press `Ctrl+D` (or `^D`) to signal end-of-file (EOF) and exit the interactive session.

**Output:**

```
Hello, world
```

**Explanation:**  
In the example above, we entered a single line of Ruby code. This line consists of two parts:
- **`puts`:** This is a method provided by Ruby, short for “output string.” Methods in Ruby are pre-defined chunks of code—**chunk** here refers to a discrete block or portion of code that performs a specific task.
- **`"Hello, world"`:** This is a string literal (text enclosed in double quotes).

When combined, the statement `puts "Hello, world"` calls the `puts` method with the argument `"Hello, world"`, which then prints the string to the terminal.

After typing your code, pressing `Ctrl+D` sends an EOF character, which causes Ruby to evaluate and execute your input.

---

## Running Ruby with Interactive Ruby (irb)

An alternative, and often more powerful, way to run Ruby interactively is by using **Interactive Ruby (irb)**. IRB is a full-featured Ruby shell that includes:

- Command-line history
- Line-editing capabilities
- Job control

### How to Use IRB

1. **Start IRB:**  
   Launch IRB by typing the following command in your terminal:

   ```bash
   irb
   ```

2. **Enter Ruby Code:**  
   Once IRB starts, you can type Ruby code and see the result of each expression immediately.

3. **Exit IRB:**  
   To exit, simply type `exit` or press `Ctrl+D`.

### Example Session

```ruby
irb(main):001* def sum(n1, n2)
irb(main):002*   n1 + n2
irb(main):003> end
=> :sum
irb(main):004> sum(3, 4)
=> 7
irb(main):005> sum("cat", "dog")
=> "catdog"
irb(main):006> exit
```

**Explanation:**

- **Line 1:** We define a method called `sum`.  
  *Defining a method returns a symbol (in this case, `:sum`) that represents the method name.*

- **Line 4:** We call the `sum` method with the arguments `3` and `4`, which returns `7`.

- **Line 5:** We call the `sum` method with string arguments `"cat"` and `"dog"`. In Ruby, adding strings concatenates them, so the output is `"catdog"`.

- **Line 6:** We exit the IRB session by typing `exit`.

> **Note:**  
> If you are using Ruby 3.1 or higher, IRB may provide autocompletion, variable name suggestions, and color-coded output to enhance the interactive experience.

---

## Vocabulary

- **Chunk:**  
  A "chunk" refers to a discrete block or portion of code that performs a specific task. In our example, the `puts` method represents a pre-defined chunk of Ruby code responsible for outputting text.

---
