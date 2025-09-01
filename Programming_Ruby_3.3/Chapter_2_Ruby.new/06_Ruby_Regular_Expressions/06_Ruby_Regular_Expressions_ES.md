
# Expresiones Regulares

Ruby cuenta con soporte incorporado para expresiones regulares, que permiten especificar patrones de caracteres para buscar dentro de cadenas. En Ruby, las expresiones regulares son objetos que se pueden manipular como cualquier otro objeto.

---

## Creación de Expresiones Regulares

Generalmente, se crea una expresión regular escribiendo un patrón entre barras inclinadas:

```ruby
/Ruby|Rust/
```

En este ejemplo, las barras delimitan el patrón, el cual consiste en dos alternativas—"Ruby" o "Rust"—separadas por un carácter de tubería (`|`), que significa "lo que está a la izquierda o a la derecha."

También puedes usar paréntesis para agrupar partes de la expresión, de modo que esta expresión es equivalente:

```ruby
/Ru(by|st)/
```

---

## Repetición y Cuantificadores

Puedes especificar repetición dentro de los patrones. Por ejemplo:

- `/ab+c/` coincide con una cadena que contiene una `a` seguida de una o más `b` y luego una `c`.
- Si cambias el signo `+` por un asterisco (`*`), `/ab*c/` coincide con una cadena que tiene una `a`, seguida de cero o más `b` y luego una `c`.

---

## Clases de Caracteres y Caracteres Especiales

Ruby admite diversas clases de caracteres y símbolos especiales en sus expresiones regulares:

- **`\s`** coincide con cualquier carácter de espacio en blanco.
- **`\d`** coincide con cualquier dígito.
- **`\w`** coincide con cualquier carácter que pueda formar parte de una palabra (letras, dígitos y guiones bajos).
- El punto (`.`) coincide con casi cualquier carácter.

Con estos elementos, puedes construir patrones más complejos.

### Ejemplos:

- `/\d\d:\d\d:\d\d/`  
  Coincide con un formato de tiempo, como `12:34:56`.

- `/Ruby.*Rust/`  
  Coincide con "Ruby", seguido de cero o más caracteres, y luego "Rust".

- `/Ruby Rust/`  
  Coincide con "Ruby", seguido de exactamente un espacio, y luego "Rust".

- `/Ruby *Rust/`  
  Coincide con "Ruby", seguido de cero o más espacios, y luego "Rust".

- `/Ruby +Rust/`  
  Coincide con "Ruby", seguido de uno o más espacios, y luego "Rust".

- `/Ruby\s+Rust/`  
  Coincide con "Ruby", seguido de uno o más caracteres de espacio en blanco, y luego "Rust".

- `/Java (Ruby|Rust)/`  
  Coincide con "Java", un espacio y luego, ya sea "Ruby" o "Rust".

---

## Comparando Cadenas con Expresiones Regulares

El operador de coincidencia `=~` se utiliza para verificar si una cadena contiene un patrón definido por una expresión regular. Si se encuentra el patrón, `=~` devuelve la posición (índice) donde comienza la coincidencia; de lo contrario, devuelve `nil`. Esto permite usar expresiones regulares como condiciones en sentencias `if` y `while`.

### Ejemplo:

```ruby
line = gets
if line =~ /Ruby|Rust/
  puts "Programming language mentioned: #{line}"
end
```

Ambos, cadenas y expresiones regulares, disponen del método `match?`, que es equivalente al operador `=~` pero devuelve un valor booleano. La forma `match?` es la más utilizada en Ruby moderno:

```ruby
line = gets
if line.match?(/Ruby|Rust/)
  puts "Scripting language mentioned: #{line}"
end
```

---

## Métodos de Sustitución

Ruby proporciona métodos para reemplazar partes de una cadena que coinciden con una expresión regular.

- **`sub`** reemplaza la primera ocurrencia del patrón:

  ```ruby
  line = gets
  newline = line.sub(/Python/, 'Ruby')  # Reemplaza la primera aparición de 'Python' por 'Ruby'
  ```

- **`gsub`** reemplaza todas las ocurrencias del patrón:

  ```ruby
  line = gets
  newerline = line.gsub(/Python/, 'Ruby')  # Reemplaza todas las ocurrencias de 'Python' por 'Ruby'
  ```

También puedes reemplazar múltiples patrones. Por ejemplo, para reemplazar "JavaScript" y "Python" por "Ruby":

```ruby
line = gets
newline = line.gsub(/JavaScript|Python/, 'Ruby')
```
