from flask import Flask, jsonify, request
import requests
import os

app = Flask(__name__)

external_api_url = 'http://db-api:3000'
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
    return "Hello, World!"

@app.route('/fetch-data', methods=['GET'])
def fetch_data():    
    return fetch(external_api_url, method='GET', headers=headers)