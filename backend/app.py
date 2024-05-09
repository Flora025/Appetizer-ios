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


class Appetizer(db.Model):
    '''
    Model representing an appetizer
    '''
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20))
    description = db.Column(db.String(60))
    price = db.Column(db.Float)
    imageURL = db.Column(db.String)
    
    calories = db.Column(db.Integer)
    protein = db.Column(db.Integer)
    carbs = db.Column(db.Integer)

    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'description': self.description,
            'price': self.price,
            'imageURL': self.imageURL,
            'calories': self.calories,
            'protein': self.protein,
            'carbs': self.carbs
        }