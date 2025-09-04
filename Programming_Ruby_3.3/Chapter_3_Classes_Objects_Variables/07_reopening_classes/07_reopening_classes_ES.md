# ✨ Reapertura de clases

> **Resumen rápido:**  
> Ruby permite **reabrir clases** ya definidas (incluso de la librería estándar o de terceros) y agregarles nuevos métodos o variables en cualquier momento. Esta técnica se conoce como **monkey-patching**.

---

## 📚 Concepto 1 — _Qué significa reabrir una clase_

En Ruby, si defines una clase y luego la declaras de nuevo, **no hay error**: las nuevas definiciones se **añaden** a la clase existente.

```ruby
class Book
  attr_accessor :title
  # más código...
end
```

Más tarde puedes hacer:

```ruby
class Book
  def uppercase_title
    title.upcase
  end
end
```

✅ El método `uppercase_title` ahora forma parte de la clase `Book`, junto con lo definido anteriormente.

---

## 🛠️ Concepto 2 — _Monkey-patching_

- Este proceso de reabrir clases y añadir métodos se llama **monkey-patching**.  
- Incluso funciona con clases que son parte de Ruby en sí.  
- Generalmente se usa cuando la clase **no es parte de tu código**, pero quieres extenderla con nuevas utilidades.  
- Es común en frameworks como **Ruby on Rails**.

---

## 🚀 Ejemplo en Rails

Rails agrega métodos de conveniencia a las clases base.  
Por ejemplo, define `String#squish`, que elimina espacios en exceso:

```ruby
"This   string   has   whitespace".squish
# => "This string has whitespace"
```

Internamente, Rails lo implementa así:

```ruby
class String
  def squish
    # implementación
  end
end
```

De esta forma, cualquier cadena en Ruby puede usar `.squish`.

---

## 📖 Glosario

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| monkey-patching | Técnica de modificar o extender clases ya definidas (incluyendo las de la librería estándar) al reabrirlas y añadir métodos. |
