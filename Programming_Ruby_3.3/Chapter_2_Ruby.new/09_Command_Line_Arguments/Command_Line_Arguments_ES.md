
# 🖥️ Argumentos de Línea de Comandos en Ruby

> **Resumen rápido:**  
> Puedes pasar argumentos a tus scripts Ruby desde la línea de comandos, haciendo tus programas más flexibles e interactivos.

---

## 📚 Concepto — _Acceso a argumentos de línea de comandos_

Cuando ejecutas un programa Ruby desde la terminal, cualquier argumento después del nombre del script está disponible desde tu código.

- **ARGV** es un arreglo global que contiene cada argumento como string.
- **ARGV.size** devuelve la cantidad de argumentos.

---

### **Ejemplo**

<details>
<summary>💻 <b>cmd_line.rb</b></summary>

```ruby
puts "Diste #{ARGV.size} argumentos"

p ARGV
```
</details>

**Uso en terminal:**

```sh
ruby cmd_line.rb hormiga abeja gato perro
```

**Salida:**
```
Diste 4 argumentos
["hormiga", "abeja", "gato", "perro"]
```

---

## ✅ Buenas Prácticas

- ✅ Usa `ARGV` para scripts simples o utilidades rápidas.
- ✅ Valida y maneja argumentos faltantes o inesperados para evitar errores.
- 🚫 No uses solo ARGV para opciones complejas—prefiere librerías para parseo avanzado de argumentos.

---

## 🚀 Ejemplo Completo

```ruby
# greet.rb — Saluda a cada nombre pasado como argumento

if ARGV.empty?
  puts "No se proporcionaron nombres. Uso: ruby greet.rb Alicia Beto Carla"
else
  ARGV.each { |name| puts "¡Hola, #{name}!" }
end
```

**Ejemplo de ejecución:**
```sh
ruby greet.rb Alicia Beto Carla
```
_Salida:_
```
¡Hola, Alicia!
¡Hola, Beto!
¡Hola, Carla!
```

---

## 📖 Glosario

| 🗝️ Palabra         | 📝 Significado / Contexto                           |
|--------------------|----------------------------------------------------|
| **Línea de comandos** | Lugar donde escribes y ejecutas comandos/programas. |
| **Argumento**         | Valor pasado al ejecutar un programa/script.        |
| **ARGV**              | Arreglo global en Ruby con los argumentos de la línea de comandos. |
| **Variable global**   | Variable accesible desde cualquier parte del código. |

---

## ❓ Preguntas / Dudas

- ¿Cómo manejo flags (como `-v` o `--help`) en scripts Ruby?
- ¿Qué librerías ayudan a parsear opciones de línea de comandos más complejas?
