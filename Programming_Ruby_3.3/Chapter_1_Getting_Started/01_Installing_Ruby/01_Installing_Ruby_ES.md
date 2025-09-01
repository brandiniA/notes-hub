
# Instalación de Ruby

Es posible que ya tengas Ruby instalado en tu sistema.  
Para comprobarlo, abre una terminal y ejecuta:

```bash
ruby --version
```

> **Importante:**  
> Es probable que la versión instalada sea antigua. Por razones de rendimiento y seguridad, es recomendable actualizar a la versión más reciente.

Este libro asume que usas un sistema **Linux o Unix**, lo que incluye distribuciones de Linux, macOS, sistemas Windows con **WSL**, contenedores Docker y entornos de desarrollo en la nube, como **Replit**.  
> **Acerca de Replit:**  
> Replit es una plataforma de desarrollo en línea basada en la nube que permite escribir, ejecutar y compartir código directamente desde el navegador. Soporta múltiples lenguajes (incluido Ruby) y es ideal para el prototipado rápido, la enseñanza y la colaboración sin necesidad de instalar software localmente.

*Nota adicional:* Ruby sí funciona en Windows, pero el proceso para gestionar su instalación en ese sistema es diferente.

Ten en cuenta que las herramientas para instalar Ruby cambian con frecuencia, por lo que algunas instrucciones específicas pueden quedar obsoletas o ser sustituidas por nuevas herramientas.

---

## Instalación de Ruby con el Gestor de Versiones rbenv

Utilizaremos un **gestor de versiones** para facilitar la instalación. Este tipo de herramienta te permite instalar y cambiar entre múltiples versiones de Ruby en la misma máquina. Entre las principales ventajas se encuentran:

- **Flexibilidad:** Facilita trabajar en proyectos que utilizan diferentes versiones de Ruby.
- **Simplicidad:** La instalación mediante un gestor es, en muchos casos, más sencilla que instalar una versión única.
- **Potencia y Usabilidad:** Proporciona herramientas avanzadas para gestionar y cambiar de versiones de manera eficiente.

Para instrucciones detalladas sobre la instalación de una única versión, consulta: [Documentación oficial](https://www.ruby-lang.org/es/documentation/installation/)

### ¿Por qué rbenv?

Usaremos **rbenv**, que es el gestor de versiones de Ruby más utilizado en la actualidad. Existen otros gestores como RVM o chruby, pero rbenv se destaca por su simplicidad y eficacia.

### Instalación de rbenv

Instala rbenv mediante el script **rbenv-installer**. Puedes encontrar el script completo en GitHub:  
[Repositorio de rbenv-installer](https://github.com/rbenv/rbenv-installer/blob/main/bin/rbenv-installer)

Ejecuta el siguiente comando en la terminal:

```bash
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
```

> **¿Qué hace este comando?**  
> Utiliza `curl` para descargar el script de instalación desde GitHub y lo ejecuta con `bash`. El script instalará rbenv utilizando el gestor de paquetes apropiado para tu sistema, además de instalar la herramienta auxiliar **ruby-build**, que se encarga de descargar e instalar distintas versiones de Ruby.  
>  
> En macOS, si usas Homebrew, es posible que veas un mensaje al final que indique “All done!”. Recuerda que este instalador **no modifica** automáticamente tus archivos de configuración del shell; deberás ejecutar `rbenv init` y reiniciar la terminal según las instrucciones.

---

## Instalando una Versión Específica de Ruby

Una vez instalado rbenv, puedes listar las versiones disponibles con el comando:

```bash
rbenv install -l
```

### Ejemplo de salida:

```
3.1.6
3.2.7
3.3.7
3.4.2
jruby-9.4.12.0
mruby-3.3.0
picoruby-3.0.0
truffleruby-24.2.0
truffleruby+graalvm-24.2.0
```

> **Nota:**  
> Solo se muestran los lanzamientos más recientes para cada implementación de Ruby.  
> Para ver todas las versiones locales, usa:
>
> ```bash
> rbenv install --list-all
> ```

La lista incluye versiones parcheadas actualizadas de diversas implementaciones de Ruby. El Ruby principal, a veces llamado **CRuby** o **MRI** ("Matz’s Ruby Interpreter"), es el que se utiliza habitualmente. También existen otras implementaciones:
- **JRuby:** Ruby en la Máquina Virtual de Java.
- **mruby:** Una versión reducida para hardware embebido.
- **TruffleRuby:** Enfocado en el alto rendimiento.

### Instalación de Ruby 3.3.0

Ejecuta:

```bash
rbenv install 3.3.0
```

---

## Preparación del Entorno de Construcción

Si encuentras errores durante la compilación, es posible que necesites instalar algunas dependencias adicionales. Por ejemplo, en Ubuntu se recomienda instalar:

```bash
sudo apt-get install autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
```

Una vez instalada la versión de Ruby, configúrala como la versión predeterminada con:

```bash
rbenv global 3.3.0
```

Si es la primera vez que instalas Ruby (como en mi caso en WSL), este comando te permitirá utilizar los comandos de Ruby en la terminal.

Para verificar la versión activa, ejecuta:

```bash
ruby --version
```

---

## ¿Qué Hace rbenv?

rbenv modifica sutilmente tu entorno de terminal para gestionar múltiples versiones de Ruby sin alterar significativamente la configuración habitual. Así funciona:

- **Gestión del PATH:**  
  La terminal utiliza la variable de entorno `PATH` para localizar los ejecutables. Al ejecutar `rbenv init`, se añade un directorio al inicio del `PATH`. Este directorio contiene los llamados *shims* de rbenv, que son pequeños programas que interceptan los comandos de Ruby (como `ruby` o `irb`) y redirigen la ejecución a la versión adecuada.

- **Funcionamiento Dinámico:**  
  Cuando ejecutas un comando, el shim de rbenv determina cuál versión de Ruby debe estar activa, generalmente basándose en la presencia de un archivo `.ruby-version` en el directorio del proyecto. Posteriormente, el comando se transfiere al ejecutable real ubicado en `~/.rbenv/versions`.

> **Tip:**  
> Si instalas una nueva versión de Ruby, recuerda ejecutar `rbenv rehash` para actualizar los shims.
