from flask import Blueprint
from controller.user_controller import signup, login, get_user, update_user

def create_user_routes(db, secret_key):
    user_routes = Blueprint("user_routes", __name__)

    @user_routes.route('/login', methods=['POST'])
    def user_signin():
        return login(db, secret_key)

    @user_routes.route('/signup', methods=['POST'])
    def user_signup():
        return signup(db, secret_key)
    
    @user_routes.route('/getuser', methods=['GET'])
    def user_get():
        return get_user(db, secret_key)
    
    @user_routes.route('/updateuser', methods=['PUT'])
    def user_update():
        return update_user(db, secret_key)

    return user_routes
