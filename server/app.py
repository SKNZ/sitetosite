from flask import Flask, request
import json

app = Flask(__name__)

@app.route('/')
def hello():
    print('SERVER GOT ' + json.dumps(request.args))
    return 'Hello World!\n'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True)
