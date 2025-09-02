# ✨ Specifying Access Control

> **Quick summary:**  
> Access control in Ruby defines which methods are visible from outside a class and helps reduce **coupling**: the dependency of one class on the **internal implementation** of another. Less coupling ⇒ more flexibility and maintainability.

---

## 📚 Concept 1 — _Why it matters (and what is coupling)_
- Exposing too much tempts users to depend on **internal details** instead of the logical interface.  
- This increases **coupling**, making the system more fragile when changes occur.  
- In Ruby, state can only be altered through **methods**: if you control methods, you control state. Rule of thumb: don’t expose methods that can leave an object in an invalid state.

---

## 🛠️ Concept 2 — _Three levels of access (with Ruby specifics)_
- **Public**: callable by anyone. It is the **default** (except `initialize`, which is always private).  
- **Protected**: callable by instances of the **same class or subclasses** (keeps access “in the family”).  
- **Private**: callable **only within the same object** and **without an explicit receiver** (not even `self.method`).

```ruby
class MyClass
  def public_m
    # public by default
  end

  protected
  def prot_m
    # protected
  end

  private
  def priv_m
    # private
  end
end
```

> [!NOTE]  
> `public`, `protected`, and `private` are **methods**, not keywords. They change the visibility of subsequent methods (not blocks). Style: don’t indent after these lines.

---

## 🔎 Concept 3 — _Key differences: `protected` vs `private`_
- **Protected** allows methods to be called between **related instances** (same class/subclass). Useful for comparing or accessing state across objects of the same type.  
- **Private** is limited to the **current object**; it **forbids explicit receivers** (you can’t call `other.private_method`, nor `self.private_method`).  
- In Ruby practice, `protected` is less common than `private`.

---

## ⚡ Concept 4 — _Dynamic access at runtime_
- Ruby checks visibility **when the method executes**, not at compile/parse time.  
- Violations appear **at runtime** when trying to call a restricted method.  
- This provides flexibility but also means errors surface only during execution.

---

## 🧰 Concept 5 — _Three ways to declare access (no ';', clean style)_

### 1) Affect methods defined **afterward** (common form)
```ruby
class MyClass
  private

  def m1
    # private
  end

  def m2
    # also private after 'private'
  end
end
```

### 2) **List** already defined methods
```ruby
class MyClass
  def m1
  end

  def m2
  end

  private :m2    # m2 becomes private
  public  :m1    # m1 explicitly public
end
```

### 3) Declare access **inline with the method** (explicit and localized)
```ruby
class MyClass
  def m1
    # public (default)
  end

  protected def m2
    # protected
  end

  private def m3
    # private
  end
end
```

> [!TIP]  
> This third form is the most **explicit**, as each method declares its own level. The first form is more common in legacy code.

---

## ✅ Best Practices _(from the chapter only)_
- Prefer the **third form** for its **explicitness**.  
- The first form is older and more common in code you’ll encounter.

---

## 🚀 Example — **Accounts and transactions** (with explanation)
**Context:** we want to guarantee domain **invariants**: every **debit** must have a corresponding **credit**.  
**Design:** expose a single public operation `transfer` while keeping `debit` and `credit` **private**, preventing misuse from outside.

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
    # Public API: orchestrates the full movement
    debit(@account_a, amount)
    credit(@account_b, amount)
  end

  private

  def debit(account, amount)
    # Outgoing money: only callable inside Transaction
    account.balance -= amount
  end

  def credit(account, amount)
    # Incoming money: also private
    account.balance += amount
  end
end

savings   = Account.new(100)
checking  = Account.new(200)
tx = Transaction.new(checking, savings)
tx.transfer(50)
```

**What’s happening and why:**
- `Transaction#transfer` is the **only entry point** for moving money (public API).  
- `debit` and `credit` are **private**: no one outside can call them to break rules (e.g., debit without credit).  
- If someone tries `tx.debit(checking, 999)`, Ruby raises a private method error **at runtime** (dynamic control).

---

## 🧪 Concept 6 — _Using `protected` (with brief explanation)_
**Goal:** allow two accounts to compare balances **without exposing** them to the outside world.

```ruby
class Account
  protected attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  def greater_balance_than?(other)
    # Allowed: 'other.balance' because both are Account (same "family")
    @balance > other.balance
  end
end
```

**Why it works:**
- `balance` is `protected`: accessible **between** `Account` objects (or subclasses) within `Account` methods.  
- From outside, `acc.balance` fails (not public); but `acc1.greater_balance_than?(acc2)` **can** access `acc2.balance`.  
- If `balance` were `private`, `other.balance` would **not** be callable.

---

## 📖 Glossary

| 🗝️ English word | 📝 Meaning / Context |
|-----------------|----------------------|
| coupling        | Degree of dependency of one class on the internal implementation of another. |
| subtle          | Subtle; a small but meaningful difference, sometimes hard to notice. |
