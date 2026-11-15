# RYUJIN Fastfetch Customizer

<p align="center">
  <img src="linuxfound.png" alt="RYUJIN Linux Logo" width="180">
</p>

<h1 align="center">RYUJIN FASTFETCH</h1>

<p align="center">
  A custom Fastfetch configuration installer for Linux.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Linux-blue?style=for-the-badge">
  <img src="https://img.shields.io/badge/Shell-Bash-green?style=for-the-badge">
  <img src="https://img.shields.io/badge/Version-1.0.0-orange?style=for-the-badge">
  <img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge">
</p>

---

## About

**RYUJIN Fastfetch Customizer** is a Bash-based automatic installer that customizes the appearance of [Fastfetch](https://github.com/fastfetch-cli/fastfetch) on Linux systems.

It automatically downloads the RYUJIN custom Linux logo, creates the Fastfetch configuration directory, backs up an existing configuration, and generates a personalized Fastfetch configuration.

The goal is to make Linux terminal customization simple and easy to install.

## Features

- Automatic Fastfetch configuration setup.
- Downloads the custom RYUJIN PNG logo from GitHub.
- Kitty graphics protocol logo support.
- Automatically creates the Fastfetch configuration directory.
- Backs up an existing configuration before replacing it.
- Custom system information layout.
- JSON configuration syntax validation.
- Simple installation process.

## Preview

<p align="center">
  <img src="linuxfound.png" alt="RYUJIN Custom Logo" width="250">
</p>

## Requirements

Make sure the following packages are installed:

| Dependency | Purpose |
|---|---|
| Fastfetch | Displays system information |
| curl | Downloads the custom logo |
| file | Checks the downloaded PNG |
| Python 3 | Validates JSON syntax |

A terminal supporting the Kitty graphics protocol is required to display the custom image using the configured logo type.

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/whilehat/ryujin-fastfetch.git
```

### 2. Enter the project directory

```bash
cd ryujin-fastfetch
```

### 3. Make the installer executable

```bash
chmod +x install.sh
```

### 4. Run the installer

```bash
./install.sh
```

The installer will automatically:

1. Check the required dependencies.
2. Create `~/.config/fastfetch`.
3. Download `linuxfound.png`.
4. Back up your existing Fastfetch configuration.
5. Generate `config.jsonc`.
6. Validate the generated JSON configuration.

## Run Fastfetch

After installation, execute:

```bash
fastfetch --config ~/.config/fastfetch/config.jsonc
```

## Configuration

The installer generates the following configuration:

```text
~/.config/fastfetch/
├── config.jsonc
└── linuxfound.png
```

### Logo Configuration

```json
"logo": {
  "type": "kitty",
  "source": "/home/username/.config/fastfetch/linuxfound.png",
  "width": 32,
  "padding": {
    "top": 1,
    "left": 2,
    "right": 3
  }
}
```

### Displayed System Information

The custom configuration displays:

- Username and hostname
- Operating system
- Kernel version
- Window manager
- Shell
- Terminal
- CPU
- GPU
- RAM
- Disk
- System uptime
- Terminal color palette

## Backup

If a Fastfetch configuration already exists, the installer creates a timestamped backup before replacing it.

Example:

```text
config.jsonc.backup.20261115120000
```

## Troubleshooting

### Logo is not displayed

Check whether the image exists:

```bash
ls -lh ~/.config/fastfetch/linuxfound.png
```

Check the image format:

```bash
file ~/.config/fastfetch/linuxfound.png
```

Make sure your terminal supports the Kitty graphics protocol.

### Fastfetch configuration error

Run:

```bash
fastfetch --config ~/.config/fastfetch/config.jsonc
```

Check the configuration file:

```bash
nano ~/.config/fastfetch/config.jsonc
```

### Download error

Test the raw GitHub image URL:

```bash
curl -fL \
https://raw.githubusercontent.com/whilehat/ryujin-fastfetch/main/linuxfound.png \
-o /tmp/linuxfound.png
```

## Project Structure

```text
ryujin-fastfetch/
│
├── install.sh
├── linuxfound.png
├── README.md
└── LICENSE
```

## Future Improvements

- Multiple custom logo profiles.
- Interactive configuration menu.
- Automatic dependency installation.
- Uninstaller functionality.
- Support for additional terminal graphics protocols.

## Author

**whilehat**

GitHub: https://github.com/whilehat

## License

This project is licensed under the MIT License.

---

<p align="center">
  <b>RYUJIN FASTFETCH CUSTOMIZER</b>
  <br>
  Customize your Linux terminal. Make it yours.
</p>
