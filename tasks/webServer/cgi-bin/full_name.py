#!/usr/bin/python3

import cgi,cgitb
cgitb.enable()

form = cgi.FieldStorage(encoding="utf-8")

first_name = form.getvalue('first_name') or ''
last_name  = form.getvalue('last_name') or ''


print("Content-type:text/html\r\n\r\n")
print("<html>")
print("<head>")
print("<title>Second CGI Program</title>")
print("</head>")
print("<body>")
print("<h2>Full Name: {} {}</h2>".format(first_name,last_name))
print("</body>")
print("</html>")
