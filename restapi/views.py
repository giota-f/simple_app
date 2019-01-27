import os
import sys
import json
from restapi import app
from jsonschema import validate
from flask import request, jsonify
from pymongo import MongoClient, ASCENDING, TEXT
from jsonschema.exceptions import ValidationError
from pymongo.errors import ConnectionFailure, DuplicateKeyError

### Reading env variables for mongoDB configuration ###
MONGO_DB = os.environ.get('MONGO_DB', 'localhost:27017')
MONGO_USERNAME = os.environ.get('MONGO_INITDB_ROOT_USERNAME', 'admin')
MONGO_PASSWORD = os.environ.get('MONGO_INITDB_ROOT_PASSWORD', 'admin')

### Establish connection with mongoDB ###
client = MongoClient(MONGO_DB, username=MONGO_USERNAME, password=MONGO_PASSWORD, authSource='admin')
db = client.admin

try:
    db.command('ismaster')
except ConnectionFailure:
    print("Failed to connect to server!")
    sys.exit()

### Creation of unique indexes ###
db.users.create_index([('id', ASCENDING)], unique=True)
db.users.create_index([('email', ASCENDING)], unique=True)

### Read validation json schema ###
with open('restapi/user-schema.json', 'r') as f:
    schema_data = f.read()
schema = json.loads(schema_data)

### Endpoints ###
@app.route('/')
def hello_world():
    return 'Hello from application', 200

@app.route('/saveUser', methods=['POST'])
def save_user():
    try:
        validate(request.json, schema)
    except ValidationError as e:
        return e.message, 400

    try:
        db.users.insert({'id': request.json['id'], 'first_name': request.json['first_name'], 'last_name': request.json['last_name'],
                                    'email': request.json['email'], 'gender': request.json['gender'],
                                    'ip_address': request.json['ip_address']})
        return 'Data successfully inserted to DB', 200
    except DuplicateKeyError:
        return 'User already exists', 400

@app.route('/getUser/email/<email>')
def get_user_email(email):
    user_email= db.users.find_one({'email': email}, {'_id': False})
    if user_email is None:
        return "No entry with this email", 400
    return jsonify({'result' : user_email}), 200

@app.route('/getUser/ip_address/<ip_address>')
def get_user_ip(ip_address):
    users= db.users.find({'ip_address': ip_address}, {'_id': False})
    output = []
    for user in users:
        output.append(user)
    if not output:
        return "No entry with this ip_address", 400
    return jsonify({'result' : output}), 200
