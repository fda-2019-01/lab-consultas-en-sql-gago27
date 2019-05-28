## 
## Escriba una consulta que compute el promedio
## de la columna c21 de la tabla tbl2 por ano 
## (columna c23) que este ordenada por año. 
##
import sqlite3, os
import glob
import sys
import time, datetime

filenames = glob.glob("tbl2.csv")
conn = sqlite3.connect(":memory:")
cur = conn.cursor()
tabla = """
CREATE TABLE tbl2(
  K1 INT,
  c21 FLOAT,
  c22 INT,
  c23 DATE,
  c24 FLOAT,
  c25 CHAR(5)
  );
"""
cur.execute(tabla).fetchall()
tabla1 = open("tbl2.csv", "rt", encoding="utf-8").readlines()
tabla2 = [line[:-1] for line in tabla1[:-1]]
tabla2.append(tabla1[-1])
tabla1 = tabla2
tabla1= [line.split(",") for line in tabla1]
tabla1[0][0] = '5'
tabla1 = [tuple(line) for line in tabla1]

cur.executemany("INSERT INTO tbl2 VALUES(?,?,?,?,?,?)", tabla1).fetchall()

cur.execute("""SELECT SUBSTR(c23, 1, 4), AVG(c21) FROM tbl2
            GROUP BY
            SUBSTR(c23, 1, 4)
            """).fetchall()
