# Graphic Configuration Tool

This repository contains two C programs and a bash script designed to adjust video settings such as brightness, contrast, and saturation on your Linux system using the `xrandr` tool. The programs allow for interaction with different graphic settings through a menu-based interface.

## Files in this Repository

- `install_and_run.sh`: A bash script that installs necessary dependencies, compiles the C programs, and runs them.
- `configuracion_video.c`: The first C program which adjusts the brightness, contrast, and saturation interactively.
- `adjust_graphic_options.c`: The second C program with similar functionality but provides a clearer menu-based interaction for adjusting graphic settings.
- `configuracion_video`: The compiled executable from the first C program.
- `adjust_graphic_options`: The compiled executable from the second C program.

## Prerequisites

- A Linux-based operating system (Debian/Ubuntu-based).
- The `xrandr` tool installed (this will be handled by the script if not already installed).
- The `gcc` compiler installed (the script will install it if necessary).

## How to Use

### Step 1: Run the Bash Script

1. Clone the repository or download the `install_and_run.sh` script to your system.

2. Open a terminal and navigate to the directory where the script is located.

3. Run the script using the following command:

   ```bash
   chmod +x install_and_run.sh
   ./install_and_run.sh
