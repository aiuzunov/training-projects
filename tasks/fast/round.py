import math


class PEL:
    def __init__(self, currposition, distance):
        self.currposition = currposition
        self.distance = distance


def shortestPath(graph, n):
    firstRound = PEL('A1', 0)
    lastRound = "A" + str(n)
    queue = [firstRound]
    past = graph.copy()

    for i in range(len(graph)):
        for j in range(len(past[i])):
            if past[i][j] == firstRound.currposition:
                past[i][j] = True
    currentPosition = queue[0]
    while len(queue) != 0:
        currentPosition = queue[0]
        queue.pop()
        distance = currentPosition.distance
        currentNumber = int(currentPosition.currposition[-1]) - 1
        if currentPosition.currposition == lastRound:
            return distance

        for i in range(len(graph[currentNumber])):
            if past[currentNumber][i] != True:
                queue.append(PEL(graph[currentNumber][i], distance + 1))
                past[currentNumber][i] = True

    return -1


def matchingRounds(firstRound, secondRound):
    distance = math.sqrt((firstRound[1] - secondRound[1]) ** 2 + (firstRound[2] - secondRound[2]) ** 2)
    if distance < (firstRound[3] + secondRound[3]) and distance > abs(firstRound[3] - secondRound[3]):
        return True
    else:
        return False


n = int(input())
rounds = []
graph = []

for i in range(n):
    name = "A" + str(i + 1)
    inputdata = input().split()
    x = int(inputdata[0])
    y = int(inputdata[1])
    rad = int(inputdata[2])
    if x < 10000 and x > -10000 and y < 10000 and y > -10000 and rad < 10000 and rad > 0:
        rounds.append((name, x, y, rad))
    else:
        if x > 10000 or x < -10000 or y > 10000 or y < -10000 or rad > 10000 or rad < 0:
            inputdata = input().split()
            x = int(inputdata[0])
            y = int(inputdata[1])
            rad = int(inputdata[2])

for i in range(len(rounds)):
    graph.append([])
    for j in range(len(rounds)):
        if i != j:
            if matchingRounds(rounds[i], rounds[j]):
                graph[i].append(rounds[j][0])

result = shortestPath(graph.copy(), n)
if result != -1:
    print(result)
else:
    print(-1)	