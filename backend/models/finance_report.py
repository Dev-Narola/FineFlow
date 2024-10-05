from datetime import datetime
from bson import ObjectId

class FinanceReport:
    def __init__(self, name, merchant_name, amount, date, description, category, bill_image=None, tax=None):
        self.id = ObjectId()
        self.name = name
        self.merchant_name = merchant_name
        self.amount = amount
        self.date = date
        self.description = description
        self.category = category
        self.bill_image = bill_image
        self.tax = tax
        self.created_date = datetime.utcnow()

    def to_dict(self):
        return {
            "_id": self.id,
            "name": self.name,
            "merchant_name": self.merchant_name,
            "amount": self.amount,
            "date": self.date,
            "description": self.description,
            "category": self.category,
            "bill_image": self.bill_image,
            "tax": self.tax,
            "created_date": self.created_date
        }