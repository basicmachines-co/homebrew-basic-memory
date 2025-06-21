# Homebrew Basic Memory Tap

A Homebrew tap for installing Basic Memory - an AI-powered knowledge management system with MCP server integration.

## Installation

### Stable Version

```bash
# Add this tap
brew tap basicmachines-co/basic-memory

# Install Basic Memory
brew install basic-memory
```

Or install directly:

```bash
brew install basicmachines-co/basic-memory/basic-memory
```

### Beta/Pre-release Version

Install a specific beta, release candidate, or development version:

```bash
# Install a specific beta version
BM_VERSION=0.13.8b1 brew install basicmachines-co/basic-memory/basic-memory-beta

# Install a release candidate
BM_VERSION=0.13.8rc1 brew install basicmachines-co/basic-memory/basic-memory-beta

# Install a development version
BM_VERSION=0.13.8.dev1 brew install basicmachines-co/basic-memory/basic-memory-beta
```

Available versions can be found at: https://pypi.org/project/basic-memory/#history

## What gets installed

- `basic-memory` command-line tool
- MCP server integration
- Configuration templates

## Usage

After installation:

```bash
# Check version
basic-memory --version

# Use the shorthand
bm --help
```

## Switching Between Versions

You can have either the stable or beta version installed at a time:

```bash
# Switch from stable to beta
brew uninstall basic-memory
BM_VERSION=x.y.z brew install basic-memory-beta

# Switch from beta to stable
brew uninstall basic-memory-beta
brew install basic-memory
```

## Configuration

Configuration files are installed to:
- `$(brew --prefix)/share/basic-memory/config/`

## Development

To install from source:

```bash
brew install --HEAD basic-memory
```

## Troubleshooting

If you encounter issues:

1. Reinstall: `brew uninstall basic-memory && brew install basic-memory`
2. For beta versions: `brew uninstall basic-memory-beta && BM_VERSION=x.y.z brew install basic-memory-beta`
3. Clear Homebrew cache: `brew cleanup basic-memory` or `brew cleanup basic-memory-beta`

## Contributing

This tap is maintained at: https://github.com/basicmachines-co/homebrew-basic-memory

Report issues or submit pull requests there.
