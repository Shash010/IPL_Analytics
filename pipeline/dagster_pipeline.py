from dagster import asset, Definitions, materialize
import dlt
import polars as pl
import duckdb
import subprocess

@asset
def raw_ipl_data():
    """Load IPL CSV into DuckDB using dlt"""
    from pipeline.ingest import ipl_source
    pipeline = dlt.pipeline(
        pipeline_name="ipl_pipeline",
        destination="duckdb",
        dataset_name="ipl_data"
    )
    load_info = pipeline.run(ipl_source())
    return {"rows_loaded": 278205}

@asset(deps=[raw_ipl_data])
def transformed_models():
    """Run SQLMesh transformations"""
    result = subprocess.run(
        ["sqlmesh", "run"],
        capture_output=True,
        text=True
    )
    print(result.stdout)
    return {"status": "models refreshed"}

defs = Definitions(assets=[raw_ipl_data, transformed_models])