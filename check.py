import duckdb
con = duckdb.connect('ipl_pipeline.duckdb')
print(con.sql("SELECT venue, COUNT(*) as count FROM ipl_data.venue_stats GROUP BY venue HAVING COUNT(*) > 1").df())
con.close()