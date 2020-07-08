inputdata = input("").split(" ")

n = int(inputdata[0])
a = int(inputdata[1])
b = int(inputdata[2])
c = int(inputdata[3])

while n > 100000 or n<1:
	print("Invalid Input For n")
	print("Enter new value for n: ")
	n = int(input())
while a > 100000 or a<1:
	print("Invalid Input For a")
	print("Enter new value for a: ")
	a = int(input())

while b > 100000 or b<1:
	print("Invalid Input For b")
	print("Enter new value for b: ")
	b = int(input())

while c > 100000 or c<1:
	print("Invalid Input For c")
	print("Enter new value for c: ")
	c = int(input())

i = 0
points_Georgi = []
while(i <= n):
	points_Georgi.append(i)
	i += a

j = n
points_Gergana = []
while(j >= 0):
	points_Gergana.append(j)
	j -= b

col_len = 0
for dot1 in points_Georgi:
	for dot2 in points_Gergana:
		tempdot1 = max(dot1, dot2)
		tempdot2 = min(dot1, dot2)
		if tempdot1 - tempdot2 == c:
			col_len = col_len + c

result = abs(n-col_len)
print(result)