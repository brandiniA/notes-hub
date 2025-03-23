# Some Basic Ruby

Let's start with a short Ruby Program.

We'll write a method that returns a personalized greeting. We'll then invoke that method a couple of times.

intro/hello1.rb

def say_hello_goodbye(name)
    result = "I don't know why you say goodbye" + name + ", I say hello"
    return result
end

puts say_hello_goodbye("Bill")
puts say_hello_goodbye("John")

ruby hello1.rb
I don't know why you say goodbye Bill, I say hello
I don't know why you say goodbye John, I say hello

As the example show, Ruby syntax is uncluterred. You don't need semicolons at the ends of statements as long as you put each statement on a separate line.

Ruby comments start with a # character and run to the end of the line.
Code layout is upt to you; identation isn't significant.
That said, two character identation--spaces, not tabs--is the overwhelming choice of the Ruby community.

Methods are defined my keyword def followed by the method name and then the methods parameters between parentheses.

Ruby doesnt use {} to delimit the bodies of compound statements and definitions.
Instead you finish the body with the keyword end.

Note that we didint have to declare the variable result, it sprang into existence when we assigned a value to it.

The line puts say_hello_goodbye("John") actually contains two method calls: one to the method say_hello_goodbye with the argument "John" and the other to the method puts whose argument is the result of the call to say_hello_goodbye.

Why does one call have its arguments in "()" while the other doesn't? I this case its purely a matter of taste the puts method is available to all objects and is often written without parentheses around its argument.
Ruby doesn't require parentheses unless they are directly needed for the interpreter to parse the statement the way you want

These lines are equivalent


puts say_hello_goodbye("John")
puts(say_hello_goodbye("John"))

Recommendation using "()" in all but the simplest cases. You'll see that ruby programs often omit the "()" when the method doesn't have an explicit receiver and only has one argument.

This example also shows Ruby string objects. Ruby hsa many ways to create a string object.
Common one is to use string literals, which are sequences of characters between "" or ''.

The two forms differ in the amount of processing Ruby does on the string while contructing the literal.

In '' case, Ruby does very little. With a few exceptions what you enter in the string literal becomes the string's value.

Ruby does more work. First it look for substitution sequences that start with a backslack character and replaces them with some binary value.

The most common of these substitutions is \n, which is replaced with a newline character. When a string containing a newline is output, that newline becomes a line break.

puts "Hello and goodbye to you, \nGeorge"

Produces
Hello and goodbye to you, 
nGeorge

THe second thing that ruby does with double string is expression interpolation.
Within the string the sequence #{EXPRESSION} is replaced by the value of EXPRESSIon. We could use this to rewrite our previous method:

def say_hello_goodbye(name)
    result = "I don't know why you say goodbye #{name}, I say hello"
    return result
end

puts say_hello_goodbye("Ringo")

output
I don't know why you say goodbye Ringo, I say hello

When ruby contruct this string object, it looks at the current value of name and substitutes it into the string.
Arbitrarily complex expressions are allowed in the #{...}. 

Example

def say_hello_goodbye(name)
    result = "I don't know why you say goodbye #{name.capitalize}, I say hello"
    return result
end

puts say_hello_goodbye("john")

output
I don't know why you say goodbye John, I say hello

Our method say_hello_goodbye we can simplify it some more.
In the absence of an explicit return statement, the value returned is the value of the last expression evaluated, so we can get rid of the temporary variable and the return statement altogether

def say_hello_goodbye(name)
    "I don't know why you say goodbye #{name.capitalize}, I say hello"
end

puts say_hello_goodbye("Paul")

output 
I don't know why you say goodbye Paul, I say hello

This version is considered more idiomatic, by which mean that it's more in line with how expert Ruby programmers have chosen to write Ruby programs. Idiomatic Ruby tends to lean into Ruby's shortcuts and specific syntax. 

Guidelines for idiomatic Ruby style can be found in the documentation for the standard gem at https://github.com/standardrb/standard.

Ruby convention
The first characters of a name indicate how broadly the variable is visible.
Local variables, method parameters, and method names should all start with a lowercase letter or an underscore.

Global variables are prefixed with a dollar sign $, and instnace variables begin with an at sign @.
Class variables start with two at signs @@.

Although we talk about global and class variables here for comleteness you'll find they are rarely used in Ruby programs.

Theres evidence that global variables make programs harder to maintain.

Class variables aren't dangerous as global variables, but they are still tricky to use safely.

People tend to not use them much because they often use easier ways to get similar functionality.

Finally class names, module names and other constants must start with an uppercase letter.

Examples

Local Variable: name   fish_and_chips   x_axis   thx1138   _x   _26 
Instance Variable: @name   @point_1   @X   @_   @plan9 
Class Variable: @@total   @@symtab   @@N   @@x_pos   @@SINGLE 
Global Variable: $debug   $CUSTOMER   $_   $plan9   $Global 
Class Name: String   ActiveRecord   MyClass 
Constant Name: FEET_PER_MILE   DEBUG 

Following this initial character, a name can contain any combination of letters, digits, and underscores, with the exception that the character following an @ sign may not be a digit. But, by convention, multiword instance variables are written with underscores between the words, like first_name or zip_code, and multiword class names are written in MixedCase (sometimes called CamelCase) with each word capitalized, like FirstName or ZipCode. Constant names are written in all caps, with words separated by underscores, like FIRST_NAME or ZIP_CODE. Method names may end with the characters ?, !, and =.