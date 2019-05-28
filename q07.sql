## 
## Escriba una consulta que retorne todos los campos de 
## la tabla tbl1 ordenada por fecha (c14) para los 
## registros con K0 diferente a A y B y c13 diferente 
## de 200 y 900
##
import sqlite3
import glob

filenames = glob.glob("tbl1.csv")
conn = sqlite3.connect(":memory:")
cur = conn.cursor()

tabla = """
CREATE TABLE tbl1 (
  K0 CHAR(1),
  K1 INT,
  c12 FLOAT,
  c13 INT,
  c14 DATE,
  c15 FLOAT,
  c16 CHAR(4)
  );
"""
conn.execute(tabla).fetchall()

tablas = open("tbl1.csv", "rt", encoding="utf-8").readlines()
tablas1 = [line[:-1] for line in tablas[:-1]]
tablas1.append(tablas[-1])
tablas = tablas1
tablas = [line.split(",") for line in tablas]
tablas = [tuple(lines) for lines in tablas]

conn.executemany("INSERT INTO tbl1 VALUES(?,?,?,?,?,?,?)", tablas).fetchall()
conn.execute("SELECT * FROM tbl1 WHERE (NOT K0 = 'A') AND(NOT K0 = 'B') AND(NOT c13 = 200) AND(NOT c13 = 900) ORDER BY c14").fetchall()

