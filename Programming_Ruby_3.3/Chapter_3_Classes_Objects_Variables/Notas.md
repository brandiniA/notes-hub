Objects and Attributes

The BookInStock objects we've created so far have an internal state (the ISBN
and price). That state is private to those objects—no other object can access
an object's instance variables.

```ruby
class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price) # Validación y conversión
  end

  def to_s
    "ISBN:#{@isbn}, price:#{@price}"
  end

  def inspect
    "#<BookInStock isbn=#{@isbn.inspect}, price=#{@price.inspect}>"
  end
end
```

It means that the object is solely responsible for maintaining its own consistency.

You'll normally define methods that let you access and manipulate the state of
an object, allowing the outside world to interact
with the object. These externally visible facets of an object are called its
attributes.

For our BookInStock objects, the first thing we may need is the ability to fin
out the ISBN and price (so we can count each distinct book and perform pric
calculations). One way of doing that is to write accessor methods:


```ruby
class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price) # Validación y conversión
  end

  def isbn
    @isbn
  end

  def price
    @price
  end

  # ..
end

book = BookInStock.new("isbn1", 12.34)
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"
```

Produces:
```
ISBN = isbn1
Price 12.34
```
As far as other objects are concerned, there's no difference between calling
these attribute accessor methods or calling any other method. This is great
because it means that the internal implementation of the object can change
without the other objects needing to be aware of the change.

Because writing accessor methods is such a common idiom, Ruby provides
convenient shortcuts.

```ruby
class BookInStock
  attr_reader :isbn, :price
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price) # Validación y conversión
  end
  # ..
end

book = BookInStock.new("isbn1", 12.34)
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"
```

Produces:
```
ISBN = isbn1
Price 12.34
```

Symbols, symbols are a convenient way of referencing a name. In this code,
you can think of :isbn as meaning the name isbn and of Plain isbn as meaning
the value of the variable. In this example, we named the accessor methods
isbn and price. The corresponding instance variables are @isbn and @price.
These accessor methods are identical to the ones we wrote by hand earlier
—they'll return the value of the instance variable whose name matches the
name of the accessor method. These methods only allow you to read the
attribute, but not to change it.

There's a common misconception that the attr_reader declaration actually
declares instance variables. 

It doesn't. 

It creates the accessor methods, but the variables themselves don't need to be declared.
An instance variable pops into existence when you assign a value to it, and any instance value that
hasn't been assigned a value returns nil when accessed.

