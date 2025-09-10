import psycopg2
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

def validate_dbt_models():
    conn = psycopg2.connect(
        host="postgres",
        port=5433,
        dbname="itsm_db",
        user="dbt_user",
        password="dbt_password"
    )
    cur = conn.cursor()
    tables = [
        "tickets_analysis",
        "avg_resolution_by_cat_priority",
        "closure_rate_by_group",
        "monthly_ticket_summary"
    ]
    for table in tables:
        cur.execute(f"SELECT COUNT(*) FROM {table};")
        count = cur.fetchone()[0]
        if count == 0:
            raise Exception(f"Validation failed: {table} has 0 rows")
        else:
            print(f"{table} has {count} rows → OK")
    cur.close()
    conn.close()
default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2025, 9, 9),
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}
dag = DAG(
    "dbt_pipeline",
    default_args=default_args,
    description="DBT orchestration DAG",
    schedule_interval="@daily",
)

# Task 1: Run DBT models
run_dbt_models = BashOperator(
    task_id="run_dbt_models",
    bash_command="cd /usr/app/itsm_dbt_project && dbt run",
    dag=dag,
)

# Task 2: Validate DBT tables
validate_dbt_task = PythonOperator(
    task_id="validate_dbt_models",
    python_callable=validate_dbt_models,
    dag=dag,
)

# Set task dependencies
run_dbt_models >> validate_dbt_task
