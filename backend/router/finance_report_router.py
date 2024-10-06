from flask import Blueprint
from controller.finance_report_controller import add_finance_report, update_finance_report, delete_finance_report, get_all_reports_for_user
from flask_jwt_extended import jwt_required

def create_finance_report_routes(db):
    finance_report_routes = Blueprint("finance_report_routes", __name__)

    @finance_report_routes.route('/add', methods=['POST'])
    @jwt_required()
    def add_report():
        return add_finance_report(db)

    @finance_report_routes.route('/update/<report_id>', methods=['PUT'])
    @jwt_required()
    def update_report(report_id):
        return update_finance_report(db, report_id)

    @finance_report_routes.route('/delete/<report_id>', methods=['DELETE'])
    @jwt_required()
    def remove_report(report_id):
        return delete_finance_report(db, report_id)

    @finance_report_routes.route('/all', methods=['GET'])
    @jwt_required()
    def get_reports():
        return get_all_reports_for_user(db)

    return finance_report_routes
