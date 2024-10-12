from flask import Flask, jsonify, request
from flask_cors import CORS
import requests
import os

app = Flask(__name__)
CORS(app)

external_api_url = 'http://questivitydb-api:3000'
headers = {'x-api-key': os.getenv('DB_API_KEY')}

def fetch(url, method='GET', headers=None, json_data=None):
    response = requests.request(method, url, headers=headers, json=json_data)
    response.raise_for_status()

    if (response.headers.get('Content-Type') == 'application/json'):
        return response.json()
    
    return {
        "message" : response.text,
        "status_code" : response.status_code,
    }

@app.route('/')
def home():
    return "Questivity Server Version 1.0.0"

@app.route('/fetch-data', methods=['GET'])
def fetch_data():    
    return fetch(external_api_url, method='GET', headers=headers)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)