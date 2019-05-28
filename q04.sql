## 
## Escriba una consulta que retorne los campos K0 y c16
## para los registros de la tabla tbl1 para los que la 
## columna c16 empieza por la misma letra de la columna K0
## 
import sqlite3
import glob
filenames = glob.glob("tbl1.csv")
conn = sqlite3.connect(":memory:")
cur= conn.cursor()

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

tabla1 = open("tbl1.csv", "rt", encoding="utf-8").readlines()
tabla1 = [line[:-1] for line in tabla1]
tabla1 = [line.split(",") for line in tabla1]
tabla1 = [tuple(line) for line in tabla1]
conn.executemany('INSERT INTO tbl1 VALUES(?,?,?,?,?,?,?)', tabla1).fetchall()
cur.execute("""SELECT K0, c16 
FROM tbl1 
  WHERE
  c16 LIKE (K0 || '%')""").fetchall()

