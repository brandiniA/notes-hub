
# Regular Expressions

Ruby has built-in support for regular expressions, which allow you to specify patterns of characters to match within strings. In Ruby, regular expressions are objects that you can manipulate just like any other object.

---

## Creating Regular Expressions

In Ruby, you typically create a regular expression by writing a pattern between forward slashes:

```ruby
/Ruby|Rust/
```

In this example, the forward slashes delimit the pattern. The pattern itself consists of two alternatives—"Ruby" or "Rust"—separated by a pipe character (`|`), which means "either the thing on the left or the thing on the right."

You can also use parentheses within patterns to group parts of the expression. For example, the following pattern matches the same set of strings:

```ruby
/Ru(by|st)/
```

---

## Repetition and Quantifiers

You can specify repetition in patterns. For example:

- `/ab+c/` matches a string containing an `a` followed by one or more `b`s, followed by a `c`.
- Changing the plus (`+`) to an asterisk (`*`), `/ab*c/` matches a string with an `a`, followed by zero or more `b`s, and then a `c`.

---

## Character Classes and Special Characters

Regular expressions in Ruby support various character classes and special symbols:

- **`\s`** matches any whitespace character.
- **`\d`** matches any digit.
- **`\w`** matches any word character (letters, digits, and underscores).
- A dot (`.`) matches almost any character.

Using these, you can build more complex patterns.

### Examples:

- `/\d\d:\d\d:\d\d/`  
  Matches a time format like `12:34:56`.

- `/Ruby.*Rust/`  
  Matches "Ruby" followed by zero or more characters, then "Rust".

- `/Ruby Rust/`  
  Matches "Ruby" followed by exactly one space, then "Rust".

- `/Ruby *Rust/`  
  Matches "Ruby" followed by zero or more spaces, then "Rust".

- `/Ruby +Rust/`  
  Matches "Ruby" followed by one or more spaces, then "Rust".

- `/Ruby\s+Rust/`  
  Matches "Ruby" followed by one or more whitespace characters, then "Rust".

- `/Java (Ruby|Rust)/`  
  Matches "Java", a space, and then either "Ruby" or "Rust".

---

## Matching Strings Against Regular Expressions

The match operator `=~` can be used to test whether a string contains a pattern defined by a regular expression. If the pattern is found, `=~` returns the starting position (index) of the match; otherwise, it returns `nil`. This allows you to use regular expressions as conditions in `if` and `while` statements.

### Example:

```ruby
line = gets
if line =~ /Ruby|Rust/
  puts "Programming language mentioned: #{line}"
end
```

Both strings and regular expressions have a `match?` method, which is functionally equivalent to using `=~` but returns a boolean value. The `match?` form is more common in modern Ruby:

```ruby
line = gets
if line.match?(/Ruby|Rust/)
  puts "Scripting language mentioned: #{line}"
end
```

---

## Substitution Methods

Ruby provides methods to replace parts of a string that match a regular expression.

- **`sub`** replaces the first occurrence of the pattern:
  
  ```ruby
  line = gets
  newline = line.sub(/Python/, 'Ruby')  # Replaces the first 'Python' with 'Ruby'
  ```

- **`gsub`** replaces every occurrence of the pattern:
  
  ```ruby
  line = gets
  newerline = line.gsub(/Python/, 'Ruby')  # Replaces every 'Python' with 'Ruby'
  ```

You can also replace every occurrence of multiple patterns. For example, to replace both "JavaScript" and "Python" with "Ruby":

```ruby
line = gets
newline = line.gsub(/JavaScript|Python/, 'Ruby')
```
