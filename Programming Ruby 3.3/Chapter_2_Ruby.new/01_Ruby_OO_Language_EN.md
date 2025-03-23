Below is the revised English version of your notes on **Ruby as a Pure Object-Oriented Language**, with a modified section that includes a Java example for computing the absolute value:

---

# Ruby: A Pure Object-Oriented Language

Ruby is an object-oriented language where **everything is an object**. This means there is no traditional distinction between primitive types and objects; even numbers and strings are full-fledged objects.

---

## Modeling with Classes and Instances

- **Classes and Instances:**  
  In object-oriented programming, you model real-world or domain-specific concepts using classes. For example, in a jukebox system you might define a class called `Song` to represent a song. Each class defines the structure (state) and behavior (methods) that its instances share.

  ```ruby
  song1 = Song.new("Ruby Tuesday")
  song2 = Song.new("Enveloped in Python")
  ```

  Each instance has a unique identifier (`object_id`) and maintains its state through instance variables (e.g., a song’s title).

- **Instance Variables:**  
  These variables store the unique state of each object. For example, every song might have an instance variable holding its title.

---

## Methods and Message Sending

- **Defining Methods:**  
  Within a class, you define instance methods—blocks of code that perform actions on the object. For instance, the `Song` class might include a method called `play` to simulate playing a song.

- **Method Invocation and Syntax:**  
  Methods are called using dot notation:

  ```ruby
  "gin joint".length    #=> 9
  "Rick".index("c")     #=> 2
  42.even?              #=> true
  sam.play              # Invokes the 'play' method on the object 'sam'
  ```

  The object before the dot is the **receiver**, and what follows is the method name being invoked.

- **Message Sending:**  
  In Ruby, calling a method is often described as sending a message to an object. The message includes the method name and any expected arguments. The object looks up the method in its class and executes it if found. This concept, inspired by Smalltalk, is central to Ruby’s design.

---

## Key Differences from Other OO Languages

- **Everything is an Object:**  
  Unlike languages such as Java or Python, where primitive types may exist separately from objects, in Ruby every value is an object. This consistency makes the language more intuitive.

- **Consistent Design Example: Absolute Value**  
  In Java, to get the absolute value of a number, you call a separate function and pass the number as an argument:

  ```java
  num = Math.abs(num); // Java code
  ```

  In Ruby, obtaining the absolute value is built into the number object. You simply send the `abs` message to the object:

  ```ruby
  num = -1234
  positive = num.abs   # => 1234
  ```

  This uniformity means that, in Ruby, methods like `abs` are called directly on objects, rather than relying on separate functions.

- **Method Consistency:**  
  Operations that in other languages might be implemented as standalone functions (e.g., `len(name)` in Python) are methods on the object in Ruby (e.g., `name.length`).

---

## Vocabulary

- **Jukebox:**  
  A jukebox is a machine that plays music, typically allowing users to select songs stored on physical media. In an object-oriented context, a jukebox example helps illustrate how to model entities (like songs) and their behavior within your code.
