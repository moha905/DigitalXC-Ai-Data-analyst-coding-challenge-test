ITSM Project: Data Engineering Workflow
Project Overview
This project demonstrates a complete data engineering workflow for IT Service Management (ITSM) data, including data ingestion, transformation, orchestration, and visualization. It leverages DBT, PostgreSQL, Apache Airflow, and Superset to create a fully functional pipeline.
Project Structure
itsm_project/
│
├── airflow/                   # Apache Airflow DAGs and configurations
├── dbt/                       # DBT models, sources, and transformations
├── dbt_project/               # DBT project configuration
├── superset/                  # Superset configuration files
├── superset_home/             # Superset home directory
├── data/                      # Raw and cleaned datasets
├── docker-compose1.yml        # Docker Compose file to run Postgres, DBT, Airflow, Superset
├── docker-compose.airflow.yml # Optional Airflow-specific Docker Compose
└── README.md                  # Project documentation
Step 1: Data Cleaning (Pandas)
Load raw data into Python using pandas.
Clean and preprocess the data:
Handle missing values
Remove duplicates
Standardize column names
Perform basic transformations (dates, numeric formats)
import pandas as pd

df = pd.read_csv("data/raw_tickets.csv")
df.drop_duplicates(inplace=True)
df['created_date'] = pd.to_datetime(df['created_date'])
df.to_csv("data/cleaned_tickets.csv", index=False)
Step 2: Docker Compose Setup
docker-compose -f docker-compose1.yml up -d
Services included:
PostgreSQL – Database for storing raw and transformed data
DBT – Data transformation and modeling
Apache Airflow – Workflow orchestration
Apache Superset – Data visualization dashboard
Step 3: Data Ingestion and Transformation (DBT & PostgreSQL)
Configure DBT profile to connect to PostgreSQL:
dbt:
  target: dev
  outputs:
    dev:
      type: postgres
      host: postgres
      user: dbt_user
      password: dbt_password
      dbname: itsm_db
      schema: public
Build DBT models:
avg_resolution_by_cat_priority.sql – Average resolution time per category & priority
closure_rate_by_group.sql – Ticket closure rate per assigned group
monthly_ticket_summary.sql – Tickets created and closed per month
Run DBT transformations:
dbt run
Step 4: Workflow Orchestration (Apache Airflow)
Schedule DBT jobs, data ingestion, and other tasks using Airflow DAGs.
Example DAG setup in airflow/dags/dbt_workflow_dag.py:
from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

dag = DAG("dbt_workflow", start_date=datetime(2025, 1, 1), schedule_interval="@daily")

run_dbt = BashOperator(
    task_id="run_dbt",
    bash_command="dbt run --project-dir /usr/app/dbt_project",
    dag=dag
)
Step 5: Data Visualization (Apache Superset)
Access Superset UI: http://localhost:8090
Connect to PostgreSQL database (itsm_db) with credentials:
Host: postgres
Port: 5432 or mapped port 5433
Username: dbt_user
Password: dbt_password
Create datasets from DBT models.
Build dashboards:
Ticket Volume Trends – Line chart
Resolution Time – Bar chart
Closure Rate – Pie chart
Ticket Backlog – Table
Add filters for week, category, and priority for interactivity.
Step 6: Git Version Control
Initialize Git repository:
git init
Add files:
git add .
git commit -m "Initial commit: ITSM project with DBT, Airflow, Superset"
Add GitHub remote and push:
git remote add origin git@github.com:moha905/DigitalXC-Ai-Data-analyst-coding-challenge-test.git
git push -u origin main
Technologies Used
Python & Pandas – Data cleaning & preprocessing
PostgreSQL – Data storage
DBT – Data transformation & modeling
Apache Airflow – Workflow orchestration
Apache Superset – Dashboard & data visualization
Docker & Docker Compose – Containerized environment
