#!/usr/bin/python3

# Import CGI and CGIT module
import cgi, cgitb,os
import urllib.parse


query = os.environ["QUERY_STRING"]
query = urllib.parse.unquote(query, errors="surrogateescape")
query_components = dict(qc.split("=") for qc in query.split("&"))
sum = 0
string = 'The sum of '
for k,v in query_components.items():
    sum += int(v)
    string += str(v) + ' and '


print ("Content-type:text/html\n")
print ("<html>")
print ("<head>")
print ("<title>First CGI Program</title>")
print ("</head>")
print ("<body>")
print ("<h2>{} is equal to {}".format(string,sum))

print ("</body>")
print ("</html>")
