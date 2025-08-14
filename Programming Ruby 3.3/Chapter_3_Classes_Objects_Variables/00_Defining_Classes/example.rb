
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

a = BookInStock.new("isbn1", 33.80)
p a
puts a
b = BookInStock.new("isbn2", 25.00)
p b
puts b
