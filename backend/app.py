from flask import Flask, jsonify
import json

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Test</p>"

@app.route("/api/appetizers")
def get_appetizers():
    '''
    Read from appetizer data file and return the data in json format .
    '''
    
    with open('./static/appetizers.json') as f:
        data = json.load(f)
    return jsonify(data)

