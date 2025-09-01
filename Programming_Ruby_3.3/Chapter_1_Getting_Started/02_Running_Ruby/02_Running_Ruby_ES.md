
# Ejecutar Ruby

Existen dos formas principales de ejecutar código Ruby:

- **Entrada interactiva:** Escribe código Ruby directamente en la línea de comandos.
- **Archivos de programa:** Crea archivos Ruby con tu código y ejecútalos como scripts.

> **Consejo:**  
> Escribir código de forma interactiva es excelente para experimentar con el lenguaje. Sin embargo, para proyectos más complejos, es mejor crear archivos de programa que permitan organizar y gestionar el código de manera eficiente.

---

## Verificar la Instalación de Ruby

Para comprobar si Ruby está instalado en tu sistema, abre una terminal y ejecuta:

```bash
ruby --version
```

**Ejemplo de salida:**

```
ruby 3.3.0 (2023-12-25 revision 5124f9ac75) [x86_64-linux]
```

---

## Ejecutar Ruby de Forma Interactiva

### Método 1: Usar el Comando `ruby`

Puedes iniciar una sesión interactiva de Ruby simplemente escribiendo `ruby` en la terminal. Esto abre un entorno en el que puedes ingresar código Ruby directamente.

**Ejemplo:**

```bash
$ ruby
puts "Hello, world"
```

Presiona `Ctrl+D` (o `^D`) para enviar el carácter de fin de archivo (EOF) y salir de la sesión interactiva.

**Salida:**

```
Hello, world
```

**Explicación:**  
En el ejemplo anterior, ingresamos una línea de código Ruby compuesta por dos partes:
- **`puts`:** Es un método predefinido en Ruby (abreviatura de "output string") que imprime el texto en la terminal. En este contexto, un **chunk** se refiere a un bloque discreto de código que realiza una tarea específica.
- **`"Hello, world"`:** Es una cadena de texto (string), es decir, texto rodeado por comillas dobles.

Al combinar ambos elementos, la instrucción `puts "Hello, world"` llama al método `puts` pasando como argumento la cadena `"Hello, world"`, lo que provoca que se imprima en la terminal.

Después de escribir el código, al presionar `Ctrl+D` se envía el carácter EOF, lo que hace que Ruby evalúe y ejecute el contenido ingresado.

---

## Ejecutar Ruby con IRB (Interactive Ruby)

Una forma alternativa y más completa de trabajar interactivamente con Ruby es mediante **IRB (Interactive Ruby)**. IRB es una consola interactiva que ofrece:

- Historial de comandos
- Edición de líneas de código
- Control de trabajos (job control)

### Cómo Utilizar IRB

1. **Iniciar IRB:**  
   Abre IRB ejecutando el siguiente comando en tu terminal:

   ```bash
   irb
   ```

2. **Escribir Código Ruby:**  
   Una vez iniciado, puedes escribir código Ruby y ver inmediatamente el resultado de cada expresión.

3. **Salir de IRB:**  
   Para salir, simplemente escribe `exit` o presiona `Ctrl+D`.

### Ejemplo de Sesión en IRB

```ruby
irb(main):001* def sum(n1, n2)
irb(main):002*   n1 + n2
irb(main):003> end
=> :sum
irb(main):004> sum(3, 4)
=> 7
irb(main):005> sum("cat", "dog")
=> "catdog"
irb(main):006> exit
```

**Explicación:**

- **Línea 1:** Se define un método llamado `sum`.  
  *Definir un método devuelve un símbolo (en este caso, `:sum`) que representa el nombre del método.*

- **Línea 4:** Se llama al método `sum` con los argumentos `3` y `4`, lo que retorna `7`.

- **Línea 5:** Se llama al método `sum` con los argumentos `"cat"` y `"dog"`. En Ruby, al sumar cadenas, estas se concatenan, produciendo la salida `"catdog"`.

- **Línea 6:** Se sale de la sesión de IRB escribiendo `exit`.

> **Nota:**  
> En Ruby 3.1 o superior, IRB puede ofrecer autocompletado de nombres de variables, sugerencias de comandos y salida con color para mejorar la experiencia interactiva.

---

## Vocabulario

- **Chunk:**  
  En este contexto, un *chunk* se refiere a un bloque discreto de código que realiza una tarea específica. Por ejemplo, el método `puts` es un chunk predefinido en Ruby que se encarga de imprimir cadenas en la terminal.
