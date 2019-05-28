## 
## Escriba una consulta que retorne por cada letra
## de la columna K0, el valor máximo de la coumna c12
## en la tabla tbl1.
##
import sqlite3
import glob

filenames = glob.glob("tbl1.csv")
conn = sqlite3.connect(":memory:")
cur= conn.cursor()

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

tabla2 = open('tbl1.csv', 'rt', encoding='utf-8').readlines()
tabla1 = [line[:-1] for line in tabla2[:-1]]
tabla1.append(tabla2[-1])
tabla2= tabla1
tabla2 = [line.split(",") for line in tabla2]
tabla2 = [tuple(line) for line in tabla2]

cur.executemany("INSERT INTO tbl1 VALUES(?,?,?,?,?,?,?)", tabla2).fetchall()
cur.execute("SELECT K0, MAX(c12) FROM tbl1 GROUP BY K0").fetchall()

