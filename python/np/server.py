from flask import Flask, abort, request, jsonify
import socket
app = Flask(__name__)
@app.route("/whoami", methods=["GET"])
def whoami():
#    return jsonify({'ip': request.environ['HTTP_X_FORWARDED_FOR']}), 200
    return jsonify({'ip': request.remote_addr}), 200
#@app.before_request 
#def onlyLB():
#    if request.remote_addr != '35.195.144.231':
#        abort(403)
@app.route("/")
def hello():
    return socket.gethostname()
if __name__ == "__main__":
    app.run(host='0.0.0.0')
