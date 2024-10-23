# Getting Started

## Required Software

To successfully develop, deploy, and run the Questivity platform, a variety of software components are needed. Below is a detailed list of the required software and their roles in the system.

---

### Godot Engine 3.6

- **Purpose**: Game development engine for creating the **Godot frontend**, which delivers the interactive user interface for the Questivity platform.
  
- **Features**:
    - Supports both 2D and 3D development.
    - Exports to **WebAssembly (WASM)**, enabling efficient performance in web browsers.
    - Provides a **user-friendly interface** for developers and robust scripting with **GDScript** (Python-like language).

---

### Python 3.8+

- **Purpose**: Core programming language used for developing the **Questivity Server** (Django backend), which handles backend logic, API processing, and database management.

- **Features**:
    - Used with **Django** for rapid web application development.
    - Extensive library support for web, data handling, and security features.
    - Python's **virtual environment** helps manage dependencies in isolation.

---

### Git

- **Purpose**: Distributed version control system used for managing and tracking changes to the Questivity codebase.

- **Features**:
    - Facilitates collaboration between multiple developers, allowing for distributed work.
    - **Branching and merging** support to enable parallel development and safe feature integration.
    - Integration with platforms like **GitHub** or **GitLab** for remote repository management.

---

### Docker

- **Purpose**: Containerization platform that packages and deploys each component of the Questivity platform (e.g., NGINX, Django, MySQL) into isolated containers.

- **Features**:
    - Creates consistent and isolated environments for development and production.
    - **Docker Compose** simplifies managing multi-container applications, automating the build, configuration, and linkage of services.
    - Ensures easier **dependency management** and deployment across different environments.

---

## Tutorials

This section provides step-by-step tutorials for installing the necessary software required for developing the Questivity platform, including **Godot**, **Git**, **Docker**, and **Python**. Follow these guides to ensure your development environment is set up correctly.

---

### Installing Godot

**Godot Engine** is used for building the interactive frontend of the Questivity platform.

1. Download the Correct Version
    - Visit the [official Godot download page](https://godotengine.org/download/3.x/).
    - Select **Godot 3.6** (do not download the .NET version).

2. Extract the Downloaded .zip File
    - Once downloaded, locate the **.zip** file in your Downloads folder.
    - Extract the contents to your preferred location (e.g., C:\Godot or /Applications on macOS).

3. Running Godot Engine
    - On Windows, navigate to the extracted folder and run the **Godot_v3.6_stable_win64.exe** file.
    - On macOS, run the **Godot.app** file inside the extracted folder.

Notes:

- No installation wizard is required since **Godot** runs as a standalone binary directly after extraction.
- On macOS, you may encounter security warnings. To resolve this, go to **System Preferences > Security & Privacy** and allow the app to run.

---

### Installing Git

**Git** is used for version control and collaboration in the Questivity project.

Windows Installation

1. Download the Git Installer
    - Visit the [official Git website](https://git-scm.com/download/win).
    - Click the **Download for Windows** button.

2. Run the Git Installer
    - Locate the downloaded **.exe** file and run it.
    - Follow the on-screen instructions. Key options include:
    - **Select Components**: Use the default settings unless you need specific options.
    - **Default Editor**: Choose a preferred text editor for Git (e.g., Vim, Visual Studio Code).
    - **PATH Environment**: Choose "Git from the command line and also from 3rd-party software" for broader usability.

3. Complete the Installation
    - Click **Finish** to finalize the installation.

4. Verify the Installation
    - Open **Git Bash** or the Command Prompt.
    - Run the following command:
        ```bash
        git --version
        ```

    - You should see output similar to:

        ```bash
        git version 2.x.x
        ```

Mac Installation

- Install Git using **Homebrew** or **Xcode Command Line Tools**:
- Visit the [official Git download page](https://git-scm.com/download/mac) for more options.

---

### Installing Docker

**Docker** is used to containerize the Questivity platform, making it easier to deploy and manage across environments.

Windows Installation

1. Enable Hyper-V Virtualization
    - Ensure that [**Hyper-V**](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v) is enabled if you're running Windows Pro or Enterprise.
    - If you're using Windows Home, follow [this guide](https://www.youtube.com/watch?v=8ONMJyIyN74).

2. Download Docker Desktop
    - Visit the [Docker Desktop Download Page](https://www.docker.com/products/docker-desktop).
    - Click the **Download for Windows** button.

3. Run the Docker Installer
    - Double-click the downloaded **Docker Desktop Installer**.
    - Follow the on-screen instructions, ensuring that **WSL** integration is disabled if prompted.

4. Verify the Installation
    - Open **Command Prompt** or **PowerShell**.
    - Run the following command:

        ```bash
        docker --version
        ```

    - You should see output similar to:

        ```bash
        Docker version x.x.x, build xxxxxxx
        ```

Mac Installation

1. Install Rosetta 2 (for Apple Silicon)
    - Open the **Terminal** and run the following command to install **Rosetta 2** (required for compatibility with some apps):
        ```bash
        softwareupdate --install-rosetta
        ```

2. Download Docker Desktop for macOS
    - Visit the [Docker Desktop Download Page](https://www.docker.com/products/docker-desktop).
    - Choose the version suitable for your system (Intel or Apple Silicon).

---

### Installing Python

**Python** is the core programming language used to develop the Questivity Server (Django backend).

Windows Installation

1. Download Python
    - Visit the [official Python website](https://www.python.org/downloads/) and download **Python 3.8+** for Windows.

2. Run the Installer
    - Locate the downloaded **.exe** file and run it.
    - Ensure that you check the option **"Add Python to PATH"** during installation.
    - Choose **Install Now** and follow the installation wizard to complete the process.

3. Verify the Installation
    - Open **Command Prompt** and run:

        ```bash
        python --version
        ```

    - You should see output similar to:

        ```bash
        Python 3.8.x
        ```

Mac Installation

1. Install Python
    - On macOS, Python is usually pre-installed. However, to install the latest version, on a system with brew installed, run:

        ```bash
        brew install python
        ```

2. Verify the Installation
    - Open **Terminal** and run:

        ```bash
        python3 --version
        ```

    - You should see output similar to:

        ```bash
        Python 3.8.x
        ```

---

By following these tutorials, you will have the core software required for developing and deploying the Questivity platform. Proceed to configure each component and integrate them with the Questivity system for a complete setup.