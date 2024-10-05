from flask import Blueprint
from controller.user_controller import signup, login

def create_user_routes(db, secret_key):
    user_routes = Blueprint("user_routes", __name__)

    @user_routes.route('/login', methods=['POST'])
    def user_signin():
        return login(db, secret_key)

    @user_routes.route('/signup', methods=['POST'])
    def user_signup():
        return signup(db, secret_key)

    return user_routes
