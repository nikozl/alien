from flask import Flask, render_template
import socket
app = Flask(__name__, template_folder="/templates")
@app.route("/")
def hello():
    return render_template("index.html")

@app.route("/myname")
def this_is_my_name():
    return socket.gethostname()

if __name__ == "__main__":
    app.run(host='0.0.0.0')
