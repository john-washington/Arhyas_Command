python -m venv flask-env
ssh pi@pi-p cat web_service.tar.gz > web_service.tar.gz
gunzip -cd web_service.tar.gz | tar -xv
cd web_service
source ../flask-env/bin/activate .
pip install Flask rq
ssh pi@pi-l cat start_remote_worker.sh > start_remote_worker.sh
chmod a+x start_remote_worker.sh
