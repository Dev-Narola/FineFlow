from flask import request, jsonify
from models.finance_report import FinanceReport
from bson import ObjectId
from flask_jwt_extended import get_jwt_identity

def update_balance(db, user_id, amount, type, is_update=False):
    # Find the user's balance record
    balance_record = db.balance.find_one({"user_id": ObjectId(user_id)})

    # If no balance record exists, initialize one with the default balance
    if not balance_record:
        balance_record = {"user_id": ObjectId(user_id), "current_balance": 0}
        db.balance.insert_one(balance_record)
    
    current_balance = balance_record["current_balance"]

    # Calculate the new balance based on the report type
    if type == "income":
        new_balance = current_balance + amount
    elif type == "expense":
        new_balance = current_balance - amount

    # Update the balance collection with the new balance
    db.balance.update_one(
        {"user_id": ObjectId(user_id)},
        {"$set": {"current_balance": new_balance}}
    )

    return new_balance

def add_finance_report(db):
    data = request.get_json()
    
    required_fields = ["name", "merchant_name", "amount", "date", "description", "category", "type"]
    if not data or not all(field in data for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400

    user_id = get_jwt_identity()

    # Get report details
    name = data["name"]
    merchant_name = data["merchant_name"]
    amount = float(data["amount"])  # Ensure amount is a float for calculations
    date = data["date"]
    description = data["description"]
    category = data["category"]
    type = data["type"].lower()  # income or expense
    bill_image = data.get("bill_image")
    tax = data.get("tax")

    # Initialize FinanceReport instance with the new type field
    finance_report = FinanceReport(user_id, name, merchant_name, amount, date, description, category, type, bill_image, tax)
    report_id = db.finance_reports.insert_one(finance_report.to_dict()).inserted_id

    # Update balance based on report type
    update_balance(db, user_id, amount, type)

    return jsonify({"message": "Finance report added successfully!", "report_id": str(report_id)}), 201


def update_finance_report(db, report_id):
    if not ObjectId.is_valid(report_id):
        return jsonify({"error": "Invalid report ID"}), 400

    user_id = get_jwt_identity()

    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400

    allowed_fields = ["name", "merchant_name", "amount", "date", "description", "category", "type", "bill_image", "tax"]
    update_data = {field: data[field] for field in allowed_fields if field in data}

    if not update_data:
        return jsonify({"error": "No valid fields provided for update"}), 400

    # Get the current report to retrieve old amount and type for balance adjustment
    current_report = db.finance_reports.find_one({"_id": ObjectId(report_id), "user_id": ObjectId(user_id)})

    if not current_report:
        return jsonify({"error": "Report not found"}), 404

    # Adjust balance based on old amount and type
    old_amount = current_report["amount"]
    old_type = current_report["type"]
    update_balance(db, user_id, -old_amount, old_type)  # Subtract old amount

    # If amount or type changed, adjust balance with the new values
    new_amount = update_data.get("amount", old_amount)
    new_type = update_data.get("type", old_type)
    update_balance(db, user_id, float(new_amount), new_type)  # Add new amount

    result = db.finance_reports.update_one(
        {"_id": ObjectId(report_id), "user_id": ObjectId(user_id)},
        {"$set": update_data}
    )

    if result.matched_count == 0:
        return jsonify({"error": "Report not found"}), 404

    return jsonify({"message": "Finance report updated successfully!"}), 200


def delete_finance_report(db, report_id):
    if not ObjectId.is_valid(report_id):
        return jsonify({"error": "Invalid report ID"}), 400

    user_id = get_jwt_identity()

    # Find the report to retrieve the amount and type before deletion
    report = db.finance_reports.find_one({"_id": ObjectId(report_id), "user_id": ObjectId(user_id)})

    if not report:
        return jsonify({"error": "Report not found"}), 404

    # Adjust the balance by reversing the deleted report amount
    update_balance(db, user_id, -report["amount"], report["type"])

    result = db.finance_reports.delete_one({"_id": ObjectId(report_id), "user_id": ObjectId(user_id)})

    if result.deleted_count == 0:
        return jsonify({"error": "Report not found"}), 404

    return jsonify({"message": "Finance report deleted successfully!"}), 200


def get_all_reports_for_user(db):
    user_id = get_jwt_identity()

    reports = list(db.finance_reports.find({"user_id": ObjectId(user_id)}))

    if not reports:
        return jsonify({"message": "No reports found", "reports": []}), 200

    for report in reports:
        report["_id"] = str(report["_id"])
        report["user_id"] = str(report["user_id"])

    return jsonify({"message": "Successfully retrieved reports", "reports": reports,}), 200

def get_balance(db):
    user_id = get_jwt_identity()

    # Find the user's balance record
    balance_record = db.balance.find_one({"user_id": ObjectId(user_id)})

    if not balance_record:
        return jsonify({"message": "Balance record not found", "current_balance": 0}), 404

    current_balance = balance_record["current_balance"]

    return jsonify({"message": "Balance retrieved successfully", "current_balance": current_balance}), 200
