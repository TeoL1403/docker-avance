from os import getenv
from flask import Flask, jsonify

print("Fichier app.py overridé !")

LISTEN_PORT = getenv("LISTEN_PORT", 8000)

app = Flask(__name__)

@app.route('/', methods=['GET'])
def index():
    return jsonify({
        "message": "Le curl fonctionne chef !",
        "listen_port": LISTEN_PORT
    })

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0', port=LISTEN_PORT)
