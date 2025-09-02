# ✨ Especificando control de acceso

> **Resumen rápido:**  
> El control de acceso en Ruby define qué métodos son visibles desde fuera de una clase y ayuda a reducir el **acoplamiento (coupling)**: la dependencia de una clase en la **implementación interna** de otra. Menos coupling ⇒ más flexibilidad y mantenibilidad.

---

## 📚 Concepto 1 — _Por qué importa (y qué es coupling)_
- Exponer demasiado invita a que usuarios dependan de **detalles internos** en vez de la interfaz.  
- Eso incrementa el **coupling** (acoplamiento), haciendo más frágil el sistema ante cambios.  
- En Ruby solo se altera el estado a través de **métodos**: si controlas métodos, controlas el estado. Regla: no expongas métodos que puedan dejar el objeto inválido.

---

## 🛠️ Concepto 2 — _Tres niveles de acceso (con matices de Ruby)_
- **Public**: invocable por cualquiera. Es el **valor por defecto** (excepto `initialize`, que siempre es privado).  
- **Protected**: invocable por instancias de la **misma clase o subclases** (permite que objetos “de la familia” se consulten entre sí).  
- **Private**: invocable **solo dentro del mismo objeto** y **sin receptor explícito** (ni siquiera `self.method`).

```ruby
class MyClass
  def public_m
    # público por defecto
  end

  protected
  def prot_m
    # protegido
  end

  private
  def priv_m
    # privado
  end
end
```

> [!NOTE]  
> `public`, `protected` y `private` **son métodos**, no palabras clave. Cambian la visibilidad de lo que sigue (no abren bloques). Estilo: no indentar tras estas líneas.

---

## 🔎 Concepto 3 — _Diferencias clave: `protected` vs `private`_
- **Protected** permite llamar métodos entre **instancias relacionadas** (misma clase/subclase). Útil para comparar/consultar estado entre objetos del mismo tipo.  
- **Private** se limita al **objeto actual**; **prohíbe receptor explícito** (no puedes hacer `otro.metodo_privado`, ni `self.metodo_privado`).  
- En la práctica en Ruby, `protected` se usa menos que `private`.

---

## ⚡ Concepto 4 — _Acceso dinámico en tiempo de ejecución_
- Ruby verifica la visibilidad **cuando el método se ejecuta**, no al compilar/parsing.  
- Las violaciones aparecen **en runtime** al intentar invocar el método restringido.  
- Esto da flexibilidad, pero los errores se detectan al correr.

---

## 🧰 Concepto 5 — _Tres formas de declarar acceso (sin ';' y con buen estilo)_

### 1) Afectar a los métodos definidos **después** (forma común)
```ruby
class MyClass
  private

  def m1
    # privado
  end

  def m2
    # también privado por estar después de 'private'
  end
end
```

### 2) **Listar** métodos ya definidos
```ruby
class MyClass
  def m1
  end

  def m2
  end

  private :m2    # m2 pasa a ser privado
  public  :m1    # m1 queda público (explícito)
end
```

### 3) Declarar acceso **junto al método** (explícito y localizado)
```ruby
class MyClass
  def m1
    # público (por defecto)
  end

  protected def m2
    # protegido
  end

  private def m3
    # privado
  end
end
```

> [!TIP]  
> Esta tercera forma hace **explícito** el nivel de cada método. La primera es la más vista en código heredado.

---

## ✅ Buenas Prácticas _(solo lo indicado por el capítulo)_
- Preferimos la **tercera forma** por su **explicitud** método a método.  
- La primera forma es más antigua y **común** en el código que verás.

---

## 🚀 Ejemplo — **Cuentas y transacciones** (con explicación)
**Contexto:** queremos garantizar la **invariantes** del dominio: cada **débito** debe tener su **crédito** correspondiente.  
**Diseño:** exponemos una operación pública `transfer` y mantenemos **privados** los detalles (`debit` y `credit`) para impedir usos incorrectos desde fuera.

```ruby
class Account
  attr_accessor :balance

  def initialize(balance)
    @balance = balance
  end
end

class Transaction
  def initialize(account_a, account_b)
    @account_a = account_a
    @account_b = account_b
  end

  def transfer(amount)
    # Interfaz pública: orquesta el movimiento completo
    debit(@account_a, amount)
    credit(@account_b, amount)
  end

  private

  def debit(account, amount)
    # Lado "sale dinero": solo invocable dentro de Transaction
    account.balance -= amount
  end

  def credit(account, amount)
    # Lado "entra dinero": también privado
    account.balance += amount
  end
end

savings   = Account.new(100)
checking  = Account.new(200)
tx = Transaction.new(checking, savings)
tx.transfer(50)
```

**Qué está pasando y por qué:**
- `Transaction#transfer` es la **única puerta** para mover dinero (API pública).  
- `debit` y `credit` son **privados**: nadie puede llamarlos desde fuera para romper la regla (por ejemplo, debitar sin acreditar).  
- Si alguien intenta `tx.debit(checking, 999)`, Ruby lanzará error de método privado **al ejecutar** (control dinámico).

---

## 🧪 Concepto 6 — _Uso de `protected` (con explicación breve)_
**Objetivo:** permitir que **dos cuentas** comparen sus saldos **sin exponer** el saldo al exterior.

```ruby
class Account
  protected attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  def greater_balance_than?(other)
    # Permitido: 'other.balance' porque both son Account (misma "familia")
    @balance > other.balance
  end
end
```

**Por qué funciona:**
- `balance` es `protected`: accesible **entre** objetos `Account` (o subclases) dentro de métodos de `Account`.  
- Desde fuera, `acc.balance` fallará (no es público); pero `acc1.greater_balance_than?(acc2)` **sí** puede consultar el saldo de `acc2` gracias a `protected`.  
- Si `balance` fuera `private`, `other.balance` **no** sería invocable.

---

## 📖 Glosario

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| coupling        | Acoplamiento; dependencia de una clase respecto a la implementación interna de otra. |
| subtle          | Sutil; diferencia pequeña pero significativa, a veces difícil de percibir. |
