export AIRFLOW_HOME=/home/airflow/

airflow initdb
airflow webserver -p 8080 &
airflow scheduler

