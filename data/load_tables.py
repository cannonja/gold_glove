import os
import pandas as pd
import sqlalchemy as sa
import urllib


## Make db engine
quoted = urllib.quote_plus('DRIVER={SQL Server};SERVER=FD63STA001756\\JAC2;DATABASE=lahman;trusted_connection=True')
engine = sa.create_engine('mssql+pyodbc:///?odbc_connect={}'.format(quoted))
con = engine.connect()

## Load tables
path = 'C:\\projects\\gold_glove\\baseballdatabank-2017.1\\core'
csvs = [i for i in os.listdir(path) if i.endswith('.csv')]
tables = [i.split('.')[0] for i in csvs]
errors = []

for tab, data in zip(tables, csvs):
   print "Loading {}".format(tab)
   df = pd.read_csv(data)
   try:
      df.to_sql(tab, con, if_exists = 'replace', index=False)
   except:
      print "Cannot load {}".format(tab)
      errors.append(tab)
      
## As of 7/12/2017, couldn't load PitchingPost
      


