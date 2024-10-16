import jwt
from flask import request, jsonify
from models.user_model import User
from werkzeug.security import generate_password_hash, check_password_hash
from flask_jwt_extended import get_jwt_identity
from bson import ObjectId

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
    token = jwt.encode(
        {
            "sub": str(user["_id"])
        },
        secret_key,
        algorithm="HS256"
    )

    return jsonify({'message': 'Logged in successfully', "token": token}), 200

def signup(db, secret_key):
    data = request.get_json()

    required_fields = ["name", "email", "mobile_no", "password"]
    if not data or not all(field in data for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400

    name = data.get("name")
    email = data.get("email")
    mobile_no = data.get("mobile_no")
    password = generate_password_hash(data.get("password"))
    user_image = ""

    if db.users.find_one({"email": email}):
        return jsonify({"error": "User with this email already exists"}), 409

    user = User(name=name, email=email, mobile_no=mobile_no, password=password, user_image=user_image)

    user_id = db.users.insert_one(user.to_dict()).inserted_id

    # Token without expiration
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

from flask_jwt_extended import decode_token

def get_user(db, secret_key):
    token = request.headers.get('Authorization', None)

    if not token:
        return jsonify({"error": "Token missing"}), 401

    try:
        decoded_token = jwt.decode(token.split(" ")[1], secret_key, algorithms=["HS256"])
        user_id = decoded_token.get('sub')
        
        user = db.users.find_one({"_id": ObjectId(user_id)})
        if not user:
            return jsonify({"error": "User not found"}), 404

        user_info = {
            "name": user["name"],
            "email": user["email"],
            "mobile_no": user["mobile_no"],
            "user_image": user["user_image"],
            "created_date": user["created_date"]
        }

        return jsonify({"user": user_info}), 200

    except jwt.ExpiredSignatureError:
        return jsonify({"error": "Token has expired"}), 401
    except jwt.InvalidTokenError:
        return jsonify({"error": "Invalid token"}), 401
