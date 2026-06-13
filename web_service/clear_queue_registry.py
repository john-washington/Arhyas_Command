from rq import Queue
import redis

connection = redis.Redis()
queue = Queue('default', connection=connection)

# Inspect jobs that are marked as currently running
started_registry = queue.started_job_registry
job_ids = started_registry.get_job_ids()

print("Stuck job IDs:", job_ids)

# Remove the specific stuck job ID from the active registry
# (This stops it from showing up as 'busy' or 'started')
for job_id in job_ids:
    started_registry.delete(job_id)
    #print(job_id)
