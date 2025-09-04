# ✨ Variables

> **Resumen rápido:**  
> En Ruby, las variables no son objetos en sí mismas; son **referencias** a objetos que viven en memoria (heap). Esto significa que varias variables pueden apuntar al mismo objeto.

---

## 📚 Concepto 1 — _Las variables referencian objetos_

Cada variable guarda una referencia a un objeto.  
Podemos confirmarlo:

```ruby
person = "Tim"
puts "The object in 'person' is a #{person.class}"
puts "The object has an id of #{person.object_id}"
puts "and a value of '#{person}'"
```

**Salida esperada:**
```
The object in 'person' is a String
The object has an id of 60
and a value of 'Tim'
```

🔎 Aquí:
- Ruby crea un objeto `String` con el valor `"Tim"`.  
- La referencia se asigna a la variable `person`.  
- La variable “toma la personalidad” del objeto: clase, id, valor.

> [!NOTE]  
> Una variable **no es un objeto**, solo una referencia a un objeto en el heap.

---

## 🛠️ Concepto 2 — _Alias de variables_

Veamos un ejemplo más complejo:

```ruby
person1 = "Tim"
person2 = person1
person1[0] = 'J'

puts "person1 is #{person1}"
puts "person2 is #{person2}"
```

**Salida esperada:**
```
person1 is Jim
person2 is Jim
```

**Explicación:**
- Cambiamos el primer carácter de `person1`.  
- Como las cadenas en Ruby son **mutables**, el cambio también se refleja en `person2`.  
- Asignar `person1` a `person2` **no crea un nuevo objeto**, solo copia la referencia.  
- Ahora ambas variables son **alias del mismo objeto**.

---

## 🔄 Concepto 3 — _Evitar aliasing con `dup`_

Podemos crear un objeto **nuevo** con el mismo contenido usando `.dup`:

```ruby
person1 = "Tim"
person2 = person1.dup
person1[0] = 'J'

puts "person1 is #{person1}"
puts "person2 is #{person2}"
```

**Salida esperada:**
```
person1 is Jim
person2 is Tim
```

👉 Aquí, `person2` apunta a un objeto distinto, aunque inicialmente con el mismo contenido.

---

## ❄️ Concepto 4 — _Congelando objetos con `freeze`_

Podemos evitar modificaciones en un objeto llamando a `.freeze`:

```ruby
person1 = "Tim"
person2 = person1.freeze
person1[0] = 'J'
```

**Salida esperada:**
```
prog.rb:4:in `<main>': can't modify frozen String: "Tim" (FrozenError)
```

**Explicación:**
- `freeze` marca el objeto como **inmutable**.  
- Cualquier intento de modificarlo lanza un `FrozenError`.  

> [!TIP]  
> Los **números** y **símbolos** en Ruby están siempre congelados, por lo que son **inmutables** por defecto.

---

## 📖 Glosario

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| heap            | Área de memoria del sistema operativo donde se almacenan dinámicamente los objetos creados en tiempo de ejecución. |
