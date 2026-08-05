# Cliverman

```text
   _____ _ _
  / ____| (_)
 | |    | |___   _____ _ __ _ __ ___   __ _ _ __
 | |    | | \ \ / / _ \ '__| '_ ` _ \ / _` | '_ \
 | |____| | |\ V /  __/ |  | | | | | | (_| | | | |
  \_____|_|_| \_/ \___|_|  |_| |_| |_|\__,_|_| |_|
```

> **A lightweight runtime manager focused on consistency.**
>
> Learn one runtime. Manage them all.

Cliverman is a universal runtime manager written entirely in Bash. It provides a single, predictable workflow for installing, switching and managing development runtimes without plugins, hidden behavior or runtime-specific commands.

Once a runtime is installed, Cliverman gets out of your way. You simply use `java`, `go`, `node`, `nvim` or any other executable as if it were installed directly on your system.

---

# Why Cliverman?

Most runtime managers eventually expose runtime-specific behaviors.

Cliverman follows a different philosophy:

- **One workflow for every runtime**
- **One architecture**
- **One user experience**

If you know how to manage Go, you already know how to manage Java.
If you know Node.js, you already know Python.

The commands never change.

```bash
cliverman search
cliverman install
cliverman use
cliverman list
cliverman uninstall
```

The runtime is just another parameter.

---

# Philosophy

Cliverman was designed around a few principles.

### Consistency

Every runtime implements exactly the same interface.

Searching, installing, activating and removing versions always behaves the same way.

### Transparency

After selecting a runtime, Cliverman disappears.

You simply execute:

```bash
java
go
node
nvim
```

No wrappers.
No special launch commands.

### Lightweight

- Pure Bash
- Minimal dependencies
- No plugin ecosystem
- Fast startup

### Integrated

Unlike plugin-based runtime managers, every runtime module is part of the project itself.

This provides:

- consistent UX
- consistent implementation
- easier maintenance
- predictable behavior

---

# Features

- Universal runtime management
- Consistent commands across every runtime
- Automatic shim generation
- Runtime aliases (`latest`, `lts`)
- Download verification using checksums
- Pure Bash implementation
- Small footprint
- Zero runtime-specific commands

---

# Supported runtimes

| Runtime | Status |
|---------|--------|
| Java (Temurin) | ✅ |
| Golang | ✅ |
| Node.js | ✅ |
| Neovim | ✅ |
| Python | ⌛ |

More runtimes will be added over time without changing the user experience.

---

# Installation

```bash
curl -s https://raw.githubusercontent.com/marcoaurelima/cliverman/refs/heads/main/installer.sh | bash
```

Add shims to your PATH:

```bash
export PATH="$HOME/.cliverman/shims:$PATH"
```

Reload your shell.

---

# Usage

Search available versions:

```bash
cliverman search java
```

Install a runtime:

```bash
cliverman install java:21
```

Install aliases:

```bash
cliverman install java:lts
cliverman install java:latest
```

Activate a version:

```bash
cliverman use java:21
```

Use it normally:

```bash
java -version
javac
jar
```

List installed versions:

```bash
cliverman list java
```

Output:

```text
• 21
• 25 (current)
• 26
```

---

# How it works

Cliverman manages complete runtime installations.

Each runtime lives inside:

```text
~/.cliverman/installs/
```

Executables are exposed through generated **shims**:

```text
~/.cliverman/shims/
```

A shim is a tiny executable that transparently redirects execution to the currently active runtime.

When you type:

```bash
java
```

the shell actually executes:

```text
~/.cliverman/shims/java
```

which resolves the active runtime and executes the real binary.

The same mechanism works for every executable contained in a runtime.

For Java, for example, Cliverman automatically generates shims for every executable found inside the JDK `bin/` directory.

---

# Project structure

```text
src/
│
├── install.sh
├── search.sh
├── use.sh
├── list.sh
├── ...
│
└── runtimes/
    ├── java/
    ├── golang/
    ├── nodejs/
    └── ...
```

Each runtime implements the same interface.

This architecture allows new runtimes to be added without changing the user experience.

---

# Requirements

- Bash 4+
- curl
- jq

---

# Roadmap

- More runtimes
- Shell completion
- Windows support
- Additional Java distributions
- Automated tests

---

# Contributing

Contributions are welcome.

Please keep the project philosophy in mind:

- simplicity
- consistency
- transparency

Every runtime should behave exactly like every other runtime.

---

# License

MIT

---

Inspired by projects like **asdf**, but built around a fully integrated runtime architecture instead of plugins.