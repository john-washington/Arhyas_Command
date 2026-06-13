import subprocess
import os
from flask import Flask, request, jsonify

def run_shell_script(script_path, *args):
    if not os.path.exists(script_path):
        return f"Error: Script not found at {script_path}"

    try:
        command = ['bash', script_path] + list(args)
        # Trigger the script securely
        result = subprocess.run(
            command,
            capture_output=True, 
            text=True, 
            check=True
        )
        return {
            "status": "success",
            "stdout": result.stdout,
            "stderr": result.stderr
        }
    except subprocess.CalledProcessError as e:
        return {
            "status": "failed",
            "error": str(e),
            "stdout": e.stdout,
            "stderr": e.stderr
        }

    #    return jsonify({"status": "success", "output": result.stdout.strip()}), 200
    #except subprocess.CalledProcessError as e:
    #    return jsonify({"status": "error", "output": e.stderr.strip()}), 500

def generate_report(lat, lon, radius, lang_code):
    try:
        # Trigger the script securely
        result = subprocess.run(
          ['./shell_script/find_circle_search_result.sh', str(lat), str(lon), str(radius), str(lang_code)],
            capture_output=True,
            text=True,
            check=True
        )
        return jsonify({"status": "success", "output": result.stdout.strip()}), 200
    except subprocess.CalledProcessError as e:
        return jsonify({"status": "error", "output": e.stderr.strip()}), 500
    #return {"report_id": report_id, "user_id": user_id, "status": "complete"}
