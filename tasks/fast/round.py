from collections import deque
import math
from PIL import Image, ImageDraw, ImageFont


class PEL:
    def __init__(self, currposition, distance, previous):
        self.currposition = currposition
        self.distance = distance
        self.previous = previous


def shortestPath(graph, n, points, lastRound):
    firstRound = PEL("A1", 0, "")
    queue = deque()
    queue.append(firstRound)
    past = graph.copy()

    for i in range(len(graph)):
        for j in range(len(past[i])):
            if past[i][j] == firstRound.currposition:
                past[i][j] = True
    currentPosition = queue[0]
    while len(queue) != 0:
        currentPosition = queue[0]
        queue.popleft()
        distance = currentPosition.distance
        currentNumber = int(currentPosition.currposition[-1]) - 1
        if currentPosition.currposition == lastRound:
            return distance

        for i in range(len(graph[currentNumber])):
            if past[currentNumber][i] != True:
                queue.append(PEL(graph[currentNumber][i], currentPosition.distance + 1,
                                 currentPosition.currposition + "," + currentPosition.previous))
                points.append(PEL(graph[currentNumber][i], currentPosition.distance + 1,
                                  currentPosition.currposition + "," + currentPosition.previous))
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
lastRound = "A" + str(n)

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

finalpath = []
points = []


def pathPoints(rounds, points, lastRound, finalpath):
    for point in points:
        if point.currposition == lastRound:
            path = point.previous
            path = point.currposition + "," + path
            path = path.split(",")

    for p in path:
        for r in rounds:
            if p == r[0]:
                finalpath.append(r)
    finalpath.reverse()
    return finalpath


def drawImage():
    minstep = 30
    if (n > 3):
        minstep = minstep - n * 2
    image = Image.new('RGB', (900, 900), (246, 237, 223))
    drawing = ImageDraw.Draw(image)
    for round in rounds:
        drawing.ellipse(((450 + (round[1] - round[3]) * minstep, 450 + (round[2] - round[3]) * minstep),
                         (450 + (round[1] + round[3]) * minstep, 450 + (round[2] + round[3]) * minstep)),
                        outline=(0, 0, 0))
    i = 0
    while i < len(finalpath) - 1:
        print(450 + finalpath[i][1] * minstep, 450 + (finalpath[i][2] * minstep), 450 + (finalpath[i + 1][1] * minstep),
              450 + (finalpath[i + 1][2] * minstep))
        drawing.line((450 + (finalpath[i][1] * minstep), 450 + (finalpath[i][2] * minstep),
                      450 + (finalpath[i + 1][1] * minstep), 450 + (finalpath[i + 1][2] * minstep)), fill=(255, 0, 0),
                     width=3)
        drawing.ellipse((447 + (finalpath[i][1] * minstep), 447 + (finalpath[i][2] * minstep),
                         453 + (finalpath[i][1] * minstep), 453 + (finalpath[i][2] * minstep)), fill=(0, 0, 255),
                        outline=(0, 0, 255))
        drawing.ellipse((447 + (finalpath[i + 1][1] * minstep), 447 + (finalpath[i + 1][2] * minstep),
                         453 + (finalpath[i + 1][1] * minstep), 453 + (finalpath[i + 1][2] * minstep)),
                        fill=(0, 0, 255), outline=(0, 0, 255))

        i += 1
    image.save("round.png")


result = shortestPath(graph.copy(), n, points, lastRound)
if result != -1:
    print(result)
    print(1)
    finalpath = pathPoints(rounds, points, lastRound, finalpath)
    print(finalpath)
    drawImage()
else:
    print(-1)