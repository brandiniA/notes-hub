
# Obtener Más Información Acerca de Ruby

Dado que es imposible documentar **todas** las funcionalidades de Ruby en un solo libro, se recurre a diversas fuentes de documentación que te ayudarán a profundizar en el lenguaje.

---

## Documentación Oficial y Estándar

- **Biblioteca Estándar:**  
  La biblioteca estándar de Ruby incluye **más de 9000 métodos**.  
- **Documentación Oficial:**  
  Puedes encontrar la documentación oficial de Ruby en [docs.ruby-lang.org](https://docs.ruby-lang.org/). Allí se encuentran las páginas oficiales para las distintas versiones del núcleo y la biblioteca estándar.
- **Documentación Interactiva en IRB:**  
  Mientras escribes en IRB, también puedes consultar la documentación de los métodos estándar a medida que los tecleas.

---

## RubyDoc

- **RubyDoc:**  
  Una herramienta llamada **RubyDoc** genera gran parte de la documentación a partir de los comentarios en el código fuente.  
- **Sitio Oficial:**  
  Visita [RubyDoc.info](https://www.rubydoc.info/) para acceder a la documentación generada para diversos proyectos Ruby que utilizan RubyDoc.

---

## Gems: Librerías de Terceros

- **Gems:**  
  En el mundo Ruby, las librerías de terceros se conocen como **gems**.  
- **Listado Oficial:**  
  La lista oficial de gems se encuentra en [rubygems.org](https://rubygems.org/).

---

## Herramienta de Línea de Comandos: `ri`

Ruby incluye una herramienta de línea de comandos llamada **`ri`** para consultar la documentación del núcleo del lenguaje.

### Cómo Usar `ri`

1. **Consulta Básica:**  
   Escribe el comando seguido del nombre de la clase o método que deseas investigar:

   ```bash
   ri <nombre_de_la_clase>
   ```

2. **Ejemplo sin Argumentos:**  
   Si escribes `ri` sin argumentos, se te mostrará un mensaje interactivo similar a:

   ```
   ri

   Enter the method name you want to look up.
   You can use tab to autocomplete.
   Enter a blank line to exit.
   ```

3. **Consulta de una Clase (por ejemplo, String):**

   Al teclear:

   ```bash
   ri String
   ```

   Obtendrás una salida como la siguiente:

   ```
   String < Object

   ------------------------------------------------------------------------
   = Includes:
   Comparable (from ruby core)

   (from ruby core)

   A String object has an arbitrary sequence of bytes, typically
   representing text or binary data. A String object may be created using
   String::new or as literals.

   String objects differ from Symbol objects in that Symbol objects are
   designed to be used as identifiers, instead of text or data.
   ```

   Esta información continúa listando todos los métodos asociados a la clase `String`.

4. **Consulta de un Método (por ejemplo, `strip`):**

   Al escribir:

   ```bash
   ri strip
   ```

   Verás una salida similar a la siguiente:

   ```
   .strip
   (from ruby core)
   === Implementation from String
   ------------------------------------------------------------------------
     strip -> new_string
   ------------------------------------------------------------------------

   Returns a copy of the receiver with leading and trailing whitespace
   removed.

   Whitespace is defined as any of the following characters: null, horizontal tab, line feed, vertical tab, form feed, carriage return,
   space.

   " hello ".strip   #=> "hello"
   "\tgoodbye\r\n".strip   #=> "goodbye"
   "\x00\t\n\v\f\r ".strip   #=> ""
   "hello".strip   #=> "hello"
   ```

5. **Salir de la Consulta:**  
   Para salir de la lista de resultados o de la sesión de `ri`, simplemente escribe **`q`**.
