## 
## Escriba una consulta que retorne la cantidad de registros
## de la tabla tbl1
## 
import sqlite3, os
import glob
import sys
filenames= glob.glob("tbl1.csv")
latabla = open("tbl1.csv","rt", encoding="utf-8").readlines()
conn = sqlite3.connect(":memory:")
cur = conn.cursor()

tabla1 = '''
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
conn.execute(tabla1).fetchall()
latabla = [line[:-1] for line in latabla]
latabla = [line.split(",") for line in latabla]
latabla = [tuple(line) for line in latabla]
conn.executemany('INSERT INTO tbl1 VALUES (?,?,?,?,?,?,?)', latabla).fetchall()
ans = conn.execute('SELECT COUNT(*) FROM "tbl1"').fetchall()
ans

