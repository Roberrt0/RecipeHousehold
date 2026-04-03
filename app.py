from flask import Flask, request, jsonify
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)

# 1. Define the Prometheus metrics
# These are the "Buckets" where your pings will be counted
RECIPE_CREATION_TOTAL = Counter('recipe_creation_total', 'Total recipes created from iOS')
APP_OPEN_TOTAL = Counter('app_open_total', 'Total times the app was opened')

@app.route('/ping', methods=['POST'])
def ping():
    data = request.get_json()
    event_type = data.get('event')

    # 2. Increment the correct counter based on the ping
    if event_type == 'recipe_created':
        RECIPE_CREATION_TOTAL.inc()
    elif event_type == 'app_opened':
        APP_OPEN_TOTAL.inc()

    return jsonify({"status": "success", "event": event_type}), 200

@app.route('/metrics')
def metrics():
    # 3. This is the endpoint Prometheus will "scrape"
    return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}

if __name__ == '__main__':
    # Run on 0.0.0.0 so your iPhone/Simulator can find it on your network
    app.run(host='0.0.0.0', port=5050)
