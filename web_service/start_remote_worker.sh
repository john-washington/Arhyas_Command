source ../flask-env/bin/activate .
rq worker --logging_level DEBUG  arhyas_queue --url redis://:krystar1@192.168.1.179

