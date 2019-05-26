## 
## Escriba una consulta que retorne los primeros cinco
## registros de la tabla tbl1 ordenados por fecha
## 
import sqlite3, os
import glob
filenames = glob.glob("tbl1.csv")
conn = sqlite3.connect(":memory:")
cur = conn.cursor()
tabla = '''
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
conn.execute(tabla).fetchall()

tablita = open("tbl1.csv", "rt", encoding="utf=8").readlines()
tablita = [line[:-1] for line in tablita]
tablita = [line.split(",") for line in tablita]
tablita = [tuple(line) for line in tablita]
conn.executemany("INSERT INTO tbl1 VALUES (?,?,?,?,?,?,?)", tablita).fetchall()
conn.execute("SELECT * FROM 'tbl1' ORDER BY c14 LIMIT 5").fetchall()

