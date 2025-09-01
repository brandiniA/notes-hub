# ✨ Classes Working with Other Classes

> **Quick summary:**  
> In Ruby, classes don’t just represent external entities: they also collaborate with each other. Designing “who does what” (responsibilities) and splitting code across files keeps programs clean and scalable.

---

## 📚 Concept 1 — _Designing new classes from responsibilities_

Besides modeling “real-world things,” we also create classes for **internal program tasks**.  
Example: we need to **consolidate and summarize** data from multiple CSV files → we design a `CsvReader` class to handle that.

```ruby
class CsvReader
  def initialize
  end

  def read_in_csv_data(csv_file_name)
  end

  def total_value_in_stock
  end

  def number_of_each_isbn
  end
end

reader = CsvReader.new
reader.read_in_csv_data("file1.csv")
reader.read_in_csv_data("file2.csv")

puts "Total value in stock = #{reader.total_value_in_stock}"
```

<details>
<summary>🔍 <strong>How does it work?</strong></summary>

- `CsvReader` must accumulate data from **multiple files**.  
- Books will be stored in an **instance array**.  
- Each book’s data is represented using the `BookInStock` class.  
</details>

---

## 🛠️ Concept 2 — _Reading CSV data with CsvReader_

The `CsvReader` class should read multiple CSV files and create an array of `BookInStock` objects for each row.

```ruby
class CsvReader
  def initialize
    @books_in_stock = []
  end

  def read_in_csv_data(csv_file_name)
    CSV.foreach(csv_file_name, headers: true) do |row|
      @books_in_stock << BookInStock.new(row["ISBN"], row["Price"])
    end
  end
end
```

**Step-by-step explanation:**

- `CSV.foreach(csv_file_name, headers: true)` opens the file and processes it row by row.  
- With `headers: true`:  
  1. The first line is treated as column names.  
  2. Each subsequent row is delivered as a **hash** with column names as keys.  
- Inside the block:  
  - Extract `"ISBN"` and `"Price"`.  
  - Instantiate a `BookInStock`.  
  - Append it to `@books_in_stock` using `<<` (which means *append to array*).  
- This way, `CsvReader` accumulates all books as files are processed.  

> [!TIP]  
> If you see the error:  
> ```
> 'Float': can't convert nil into Float (TypeError)
> ```  
> you likely have **extra spaces** at the end of the header line in your CSV file. The `CSV` library is strict about formats.

---

## 🚀 From fragment to working program

Now we move from isolated fragments to a **functional program**.  
We’ll organize the code into **three files**:  

- `book_in_stock.rb` → defines the `BookInStock` class.  
- `csv_reader.rb` → contains the `CsvReader` class.  
- `stock_stats.rb` → main driver program.

### Step 1 — `book_in_stock.rb` (book model)

Represents a **book** and exposes price in cents to avoid float errors.

```ruby
# book_in_stock.rb
class BookInStock
  attr_reader :isbn, :price

  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end

  def price_in_cents
    (price * 100).round
  end
end
```

**Why this way?**

- Stores `@isbn` and `@price` (converted to `Float`).  
- `price_in_cents` avoids decimal drift when summing money (though `BigDecimal` is even safer).

---

### Step 2 — `csv_reader.rb` (CSV reader/accumulator)

Handles **reading** one or more CSV files and **accumulating** their books.

```ruby
# csv_reader.rb
require "csv"
require_relative "book_in_stock"

class CsvReader
  def initialize
    @books_in_stock = []
  end

  def read_in_csv_data(csv_file_name)
    CSV.foreach(csv_file_name, headers: true) do |row|
      @books_in_stock << BookInStock.new(row["ISBN"], row["Price"])
    end
  end

  def total_value_in_stock
    sum = 0.0
    @books_in_stock.each { |book| sum += book.price_in_cents }
    sum / 100.0
  end

  def number_of_each_isbn
    counts = Hash.new(0)
    @books_in_stock.each { |book| counts[book.isbn] += 1 }
    counts
  end
end
```

**What does each part do?**

- `require "csv"` loads the standard library; `require_relative` loads our model.  
- `read_in_csv_data` iterates through rows, creating `BookInStock` objects.  
- `total_value_in_stock` sums in cents, then converts back to dollars.  
- `number_of_each_isbn` shows how to group by ISBN.

---

### Step 3 — `stock_stats.rb` (main driver program)

Takes CSV files from the **command line**, uses `CsvReader`, and outputs results.

```ruby
# stock_stats.rb
require_relative "csv_reader"

reader = CsvReader.new

ARGV.each do |csv_file_name|
  $stderr.puts "Processing #{csv_file_name}"
  reader.read_in_csv_data(csv_file_name)
end

puts "Total value = #{reader.total_value_in_stock}"
```

**What does it solve?**

- `ARGV` holds command-line arguments (CSV filenames).  
- For each file: log to **stderr** and delegate reading to `CsvReader`.  
- Finally, print the **total value**.

**Execution example:**

```
$ ruby stock_stats.rb data.csv
Processing data.csv
Total value = 122.07
```

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| _No new words relevant in this section._ |
