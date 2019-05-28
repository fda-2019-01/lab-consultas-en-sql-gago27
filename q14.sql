## 
## Escriba una consulta que retorne por cada letra
## de la columna K0, el valor promedio de la columna c12
## en la tabla tbl1, para aquellos registros con c13 mayor
## a 400.
##
import sqlite3
import glob

filenames = glob.glob("tbl1.csv")
conn = sqlite3.connect(":memory:")
cur = conn.cursor()

tabla = """
CREATE TABLE tbl1(
  K0 CHAR(1),
  K1 INT,
  c12 FLOAT,
  c13 INT,
  c14 DATE,
  c15 FLOAT,
  c16 CHAR(4)
  );
"""
cur.execute(tabla).fetchall()

tabla1 = open("tbl1.csv", "rt", encoding="utf-8").readlines()
tabla2 = [line[:-1] for line in tabla1[:-1]]
tabla2.append(tabla1[-1])
tabla1=tabla2
tabla1 = [line.split(",") for line in tabla1]
tabla1 = [tuple(line) for line in tabla1]

cur.executemany("INSERT INTO tbl1 VALUES(?,?,?,?,?,?,?)", tabla1).fetchall()
cur.execute("SELECT K0, AVG(c12) FROM tbl1 WHERE c13 > '400' GROUP BY K0 ").fetchall()

