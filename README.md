# Homebrew Basic Memory Tap

A Homebrew tap for installing Basic Memory - an AI-powered knowledge management system with MCP server integration.

## Installation

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

## What gets installed

- `basic-memory` command-line tool
- MCP server integration
- Configuration templates
- Service management (launchd integration)

## Usage

After installation:

```bash
# Start Basic Memory server
brew services start basic-memory

# Or run manually
basic-memory serve

# Check version
basic-memory --version
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

1. Check the service status: `brew services list | grep basic-memory`
2. View logs: `tail -f $(brew --prefix)/var/log/basic-memory.log`
3. Reinstall: `brew uninstall basic-memory && brew install basic-memory`

## Contributing

This tap is maintained at: https://github.com/basicmachines-co/homebrew-basic-memory

Report issues or submit pull requests there.