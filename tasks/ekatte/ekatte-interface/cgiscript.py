#!/usr/bin/python3

import cgi,cgitb, psycopg2

print ("Content-type:text/html; charset=utf-8\r\n\r\n")
print ("<html>")
print ("<head>")

print ("<style>")
print("table, th, td {")
print("border: 1px solid black;")
print("}")
print ("td {")
print ("display: table-cell;")
print ("text-align:center;")
print ("}")
print ("</style>")
 

print ("<title>Ekatte Task</title>")
print ("</head>")
print ("<body>")
print ("<h3> Търсене на информация за населено място </h3>")
print ('<form name="userinputform" method="POST" action = "cgiscript.py"> <input name="name" type="text" pattern="[а-яА-Я]*" required /> </form>')

form = cgi.FieldStorage()
input = form.getvalue("name")

connection = psycopg2.connect(
	database = 'ekatte',
	user = 'ekatte',
	password = 'randompassword1234',
	host = '127.0.0.1',
	port = '5432'
)

sql = connection.cursor()

sql.execute("SELECT ekatte.ekatte, oblasti.name, obshtini.name, ekatte.t_v_m, ekatte.name FROM oblasti,obshtini,ekatte WHERE ekatte.name LIKE concat(%s,%s) AND oblasti.oblast = obshtini.oblast AND obshtini.obshtina = ekatte.obshtina;",(input,'%'))

results = sql.fetchall()
connection.commit()

sql.close()
connection.close()

print("<table> <tr> <th>ЕКАТТЕ</th> <th>Област</th> <th>Община</th> <th>Вид</th> <th>Име</th> </tr>")

for row in results:
	print("<tr> <td>",row[0],"</td> <td>",row[1],"</td> <td>",row[2],"</td> <td>",row[3],"</td> <td>",row[4],"</td> </tr>")

print("</tr></table>")

print ("</body>")
print ("</html>")
