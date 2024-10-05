from flask import Blueprint
from controller.finance_report_controller import add_finance_report, delete_finance_report, update_finance_report

def create_finance_report_routes(db):
    finance_report_routes = Blueprint("finance_report_routes", __name__)

    @finance_report_routes.route('/add', methods=['POST'])
    def add_report():
        return add_finance_report(db)

    @finance_report_routes.route('/update/<report_id>', methods=['PUT'])
    def update_report(report_id):
        return update_finance_report(db, report_id)

    @finance_report_routes.route('/delete/<report_id>', methods=['DELETE'])
    def remove_report(report_id):
        return delete_finance_report(db, report_id)

    return finance_report_routes
