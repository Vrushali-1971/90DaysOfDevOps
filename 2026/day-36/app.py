from flask import Flask
import mysql.connector
import os
import time

app = Flask(__name__)

def get_db_connection():
    while True:
        try:
            connection = mysql.connector.connect(
                host=os.getenv("DB_HOST", "db"),
                user=os.getenv("DB_USER", "root"),
                password=os.getenv("DB_PASSWORD", "password"),
                database=os.getenv("DB_NAME", "todo_db")
            )
            return connection
        except:
            print("Database not ready... retrying in 2 seconds")
            time.sleep(2)

@app.route('/')
def index():
    # Attempt to connect and fetch data
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("CREATE DATABASE IF NOT EXISTS todo_db")
        cursor.execute("USE todo_db")
        cursor.execute("CREATE TABLE IF NOT EXISTS tasks (id INT AUTO_INCREMENT PRIMARY KEY, task VARCHAR(255))")
        cursor.execute("SELECT * FROM tasks")
        tasks = cursor.fetchall()
        cursor.close()
        conn.close()
        db_status = "Connected ✅"
        status_color = "#00ff88"
    except Exception as e:
        tasks = []
        db_status = f"Error: {str(e)} ❌"
        status_color = "#ff4d4d"

    task_list = "".join([f"<li>{t[1]}</li>" for t in tasks])

    # The CSS is right here inside the HTML string!
    return f"""
    <html>
    <head>
        <title>DevOps Task Tracker</title>
        <style>
            body {{ 
                font-family: sans-serif; 
                background-color: #0f172a; 
                color: #f8fafc; 
                display: flex; 
                justify-content: center; 
                align-items: center; 
                height: 100vh; 
                margin: 0;
            }}
            .card {{ 
                background: #1e293b; 
                padding: 2rem; 
                border-radius: 1rem; 
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.5);
                width: 400px;
                text-align: center;
            }}
            h1 {{ color: #38bdf8; margin-bottom: 0.5rem; }}
            .status {{ color: {status_color}; font-weight: bold; margin-bottom: 1.5rem; }}
            ul {{ text-align: left; list-style: none; padding: 0; }}
            li {{ background: #334155; margin: 0.5rem 0; padding: 0.75rem; border-radius: 0.5rem; }}
        </style>
    </head>
    <body>
        <div class="card">
            <h1>DevOps Task Tracker</h1>
            <div class="status">DB Status: {db_status}</div>
            <ul>
                {task_list if task_list else "<li>No tasks yet. Add some via MySQL!</li>"}
            </ul>
            <div style="margin-top: 2rem; font-size: 0.8rem; opacity: 0.5;">
                Josh Batch 10 | Day 36 Project
            </div>
        </div>
    </body>
    </html>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
