# RYUJIN Fastfetch Customizer

\<p align="center">
&#x20; \<b>A custom Fastfetch image and Linux profile launcher.\</b>
\</p>

\<p align="center">
&#x20; \<img src="[https://raw.githubusercontent.com/whilehat/ryujin-fastfetch/main/linuxfound.png](https://raw.githubusercontent.com/whilehat/ryujin-fastfetch/main/linuxfound.png)" width="180" alt="RYUJIN Custom Logo">
\</p>

\<p align="center">
&#x20; \<img src="[https://img.shields.io/badge/Version-1.0.0-red?style=for-the-badge](https://img.shields.io/badge/Version-1.0.0-red?style=for-the-badge)">
&#x20; \<img src="[https://img.shields.io/badge/Platform-Linux-blue?style=for-the-badge](https://img.shields.io/badge/Platform-Linux-blue?style=for-the-badge)">
&#x20; \<img src="[https://img.shields.io/badge/Language-Bash-green?style=for-the-badge](https://img.shields.io/badge/Language-Bash-green?style=for-the-badge)">
&#x20; \<img src="[https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)">
\</p>

## About

**RYUJIN Fastfetch Customizer** is a Bash-based utility that customizes the Fastfetch terminal experience by replacing the default distribution logo with a custom image.

It supports multiple Linux profile commands, automatic image downloading from GitHub, and simple image management.

## Features

- Custom image instead of the default distribution logo.
- Automatic image downloading from GitHub.
- Arch Linux profile.
- Kali Linux profile.
- Fedora profile.
- Ubuntu profile.
- Image update functionality.
- Custom image removal.
- Help and version commands.
- Kitty graphics protocol support.

## Supported Profiles

| Command             | Profile    |
| ------------------- | ---------- |
| `fastfetch -arch`   | Arch Linux |
| `fastfetch -kali`   | Kali Linux |
| `fastfetch -fedora` | Fedora     |
| `fastfetch -ubuntu` | Ubuntu     |

**Note:** These commands select display profiles. Fastfetch continues to detect the actual operating system automatically. All profiles currently use the same custom image.

## Requirements

- Linux operating system
- Fastfetch
- Bash
- curl
- file
- Kitty-compatible terminal graphics support for image rendering

## Installation

### 1. Install dependencies

**Arch Linux**

```bash
sudo pacman -S fastfetch curl file
```

**Kali Linux**

```bash
sudo apt install fastfetch curl file
```

**Fedora**

```bash
sudo dnf install fastfetch curl file
```

### 2. Clone the repository

```bash
git clone https://github.com/whilehat/ryujin-fastfetch.git
```

```bash
cd ryujin-fastfetch
```

### 3. Make the script executable

```bash
chmod +x fastfetch.sh
```

### 4. Install the customizer

The current script can be run directly:

```bash
./fastfetch.sh -arch
```

For the `fastfetch -arch` command interface, install the script as a wrapper in your local PATH and configure it to invoke the system Fastfetch binary.

## Usage

### Launch custom profiles

```bash
fastfetch -arch
```

```bash
fastfetch -kali
```

```bash
fastfetch -fedora
```

```bash
fastfetch -ubuntu
```

### Update custom image

```bash
fastfetch -update
```

### Remove custom image

```bash
fastfetch -remove
```

### Display version

```bash
fastfetch -version
```

### Display help

```bash
fastfetch -help
```

## Project Structure

```text
ryujin-fastfetch/
│
├── fastfetch.sh
├── install.sh
├── README.md
├── LICENSE
└── linuxfound.png
```

## Configuration

The custom image is downloaded from:

```text
https://raw.githubusercontent.com/whilehat/ryujin-fastfetch/main/linuxfound.png
```

The image is stored locally at:

```text
~/.config/fastfetch/linuxfound.png
```

The default image settings are:

```bash
LOGO_TYPE="kitty"
LOGO_WIDTH=32
```

## Technologies Used

- Bash Scripting
- Fastfetch
- Linux
- cURL
- GitHub
- Kitty Graphics Protocol

## Future Improvements

- Individual logos for different Linux distributions.
- Automatic Linux distribution detection.
- Interactive installation wizard.
- Support for additional terminal graphics protocols.
- Configuration backup and restoration.
- One-command installation.

## Contributing

Contributions, suggestions, and improvements are welcome.

1. Fork this repository.
2. Create a feature branch.
3. Commit your changes.
4. Submit a Pull Request.

## Author

**whilehat**

GitHub: [https://github.com/whilehat](https://github.com/whilehat)

## License

This project is licensed under the MIT License.

---

\<p align="center">
&#x20; \<b>RYUJIN — Customize Your Terminal. Define Your Identity.\</b>
\</p>Drag files here to add them to your repository&#x20;

Or
