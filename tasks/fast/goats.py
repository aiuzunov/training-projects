#Козички - Александър Узунов
print("Input N (Number of goats) and K (Number of courses)")
inputdata = input().split(" ")
goatsnum= int(inputdata[0])
courses=int(inputdata[1])
while goatsnum<1 or goatsnum >1000:
	print("Please input a valid value for N:")
	goatsnum = int(input())
while courses<1 or courses >1000:
	print("Please input a valid value for K:")
	courses = int(input())
print("Input the weights of the goats")
inputdata2= input().split(" ")
transported = [None] * goatsnum
goats = []
for i in range(goatsnum):
	goats.append(int(inputdata2[i]))
	while goats[i]<0 or goats[i] > 100000:
		print("Please input a valid weight for goat #{:d}:".format(i+1))
		goats[i]=int(input()) 
goats.sort()
boatsize = goats[len(goats)-1]
flag = 1
while flag==1:
	for i in range(0,goatsnum):
		transported[i] = 0
	flag=0
	boatsize=boatsize+1
	for i in range(0,courses):
		currboatsize = 0
		for j in range(goatsnum-1,-1,-1):
			if currboatsize < boatsize:
				if transported[j]==0 and currboatsize+goats[j]<=boatsize:
					currboatsize = currboatsize + goats[j]
					transported[j]=1
	for i in range(0,goatsnum):
		if transported[i]!=1:
			flag=1
			break
print(boatsize)
