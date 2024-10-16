from flask import request, jsonify
from models.finance_report import FinanceReport
from bson import ObjectId
from flask_jwt_extended import get_jwt_identity

def add_finance_report(db):
    data = request.get_json()

    required_fields = ["name", "merchant_name", "amount", "date", "description", "category"]
    if not data or not all(field in data for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400

    user_id = get_jwt_identity()

    name = data["name"]
    merchant_name = data["merchant_name"]
    amount = data["amount"]
    date = data["date"]
    description = data["description"]
    category = data["category"]
    bill_image = data.get("bill_image")
    tax = data.get("tax")

    finance_report = FinanceReport(user_id, name, merchant_name, amount, date, description, category, bill_image, tax)

    report_id = db.finance_reports.insert_one(finance_report.to_dict()).inserted_id

    return jsonify({"message": "Finance report added successfully!", "report_id": str(report_id)}), 201


def update_finance_report(db, report_id):
    if not ObjectId.is_valid(report_id):
        return jsonify({"error": "Invalid report ID"}), 400
    
    user_id = get_jwt_identity()

    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400

    allowed_fields = ["name", "merchant_name", "amount", "date", "description", "category", "bill_image", "tax"]
    update_data = {field: data[field] for field in allowed_fields if field in data}



    if not update_data:
        return jsonify({"error": "No valid fields provided for update"}), 400

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

    result = db.finance_reports.delete_one({"_id": ObjectId(report_id), "user_id":ObjectId(user_id)})

    if result.deleted_count == 0:
        return jsonify({"error": "Report not found"}), 404

    return jsonify({"message": "Finance report deleted successfully!"}), 200

def get_all_reports_for_user(db):
    user_id = get_jwt_identity()

    reports = list(db.finance_reports.find({"user_id": ObjectId(user_id)}))

    if not reports:
        return jsonify({"message": "No reports found"}), 404

    for report in reports:
        report["_id"] = str(report["_id"])
        report["user_id"] = str(report["user_id"])

    return jsonify(reports), 200


def get_all_reports_for_user(db):
    user_id = get_jwt_identity()

    reports = list(db.finance_reports.find({"user_id": ObjectId(user_id)}))

    if not reports:
        return jsonify({"message": "No reports found", "reports": []}), 200

    for report in reports:
        report["_id"] = str(report["_id"])
        report["user_id"] = str(report["user_id"])

    return jsonify({"message": "Sucessfully get response", "reports": reports}), 200
