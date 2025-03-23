
# Crear Programas en Ruby

Una forma común de escribir programas en Ruby es colocar el código en uno o más archivos de texto. Existen numerosos editores populares para hacerlo, como VS Code, Vim, Sublime Text y RubyMine. Puedes ejecutar programas de un solo archivo directamente desde el editor, mientras que los programas más complejos se suelen ejecutar desde la línea de comandos.

---

## Creación y Ejecución de un Programa en Ruby

1. **Crear el Directorio del Proyecto:**  
   Abre tu terminal y crea un directorio vacío para tu proyecto:

   ```bash
   mkdir pickaxe
   ```

2. **Abrir la Carpeta en tu Editor:**  
   Utiliza tu editor de preferencia para abrir la carpeta recién creada.

3. **Crear el Archivo:**  
   Dentro de esa carpeta, crea un archivo llamado `myprog.rb`.

4. **Agregar el Código Ruby:**  
   Escribe el siguiente código en `myprog.rb`:

   ```ruby
   puts "Hello, Ruby Programmer!"
   puts "It is now #{Time.now}"
   ```

   > **Nota:**  
   > La segunda línea utiliza `#{Time.now}` (llaves) para interpolar la hora actual dentro del string, no se usan paréntesis.

5. **Ejecutar el Programa:**  
   Desde la terminal, ejecuta el archivo con el siguiente comando:

   ```bash
   ruby myprog.rb
   ```

   **Salida esperada:**

   ```
   Hello, Ruby Programmer!
   It is now 2025-03-22 23:53:24 -0600
   ```

---

## Uso de la Notación Shebang en Sistemas Unix

En sistemas Unix, puedes incluir al inicio del archivo Ruby una línea **shebang** para especificar el intérprete. Esto te permite ejecutar el archivo como un programa sin llamar explícitamente a Ruby. En lugar de codificar la ruta a Ruby, puedes usar:

```ruby
#!/usr/bin/env ruby
puts "Hello, Ruby Programmer!"
puts "It is now #{Time.now}"
```

Esta línea indica al sistema que busque Ruby en el `PATH` y lo ejecute.

---

## Hacer el Archivo Ejecutable

Para poder ejecutar el archivo Ruby directamente como un programa, debes hacerlo ejecutable mediante el comando `chmod`:

```bash
chmod +x myprog.rb
```

### ¿Qué Hace `chmod +x myprog.rb`?

- **`chmod`:** Es el comando utilizado en Unix para cambiar los permisos de un archivo.
- **`+x`:** Agrega el permiso de **ejecución** al archivo.
- **`myprog.rb`:** Es el archivo al que se le está otorgando permiso de ejecución.

Al establecer el flag de ejecutable, permites que el sistema operativo ejecute el archivo como un programa. Una vez hecho esto, podrás ejecutarlo directamente desde la terminal:

```bash
./myprog.rb
```

**Ejemplo de salida:**

```
Hello, Ruby Programmer!
It is now 2023-11-02 17:15:44 -0500
```

---

## Ejecución de Programas Ruby en Windows

En Microsoft Windows, se puede lograr un comportamiento similar mediante asociaciones de archivos. Además, las aplicaciones GUI desarrolladas en Ruby se pueden ejecutar haciendo doble clic sobre ellas en el explorador de Windows.
