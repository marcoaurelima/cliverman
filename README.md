# Cliverman

```
   _____ _ _                                      
  / ____| (_)                                     
 | |    | |___   _____ _ __ _ __ ___   __ _ _ __  
 | |    | | \ \ / / _ \ '__| '_ ` _ \ / _` | '_ \ 
 | |____| | |\ V /  __/ |  | | | | | | (_| | | | |
  \_____|_|_| \_/ \___|_|  |_| |_| |_|\__,_|_| |_|
```

Um gerenciador de runtimes universal inspirado no **[asdf](https://github.com/asdf-vm/asdf)**, escrito em Bash. Gerencie múltiplas versões de linguagens de programação e ferramentas de desenvolvimento de forma simples e eficiente.

## 🚀 Características

- **Universal**: Gerencie diversos runtimes (Go, Node.js, Python, Ruby, etc.) com uma única ferramenta
- **Simples**: Interface de linha de comando intuitiva e fácil de usar
- **Leve**: Escrito em Bash puro, sem dependências pesadas
- **Flexível**: Alterne entre versões de runtimes facilmente

## 📋 Runtimes Suportados

#### ✅ Implementados e Disponíveis
- **`Golang` (beta)** - Linguagem de programação Go
- **`Node.js` (beta)** - Runtime JavaScript

#### ⌛ Em Desenvolvimento
- **`Python`** - Linguagem de programação Python
- **`Ruby`** - Linguagem de programação Ruby
- **`Deno`** - Runtime JavaScript/TypeScript seguro
- **`Rust`** - Linguagem de sistema Rust
- **`Java`** - Plataforma Java

## 📦 Instalação

```bash
git clone https://github.com/marcoaurelima/cliverman.git $HOME/.cliverman && cd $HOME/.cliverman && rm -rf .git
```

#### Configure o PATH:
Adicione a seguinte linha ao seu arquivo de configuração do shell:
```bash
export PATH="$HOME/.cliverman/shims:$PATH"
```

- **Bash:** `~/.bashrc` ou `~/.bash_profile`
- **Zsh:** `~/.zshrc`
- **Fish:** `~/.config/fish/config.fish`

Após adicionar, recarregue o arquivo:

```bash
source ~/.bashrc  # ou ~/.zshrc, dependendo do seu shell
```


## 📖 Uso

### Sintaxe básica

```bash
cliverman [comando] [argumentos]
```

### Comandos disponíveis

#### `search` - Buscar runtimes disponíveis

```bash
# Listar todos os runtimes disponíveis para instalação
cliverman search all

# Listar todas as versões de um runtime específico
cliverman search golang
cliverman search nodejs
cliverman search python
```

#### `list` - Listar runtimes instalados

```bash
# Listar todos os runtimes instalados
cliverman list all

# Listar versões instaladas de um runtime específico
cliverman list golang
```

#### `install` - Instalar um runtime

```bash
# Instalar uma versão específica de um runtime
cliverman install golang:14.17.0
cliverman install python:3.9.5
cliverman install ruby:3.0.0
```

#### `use` - Definir versão ativa

```bash
# Definir a versão global ativa de um runtime
cliverman use golang:14.17.0
cliverman use python:3.9.5
```

#### `uninstall` - Desinstalar runtime

```bash
# Desinstalar todas as versões de um runtime
cliverman uninstall golang

# Desinstalar uma versão específica
cliverman uninstall golang:14.17.0
```

## 💡 Exemplos práticos

```bash
# 1. Buscar versões disponíveis do Golang
cliverman search golang

# 2. Instalar Golang versão 14.17.0
cliverman install golang:14.17.0

# 3. Instalar Golang versão 16.13.0
cliverman install golang:16.13.0

# 4. Listar versões instaladas do Golang
cliverman list golang

# 5. Ativar a versão 16.13.0 globalmente
cliverman use golang:16.13.0

# 6. Verificar a versão ativa
go version

# 7. Desinstalar uma versão específica
cliverman uninstall golang:14.17.0
```

## 🔧 Requisitos

- Bash 4.0 ou superior
- curl
- jq
- Permissões de escrita no diretório de instalação

## 📂 Estrutura de diretórios

```
~/.cliverman/
├── installs/          # Runtimes instalados
│   ├── golang/
│   ├── python/
│   └── ruby/
└── shims/             # Links simbólicos para executáveis ativos
```

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para:

1. Fazer fork do projeto
2. Criar uma branch para sua feature (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Adiciona MinhaFeature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abrir um Pull Request

## 📝 Roadmap

- [ ] Suporte a mais runtimes (Deno, Rust, Java, etc.)
- [ ] Configuração por projeto (.cliverman-version)
- [ ] Auto-instalação de dependências
- [ ] Shell completion (bash, zsh, fish)

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 🙏 Agradecimentos

Inspirado pelo excelente projeto [asdf](https://github.com/asdf-vm/asdf).

---

Feito com ❤️ em Bash