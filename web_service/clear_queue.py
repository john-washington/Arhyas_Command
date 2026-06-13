import redis
from rq import Worker, Queue

# 1. Connect to your Redis instance
connection = redis.Redis(host='localhost', port=6379, db=0)

# 2. Fetch all registered workers 
workers = Worker.all(connection=connection)

for worker in workers:
    # Check if the worker is registered as busy in Redis
    if worker.state == 'busy':
        print(f"Cleaning up stuck worker: {worker.name}")
        
        # This force-moves its active job to the failed registry 
        # and unregisters the dead worker from Redis
        worker.register_death()
