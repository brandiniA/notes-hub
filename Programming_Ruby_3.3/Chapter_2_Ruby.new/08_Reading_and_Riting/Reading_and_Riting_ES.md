# ✨ Lectura y Escritura en Ruby: Entrada/Salida Básica

> **Resumen rápido:**  
> Dominar los métodos de entrada/salida integrados en Ruby (`puts`, `p`, `gets`) te permite depurar más rápido y crear scripts interactivos sin gemas extra.

---

## 📚 Concepto 1 — _Escritura en la salida estándar_

`puts` y `p` envían datos a la **salida estándar** (`$stdout`), pero con diferentes formatos:

```ruby
puts "Hola"      # => Hola\n         (para usuarios)
p    "Hola"      # => "Hola"         (para depuración)
```

<details>
<summary>🔍 **¿Cómo funciona?**</summary>

- `puts` llama a `to_s` en sus argumentos y añade un salto de línea.  
- `p` llama a `inspect`, mostrando información de tipo, comillas, etc.—ideal para depurar.  
- Ambos aceptan múltiples argumentos y escriben cada uno en una línea.  
- Puedes redirigir la salida pasando un objeto IO explícito: `io.puts "mensaje"`.
</details>

---

## 🛠️ Concepto 2 — _Lectura desde la entrada estándar_

Utiliza `gets` (“get string”) para leer una línea de la **entrada estándar** (`$stdin`).  
Devuelve `nil` al final del archivo, por lo que es ideal para condiciones de bucle.

```ruby
while (line = gets)         # termina cuando gets devuelve nil
  print line                # muestra la entrada
end
```

> [!TIP]  
> **EOF en Windows:** Usa _Ctrl+Z_ y luego *Enter* para indicar fin de archivo en la terminal.

---

## ✅ Buenas Prácticas

- ✅ Usa `puts` para mensajes al usuario, `p` para depuración.  
- ✅ Considera los objetos de I/O (`$stdin`, `$stdout`, archivos, sockets) como intercambiables—escribe código polimórfico.  
- 🚫 No olvides el salto de línea: `print` *no* lo agrega automáticamente.

---

## 🚀 Ejemplo Completo

```ruby
# echo.rb — programa eco mínimo
puts "Escribe algo (Ctrl-D para salir):"

while (line = gets)
  puts "Dijiste: #{line.chomp}"
end

puts "¡Adiós!"
```

**Salida esperada (ejemplo):**

```
Escribe algo (Ctrl-D para salir):
hola
Dijiste: hola
42
Dijiste: 42
¡Adiós!
```

---

## 📖 Glosario

| 🗝️ Palabra          | 📝 Significado / Contexto                                |
|---------------------|---------------------------------------------------------|
| **I/O (Entrada/Salida)**  | Término general para leer y escribir datos.         |
| **Entrada/Salida estándar** | Flujos por defecto conectados al teclado y terminal. |
| **EOF (Fin de archivo)**   | Señal de que no hay más datos para leer.            |
| **Código polimórfico**   | Código que funciona igual con diferentes tipos de objetos, siempre que compartan la misma interfaz (métodos). En Ruby I/O, esto permite usar la misma lógica para $stdin, $stdout, archivos o sockets.           |

---

## ❓ Preguntas / Dudas

- ¿Conviene usar `STDOUT.write` en vez de `puts` si busco mayor rendimiento?
- ¿Cómo puedo leer datos binarios (por ejemplo, imágenes) de forma segura?
