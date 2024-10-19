import subprocess
import tkinter as tk
import os
import platform
import webbrowser
from tkinter import simpledialog, messagebox, ttk, Frame

def run_command(command):
    """Run a git command and return the output."""
    try:
        output = subprocess.check_output(command, stderr=subprocess.STDOUT)
        return output.decode().strip()
    except subprocess.CalledProcessError as e:
        return f"Error: {e.output.decode().strip()}"

def create_branch():
    branch_name = simpledialog.askstring("Input", "Enter new branch name:")
    if branch_name:
        output = run_command(["git", "checkout", "-b", branch_name])
        messagebox.showinfo("Branch Created", output)
        update_branch_dropdown()
        check_status()

def commit_changes():
    commit_message = simpledialog.askstring("Input", "Enter commit message:")
    if not commit_message:
        messagebox.showerror("Error", "Commit message can't be blank.")
        return

    output = run_command(["git", "add", "."]) 
    if "Error" in output:
        messagebox.showerror("Error", output)
        return

    output = run_command(["git", "commit", "-m", commit_message])
    messagebox.showinfo("Changes Committed", output)
    check_status()

def push_changes():
    current_branch = run_command(["git", "rev-parse", "--abbrev-ref", "HEAD"])
    output = run_command(["git", "push", "origin", current_branch])
    messagebox.showinfo("Push Result", output)
    check_status()

def pull_changes():
    current_branch = run_command(["git", "rev-parse", "--abbrev-ref", "HEAD"])
    ahead = run_command(["git", "rev-list", "--count", f"main..{current_branch}"])
    
    if int(ahead) > 0:
        messagebox.showerror("Error", "Cannot pull changes because you have commits ahead of 'main'.")
    else:
        output = run_command(["git", "pull", "origin", "main"])
        messagebox.showinfo("Pull Result", output)
        check_status()

def switch_branch():
    selected_branch = branch_combobox.get()
    output = run_command(["git", "checkout", selected_branch])
    messagebox.showinfo("Switched Branch", output)
    update_branch_dropdown()
    check_status()

def update_branch_dropdown():
    """Update the dropdown with the current branches and select the current branch."""
    branches = run_command(["git", "branch"]).splitlines()
    branch_names = [branch.strip("* ").strip() for branch in branches]
    branch_combobox['values'] = branch_names

    current_branch = run_command(["git", "rev-parse", "--abbrev-ref", "HEAD"])
    if current_branch in branch_names:
        branch_combobox.current(branch_names.index(current_branch))

def check_status():
    status_text = get_git_status()
    status_label.config(text=status_text)

def get_git_status():
    branch = run_command(["git", "rev-parse", "--abbrev-ref", "HEAD"])
    
    behind = run_command(["git", "rev-list", "--count", f"{branch}..main"])
    
    ahead = run_command(["git", "rev-list", "--count", f"main..{branch}"])

    status = run_command(["git", "status", "--porcelain"])
    uncommitted_changes = len(status.splitlines()) if status else 0

    status_message = f"Current Branch: {branch}\n"
    status_message += f"Commits Ahead of 'main': {ahead}\n"
    status_message += f"Commits Behind 'main': {behind}\n"
    status_message += f"Uncommitted Changes: {uncommitted_changes}\n"

    if uncommitted_changes > 0:
        status_message += "You have uncommitted changes in your working directory."
    else:
        status_message += "Your working directory is clean."

    if int(ahead) > 0:
        status_message += "\nYou cannot pull changes because you have commits ahead of the main branch."
    if int(behind) > 0:
        status_message += "\nYou cannot push changes because you are behind the main branch."

    return status_message

def open_git_bash():
    if platform.system() == "Windows":
        possible_paths = [
            r"C:\Program Files\Git\bin\bash.exe",
            r"C:\Program Files (x86)\Git\bin\bash.exe",
            r"C:\Users\YourUsername\AppData\Local\Programs\Git\bin\bash.exe" 
        ]
        
        git_bash_path = None
        for path in possible_paths:
            if os.path.exists(path):
                git_bash_path = path
                break
        
        if git_bash_path:
            subprocess.Popen(git_bash_path, cwd=os.getcwd())
        else:
            messagebox.showerror("Error", "Git Bash is not found on your system. Please install Git.")
    else:
        messagebox.showerror("Error", "Git Bash is only available on Windows.")

def open_repo():
    try:
        remote_url = run_command(["git", "config", "--get", "remote.origin.url"])
        webbrowser.open(remote_url)
    except Exception as e:
        messagebox.showerror("Error", "Could not open repository link.")

root = tk.Tk()
root.title("Git Workflow Manager")
root.geometry("800x400")
root.configure(bg="#121212")

main_frame = Frame(root, bg="#121212")
main_frame.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

branch_frame = Frame(main_frame, padx=10, pady=10, bg="#1E1E1E", relief=tk.RAISED, borderwidth=1)
branch_frame.pack(fill=tk.X, padx=5, pady=5)

branch_label = tk.Label(branch_frame, text="Branches", font=("Helvetica", 12, "bold"), bg="#1E1E1E", fg="#FFFFFF")
branch_label.pack(side=tk.LEFT, padx=5)

branch_combobox = ttk.Combobox(branch_frame, width=30)
branch_combobox.pack(side=tk.LEFT, padx=5)

switch_branch_button = tk.Button(branch_frame, text="Switch Branch", command=switch_branch, bg="#4CAF50", fg="white", font=("Helvetica", 10))
switch_branch_button.pack(side=tk.LEFT, padx=5)

create_branch_button = tk.Button(branch_frame, text="Create Branch", command=create_branch, bg="#2196F3", fg="white", font=("Helvetica", 10))
create_branch_button.pack(side=tk.LEFT, padx=5)

status_frame = Frame(main_frame, padx=10, pady=10, bg="#1E1E1E", relief=tk.RAISED, borderwidth=1)
status_frame.pack(fill=tk.BOTH, padx=5, pady=5, expand=True)

status_label_title = tk.Label(status_frame, text="Status", font=("Helvetica", 16, "bold"), bg="#1E1E1E", fg="#FFFFFF")
status_label_title.pack(anchor=tk.W, padx=5, pady=5) 

status_label = tk.Label(status_frame, text="Checking Git status...", justify=tk.LEFT, padx=10, pady=10, font=("Helvetica", 12), bg="#1E1E1E", fg="#FFFFFF")
status_label.pack(anchor=tk.W, padx=5) 

action_frame = Frame(main_frame, padx=10, pady=10, bg="#1E1E1E", relief=tk.RAISED, borderwidth=1)
action_frame.pack(fill=tk.X, padx=5, pady=5)

action_label = tk.Label(action_frame, text="Actions", font=("Helvetica", 12, "bold"), bg="#1E1E1E", fg="#FFFFFF")
action_label.pack(side=tk.LEFT, padx=5)

commit_changes_button = tk.Button(action_frame, text="Commit", command=commit_changes, bg="#FFC107", fg="black", font=("Helvetica", 10))
commit_changes_button.pack(side=tk.LEFT, padx=5)

push_changes_button = tk.Button(action_frame, text="Push", command=push_changes, bg="#4CAF50", fg="white", font=("Helvetica", 10))
push_changes_button.pack(side=tk.LEFT, padx=5)

pull_changes_button = tk.Button(action_frame, text="Pull", command=pull_changes, bg="#FF5722", fg="white", font=("Helvetica", 10))
pull_changes_button.pack(side=tk.LEFT, padx=5)

git_bash_button = tk.Button(action_frame, text="Open Git Bash", command=open_git_bash, bg="#673AB7", fg="white", font=("Helvetica", 10))
git_bash_button.pack(side=tk.LEFT, padx=5)

repo_button = tk.Button(action_frame, text="Open Repo", command=open_repo, bg="#FF4081", fg="white", font=("Helvetica", 10))
repo_button.pack(side=tk.LEFT, padx=5)

update_branch_dropdown()
check_status()

root.mainloop()
