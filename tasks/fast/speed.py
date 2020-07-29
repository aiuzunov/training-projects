def calc(roads,cities,optimal):
	stack = []

	new_roads  = []

	for i in roads:
		if optimal[0] <= i[2] and optimal[1] >= i[2]:
			new_roads.append(i)

	seen = [False] * len(new_roads)

	seenCities = [False] * cities
	seenCities[0] = True

	start_of_graph = 1
	stack.append(start_of_graph)
	current_pos = -1
	while len(stack) != 0:
		current_pos = stack[-1]
		for i in range(len(new_roads)):
			if current_pos == new_roads[i][0] and seen[i] is False:
				stack.append(new_roads[i][1])
				seen[i] = True
				seenCities[new_roads[i][1]-1] = True

			elif current_pos == new_roads[i][1] and seen[i] is False:
				stack.append(new_roads[i][0])
				seen[i] = True
				seenCities[new_roads[i][0]-1] = True

		try:
			delitem = stack.index(current_pos)
		except:
			delitem = -1

		if delitem != -1:		
			stack = stack[:delitem] + stack[delitem+1:]

	if False in seenCities:
		return False
	else:
		return True		

inputdata = input().split()
cities = int(inputdata[0])
num_road = int(inputdata[1])


roads= []

for i in range(num_road):
	inputdata = input().split()
	tempF = int(inputdata[0])
	tempT = int(inputdata[1])
	tempS = int(inputdata[2])
	roads.append((tempF,tempT,tempS))

optimalSpeeds = []

for i in roads:
	if i[2] not in optimalSpeeds:
		optimalSpeeds.append(i[2])
optimalSpeeds.sort()

all_tuple = []
for i in optimalSpeeds:
	for j in optimalSpeeds:
		if i < j:
			all_tuple.append((i,j))


valid_answers = []

current_optimal_sum = 10000

for i in all_tuple:
	temp = calc(roads,cities,i)
	if	temp and (abs(i[0] - i[1]) < current_optimal_sum):
		valid_answers = valid_answers[:-1]
		valid_answers.append(i)
		current_optimal_sum = abs(i[0] - i[1])
	elif temp and (abs(i[0] - i[1]) == current_optimal_sum):
		valid_answers.append(i)

valid_answers = sorted(valid_answers, key=lambda tup: tup[0])

print(valid_answers[0])
