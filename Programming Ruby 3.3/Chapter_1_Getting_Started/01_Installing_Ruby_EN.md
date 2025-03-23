
# Installing Ruby

There's a good chance you already have Ruby installed on your system.  
To check, open your terminal and run:

```bash
ruby --version
```

> **Important:**  
> It’s likely that the installed version is outdated. For performance and security reasons, it's best to upgrade to the latest version.

This book assumes you are using a **Linux or Unix**-style system, which includes Linux distributions, macOS, Windows systems running WSL, most Docker containers, and cloud-based development environments like **Replit**.  
> **About Replit:**  
> Replit is a cloud-based development platform that allows you to write, run, and share code directly from your browser. It supports multiple programming languages (including Ruby) and is ideal for rapid prototyping, education, and collaborative projects without needing to install software locally.

*Note:* Ruby does run on Windows, but the process for managing its installation on that platform is different.

Keep in mind that the tooling for installing Ruby changes frequently, so some specific instructions may become outdated or be replaced by newer tools.

---

## Installing Ruby with the rbenv Version Manager

We will use a **version manager** to simplify the installation process. A version manager lets you install and switch between multiple Ruby versions on the same machine. The advantages include:

- **Flexibility:** Easily switch between Ruby versions to work on projects developed at different times.
- **Simplicity:** Installation through a version manager is often simpler than installing a single version manually.
- **Enhanced Usability:** Provides powerful tools to manage and switch between versions seamlessly.

For detailed instructions on installing a single version, refer to the [official documentation](https://www.ruby-lang.org/en/documentation/installation/).

### Why rbenv?

We will use **rbenv**, the most popular Ruby version manager today. While there are alternatives like RVM and chruby, rbenv stands out for its simplicity and effectiveness.

### Installing rbenv

Install rbenv using the **rbenv-installer** script. You can view the full script on GitHub:  
[View rbenv-installer on GitHub](https://github.com/rbenv/rbenv-installer/blob/main/bin/rbenv-installer)

Run the following command in your terminal:

```bash
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
```

> **What Does This Command Do?**  
> It uses `curl` to download the installation script from GitHub and pipes it to `bash` for execution. This script installs rbenv using your system's appropriate package manager and also installs **ruby-build**, a helper tool that manages downloading and installing various Ruby versions.  
>  
> On macOS (using Homebrew), you might see a message like “All done!” at the end. Remember, the installer **does not automatically modify** your shell configuration files; you’ll need to run `rbenv init` and restart your terminal as instructed.

---

## Installing a Specific Ruby Version

Once rbenv is installed, you can list available Ruby versions with:

```bash
rbenv install -l
```

### Example Output:

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

> **Note:**  
> This command shows only the latest releases for each Ruby implementation.  
> To view all local versions, use:
>
> ```bash
> rbenv install --list-all
> ```

The list includes up-to-date patch versions for various Ruby implementations. The main Ruby implementation—sometimes called **CRuby** or **MRI** (Matz’s Ruby Interpreter)—is the one most commonly used. Other implementations include:
- **JRuby:** Ruby running on the Java Virtual Machine.
- **mruby:** A minimal Ruby build designed for embedded hardware.
- **TruffleRuby:** Focused on high performance.

### Installing Ruby 3.3.0

Run the following command:

```bash
rbenv install 3.3.0
```

---

## Setting Up the Build Environment

If your build fails, you might need to install additional dependencies. For example, on Ubuntu, it's recommended to install:

```bash
sudo apt-get install autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
```

After installing Ruby, set it as the default version with:

```bash
rbenv global 3.3.0
```

If you’re installing Ruby for the first time (as was my case with WSL), this command allows you to run Ruby commands directly from the terminal.

To verify, run:

```bash
ruby --version
```

---

## What Does rbenv Actually Do?

rbenv subtly adjusts your terminal environment to manage multiple Ruby versions without disrupting your usual setup. Here's how it works:

- **PATH Management:**  
  The terminal uses the `PATH` environment variable to locate executable programs. When you run `rbenv init`, it prepends a directory to your `PATH` containing rbenv’s *shims*. These small programs intercept commands like `ruby` or `irb` and redirect them to the correct Ruby version.

- **Dynamic Switching:**  
  When a command is executed, the rbenv shim determines which Ruby version should be active—typically based on a `.ruby-version` file in the project directory—and passes the command to the corresponding executable located in `~/.rbenv/versions`.

> **Tip:**  
> After installing a new Ruby version, run `rbenv rehash` to refresh the shims.
