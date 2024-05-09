## To Start

- Backend

```bash
# install flask before performing the following cmds
$ cd backend
$ . .venv/bin/activate # activate the environment
$ flask --app app run
```

- iOS frontend

open and build project in XCode



## Server Endpoints

### Get User Profile Information

```http
GET /api/users/{user_id}
```

### Get Appetizer Items

```http
GET /api/appetizers
```

Sample Response

```http 
 {
  "request": [
    {
      "price": 8.99,
      "calories": 300,
      "protein": 14,
      "imageURL": "https://xxx/xxx.jpg",
      "name": "Asian Flank Steak",
      "carbs": 0,
      "description": "This perfectly thin cut just melts in your mouth.",
      "id": 1
    },
    ...
    ]
}
```

### Get Order Item by ID

```http
GET /api/appetizer/<int:appetizer_id>
```

Sample Response

```http
{
  "id": 1,
  "name": "Asian Flank Steak",
  "description": "This perfectly thin cut just melts in your mouth.",
  "price": 8.99,
  "calories": 300,
  "protein": 14,
  "carbs": 0,
  "imageURL": "https://xxx/xxx.jpg"
}
```

### Delete Order Items

```http
DELETE /api/appetizer/<int:appetizer_id>
```

### Add Order Item

```http
POST /api/appetizer
{
  "name": "New Item",
  "description": "Description of the new item",
  "price": 9.99,
  "calories": 250,
  "protein": 12,
  "carbs": 20,
  "imageURL": "https://example.com/image.jpg"
}
```

