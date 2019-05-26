## 
## Escriba una consulta que retorne todos los campos de 
## la tabla tbl0 para los que el campo c02 es igual a 100
## o igual a 600
## 
import sqlite3
import glob
conn = sqlite3.connect(":memory:")
cur = conn.cursor()
filenames = glob.glob("tbl0.csv")
tabla= """
CREATE TABLE tbl0 (
 K0 CHAR(1),
 c01 INT,
 c02 INT,
 c03 CHAR(4),
 c04 FLOAT
 );"""
conn.execute(tabla).fetchall()
tablas = open("tbl0.csv", "rt", encoding="utf-8").readlines()
tablas = [line[:-1] for line in tablas]
tablas = [line.split(",") for line in tablas]
tablas[0][0] = 'A'
tablas = [tuple(line) for line in tablas]
conn.executemany("INSERT INTO tbl0 VALUES(?,?,?,?,?)", tablas).fetchall()
conn.execute("SELECT * FROM tbl0 WHERE c02 = 100 OR c02 = 600").fetchall()
