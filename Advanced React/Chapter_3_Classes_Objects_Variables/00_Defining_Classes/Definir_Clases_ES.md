# ✨ Definir Clases

> **Resumen rápido:**  
> En Ruby, las clases permiten representar conceptos del dominio como estructuras que encapsulan datos (estado) y comportamientos (métodos). Este capítulo profundiza en cómo inicializar objetos, validar datos y personalizar su representación de texto.

---

## 📚 Concepto 1 — _Identificar conceptos del dominio_

En diseño orientado a objetos, el primer paso es identificar los **conceptos del dominio** con los que trabajará el sistema.  
Estos conceptos pueden ser objetos físicos, procesos o cualquier entidad relevante.  

- **Clases** → Representan esos conceptos en el código.  
- **Instancias** → Objetos concretos creados a partir de esas clases.  

**Ejemplo:**
```ruby
class BookInStock
end

a_book = BookInStock.new
another_book = BookInStock.new
```
Aquí `a_book` y `another_book` son dos instancias diferentes de `BookInStock`.  
Aunque son del mismo tipo, inicialmente no contienen información útil; solo tienen un ID interno distinto.

<details>
<summary>🔍 **¿Cómo funciona?**</summary>

- Paso 1: Detecta los conceptos clave (ej. "Libro en inventario").  
- Paso 2: Define una clase para cada concepto.  
- Paso 3: Crea instancias que representen casos específicos.  

</details>

---

## 🛠️ Concepto 2 — _Inicialización con `initialize`_

Para que los objetos tengan datos útiles desde el inicio, definimos el método especial `initialize`.  
Este método se ejecuta automáticamente justo después de que `new` crea el objeto en memoria.

```ruby
class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price) # Conversión y validación
  end
end
```

🔹 **Flujo interno de `new` → `initialize`:**
1. `new` **reserva memoria** para un objeto vacío.  
2. Ruby **llama automáticamente** a `initialize`, pasando los argumentos que se dieron a `new`.  
3. Dentro de `initialize`, se usan **variables de instancia** (`@isbn`, `@price`) para almacenar datos que pertenecerán al objeto.  

> El signo `@` (*at sign*) forma parte del nombre de la variable y la convierte en una **variable de instancia** (estado propio del objeto).  
> No debe confundirse con variables locales (`isbn`), que desaparecen al salir del método.

---

## 🛠️ Concepto 3 — _Validación de datos_

En este ejemplo, usamos `Float(price)` para convertir cualquier valor compatible a número decimal:  
- Acepta `Float`, `Integer` o `String` con un número válido.  
- Si no puede convertirlo, lanza un error y detiene el programa.  

Esto asegura que el atributo `@price` siempre sea un número válido.

---

## 🛠️ Concepto 4 — _`puts`, `p`, `to_s` e `inspect`_

Cuando usamos `puts` con un objeto, Ruby intenta convertirlo a string enviándole el mensaje `to_s`.  

🔹 **Comportamiento por defecto:**  
- Si no hemos sobrescrito `to_s`, Ruby usa la implementación heredada de `Object`.  
- El formato estándar es:  
  ```
  #<NombreClase:IDObjetoHexadecimal>
  ```
  Ejemplo:
  ```
  #<BookInStock:0x0000000104739628>
  ```

🔹 **Sobrescribiendo `to_s`:**
```ruby
class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end

  def to_s
    "ISBN:#{@isbn}, price:#{@price}"
  end
end

puts BookInStock.new("isbn1", 3)
# → ISBN:isbn1, price:3.0
```
- `to_s` debe devolver una versión **amigable para el usuario final**.

---

🔹 **Diferencia entre `puts` y `p`:**  
- `puts` → Llama a `to_s` (salida orientada a usuarios).  
- `p` → Llama a `inspect` (salida orientada a desarrolladores).  

`inspect` suele mostrar más detalles internos, útil para depuración.  
Por defecto, `inspect` devuelve algo como:
```
#<BookInStock:0x0000000102f99720 @isbn="isbn1", @price=3.0>
```

Podemos sobrescribir `inspect` si queremos un formato más claro para debugging.

---

## ✅ Buenas Prácticas

- ✅ Usar `initialize` para establecer siempre un estado válido y completo del objeto.  
- ✅ Validar y convertir datos de entrada (ej. `Float(price)`).  
- ✅ Sobrescribir `to_s` para ofrecer una salida amigable al usuario.  
- ✅ Usar `inspect` o `p` durante depuración para ver valores internos.  
- 🚫 No confundir variables locales (`nombre`) con variables de instancia (`@nombre`).  

---

## 🚀 Ejemplo Completo

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

b1 = BookInStock.new("isbn1", 3)
b2 = BookInStock.new("isbn2", 3.14)
b3 = BookInStock.new("isbn3", "5.67")

puts "Con puts (to_s):"
puts b1
puts b2
puts b3

puts "\nCon p (inspect):"
p b1
p b2
p b3
```

**Salida esperada:**
```
Con puts (to_s):
ISBN:isbn1, price:3.0
ISBN:isbn2, price:3.14
ISBN:isbn3, price:5.67

Con p (inspect):
#<BookInStock isbn="isbn1", price=3.0>
#<BookInStock isbn="isbn2", price=3.14>
#<BookInStock isbn="isbn3", price=5.67>
```

---

## 📖 Glosario

| 🗝️ Palabra en inglés | 📝 Significado / Contexto |
|----------------------|--------------------------|
| **gang of clerks**   | Grupo de oficinistas o empleados administrativos. |
| **trip up**          | Confundir o provocar un error a alguien. |
| **at**               | En Ruby, se refiere al signo `@` usado para variables de instancia. |
| **resilient**        | Capaz de resistir y recuperarse ante dificultades o fallos. |
