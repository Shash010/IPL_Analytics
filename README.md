# 🏏 IPL Cricket Analytics (2008–2025)

An end-to-end Data Engineering and Data Analytics portfolio project built on 278,205 ball-by-ball records spanning 17 seasons of IPL cricket.
---

## 📌 Project Overview

This project builds a complete modern data pipeline - from raw CSV ingestion all the way to interactive Tableau dashboards - using a modern, production-inspired free toolstack. The goal was to answer real cricket questions with data while demonstrating end-to-end data engineering skills.

**Questions answered:**
- Which IPL teams have the highest all-time win percentage?
- Does winning the toss actually help — and does the decision to bat or field matter?
- Who are the top run scorers and wicket takers across all 17 seasons?
- Which venues favour chasers vs defenders?
- How has powerplay and death over scoring evolved over the years?
- Who has won the most Player of the Match awards?

---

## 🛠️ Tech Stack

| Layer | Tool | Purpose |
|---|---|---|
| Ingestion | [dlt](https://dlthub.com/) | Load CSV into DuckDB with auto schema inference |
| Transformation | [Polars](https://pola.rs/) | Fast DataFrame operations for data inspection |
| Storage | [DuckDB](https://duckdb.org/) | Embedded OLAP database — zero server setup |
| Modelling | [SQLMesh](https://sqlmesh.com/) | SQL transformation models with lineage and testing |
| Orchestration | [Dagster](https://dagster.io/) | Asset-based pipeline orchestration with local UI |
| Visualisation | [Tableau Public](https://public.tableau.com/) | Interactive dashboards published online |
---

## 📊 Dashboards

### Dashboard 1 — Team & Match Analysis
- Matches played by team across all seasons
- Win percentage by team with 50% reference line
- Player of the Match award leaders
- Toss decision impact (bat vs field)

<img width="1656" height="878" alt="image" src="https://github.com/user-attachments/assets/e32c3cad-76f8-4dcf-ac0f-7dc67ad1e570" />

### Dashboard 2 — Performance Analysis
- Top 10 all-time run scorers
- Top 10 all-time wicket takers
- Venue chase success rates
- Powerplay vs Death overs scoring trends (2008–2025)

<img width="1656" height="881" alt="image" src="https://github.com/user-attachments/assets/f768c2d2-dca9-40f5-bfbf-c64ebc7cf27d" />

---

## 📁 Project Structure

```
IPL_Analytics/
├── data/
│   ├── raw/                    # Raw CSV from Kaggle (not tracked in git)
│   ├── match_summary.csv       # Exported model outputs
│   ├── batting_stats.csv
│   ├── bowling_stats.csv
│   ├── team_performance.csv
│   ├── venue_stats.csv
│   ├── batter_career.csv
│   ├── bowler_career.csv
│   └── powerplay_analysis.csv
├── models/                     # SQLMesh transformation models
│   ├── clean_deliveries.sql
│   ├── match_summary.sql
│   ├── batting_stats.sql
│   ├── bowling_stats.sql
│   ├── team_performance.sql
│   ├── venue_stats.sql
│   ├── batter_career.sql
│   ├── bowler_career.sql
│   └── powerplay_analysis.sql
├── pipeline/
│   ├── ingest.py               # dlt ingestion script
│   └── dagster_pipeline.py     # Dagster asset definitions
├── config.yaml                 # SQLMesh configuration
├── requirements.txt
└── README.md
```

---

## 🚀 How to Run

### Prerequisites
- Python 3.9+
- Git

### 1. Clone the repo
```bash
git clone https://github.com/Shash010/IPL_Analytics.git
cd IPL_Analytics
```

### 2. Create and activate virtual environment
```bash
python -m venv venv
venv\Scripts\activate       # Windows CMD
source venv/Scripts/activate # Git Bash
```

### 3. Install dependencies
```bash
pip install -r requirements.txt
```

### 4. Download the dataset
Download the IPL dataset (2008–2025) from Kaggle:
[kaggle.com/datasets/chaitu20/ipl-dataset2008-2025](https://www.kaggle.com/datasets/chaitu20/ipl-dataset2008-2025)

Place `IPL.csv` inside `data/raw/`

### 5. Run the ingestion pipeline
```bash
python pipeline/ingest.py
```

### 6. Run SQLMesh transformations
```bash
sqlmesh plan
```
Type `y` when prompted.

### 7. Export models to CSV
```bash
python -c "
import duckdb
con = duckdb.connect('ipl_pipeline.duckdb')
con.sql('COPY ipl_data.match_summary TO \"data/match_summary.csv\" (HEADER, DELIMITER \",\")')
con.sql('COPY ipl_data.team_performance TO \"data/team_performance.csv\" (HEADER, DELIMITER \",\")')
con.sql('COPY ipl_data.venue_stats TO \"data/venue_stats.csv\" (HEADER, DELIMITER \",\")')
con.sql('COPY ipl_data.batting_stats TO \"data/batting_stats.csv\" (HEADER, DELIMITER \",\")')
con.sql('COPY ipl_data.bowling_stats TO \"data/bowling_stats.csv\" (HEADER, DELIMITER \",\")')
con.sql('COPY ipl_data.batter_career TO \"data/batter_career.csv\" (HEADER, DELIMITER \",\")')
con.sql('COPY ipl_data.bowler_career TO \"data/bowler_career.csv\" (HEADER, DELIMITER \",\")')
con.sql('COPY ipl_data.powerplay_analysis TO \"data/powerplay_analysis.csv\" (HEADER, DELIMITER \",\")')
print('All exported!')
con.close()
"
```

### 8. Launch Dagster UI (optional)
```bash
dagster dev -f pipeline/dagster_pipeline.py
```
Open `http://127.0.0.1:3000` in your browser.

### 9. Open in Tableau Public
Connect each CSV in `data/` as a data source in Tableau Public Desktop.

---

## 🔍 Key Insights

- **Gujarat Titans** have the highest win percentage (66.82%) despite being one of the newest franchises
- **Teams that field first** win more often (438 wins) vs batting first (377 wins) - a clear strategic insight
- **AB de Villiers** leads all-time Player of the Match awards with 27
- **Virat Kohli** is the all-time leading run scorer with 8,652 runs
- **YS Chahal** leads wicket takers with 217 wickets
- **Death over scoring** has risen significantly from 2020 onwards - T20 cricket is getting more aggressive

---

## 📦 Dependencies

```
dlt
polars
duckdb
sqlmesh
dagster
dagster-webserver
```

Install all with:
```bash
pip install dlt polars duckdb sqlmesh dagster dagster-webserver
```

---

## 📂 Data Source

- **Dataset:** [IPL Dataset 2008–2025](https://www.kaggle.com/datasets/chaitu20/ipl-dataset2008-2025) by Chaitu20 on Kaggle
- **Records:** 278,205 ball-by-ball deliveries
- **Seasons:** 2007/08 through 2025

---
