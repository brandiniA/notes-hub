
# Algunos Conceptos Básicos de Ruby

Comenzamos con un breve programa Ruby que define un método para devolver un saludo personalizado y lo invoca un par de veces.

---

## Ejemplo de Programa

**Archivo:** `intro/hello1.rb`

```ruby
def say_hello_goodbye(name)
  result = "I don't know why you say goodbye " + name + ", I say hello"
  return result
end

puts say_hello_goodbye("Bill")
puts say_hello_goodbye("John")
```

**Ejecución en la terminal:**

```bash
ruby hello1.rb
```

**Salida:**

```
I don't know why you say goodbye Bill, I say hello
I don't know why you say goodbye John, I say hello
```

---

## Características del Lenguaje Ruby

- **Sintaxis Despejada:**  
  Ruby es muy legible y no requiere el uso de punto y coma al final de cada sentencia, siempre que cada sentencia se escriba en una línea separada.

- **Comentarios en Ruby:**  
  Los comentarios en Ruby comienzan con el carácter `#` y se extienden hasta el final de la línea.

  **Ejemplo:**

  ```ruby
  # Este es un comentario de una sola línea.
  ```

- **Formato del Código:**  
  La indentación no es significativa para el intérprete, aunque la convención en la comunidad es usar dos espacios (no tabuladores).

- **Definición de Métodos:**  
  Los métodos se definen utilizando la palabra clave `def`, seguida del nombre del método y, opcionalmente, de sus parámetros entre paréntesis. La definición se cierra con la palabra clave `end`.

  > **Nota:** No es necesario declarar una variable antes de asignarle un valor; ésta se crea automáticamente en el momento de la asignación.

- **Llamadas a Métodos:**  
  La línea:
  ```ruby
  puts say_hello_goodbye("John")
  ```
  contiene dos llamadas a métodos:
  1. Una llamada a `say_hello_goodbye` con el argumento `"John"`.
  2. Una llamada a `puts`, cuyo argumento es el resultado de la primera llamada.

  Ruby permite omitir los paréntesis en las llamadas a métodos cuando no son necesarios para la interpretación del código. Por ejemplo, estas dos líneas son equivalentes:

  ```ruby
  puts say_hello_goodbye("John")
  puts(say_hello_goodbye("John"))
  ```

  **Recomendación:** Se recomienda usar paréntesis en la mayoría de los casos, salvo en llamadas muy sencillas o cuando no haya un receptor explícito y solo se pase un argumento.

---

## Manejo de Cadenas (Strings)

Ruby ofrece varias formas de crear objetos de tipo cadena. Las más comunes son:

- **Cadenas Literales:**  
  Se definen entre comillas dobles (`" "`) o comillas simples (`' '`).  
  La diferencia principal es que las cadenas entre comillas dobles procesan secuencias de escape e interpolación, mientras que las de comillas simples hacen muy poco procesamiento.

### Ejemplo de Secuencias de Escape

```ruby
puts "Hello and goodbye to you, \nGeorge"
```

**Salida:**

```
Hello and goodbye to you, 
George
```

> Aquí, `\n` se reemplaza por un salto de línea.

### Ejemplo de Interpolación de Cadenas

Podemos reescribir el método anterior para usar interpolación:

```ruby
def say_hello_goodbye(name)
  result = "I don't know why you say goodbye #{name}, I say hello"
  return result
end

puts say_hello_goodbye("Ringo")
```

**Salida:**

```
I don't know why you say goodbye Ringo, I say hello
```

También se pueden usar expresiones más complejas dentro de la interpolación. Por ejemplo:

```ruby
def say_hello_goodbye(name)
  result = "I don't know why you say goodbye #{name.capitalize}, I say hello"
  return result
end

puts say_hello_goodbye("john")
```

**Salida:**

```
I don't know why you say goodbye John, I say hello
```

Y se puede simplificar aún más el método eliminando la variable temporal y la instrucción `return` (ya que Ruby devuelve el valor de la última expresión evaluada):

```ruby
def say_hello_goodbye(name)
  "I don't know why you say goodbye #{name.capitalize}, I say hello"
end

puts say_hello_goodbye("Paul")
```

**Salida:**

```
I don't know why you say goodbye Paul, I say hello
```

Esta versión es considerada más idiomática, ya que se ajusta al estilo que los programadores expertos en Ruby suelen utilizar. Para más detalles sobre el estilo idiomático, consulta la documentación del gem estándar en [Standard Ruby Style](https://github.com/standardrb/standard).

---

## Convenciones de Nombres en Ruby

- **Variables Locales, Parámetros y Nombres de Métodos:**  
  Deben comenzar con una letra minúscula o un guion bajo (`_`).  
  **Ejemplos:**  
  - Variables locales: `name`, `fish_and_chips`, `x_axis`  
  - Nombres de métodos: `calculate_total`, `print_report`

- **Variables Globales:**  
  Se antepone el signo de dólar (`$`).  
  **Ejemplos:**  
  - `$debug`, `$CUSTOMER`

- **Variables de Instancia:**  
  Comienzan con una arroba (`@`).  
  **Ejemplos:**  
  - `@name`, `@point_1`

- **Variables de Clase:**  
  Comienzan con dos arrobas (`@@`).  
  **Ejemplos:**  
  - `@@total`, `@@symtab`

  > **Nota:** Aunque se mencionan las variables globales y de clase, se usan raramente, ya que pueden dificultar el mantenimiento del código.

- **Nombres de Clases y Módulos:**  
  Deben comenzar con una letra mayúscula y se escriben en CamelCase (cada palabra empieza con mayúscula).  
  **Ejemplos:**  
  - Clases: `String`, `ActiveRecord`, `MyClass`  
  - Módulos: `Enumerable`, `MathTools`

- **Constantes:**  
  Se escriben en mayúsculas, con palabras separadas por guiones bajos.  
  **Ejemplos:**  
  - `FEET_PER_MILE`, `DEBUG`, `MAX_LIMIT`

- **Sufijos en Nombres de Métodos:**  
  Los nombres de métodos pueden terminar con `?`, `!` o `=` para indicar, respectivamente, métodos que devuelven un valor booleano, métodos que pueden modificar el estado del objeto o métodos que actúan como asignaciones.  
  **Ejemplos:**  
  - Métodos booleanos: `empty?`, `valid?`  
  - Métodos que modifican: `sort!`  
  - Métodos de asignación: `name=`
