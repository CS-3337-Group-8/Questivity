# Getting Started

## Required Software

To successfully develop, deploy, and run the Questivity platform, a variety of software components are needed. Below is a detailed list of the required software and their roles in the system.

### Godot Engine 3.6

-   **Purpose**: Game development engine for creating the **Godot frontend**, which delivers the interactive user interface for the Questivity platform.
-   **Features**:
    -   Supports both 2D and 3D development.
    -   Exports to **WebAssembly (WASM)**, enabling efficient performance in web browsers.
    -   Provides a **user-friendly interface** for developers and robust scripting with **GDScript** (Python-like language).

### Python

-   **Purpose**: Core programming language used for developing the **Questivity Server** (Django backend), which handles backend logic, API processing, and database management.

-   **Features**:
    -   Used with **Django** for rapid web application development.
    -   Extensive library support for web, data handling, and security features.
    -   Python's **virtual environment** helps manage dependencies in isolation.

### Git

-   **Purpose**: Distributed version control system used for managing and tracking changes to the Questivity codebase.

-   **Features**:
    -   Facilitates collaboration between multiple developers, allowing for distributed work.
    -   **Branching and merging** support to enable parallel development and safe feature integration.
    -   Integration with platforms like **GitHub** or **GitLab** for remote repository management.

### Docker

-   **Purpose**: Containerization platform that packages and deploys each component of the Questivity platform (e.g., NGINX, Django, MySQL) into isolated containers.

-   **Features**:
    -   Creates consistent and isolated environments for development and production.
    -   **Docker Compose** simplifies managing multi-container applications, automating the build, configuration, and linkage of services.
    -   Ensures easier **dependency management** and deployment across different environments.

---

## Installing Required Software

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

-   No installation wizard is required since **Godot** runs as a standalone binary directly after extraction.
-   On macOS, you may encounter security warnings. To resolve this, go to **System Preferences > Security & Privacy** and allow the app to run.

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

-   Install Git using **Homebrew** or **Xcode Command Line Tools**:
-   Visit the [official Git download page](https://git-scm.com/download/mac) for more options.

---

### Installing Docker

**Docker** is used to containerize the Questivity platform, making it easier to deploy and manage across environments.

Windows Installation

1. Enable Hyper-V Virtualization

    - Ensure that [**Hyper-V**](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v) is enabled if you're running Windows Pro or Enterprise.
    - If you're using Windows Home, follow [this guide](https://www.youtube.com/watch?v=8ONMJyIyN74).

2. Download Docker Desktop

    - Visit the [Docker Desktop Download Page](https://www.docker.com/products/docker-desktop/).
    - Click the **Download Docker Desktop** button.

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

    - Visit the [official Python website](https://www.python.org/downloads/) and download **Python** for Windows.

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
        Python 3.x.x
        ```

Mac Installation

1.  Download Python

    -   Visit the [official Python website for macOS](https://www.python.org/downloads/macos/).
    -   Download the latest stable version of **Python** for macOS by clicking the appropriate link.

2.  Run the Installer

    -   Once the download completes, locate the **.pkg** file in your **Downloads** folder and double-click it to start the installation process.
    -   Follow the installation wizard. It will guide you through the necessary steps.
        -   **Note:** You do not need to adjust any advanced settings. The default options will work fine for most users.

3.  Verify the Installation
    After installation, you need to verify that Python was installed correctly and that it is working as expected.

    -   Open **Terminal** (you can find this in Applications > Utilities or by using Spotlight).
    -   Run the following command to check the installed Python version:

        ```bash
        python --version
        ```

    -   You should see an output similar to:

        ```bash
        Python 3.x.x
        ```

This confirms that Python is installed and ready to use on your macOS system.

---

### Using the Terminal

Both **Terminal** on macOS and **Git Bash** on Windows use the **Bash** (Bourne Again Shell) command-line interface, which allows you to interact with your computer and execute commands. While they operate on different systems, the commands are similar because they both rely on Bash.

---

#### macOS: Open Terminal from a Specific Folder in Finder

1. **Navigate to the Folder**  
   Open **Finder** and go to the folder where you want to open Terminal.

2. **Open Terminal from Finder**

    - Option 1: Right-click the folder or anywhere inside the folder (if you're already in it).
    - Option 2: Hold down the **Control** key and click to open the context menu.
    - Choose **New Terminal at Folder** (available on macOS 12 Monterey and newer).

    **Note:** If you don’t see this option, enable it by going to:  
    `System Settings > Privacy & Security > Developer Tools`  
    Then check the option for **Finder**.

---

#### Windows: Open Git Bash from a Specific Folder in File Explorer

1. **Navigate to the Folder**  
   Open **File Explorer** and go to the folder where you want to open Git Bash.

2. **Open Git Bash from Explorer**
    - Right-click inside the folder or on the folder itself.
    - In the context menu, select **Git Bash Here**. This opens Git Bash with that folder as the current directory.

---

#### How to Open the Terminal (macOS)

1. Press **Cmd + Space** to open **Spotlight**.
2. Type **Terminal** and press **Enter** to launch the Terminal app.

---

#### How to Open Git Bash (Windows)

1. Open the **Start Menu**.
2. Search for **Git Bash** and click on it to open.

---

#### Basic Bash Commands

Both **macOS Terminal** and **Git Bash** use similar commands to navigate through directories:

-   `pwd`: Displays the current directory (Print Working Directory).
-   `ls`: Lists files and directories in the current location.
-   `cd [directory]`: Changes the current directory to the specified one.
-   `cd ..`: Moves up one directory (to the parent directory).
-   `cd ~`: Returns to the home directory.

---

#### Useful Shortcuts

-   **Up Arrow (↑)**: Scroll through previously entered commands.
-   **Tab Completion**: Press **Tab** to auto-complete directory or file names.

---

#### Example of Navigation in Bash

1. **Move into a folder**:

    ```bash
    cd Documents
    ```

2. **Move up one directory**:

    ```bash
    cd ..
    ```

3. **Go to the home directory**:

    ```bash
    cd ~
    ```

4. **List contents of the current folder**:
    ```bash
    ls
    ```

---

#### Bash Path Differences

Bash uses the forward slash (`/`) as a directory separator, unlike Windows which uses the backslash (`\`).

-   **Windows Example**:  
    `C:\Users\User\Documents\Folder\file.txt`

-   **Bash Example**:  
    `/c/Users/User/Documents/Folder/file.txt`

---

### Using Git

This section outlines how to configure and use Git, from setting up your username to managing branches and resolving conflicts.

#### Summary of Key Git Commands

| Action                                     | Command                                            |
| ------------------------------------------ | -------------------------------------------------- |
| Clone a repository                         | `git clone https://github.com/username/repository` |
| Pull latest changes from remote repository | `git pull`                                         |
| Check status of local repository           | `git status`                                       |
| Create and switch to a new branch          | `git checkout -b new-branch-name`                  |
| Stage all changes                          | `git add .`                                        |
| Commit changes with a message              | `git commit -m "your commit message"`              |
| Push a branch to remote                    | `git push origin branch-name`                      |
| Switch to an existing branch               | `git checkout branch-name`                         |

---

#### Logging in with Git

To configure Git with your username and email address, use the following commands in **Terminal** (macOS) or **Git Bash** (Windows). Replace the placeholders with your details:

```bash
git config --global user.name "Your Name"
```

```bash
git config --global user.email "youremail@example.com"
```

When using Git to interact with remote repositories like GitHub, you may be prompted to log in with browser or you may need to login from terminal. GitHub now requires a **Personal Access Token (PAT)** instead of your password:

1. **Prompt to Open Browser**:  
   When performing an action like pushing changes to a repository, Git may prompt you to authenticate. You may be directed to a browser to log into your GitHub account.

2. **Prompt to Login from Terminal**:  
   If prompted for a username and password in the terminal, use your GitHub **Personal Access Token** as the password. For instructions on creating a token, [use this guide](https://dev.to/shafia/support-for-password-authentication-was-removed-please-use-a-personal-access-token-instead-4nbk).

---

#### Cloning a Repository

Cloning a repository creates a local copy of a remote Git repository, including its full history. Here's how to clone a repository:

1. **Find the Repository URL**:

    - Navigate to the repository on your Git hosting service (GitHub, GitLab, Bitbucket).
    - Copy the repository's URL.

2. **[Open Terminal](#macos-open-terminal-from-a-specific-folder-in-finder) or Git Bash**:

    - On macOS, open **Terminal**.
    - On Windows, open **Git Bash**.

3. **[Navigate](#using-the-terminal) to the Desired Directory**:  
   Use the `cd` command to navigate to the folder where you want to clone the repository:

    ```bash
    cd /path/to/folder
    ```

4. **Clone the Repository**:  
   Run the following command, replacing the URL with the one you copied:

    ```bash
    git clone https://github.com/username/repository
    ```

    This creates a folder with the repository's contents.

---

#### Pulling a Repository

The `git pull` command updates your local repository with the latest changes from the remote repository:

1. **[Open Terminal](#macos-open-terminal-from-a-specific-folder-in-finder) or Git Bash**:
2. **[Navigate](#using-the-terminal) to Your Local Repository**:
3. **Run the Command**:

    ```bash
    git pull
    ```

    This fetches and merges changes from the remote repository into your current branch. Be aware of potential **merge conflicts**, which require manual resolution.

---

#### Staging in Git

Staging in Git is the process of selecting changes to include in the next commit. Here's how to manage staging:

1. **Check Status**:  
   View the status of your repository to see modified or new files:

    ```bash
    git status
    ```

2. **Stage Changes**:

    - Stage a specific file:

        ```bash
        git add filename.txt
        ```

    - Stage all changes:

        ```bash
        git add .
        ```

3. **Review Staged Changes (Optional)**:  
   To see what changes are staged, run:

    ```bash
    git diff --cached
    ```

4. **Unstage Changes (Optional)**:

    - Unstage a specific file:

        ```bash
        git reset filename.txt
        ```

    - Unstage all files:

        ```bash
        git reset
        ```

---

#### Commit in Git

A **commit** is a snapshot of your project at a specific point. After staging your changes, commit them with a descriptive message:

1. **[Stage](#staging-in-git) the Files You Want to Commit**.
2. **Make the Commit**:

    ```bash
    git commit -m "your commit message"
    ```

---

#### Pull Requests (PRs)

What is a Pull Request?

A pull request (PR) is a way to propose changes to a codebase in a collaborative environment, typically on platforms like GitHub. It allows you to notify other developers about the changes you've made in a branch and request that they review and merge those changes into another branch (usually the main branch).

What Are Branches?
In Git, a branch is a separate line of development. It allows you to work on changes without affecting the main codebase. Branches are like parallel versions of the project, which can be modified independently and later merged back into the main code when the work is ready. This setup helps in managing different features, bug fixes, or experiments without disrupting the stability of the main branch.

A **pull request** (PR) is used to propose changes to a repository, typically when working collaboratively. Here’s how to create a PR:

1.  **Create a New Branch**:

    ```bash
    git checkout -b new-feature-branch
    ```

2.  **[Stage](#staging-in-git) and [Commit](#commit-in-git) Your Changes**.
3.  **Push the Branch to GitHub**:

    ```bash
    git push origin new-feature-branch
    ```

4.  **Create the Pull Request**:

    -   Open the repository in a browser.
    -   Switch to your new branch.
    -   Click **Compare & pull request**.
    -   Fill out the form and submit your PR.

5.  **Sync Changes After Merge**:
    If your branch is already merged, you must sync your main branch to apply these new changes, if you want to make changes but your branch has not yet been approved, you can [update your pull request](#updating-a-pull-request-pr-before-approval)

    -   Switch back to the main branch:

        ```bash
        git checkout main
        ```

    -   Pull the latest changes:

        ```bash
        git pull origin main
        ```

    If you need to make updates to your pull request before someone approves or merges it, you can continue making changes on the **same branch**. The steps below explain how to update a pull request with additional changes:

---

#### Updating a Pull Request (PR) Before Approval

If your pull request is still open and you want to make changes to the same branch, follow these steps:

1. **Make Additional Changes**  
   Edit the files in your local repository as needed.

2. **Stage and Commit the Changes**  
   Once you have made the required changes, stage and commit them as you normally would:

    ```bash
    git add .
    git commit -m "Update with additional changes"
    ```

3. **Push the New Commits to the Same Branch**  
   After committing, push the changes to the same branch you created the pull request from:

    ```bash
    git push origin new-feature-branch
    ```

    Since the pull request is linked to this branch, GitHub will automatically update the pull request with the new changes.

##### Viewing Updates in the PR

After pushing your updates, the changes will appear in the existing pull request. Reviewers will now see your latest commits and can continue the review process with the updated code.

##### Important Considerations

-   **Multiple Commits**: Each commit you push to the branch will be reflected in the pull request, so you can push as many changes as necessary until the PR is approved.

-   **Keep Branches Updated**: To avoid conflicts, regularly pull the latest changes from the main branch into your feature branch before making updates:

    ```bash
    git pull origin main
    ```

---

#### Merge Conflicts

A **merge conflict** occurs when changes in different branches cannot be automatically merged. Here's how to resolve them:

1. **Check the Status**:

    ```bash
    git status
    ```

2. **Identify Conflict Markers**:  
   Conflict markers appear in files like this:

    ```plaintext
    <<<<<<< HEAD
    Your changes.
    =======
    Changes from the other branch.
    >>>>>>> feature-branch
    ```

3. **Resolve the Conflict**:  
   Edit the file to keep the appropriate changes and remove conflict markers.

4. **Stage the Resolved File**:

    ```bash
    git add resolved-file.txt
    ```

5. **Commit the Resolved Changes**:

    ```bash
    git commit
    ```

---

#### Preventing Merge Conflicts

To minimize conflicts:

-   Communicate with your team regularly about shared files.
-   Pull frequently from the main branch.
-   Keep feature branches small and focused.

---

### Using Docker

Docker is a powerful tool that simplifies the deployment and management of applications by using containers. Containers encapsulate an application and its dependencies, ensuring consistent behavior across different environments. This reduces conflicts and simplifies the management of software components.

#### Summary of Key Commands

| Action                             | Command                                 |
| ---------------------------------- | --------------------------------------- |
| Start services with Docker Compose | `docker-compose up -d`                  |
| Rebuild containers                 | `docker-compose up --build`             |
| Stop services                      | `docker-compose stop`                   |
| Stop and remove services           | `docker-compose down`                   |
| View running containers            | `docker ps`                             |
| View all containers                | `docker ps -a`                          |
| Stop a specific container          | `docker stop <container_id_or_name>`    |
| Start a specific container         | `docker start <container_id_or_name>`   |
| View logs of a container           | `docker logs <container_id_or_name>`    |
| Remove a container                 | `docker rm <container_id_or_name>`      |
| Restart a container                | `docker restart <container_id_or_name>` |

#### Cleaning up Docker

To free up disk space by removing unused containers, images, volumes, and networks, Docker provides several cleanup commands. Here’s a summary of these commands:

```bash
docker system prune -a --volumes
```

---

#### Docker Compose

For multi-container applications, **Docker Compose** is used. It allows you to define, configure, and run multiple containers as part of a single application stack. The application is defined in a `docker-compose.yml` or `compose.yml` file, making it easy to manage services with a single command.

---

#### Starting Docker Compose

To start the services defined in a `docker-compose.yml` or `compose.yml` file, follow these steps:

1. Ensure Docker is Running

    - Open **Docker Desktop** (macOS or Windows).
    - Verify that Docker is running. Docker Desktop should show as "Running."

2. Navigate to the Directory

    - Open your terminal and navigate to the directory containing your `docker-compose.yml` file:
        ```bash
        cd /path/to/your/project
        ```

3. Start the Services

    - Start all the services defined in your `docker-compose.yml` file:

        ```bash
        docker-compose up -d
        ```

    - **`-d`**: Runs containers in detached mode (in the background).
    - **`--build`**: Rebuilds images before starting containers.

        ```bash
        docker-compose up --build
        ```

4. Stopping Services

    - To stop the services without removing the containers:

        ```bash
        docker-compose stop
        ```

This stops the running containers but keeps them available for future use. To remove the containers completely, use `docker-compose down` (explained below).

---

#### Viewing Running Containers

To see all running containers:

```bash
docker ps
```

-   **`ps`**: Lists running Docker containers along with their IDs, status, ports, and more.
-   **Common flag**:
    -   **`-a`**: Shows all containers, including those that are stopped.

```bash
docker ps -a
```

---

#### Stopping a Specific Container

To stop a specific container, use its container ID or name (retrieved from `docker ps`):

```bash
docker stop <container_id_or_name>
```

-   **`stop`**: Sends a SIGTERM signal to gracefully stop the container.

---

#### Starting a Specific Container

To start a stopped container:

```bash
docker start <container_id_or_name>
```

-   **`start`**: Starts a container that was previously stopped.

---

#### Removing a Container

To remove a stopped container:

```bash
docker rm <container_id_or_name>
```

-   **`rm`**: Permanently deletes the container, freeing up disk space.

---

#### Viewing Logs of a Container

To view logs from a running container:

```bash
docker logs <container_id_or_name>
```

-   **`logs`**: Displays the standard output of a container.
-   **Common flag**:
    -   **`-f`**: Follows the logs and continuously updates them in real-time.

---

#### Restarting a Container

To restart a container (stop and start it again):

```bash
docker restart <container_id_or_name>
```

-   **`restart`**: Stops and then starts the container in a single command.

---

#### Bringing Down the Entire Docker Compose Setup

To stop and remove all services, networks, and containers defined in the `docker-compose.yml` file:

```bash
docker-compose down
```

-   **`down`**: Stops and removes containers, networks, and associated volumes created by `docker-compose up`.

---
