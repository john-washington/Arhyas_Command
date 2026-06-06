import subprocess
from flask import Flask, request, jsonify


def arhyas_command(lat, lon, radius, lang_code):
    try:
        # Trigger the script securely
        result = subprocess.run(
          ['./shell_script/arhyas_command_web.sh', str(lat), str(lon), radius, lang_code],
            capture_output=True, 
            text=True, 
            check=True
        )
        return jsonify({"status": "success", "output": result.stdout.strip()})
    except subprocess.CalledProcessError as e:
        return jsonify({"status": "error", "output": e.stderr.strip()}), 500

def generate_report(report_id, user_id):
    time.sleep(5)
    return {"report_id": report_id, "user_id": user_id, "status": "complete"}
