import redis
from rq import Queue

connection = redis.Redis(host='localhost', port=6379, db=0)
queue = Queue('default', connection=connection)

started_registry = queue.started_job_registry
job_ids = started_registry.get_job_ids()

for job_id in job_ids:
    # Use the internal connection to remove the specific job ID key
    started_registry.connection.zrem(started_registry.key, job_id)
    print(f"Force-removed stuck job ID {job_id} from registry.")
