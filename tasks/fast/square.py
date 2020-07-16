import math

lengths = []
longestSegment = 0

A = int(input())
while A < 0 or A > 20000:
	print("Please insert a value between 0 and 20000")
	A = int(input())


for x in range(1,A+1):
    for y in range(x+1,A+1): 
        temp = math.floor(math.sqrt(x*x + y*y))
        if temp*temp == (x*x + y*y):
            lengths.append(temp)
            if longestSegment < temp:
                longestSegment = temp


lengths = set(lengths)
print(longestSegment,len(lengths))
