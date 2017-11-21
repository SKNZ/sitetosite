import socket
from flask import Flask, request
import json

app = Flask(__name__)

@app.route('/')
def hello():
    print('SERVER GOT ' + json.dumps(request.args))
    print('SERVER URL ' + request.url)
    return 'Greetings from  ' + socket.gethostname() + ', ' + request.remote_addr + '!\n'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=True)
