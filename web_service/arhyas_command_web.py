import subprocess
from flask import Flask, request, jsonify
from redis import Redis
from rq import Queue
from rq.job import Job
from rq.exceptions import NoSuchJobError
#from uuid import uuid4
from task import run_shell_script
import json
#import ijson
import jq
import sys
import math
#sys.path = [p for p in sys.path if "/usr/lib" not in p]

app = Flask(__name__)

#connect Flask to Redis and RQ Task Queue
redis_conn = Redis(host="192.168.1.179", port=6379, password='krystar1', decode_responses=False)
task_queue = Queue('arhyas_queue', connection=redis_conn, default_timeout='24h')

#this method is the main entry, for app with one single app server
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

    script_path = '../shell_script/arhyas_command_web.sh'
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
          
#this method is for app with server queue architecture, which enqueue chunks from the circle search for remote worker rq to consume, so any machine on the web can act as queue worker consumer
#we may need some type of certificate secruity at this point or look for such in the redis rq framework
@app.route('/grid_master/', methods=['POST'])
def run_grid_script():
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

    if latitude is None or longitude is None:
        return jsonify({"error": "Missing GPS coordinates"}), 400
  
    api_url="http://gis.peertalk.net:9080/functions/public.circle_search_on_centerpoint/items?center_latitude=" + str(latitude) + '&center_longitude=' + str(longitude) + '&radius=' + str(radius) + "&limit=50000"
    print(f"api_url:", {api_url})
    response1 = requests.get(api_url)    
    #print(f"respone1:", {response1})
                
    if response1.status_code == 200:
        json1 = response1.json()
        #print(json1)
        #extract data and put right back into a list
        #query1 = "[.[] | .ip_range_start]"
        compiled_query1 = jq.compile("[.[] | .ip_range_start]")
        result_obj1 = compiled_query1.input_value(json1)
        #jq '.[] | .network' "center_${lat}_${lon}_${language_code}_${radius}.json" | tr -d '"' | sed  's/\/[0-9]\{1,\}//g' > "center_${lat}_${lon}_${language_code}_${radius}.txt"
        #print(result_obj1)
        final_obj1 = list(result_obj1)
        #print(final_obj1)
    else:
        print("Error:", {response1.status_code})
        #return jsonify({"error": "response from gis is empty"}), 400
                    
    if response1 is None:
        print(f"warning: first circle search returns empty")
    
    #adjust for specific code variants of the gis api url
    language_code = str(lang_code)
    if str(lang_code) == 'zh': 
        language_code = 'zh_cn'
        
    if str(lang_code) == 'pt':
       language_code = 'pt_br'
    
                    
    api_url2="http://gis.peertalk.net:9080/functions/public.circle_search_on_centerpoint_" + str(language_code) + "/items?center_latitude=" + str(latitude) + "&center_longitude=" + str(longitude) + "&radius=" + str(radius) + "&limit=50000"
    print(f"api_url2:", {api_url2})
    response2 = requests.get(api_url2)  
    #print(response2)
                
    if response2.status_code == 200:
        json2 = response2.json()
        #print(json2)
        #extract data and put right back into a list
        #query2 = "[.[] | .network]"
        compiled_query2 = jq.compile('[.[] | .network | split("/") | .[0]]')
        result_obj2 = compiled_query2.input_value(json2)
        #print(result_obj2)
        final_obj2 = list(result_obj2)
        #print(final_obj2)
        
    else:
        print("Error:", {response2.status_code})
                    
    if response2 is None:
        print(f"warning: second circle search returns empty")
        # jsonify({"error": "response from gis is empty"}), 400
                   
    if response1 is None and response2 is None:
        return jsonify({"status": "error", "output": "No result from circle search"}), 500
        
    #so the result should be a list of chunks, which in turn is another list of targets
    combined_list = []
    for f in final_obj1[0]:
        combined_list.append(f)
        
    for k in final_obj2[0]:
        combined_list.append(k)
        
    print(f"length of final_obj1:", len(final_obj1[0]))
    print(f"length of final_obj2:", len(final_obj2[0]))
    print(f"combined_list length:", len(combined_list) )
    #print(combined_list)
    #json_arry = json.dumps(combined_list)
    chunk_size = 100
  
    #total_chunks = math.ceil(len(json_arry) / chunk_size)
    #print(f"total_chunks:", {total_chunks})
 
    chunk = []
    i = 0 
  
    return_str = ""
    for item in combined_list:
        chunk.append(item)
        #count += 1
        if len(chunk) == chunk_size:
            i +=  1
           
            #try:
            #enqueue task loop by array of chunks json format
            script_path = '../shell_script/grid_timeout.sh'
            script_args = [str(lang_code), json.dumps(chunk)]
            print(script_args)
            
            job = task_queue.enqueue(
                run_shell_script, script_path, *script_args
            )
            print(f"enqueued task job id: {job.id}")
            return_str += str(jsonify({
                "status": str(job.get_status()),
                "job_id": str(job.id), 
                "message": "Task added to the queue."
            }))
                
            chunk = []
       
    #write any left over items
    if chunk:
            #enqueue task loop by array of chunks json format
            script_path = '../shell_script/grid_timeout.sh'
            script_args = [str(lang_code), json.dumps(chunk)]
            print(script_args)
            
            job = task_queue.enqueue(
                run_shell_script, script_path, *script_args
            )
            print(f"enqueued task job id: {job.id}")
            return_str += str(jsonify({
                "status": str(job.get_status()),
                "job_id": str(job.id), 
                "message": "Task added to the queue."
            }))       
    
    return jsonify(return_str)
     
#this one is not working yet, but a place holder for reporting functions
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
          ['../shell_script/find_circle_search_result.sh', str(latitude), str(longitude), str(radius), str(lang_code)],
            capture_output=True,
            text=True,
            check=True
        )
       return jsonify({"status": "success", "output": result.stdout.strip()}), 200
    except subprocess.CalledProcessError as e:
       return jsonify({"status": "error", "output": e.stderr.strip()}), 500

#this one is working for cell app
@app.route("/task-status/<job_id>", methods=["GET"])
def get_task_status(job_id):
    try:
      job = Job.fetch(job_id, connection=redis_conn)
      if job.is_failed:
            return jsonify({
              "job exception": job.exc_info})
    except NoSuchJobError as e:
      return jsonify({
                "error": e.stderr.strip(), 
                "task_status": job.get_status(),
                "result": job.result}), 404

    return jsonify({
      "job_id": job.id, 
      "task_status": job.get_status(),
      "result": job.result,
      "created_at": str(job.created_at),
      "ended_at": str(job.ended_at),
    })


#change the host to the deploy server address
if __name__ == '__main__':
    app.run(debug=True, host='192.168.1.179', port=5000)
