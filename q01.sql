## 
## Escriba una consulta que devuelva la suma del campo c12
## de la tabla tbl1
## 
import sys
import sqlite3, os
import glob
filenames = glob.glob("tbl1.csv")
conn = sqlite3.connect(":memory:")
cur = conn.cursor()
sqlcmd= '''
CREATE TABLE tbl1 (
  K0 CHAR(1),
  K1 INT,
  c12 FLOAT,
  c13 INT,
  c14 DATE,
  c15 FLOAT,
  c16 CHAR(4)
  );
  '''
conn.execute(sqlcmd).fetchall()

text = open("tbl1.csv", "rt", encoding="utf-8").readlines()
text = [line[:-1] for line in text]
text = [line.split(",") for line in text]
text = [tuple(line) for line in text]
conn.executemany('INSERT INTO tbl1 VALUES (?,?,?,?,?,?,?)', text).fetchall()
lista= conn.execute('''SELECT c12 FROM "tbl1"''').fetchall()
a = 0
for line in lista:
  a = a + line[0]
a
