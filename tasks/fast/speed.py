class road:
	def __init__(self,F,T,S):
		self.F = F
		self.T = T
		self.S = S
	
def seen_before(for_check,towns):
	count = 0
	queue = []
	seen_before = [0]*num_roads
	seen_before[1] = 1
	queue.append(1)
	count += 1
	while len(queue) != 0:
		position = queue[0]
		queue.pop(0)
		for i in for_check[position]:
			if seen_before[i] != 1:
				seen_before[i] = 1
				queue.append(i)
				count += 1
	return towns == count 

cur_max = 30000	
curr_min = 1
roads = []

print("Въведете 1 за въвеждане от конзолата или което и да е друго число за въвеждане от файл")
choice = int(input())

if choice == 1:
	inputdata = input().split()
	towns = int(inputdata[0])
	num_roads = int(inputdata[1])
	for i in range(num_roads):
		inputdata = input().split()
		roads.append(road(int(inputdata[0]),int(inputdata[1]),int(inputdata[2])))
else:
	i = 0 
	print("Моля въведете пътя към файла")
	filepath = input()
	file = open('{}'.format(filepath),'r')
	while 1:
		line = file.readline()
		if not line:
			break;
		fileline=line.split()
		if i != 0:
			roads.append(road(int(fileline[0]),int(fileline[1]),int(fileline[2])))
		else:
			towns = int(fileline[0])
			num_roads = int(fileline[1])
		i+=1

	file.close()

roads.sort(key=lambda x: x.S)

temp = []
for_check = [[] for i in range(num_roads)]

for i in range(len(roads)):
	for_check[roads[i].F].append(roads[i].T)
	for_check[roads[i].T].append(roads[i].F)
	temp.append(i)
	while len(temp) != 0 and seen_before(for_check,towns):
		oldest = temp[0]
		if (roads[i].S - roads[oldest].S < cur_max - curr_min):
			curr_min = roads[oldest].S
			cur_max = roads[i].S
		temp.pop(0)
		for_check[roads[oldest].F].pop(0)
		for_check[roads[oldest].T].pop(0)
	
print(curr_min,cur_max)
