import sys
import pandas
from sqlalchemy import create_engine

if len(sys.argv) == 3:
    sql_file = sys.argv[1]
    result_file = sys.argv[2]
    conn = create_engine(
        r"mssql+pyodbc://DESKTOP-F1E0DKV\SQL2019/master?driver=ODBC+Driver+17+for+SQL+Server"
    )
    with open(sql_file) as file:
        sql = file.read()
        df = pandas.read_sql(sql, conn)
        df.to_csv(result_file, index=False)
else:
    print("Usage: runme.py SQLFile ResultFile")
