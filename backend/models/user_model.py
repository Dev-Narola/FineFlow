from datetime import datetime
from bson import ObjectId

class User:
    def __init__(self, name, email, mobile_no, password, user_image="https://img.freepik.com/premium-vector/portrait-happy-business-man-avatar-hand-drawn-doodle-cartoon-style-vector-illustration_1044602-55.jpg", token=None):
        self.id = ObjectId()
        self.name = name
        self.email = email
        self.mobile_no = mobile_no
        self.password = password
        self.user_image = user_image
        self.token = token
        self.created_date = datetime.utcnow()

    def to_dict(self):
        return {
            "_id": self.id,
            "name": self.name,
            "email": self.email,
            "mobile_no": self.mobile_no,
            "password": self.password,
            "user_image": self.user_image,
            "created_date": self.created_date,
            "token" : self.token
        }
