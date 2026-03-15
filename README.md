# Termux Basic Setup

Basic setup script for a **fresh Termux installation**.  
This script installs several useful tools and utilities to make Termux more comfortable for daily use.

## Requirements
- Clean Termux installation
- Internet connection

## Download Termux
Download Termux from the official GitHub repository:

https://github.com/termux/termux-app

## Installation

Run the following commands in **Termux**:

```bash
pkg update && pkg upgrade -y
pkg install git
termux-setup-storage

git clone https://github.com/DirmdsLab/Termux-Basic-Setup.git
cd Termux-Basic-Setup
chmod +x Setup.sh
./Setup.sh
````

After the installation finishes, **restart Termux**.

## Installed Packages

The setup script installs the following tools:

* `openssh`
* `fish`
* `starship`
* `tmux`
* `proot-distro`
* `eza`
* `neofetch`
* `cava`
* `pulseaudio`
* `zip`
* `unzip`

## Optional Packages

You may also want to install these additional tools:

* `python`
* `ffmpeg`
* `yt-dlp`

Example:

```bash
pkg install python ffmpeg yt-dlp
```

## Repository

GitHub:
[https://github.com/DirmdsLab/Termux-Basic-Setup](https://github.com/DirmdsLab/Termux-Basic-Setup)


