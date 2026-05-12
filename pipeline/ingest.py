import dlt
import polars as pl

@dlt.resource(name="ipl_deliveries", write_disposition="replace")
def load_ipl_csv():
    df = pl.read_csv(
        "data/raw/IPL.csv",
        null_values=["Unknown"],
        infer_schema_length=10000
    )
    for row in df.iter_rows(named=True):
        yield row

@dlt.source
def ipl_source():
    return load_ipl_csv()

if __name__ == "__main__":
    pipeline = dlt.pipeline(
        pipeline_name="ipl_pipeline",
        destination="duckdb",
        dataset_name="ipl_data"
    )
    load_info = pipeline.run(ipl_source())
    print(load_info)