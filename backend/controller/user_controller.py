import jwt
from flask import request, jsonify
from models.user_model import User
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime, timedelta

def login(db,secret_key):
    data = request.get_json()
    required_fields = ["email", "password"]
    if not data or not all(field in data for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400
    
    email = data['email']
    password = data['password']

    user = db.users.find_one({"email":email})
    if not user:
        return jsonify({'error':"Invalid email or password"}),401
    
    if not check_password_hash(user['password'], password):
        return jsonify({'error':"Invalid email or password"}),401
    
    token = jwt.encode(
        {"user_id": str(user["_id"]), "exp": datetime.utcnow() + timedelta(hours=24)},
        secret_key,
        algorithm="HS256"
    )

    return jsonify({'message':'loggedin successfully', "token":token}), 200


def signup(db, secret_key):
    data = request.get_json()

    required_fields = ["name", "email", "mobile_no", "password"]
    if not data or not all(field in data for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400

    name = data["name"]
    email = data["email"]
    mobile_no = data["mobile_no"]
    password = generate_password_hash(data["password"])
    user_image = None

    if db.users.find_one({"email": email}):
        return jsonify({"error": "User with this email already exists"}), 409

    token = jwt.encode({
        "email": email,
        "exp": datetime.utcnow() + timedelta(days=1)
    }, secret_key, algorithm="HS256")

    user = User(name=name, email=email, mobile_no=mobile_no, password=password, user_image=user_image, token=token)

    user_id = db.users.insert_one(user.to_dict()).inserted_id

    return jsonify({
        "message": "User created successfully!",
        "user_id": str(user_id),
        "token": token
    }), 201
