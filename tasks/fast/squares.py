n = int(input())

while n < 2 or n > 3:
    print('Невалиден вход')
    n = int(input())


size = n**2

check = []
square = []
symbols = []

for i in range(size):
    line = input().split()
    arr = []
    for x in range(len(line)):
        arr.append(line[x])
    square.append(line)
    check.append(arr)

for i in range(size):
    for j in range(size):
      if square[i][j] not in symbols:
          if square[i][j] != '0':
            symbols.append(square[i][j])

if len(symbols) < size:
    raise Exception("Броят на символите не може да бъде по - малък от размера на матрицата")

def isValid(x, y, s):
    correct = True

    for k in range(size):
        if square[x][k] == s or square[k][y]==s: 
          correct = False

    for k in range(n*(x//n), n + n*(x//n)): 
      for l in range(n*(y//n), n + n*(y//n)):
        if square[k][l] == s:
          correct = False

    return correct

def CheckAndReplace(x, y):
    if x == size-1:
        nextPoint = (0, y+1)
    else:
        nextPoint = (x+1, y)
    if(square[x][y] == '0'):
        for s in symbols:
            if isValid(x, y, s):
                square[x][y] = s
                if isSolved():
                    print('Резултат:')
                    for i in range(size):
                        for j in range(size):
                            if square[i][j] == check[i][j]:
                                print(square[i][j], end=" ")
                            else:
                                print(square[i][j], end=" ")
                        print()
                else:
                    CheckAndReplace(nextPoint[0], nextPoint[1])
        square[x][y] = '0'
    else:
        if x != size-1 or y != size-1:
            CheckAndReplace(nextPoint[0], nextPoint[1])

def isSolved():
    solved = True
    for x in range(size):
        for y in range(size):
            if square[x][y] == '0':
                solved = False
    return solved

CheckAndReplace(0, 0)