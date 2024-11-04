from bson import ObjectId

class Balance:
    def __init__(self, user_id, initial_balance=0.0):
        self.id = ObjectId()
        self.user_id = ObjectId(user_id)
        self.current_balance = initial_balance

    def to_dict(self):
        return {
            "_id": self.id,
            "user_id": self.user_id,
            "current_balance": self.current_balance
        }
