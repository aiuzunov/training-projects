import math

numberOfLengths = 0
longestSegment = 0

A = int(input())
while A < 0 or A > 20000:
	print("Please insert a value between 0 and 20000")
	A = int(input())


for x in range(1,A+1):
    for y in range(x+1,A+1): 
        temp = math.floor(math.sqrt(x*x + y*y))
        if temp*temp == (x*x + y*y):
            numberOfLengths+=1
            if longestSegment < temp:
                longestSegment = temp

print(longestSegment,numberOfLengths)
