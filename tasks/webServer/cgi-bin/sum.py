#!/usr/bin/python3

# Import CGI and CGIT module
import cgi, cgitb,os
import os,sys
import urllib.parse

print ("Content-type:text/html\n")
print ("<html>")
print ("<head>")
print ("<title>First CGI Program</title>")
print ("</head>")
print ("<body>")

try:
    query = os.environ["QUERY_STRING"]
    query = urllib.parse.unquote(query, errors="surrogateescape")
    query_components = dict(qc.split("=") for qc in query.split("&"))
    sum = 0
    string = ''
    for k,v in query_components.items():
        sum += int(v)
        string += str(v) + '+'
    string = string[:-1]
except Exception as e:
    exc_type, exc_obj, exc_tb = sys.exc_info()
    fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
    print("<h3>An error occured while executing the cgi script. </br> Most Likely No Query Params Were Given</h3>")
    print("<span> Error {} </br> File Name {} </br>  Line: {} </span>".format(e,fname,exc_tb.tb_lineno))

print ("<h2>{} = {}".format(string,sum))

print ("</body>")
print ("</html>")
