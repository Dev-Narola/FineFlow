from models.balance_model import Balance  # Import Balance model
import jwt
from flask import request, jsonify
from models.user_model import User
from werkzeug.security import generate_password_hash, check_password_hash
from flask_jwt_extended import get_jwt_identity
from bson import ObjectId

def signup(db, secret_key):
    data = request.get_json()

    required_fields = ["name", "email", "mobile_no", "password", "initial_balance"]
    if not data or not all(field in data for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400

    name = data.get("name")
    email = data.get("email")
    mobile_no = data.get("mobile_no")
    password = generate_password_hash(data.get("password"))
    user_image = "https://as2.ftcdn.net/v2/jpg/05/87/66/83/1000_F_587668357_Vco2ldq4Q9aWDH3ynxSOCydf5W1UdvrK.jpg"

    # Check if user already exists
    if db.users.find_one({"email": email}):
        return jsonify({"error": "User with this email already exists"}), 409

    # Create the User object
    user = User(name=name, email=email, mobile_no=mobile_no, password=password, user_image=user_image)

    # Insert the user into the database
    user_id = db.users.insert_one(user.to_dict()).inserted_id

    # Create balance from the initial balance field
    initial_balance = data.get("initial_balance", 0.0)  # Use provided initial balance or default to 0.0
    balance = Balance(user_id=user_id, initial_balance=initial_balance)
    
    # Insert the balance into the database
    db.balance.insert_one(balance.to_dict())  # Assuming you have a balances collection

    # Generate JWT token
    token = jwt.encode(
        {
            "sub": str(user_id)
        },
        secret_key,
        algorithm="HS256"
    )

    db.users.update_one(
        {"_id": user_id},
        {"$set": {"token": token}}
    )

    return jsonify({
        "message": "User created successfully!",
        "user_id": str(user_id),
        "token": token
    }), 201
def login(db, secret_key):
    data = request.get_json()
    
    required_fields = ["email", "password"]
    if not data or not all(field in data for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400

    email = data.get('email')
    password = data.get('password')

    user = db.users.find_one({"email": email})
    if not user:
        return jsonify({'error': "Invalid email or password"}), 401

    if not check_password_hash(user['password'], password):
        return jsonify({'error': "Invalid email or password"}), 401

    # Token without expiration
    token = jwt.encode({"sub": str(user["_id"])}, secret_key, algorithm="HS256")

    return jsonify({'message': 'Logged in successfully', "token": token}), 200

def get_user(db, secret_key):
    token = request.headers.get('Authorization', None)

    if not token:
        return jsonify({"error": "Token missing"}), 401

    try:
        # Decode the token and get user ID
        decoded_token = jwt.decode(token.split(" ")[1], secret_key, algorithms=["HS256"])
        user_id = decoded_token.get('sub')
        
        user = db.users.find_one({"_id": ObjectId(user_id)})
        if not user:
            return jsonify({"error": "User not found"}), 404

        # Fetch user's balance
        balance = db.balances.find_one({"user_id": ObjectId(user_id)})
        current_balance = balance["current_balance"] if balance else 0.0

        user_info = {
            "name": user["name"],
            "email": user["email"],
            "mobile_no": user["mobile_no"],
            "user_image": user["user_image"],
            "created_date": user["created_date"],
            "balance": current_balance
        }

        return jsonify({"user": user_info}), 200

    except jwt.ExpiredSignatureError:
        return jsonify({"error": "Token has expired"}), 401
    except jwt.InvalidTokenError:
        return jsonify({"error": "Invalid token"}), 401

def update_user(db, secret_key):
    # Get the token from Authorization header
    token = request.headers.get('Authorization', None)

    if not token:
        return jsonify({"error": "Token missing"}), 401

    try:
        # Decode the JWT token to extract the user ID
        decoded_token = jwt.decode(token.split(" ")[1], secret_key, algorithms=["HS256"])
        user_id = decoded_token.get('sub')

        # Find the user in the database
        user = db.users.find_one({"_id": ObjectId(user_id)})
        if not user:
            return jsonify({"error": "User not found"}), 404

        # Get the data from the request body
        data = request.get_json()

        # Prepare the fields that are allowed to be updated
        update_fields = {}
        if 'name' in data:
            update_fields['name'] = data['name']
        if 'email' in data:
            # Check if email already exists
            if db.users.find_one({"email": data['email'], "_id": {"$ne": ObjectId(user_id)}}):
                return jsonify({"error": "Email is already in use by another account"}), 409
            update_fields['email'] = data['email']
        if 'mobile_no' in data:
            update_fields['mobile_no'] = data['mobile_no']
        if 'password' in data:
            update_fields['password'] = generate_password_hash(data['password'])
        if 'user_image' in data:
            update_fields['user_image'] = data['user_image']

        # Check if there's anything to update
        if not update_fields:
            return jsonify({"error": "No fields to update"}), 400

        # Update the user document in the database
        db.users.update_one({"_id": ObjectId(user_id)}, {"$set": update_fields})

        return jsonify({"message": "User profile updated successfully"}), 200

    except jwt.ExpiredSignatureError:
        return jsonify({"error": "Token has expired"}), 401
    except jwt.InvalidTokenError:
        return jsonify({"error": "Invalid token"}), 401