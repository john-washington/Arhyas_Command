#import subprocess
from flask import Flask, request, jsonify
from redis import Redis
from rq import Queue
from rq.job import Job
from uuid import uuid4
from arhyas_command_task import arhyas_command, generate_report

app = Flask(__name__)

#connect Flask to Redis and RQ Task Queue
redis_conn = Redis(host="localhost", port=6379)
task_queue = Queue(connection=redis_conn, default_timeout='24h')

@app.route('/', methods=['POST'])
def run_script():
    data = request.get_json()
    print(data)
    latitude = data['location']['coords'].get('latitude')
    longitude = data['location']['coords'].get('longitude')
    device_id = data.get('device_id', 'unknown_device')
    altitude = data['location']['coords'].get('altitude')
    radius = '200000'
    lang_code = 'zh'
    print(f"Tracking [Device {device_id}]: altitude {altitude}, Latitude {latitude}, Longitude {longitude}")

    if latitude is None or longitude is None:
       return jsonify({"error": "Missing GPS coordinates"}), 400
  
    job_id = str(uuid4())

    #enqueue task
    job = task_queue.enqueue(
            arhyas_command,
            str(latitude), str(longitude), radius, lang_code
    )   
    print(f"enqueued task job id: {job.id}")

    return jsonify({
        "status": "queued",
        "job_id": job.id, 
        "message": "Task added to the queue."
        }), 202

@app.route("/report/<int:report_id>", methods=["POST"])
def trigger_report(report_id):
      job = task_queue.enqueue(generate_report, report_id, 42, job_timeout=120)
      return jsonify({"job_id": job.id})

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
