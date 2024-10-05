from flask import Flask
from pymongo import MongoClient
from router.user_routes import create_user_routes
from router.finance_report_router import create_finance_report_routes

app = Flask(__name__)

client = MongoClient("mongodb+srv://dev:dev@main.mbfbf.mongodb.net/?retryWrites=true&w=majority&appName=main")
db = client["fineflow"]
user_col = db['users']

app.config["SECRET_KEY"] = "123456"

app.register_blueprint(create_user_routes(db, app.config["SECRET_KEY"]), url_prefix='/api/users')
app.register_blueprint(create_finance_report_routes(db), url_prefix='/api/reports')

if __name__ == "__main__":
    app.run(debug=True)