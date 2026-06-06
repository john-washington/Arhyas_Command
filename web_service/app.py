import subprocess
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/run', methods=['GET'])
def run_script():
    # Safely extract query parameters from URL
    device_id = request.args.get('device_id', 'unknown_device')
    lat = request.args.get('lat', '0.0')
    lon = request.args.get('lon', '0.0')
    radius = request.args.get('radius', '10000')
    lang_code = request.args.get('lang_code', 'en')
    print(f"Tracking [Device {device_id}]: Lat {lat}, Lng {lon}, Radius {radius}, Language Code {lang_code}")

    try:
        # Trigger the script securely
        result = subprocess.run(
          ['./shell_script/arhyas_command_web.sh', lat, lon, radius, lang_code],
            capture_output=True, 
            text=True, 
            check=True
        )
        return jsonify({"status": "success", "output": result.stdout.strip()})
    except subprocess.CalledProcessError as e:
        return jsonify({"status": "error", "output": e.stderr.strip()}), 500

if __name__ == '__main__':
    app.run(debug=True, host='arhyas.command.peertalk.net', port=5000)
