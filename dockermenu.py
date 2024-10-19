import os
import subprocess
import threading
import tkinter as tk
from tkinter import messagebox, ttk
import webbrowser

def run_command(command, action_name):
    output_text.insert(tk.END, f"{action_name} in progress...\n")
    output_text.update_idletasks() 

    loading_bar.start()

    try:
        process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        for line in iter(process.stdout.readline, ''):
            output_text.insert(tk.END, line) 
            print(line, end='') 
            output_text.update_idletasks()

        _, stderr = process.communicate()
        if stderr:
            output_text.insert(tk.END, stderr)
            print(stderr, end='')

        output_text.insert(tk.END, f"{action_name} completed.\n")
    except Exception as e:
        output_text.insert(tk.END, f"Error: {str(e)}\n")
        print(f"Error: {str(e)}")
    finally:
        loading_bar.stop()

    output_text.see(tk.END)

def execute_command_in_thread(command, action_name):
    thread = threading.Thread(target=run_command, args=(command, action_name))
    thread.start()

def update_container_list():
    try:
        process = subprocess.run('docker-compose -f ./docker/compose.yml ps --services --filter "status=running"', 
                                 shell=True, capture_output=True, text=True)
        container_list = process.stdout.strip().split('\n')
        if container_list == ['']:
            container_list = ["No running containers"]

        container_listbox.delete(0, tk.END)
        for container in container_list:
            container_listbox.insert(tk.END, container)
    except Exception as e:
        container_listbox.insert(tk.END, f"Error: {str(e)}")

    root.after(5000, update_container_list)

def check_docker():
    try:
        subprocess.run("docker info", shell=True, capture_output=True, text=True, check=True)
    except subprocess.CalledProcessError:
        messagebox.showerror("Docker Error", "Docker engine is not running. Please start Docker on your system.")
        root.quit()

def compose_up():
    execute_command_in_thread('docker-compose -f ./docker/compose.yml up -d', 'Starting Docker Compose')

def compose_stop():
    execute_command_in_thread('docker-compose -f ./docker/compose.yml stop', 'Stopping Docker Compose')

def compose_restart():
    execute_command_in_thread('docker-compose -f ./docker/compose.yml restart', 'Restarting Docker Compose')

def compose_rebuild():
    execute_command_in_thread('docker-compose -f ./docker/compose.yml up --build -d', 'Rebuilding Docker Compose')

def compose_cleanup():
    execute_command_in_thread('docker system prune -f', 'Cleaning up Docker')

def reset_database():
    execute_command_in_thread(
        'docker-compose -f ./docker/compose.yml stop mysql questivity-server && '
        'docker-compose -f ./docker/compose.yml rm -f mysql questivity-server && '
        'docker-compose -f ./docker/compose.yml up -d mysql questivity-server',
        'Resetting MySQL and Questivity Server Containers'
    )

def create_superuser():
    execute_command_in_thread(
        'docker-compose -f ./docker/compose.yml exec questivity-server python manage.py createsuperuser --username admin --no-input',
        'Creating Superuser in Questivity Server'
    )


def exit_program():
    root.quit()

def open_localhost():
    webbrowser.open("http://localhost")

def open_logs():
    webbrowser.open("http://logs.localhost")

root = tk.Tk()
root.title("Docker Compose GUI")
root.geometry("900x600")
root.configure(bg="#1e1e1e")

style = ttk.Style(root)
style.theme_use("clam")

style.configure("TButton", background="#3e3e3e", foreground="white", borderwidth=1)
style.map("TButton", background=[("active", "#5e5e5e")])
style.configure("TLabel", background="#1e1e1e", foreground="white")
style.configure("TFrame", background="#1e1e1e")
style.configure("TListbox", background="#2e2e2e", foreground="white")

style.configure("TProgressbar", troughcolor="#2e2e2e", background="#00ff00", thickness=20)

button_frame = ttk.Frame(root, padding="10")
button_frame.pack(side=tk.LEFT, fill=tk.Y)

output_frame = ttk.Frame(root, padding="10")
output_frame.pack(side=tk.RIGHT, fill=tk.BOTH, expand=True)

button_up = ttk.Button(button_frame, text="Start", command=compose_up)
button_up.pack(pady=10, fill=tk.X)

button_stop = ttk.Button(button_frame, text="Stop", command=compose_stop)
button_stop.pack(pady=10, fill=tk.X)

button_restart = ttk.Button(button_frame, text="Restart", command=compose_restart)
button_restart.pack(pady=10, fill=tk.X)

button_rebuild = ttk.Button(button_frame, text="Rebuild", command=compose_rebuild)
button_rebuild.pack(pady=10, fill=tk.X)

button_cleanup = ttk.Button(button_frame, text="Clean Up", command=compose_cleanup)
button_cleanup.pack(pady=10, fill=tk.X)

button_reset_db = ttk.Button(button_frame, text="Reset Database", command=reset_database)
button_reset_db.pack(pady=10, fill=tk.X)

button_create_superuser = ttk.Button(button_frame, text="Create Superuser", command=create_superuser)
button_create_superuser.pack(pady=10, fill=tk.X)

button_open_localhost = ttk.Button(button_frame, text="Open Localhost", command=open_localhost)
button_open_localhost.pack(pady=10, fill=tk.X)

button_open_logs = ttk.Button(button_frame, text="Open Logs", command=open_logs)
button_open_logs.pack(pady=10, fill=tk.X)

button_exit = ttk.Button(button_frame, text="Exit", command=exit_program)
button_exit.pack(pady=10, fill=tk.X)

container_list_frame = tk.Frame(output_frame, bg="#1e1e1e", relief=tk.RAISED, borderwidth=2)
container_list_frame.pack(fill=tk.BOTH, expand=False)

container_label = ttk.Label(container_list_frame, text="Running Containers", background="#1e1e1e", foreground="white")
container_label.pack(pady=5)

container_listbox = tk.Listbox(container_list_frame, height=8, font=("Consolas", 10), bg="#2e2e2e", fg="white", selectbackground="#4e4e4e", selectforeground="white")
container_listbox.pack(fill=tk.BOTH, expand=True)

output_text = tk.Text(output_frame, wrap=tk.WORD, height=20, font=("Consolas", 10), bg="#2e2e2e", fg="white")
output_text.pack(fill=tk.BOTH, expand=True)

loading_bar = ttk.Progressbar(output_frame, mode='indeterminate', length=300, style="TProgressbar")
loading_bar.pack(pady=10)

def scroll_text(event):
    output_text.yview_scroll(int(-1*(event.delta/120)), "units")

output_text.bind("<MouseWheel>", scroll_text)

def scroll_listbox(event):
    container_listbox.yview_scroll(int(-1*(event.delta/120)), "units")

container_listbox.bind("<MouseWheel>", scroll_listbox)

check_docker()

update_container_list()

root.mainloop()
