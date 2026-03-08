# Cliverman

```
   _____ _ _                                      
  / ____| (_)                                     
 | |    | |___   _____ _ __ _ __ ___   __ _ _ __  
 | |    | | \ \ / / _ \ '__| '_ ` _ \ / _` | '_ \ 
 | |____| | |\ V /  __/ |  | | | | | | (_| | | | |
  \_____|_|_| \_/ \___|_|  |_| |_| |_|\__,_|_| |_|
```

A universal runtime manager inspired by **[asdf](https://github.com/asdf-vm/asdf)**, written in Bash. Manage multiple versions of programming languages and developer tools in a simple and efficient way.

## 🚀 Features

- **Universal**: Manage multiple runtimes (Go, Node.js, Python, Ruby, etc.) with a single tool
- **Simple**: Intuitive and easy-to-use command-line interface
- **Lightweight**: Written in pure Bash with no heavy dependencies
- **Flexible**: Easily switch between runtime versions

## 📋 Supported Runtimes

#### ✅ Implemented and Available
- **`Node.js`** - JavaScript runtime
- **`Golang`** - Go programming language

#### ⌛ In Development
- **`Neovim`** - Hyperextensible Vim-based text editor
- **`Python`** - Python programming language
- **`Java`** - Java platform

## 📦 Installation

```bash
git clone https://github.com/marcoaurelima/cliverman.git $HOME/.cliverman && cd $HOME/.cliverman && rm -rf .git
```

#### Configure your PATH
Add the following line to your shell configuration file:

```bash
export PATH="${HOME}/.cliverman/shims:${PATH}"
```

- **Bash:** `~/.bashrc` or `~/.bash_profile`
- **Zsh:** `~/.zshrc`
- **Fish:** `~/.config/fish/config.fish`

After adding, reload the file:

```bash
source ~/.bashrc  # or source ~/.zshrc depending on your shell
```


## 📖 Usage

### Basic syntax

```bash
cliverman [command] [arguments]
```

### Available commands

#### `[s]earch` - Search available runtimes

```bash
# List all available runtimes for installation
cliverman search all

# List all versions for a specific runtime
cliverman search golang
cliverman search nodejs
cliverman search python
```

#### `[l]ist` - List installed runtimes

```bash
# List all installed runtimes
cliverman list all

# List installed versions for a specific runtime
cliverman list golang
```

#### `[i]nstall` - Install a runtime

```bash
# Install a specific version of a runtime
cliverman install golang:14.17.0
cliverman install python:3.9.5
cliverman install ruby:3.0.0
```

#### `[u]se` - Set active version

```bash
# Set the global active version for a runtime
cliverman use golang:14.17.0
cliverman use python:3.9.5
```

#### `[un]install` - Uninstall runtime

```bash
# Uninstall all versions of a runtime
cliverman uninstall golang

# Uninstall a specific version
cliverman uninstall golang:14.17.0
```

#### `[c]lear` - Clear runtime shims and cached data

```bash
# Invoke the runtime-specific clear script to remove shims
# and any cached/current-version metadata for a runtime
cliverman clear nodejs
cliverman clear golang
```

## 💡 Practical examples

```bash
# 1. Search available Go versions
cliverman search golang

# 2. Install Go version 14.17.0
cliverman install golang:14.17.0

# 3. Install Go version 16.13.0
cliverman install golang:16.13.0

# 4. List installed Go versions
cliverman list golang

# 5. Activate version 16.13.0 globally
cliverman use golang:16.13.0

# 6. Check active version
go version

# 7. Uninstall a specific version
cliverman uninstall golang:14.17.0
```

## 🔧 Requirements

- Bash 4.0 or newer
- curl
- jq
- [Nerdfont](https://www.nerdfonts.com/)

## 📂 Directory structure

```
~/.cliverman/
├── installs/          # Installed runtimes
│   ├── golang/
│   ├── python/
│   └── ruby/
└── shims/             # Symbolic links to active executables
```

## 🤝 Contributing

Contributions are welcome! Feel free to:

1. Fork the project
2. Create a branch for your feature (`git checkout -b feature/MyFeature`)
3. Commit your changes (`git commit -m 'Add MyFeature'`)
4. Push to your branch (`git push origin feature/MyFeature`)
5. Open a Pull Request

## 📝 Roadmap

- [ ] Support more runtimes (Deno, Rust, Java, etc.)
- [ ] Shell completion (bash, zsh, fish)

## 📄 Licença

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## 🙏 Acknowledgements

Inspired by the excellent project [asdf](https://github.com/asdf-vm/asdf).

---

Made with ❤️ in Bash