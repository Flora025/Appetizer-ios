from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from model import *
import json
import os

app = Flask(__name__)

# init database
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:////' + os.path.join(app.root_path, 'data.db')
db = SQLAlchemy(app) 

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

@app.route("/api/appetizer/<int:appetizer_id>", methods=["GET"])
def get_order_item(appetizer_id):
    '''
    Get an appetizer by id.
    '''
    appetizer = Appetizer.query.get_or_404(appetizer_id)
    return jsonify(appetizer.to_dict())

@app.route("/api/appetizer", methods=["POST"])
def add_order_item():
    '''
    Add an appetizer.
    '''
    data = request.json
    appetizer = Appetizer(name=data['name'], description=data['description'], price=data['price'],
                          imageURL=data['imageURL'], calories=data['calories'], protein=data['protein'],
                          carbs=data['carbs'])
    db.session.add(appetizer)
    
    db.session.commit()
    return jsonify(appetizer.to_dict()), 201

@app.route("/api/appetizer/<int:appetizer_id>", methods=["DELETE"])
def delete_order_item(appetizer_id):
    '''
    Delete an appetizer by id.
    '''
    appetizer = Appetizer.query.get_or_404(appetizer_id)
    db.session.delete(appetizer)
    
    db.session.commit()
    return jsonify({'message': 'Appetizer deleted'}), 200