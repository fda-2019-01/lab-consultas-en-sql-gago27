## 
## Escriba una consulta que retorne el total 
## de registros de la tabla tbl1 para el ano
## 2018
##
import sqlite3, os
import glob 
import sys

filenames = glob.glob("tbl1.csv")
conn = sqlite3.connect(":memory:")
cur = conn.cursor()

tabla ="""
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
tabla0 = [line[:-1] for line in tabla1[:-1]]
tabla0.append(tabla1[-1])
tabla1 = tabla0
tabla1 = [line.split(",") for line in tabla1]
tabla1 = [tuple(line) for line in tabla1]

cur.executemany("INSERT INTO tbl1 VALUES(?,?,?,?,?,?,?)", tabla1).fetchall()
cur.execute("SELECT COUNT(*) FROM tbl1 WHERE c14 > '2017-12-31' AND(c14 < '2019-01-01')").fetchall()
