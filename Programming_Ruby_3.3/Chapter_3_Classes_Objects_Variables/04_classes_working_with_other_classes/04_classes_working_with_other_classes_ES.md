# ✨ Clases trabajando con otras clases

> **Resumen rápido:**  
> En Ruby, las clases no solo representan entidades externas: también colaboran entre sí. Diseñar “quién hace qué” (responsabilidades) y separar en archivos ayuda a mantener el código claro y escalable.

---

## 📚 Concepto 1 — _Diseñando nuevas clases a partir de responsabilidades_

Además de modelar “cosas del mundo real”, también creamos clases para las **tareas internas del programa**.  
Ejemplo: debemos **consolidar y resumir** datos de múltiples CSV → creamos una clase `CsvReader` que haga esa lectura y acumulación.

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
<summary>🔍 <strong>¿Cómo funciona?</strong></summary>

- `CsvReader` debe acumular datos de **múltiples archivos**.  
- Guardaremos los libros en un **arreglo** de instancia.  
- Para representar cada libro reutilizamos la clase `BookInStock`.  
</details>

---

## 🛠️ Concepto 2 — _Leyendo datos CSV con CsvReader_

La clase `CsvReader` debe leer múltiples archivos CSV y crear un arreglo de objetos `BookInStock` para cada fila.  

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

**Explicación paso a paso:**

- Usamos `CSV.foreach(csv_file_name, headers: true)` para abrir el archivo y procesarlo fila por fila.  
- La opción `headers: true` indica a la librería dos cosas:  
  1. La primera línea del archivo se interpreta como nombres de columna.  
  2. Cada fila posterior se entrega como un **hash**, con los nombres de columna como claves.  
- Dentro del bloque `do ... end`:  
  - Extraemos los valores de `"ISBN"` y `"Price"`.  
  - Creamos un nuevo objeto `BookInStock`.  
  - Lo añadimos al arreglo `@books_in_stock` usando `<<` (que en Ruby significa *append to array*).  
- Con esto, `CsvReader` va acumulando todos los libros en stock a medida que se leen archivos CSV.  

> [!TIP]  
> Si aparece el error:  
> ```
> 'Float': can't convert nil into Float (TypeError)
> ```  
> probablemente tengas **espacios extras** al final de la línea de encabezados en tu archivo CSV. La librería `CSV` es estricta con el formato.

---

## 🚀 De fragmento a programa completo

Ahora dejamos de lado los fragmentos aislados para implementar un **programa funcional**.  
Lo organizaremos en **tres archivos**:  

- `book_in_stock.rb` → define la clase `BookInStock`.  
- `csv_reader.rb` → contiene la clase `CsvReader`.  
- `stock_stats.rb` → programa principal que orquesta la ejecución.

### Paso 1 — `book_in_stock.rb` (modelo de libro)

Creamos el objeto que representa **un libro** y exponemos precio en centavos para evitar errores de `Float`.

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

**¿Por qué así?**

- Guardamos `@isbn` y `@price` (conversión a `Float`).  
- `price_in_cents` evita acumulación de decimales al sumar dinero (mejor aún sería `BigDecimal` en cálculos críticos).

---

### Paso 2 — `csv_reader.rb` (lector/acumulador de CSV)

Encargado de **leer** uno o varios archivos CSV y de **acumular** sus libros.

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

**¿Qué hace cada parte?**

- `require "csv"` carga la librería estándar; `require_relative` incluye nuestro modelo.  
- `read_in_csv_data` abre y recorre el CSV, creando `BookInStock` por fila.  
- `total_value_in_stock` suma en centavos y convierte al final a dólares.  
- `number_of_each_isbn` ejemplifica cómo agrupar libros por ISBN.

---

### Paso 3 — `stock_stats.rb` (programa principal / orquestador)

Toma archivos CSV desde la **línea de comandos**, usa `CsvReader` y muestra resultados.

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

**¿Qué resuelve?**

- `ARGV` contiene los argumentos de la CLI (los nombres de archivos CSV).  
- Para cada archivo: registramos en **stderr** y delegamos la carga a `CsvReader`.  
- Al final, mostramos el **valor total**.

**Ejemplo de ejecución:**

```
$ ruby stock_stats.rb data.csv
Processing data.csv
Total value = 122.07
```

---

## 📖 Glosario

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| _No new words relevant in this section._ |
