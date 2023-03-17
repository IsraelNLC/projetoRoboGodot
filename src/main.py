# DEPRECATED: This file is no longer used. It is kept for reference only.
from flask import Flask, request
import sqlite3
import requests
import threading

app = Flask(__name__)

godot_url = "http://localhost:3000"
db_file = "./db/bata.db"

# keep listening for changes in the database
def listen_for_changes():
    while True:
        conn = sqlite3.connect(db_file)
        c = conn.cursor()
        c.execute("SELECT x, y, z FROM movement ORDER BY id DESC LIMIT 1;")
        for row in c:
            print(row)
            # send the change to the godot server
            requests.post(godot_url, data={'x': row[0], 'y': row[1], 'z': row[2]})
        conn.close()


@app.route('/api', methods=['POST'])
def api():
    # get the data from the request
    data = request.get_json()
    # connect to the database
    conn = sqlite3.connect(db_file)
    c = conn.cursor()
    # insert the data into the database
    c.execute("INSERT INTO movement (x,y,z) VALUES (?,?,?)", (data['x'], data['y'], data['z']))
    conn.commit()
    conn.close()
    return "OK"

def run_listener():
    listen_for_changes()

if __name__ == '__main__':
    listener_thread = threading.Thread(target=run_listener)
    listener_thread.start()
    app.run(host='localhost', port=5000, debug=False)
    # stop the thread when the app is closed
    listener_thread.join()
    # free cmd
    input()
