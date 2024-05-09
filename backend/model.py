from app import db

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