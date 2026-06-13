import redis
from rq import Queue
from rq.job import Job

connection = redis.Redis(host='localhost', port=6379, db=0)
queue = Queue('default', connection=connection)

# Fetch all job IDs currently stuck in the started registry
started_registry = queue.started_job_registry
job_ids = started_registry.get_job_ids()

for job_id in job_ids:
    try:
        # Fetch the job object using the ID
        job = Job.fetch(job_id, connection=connection)
        
        # This automatically pulls it out of StartedJobRegistry
        job.cancel()
        print(f"Successfully canceled stuck job: {job_id}")
        
    except Exception as e:
        print(f"Could not cancel job {job_id}: {e}")
