## 
## Escriba una consulta que retorne todos los 
## campos de los registros de la tabla tbl0 
## con la columna ## c02 mayor o igual a 300.
##
import sqlite3
import glob

filenames = glob.glob("tbl0.csv")
conn = sqlite3.connect(":memory:")
cur = conn.cursor()

tabla = """
CREATE TABLE tbl0(
  K0 CHAR(1),
  c01 INT,
  c02 INT,
  c03 CHAR(4),
  c04 FLOAT
  );
"""
cur.execute(tabla).fetchall()

tabla0 = open("tbl0.csv", "rt", encoding="utf-8").readlines()
tabla1 =[line[:-1] for line in tabla0[:-1]]
tabla1.append(tabla0[-1])
tabla0 = tabla1
tabla0 = [line.split(",") for line in tabla0]
tabla0[0][0] = "A"
tabla0 = [tuple(line) for line in tabla0]

cur.executemany("INSERT INTO tbl0 VALUES(?,?,?,?,?)", tabla0).fetchall()
cur.execute("SELECT * FROM tbl0 WHERE c02 > 300 OR(c02 = 300)").fetchall()
