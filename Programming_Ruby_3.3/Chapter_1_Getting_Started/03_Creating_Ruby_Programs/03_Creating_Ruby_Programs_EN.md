
# Creating Ruby Programs

A common way to write Ruby programs is to place your Ruby code in one or more text files. Many popular editors can be used for this, such as VS Code, Vim, Sublime Text, and RubyMine. You can run simple, single-file programs directly from your editor, while more complex projects might be executed from the command line.

---

## Creating and Running a Ruby Program

1. **Open your terminal** and create an empty directory for your project:

   ```bash
   mkdir pickaxe
   ```

2. **Open the folder** with your editor of choice.

3. **Create a new file** named `myprog.rb`.

4. **Add the following Ruby code** to `myprog.rb`:

   ```ruby
   puts "Hello, Ruby Programmer!"
   puts "It is now #{Time.now}"
   ```

   > **Note:**  
   > The second string uses `#{Time.now}` (curly braces) to interpolate the current time into the string, not parentheses.

5. **Run the program** from your terminal by executing:

   ```bash
   ruby myprog.rb
   ```

   **Expected output:**

   ```
   Hello, Ruby Programmer!
   It is now 2025-03-22 23:53:24 -0600
   ```

---

## Using the Shebang Line on Unix Systems

On Unix-based systems, you can use a **shebang** at the beginning of your Ruby file to specify the interpreter. This allows you to run the file as a program without explicitly calling Ruby. Instead of hard-coding the Ruby path, you can use:

```ruby
#!/usr/bin/env ruby
puts "Hello, Ruby Programmer!"
puts "It is now #{Time.now}"
```

If your system supports it, this line tells the OS to search your `PATH` for Ruby and then execute it.

---

## Making Your Ruby File Executable

To run the Ruby file directly as a program, you can make it executable with the `chmod` command:

```bash
chmod +x myprog.rb
```

### What Does `chmod +x myprog.rb` Do?

- **`chmod`:** This is a Unix command used to change the file mode (permissions).
- **`+x`:** This option adds the **executable** permission to the file.
- **`myprog.rb`:** The target file for which you want to enable execution.

By setting the executable flag, you allow the operating system to run the file as a program. After making the file executable, you can run it directly from your terminal:

```bash
./myprog.rb
```

**Example output:**

```
Hello, Ruby Programmer!
It is now 2023-11-02 17:15:44 -0500
```

---

## Running Ruby Programs on Windows

Under Microsoft Windows, you can achieve similar behavior using file associations. Additionally, Ruby GUI applications can be executed by double-clicking their icons in Windows Explorer.
