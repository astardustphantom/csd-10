import pymongo
from pymongo import MongoClient
url = "mongodb+srv://admin:348partlycloudy_@cluster0.gi0wuho.mongodb.net/pytech"
client = MongoClient(url)
db = client.pytech
print(db.list_collection_names)
