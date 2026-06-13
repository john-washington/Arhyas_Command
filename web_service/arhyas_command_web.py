import subprocess
from flask import Flask, request, jsonify
from redis import Redis
from rq import Queue
from rq.job import Job
from uuid import uuid4
from task import run_shell_script

app = Flask(__name__)

#connect Flask to Redis and RQ Task Queue
redis_conn = Redis(host="localhost", port=6379)
task_queue = Queue(connection=redis_conn, default_timeout='24h')

@app.route('/', methods=['POST'])
def run_script():
    data = request.get_json()
    print(data)
    latitude = data.get('latitude')
    longitude = data.get('longitude')
    device_id = data.get('deviceId', 'unknown_device')
    #altitude = data.get('altitude')
    radius = data.get('searchDistanceKm')
    radius = int(radius * 1000)
    lang_code = data.get('searchText')
    print(f"Tracking [Device {device_id}]:  Latitude {latitude}, Longitude {longitude}, Search Radius {radius}, Language Code {lang_code}")

    script_path = './shell_script/arhyas_command_web.sh'
    script_args = [str(latitude), str(longitude), str(radius), str(lang_code)]

    if latitude is None or longitude is None:
       return jsonify({"error": "Missing GPS coordinates"}), 400
    
    try:
      #enqueue task
      job = task_queue.enqueue(
            run_shell_script, script_path, *script_args
      )   
      print(f"enqueued task job id: {job.id}")

      return jsonify({
        "status": job.get_status(),
        "job_id": job.id, 
        "message": "Task added to the queue."
        }), 200
    except e:
        return jsonify({
          "status": "failed",
          "error": str(e)}), 400
          

@app.route("/report/", methods=["POST"])
def trigger_report():
    data = request.get_json()
    print(data)
    latitude = data.get('latitude')
    longitude = data.get('longitude')
    device_id = data.get('deviceId', 'unknown_device')
    radius = data.get('searchDistanceKm')
    radius = radius * 1000
    lang_code = data.get('searchText')
    #job = task_queue.enqueue(generate_report, latitude, longitude, radius, lang_code )
    try:
    # Trigger the script securely
       result = subprocess.run(
          ['./shell_script/find_circle_search_result.sh', str(latitude), str(longitude), str(radius), str(lang_code)],
            capture_output=True,
            text=True,
            check=True
        )
       return jsonify({"status": "success", "output": result.stdout.strip()}), 200
    except subprocess.CalledProcessError as e:
       return jsonify({"status": "error", "output": e.stderr.strip()}), 500

@app.route("/task-status/<job_id>", methods=["GET"])
def get_task_status(job_id):
    try:
      job = Job.fetch(job_id, connection=redis_conn)
    except:
      return jsonify({"error": "Job not found"}), 404

    return jsonify({
      "job_id": job.id, 
      "task_status": job.get_status(),
      "result": job.result,
      "created_at": str(job.created_at),
      "ended_at": str(job.ended_at),
    })



if __name__ == '__main__':
    app.run(debug=True, host='arhyas.command.peertalk.net', port=5000)
