
# Getting More Information About Ruby

Since it’s impossible to document **every** aspect of Ruby in a single book, several resources provide detailed documentation to help you explore the language further.

---

## Official and Standard Documentation

- **Standard Library:**  
  Ruby’s standard library contains over **9000 methods**.
- **Official Ruby Documentation:**  
  The official Ruby documentation is available at [docs.ruby-lang.org](https://docs.ruby-lang.org/), which hosts the official pages for different versions of the core and standard libraries.
- **Interactive Documentation in IRB:**  
  While using IRB, you can also access documentation for standard methods as you type.

---

## RubyDoc

- **RubyDoc Overview:**  
  RubyDoc is a tool that generates much of Ruby's documentation based on comments within the source code.
- **Official RubyDoc Site:**  
  Visit [RubyDoc.info](https://www.rubydoc.info/) to access documentation for various Ruby projects that use RubyDoc.

---

## Gems: Third-Party Libraries

- **Gems:**  
  In the Ruby ecosystem, third-party libraries are known as **gems**.
- **Official Gems Listing:**  
  The official listing of Ruby gems is available at [rubygems.org](https://rubygems.org/).

---

## The `ri` Command-Line Tool

Ruby includes a command-line tool called **`ri`** for accessing core documentation.

### How to Use `ri`

1. **Basic Lookup:**  
   Use the command followed by a class or method name to look up its documentation:

   ```bash
   ri <classname_or_method>
   ```

2. **Interactive Prompt:**  
   If you run `ri` without arguments, you'll see a prompt similar to this:

   ```
   ri

   Enter the method name you want to look up.
   You can use tab to autocomplete.
   Enter a blank line to exit.
   ```

3. **Example: Looking Up a Class (e.g., `String`)**

   Typing:

   ```bash
   ri String
   ```

   might produce output like:

   ```
   String < Object

   ------------------------------------------------------------------------
   = Includes:
   Comparable (from ruby core)

   (from ruby core)

   A String object has an arbitrary sequence of bytes, typically
   representing text or binary data. A String object may be created using
   String::new or as literals.

   String objects differ from Symbol objects in that Symbol objects are
   designed to be used as identifiers, rather than text or data.
   ```

   This output continues with a list of methods available on the `String` class.

4. **Example: Looking Up a Method (e.g., `strip`)**

   Typing:

   ```bash
   ri strip
   ```

   might display output similar to:

   ```
   .strip
   (from ruby core)
   === Implementation from String
   ------------------------------------------------------------------------
     strip -> new_string
   ------------------------------------------------------------------------

   Returns a copy of the receiver with leading and trailing whitespace removed.

   Whitespace is defined as any of the following characters: null, horizontal tab, line feed, vertical tab, form feed, carriage return, space.

   " hello ".strip   #=> "hello"
   "\tgoodbye\r\n".strip   #=> "goodbye"
   "\x00\t\n\v\f\r ".strip   #=> ""
   "hello".strip   #=> "hello"
   ```

5. **Exiting `ri`:**  
   To exit the documentation listing or the interactive prompt, simply type **`q`**.
