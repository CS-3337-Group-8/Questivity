from flask import Flask, jsonify
import requests
import os

app = Flask(__name__)


@app.route('/')
def home():
    return "Hello, World!"


@app.route('/fetch-data', methods=['GET'])
def fetch_data():
    try:
        external_api_url = 'http://db-api:3000/'
        api_key = os.getenv('API_KEY')

        headers = {
            'x-api-key': api_key
        }

        response = requests.get(external_api_url, headers=headers)


        app.logger.info(f"Response status code: {response.status_code}")
        app.logger.info(f"Response text: {response.text}")


        if response.status_code == 200:
            return response.text, 200 
        else:
            app.logger.error(f"Failed to fetch data: {response.status_code} - {response.text}")
            return jsonify({"error": "Failed to fetch data from external API"}), response.status_code
    except requests.exceptions.RequestException as e:
        app.logger.error(f"Request exception: {str(e)}")
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)