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
print ("text-align:left;")
print ("}")
print ("</style>")
 

print ("<title>Ekatte Task</title>")
print ("</head>")
print ("<body style='background-color:rgb(211, 159, 149)'>")
print ("<h3> Търсене на информация за населено място </h3>")
print ('<form name="userinputform" method="POST" action = "cgiscript.py"> <input name="name" type="text" placeholder = "Име на населено място" pattern="[а-яА-Я ]*" required /> </form>')

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

sql.execute("SELECT selishta.ekatte, oblasti.name, obshtini.name, selishta.t_v_m, selishta.name FROM oblasti,obshtini,selishta WHERE LOWER(selishta.name) LIKE concat(LOWER(%s),%s) AND oblasti.oblast_id = obshtini.oblast_id AND obshtini.obshtina_id = selishta.obshtina_id ORDER BY selishta.ekatte;",(input,'%'))

results = sql.fetchall()
connection.commit()
sql = connection.cursor()

sql = connection.cursor()

oblselect = 'SELECT count(*) from oblasti'
sql.execute(oblselect)
obl_stat = sql.fetchone()

obsselect = 'SELECT count(*) from obshtini'
sql.execute(obsselect)
obs_stat = sql.fetchone()

ekselect = 'SELECT count(*) from selishta'
sql.execute(ekselect)
ekt_stat = sql.fetchone()


sql.close()
connection.close()





print("<table> <tr> <th>ЕКАТТЕ</th> <th>Област</th> <th>Община</th> <th>Вид</th> <th>Име</th> </tr>")

for row in results:
	print("<tr> <td>",row[0],"</td> <td>",row[1],"</td> <td>",row[2],"</td> <td>",row[3],"</td> <td>",row[4],"</td> </tr>")

print("</tr></table>")
print("<br><br>")

print("<table> <tr> <th>Брой Области</th> <th>Брой Общини</th> <th>Брой Селища</th> </tr>")
print("<tr> <td>",obl_stat[0],"</td> <td>",obs_stat[0],"</td> <td>",ekt_stat[0],"</td> </tr>")
print("</tr></table>")


print ("</body>")
print ("</html>")
