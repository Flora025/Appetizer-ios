## Endpoints

### Get User Profile Information

```http
GET /api/users/{user_id}
```

### Get Appetizer Items

```http
GET /api/appetizers
```

Response

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



### Get Order Items

```http
GET /api/orderitems
```

### Delete Order Items

```http
DELETE /api/orderitems/{item_id}
```

### Add Order Item

```http
POST /api/orderitems
{
  "item_name": "Example Item",
  "quantity": 1,
  "price": 9.99
}
```

