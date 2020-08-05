def checkBox(x1, y1, x2, y2):
    count = 0
    for i in range(x1, x2):
        for j in range(y1, y2):
            if square[i][j] == '0':
              valid = 1
              for k in range(n*(i//n), n + n*(i//n)):
                  for l in range(n*(j//n), n + n*(j//n)):
                    if square[k][l] == s:
                      valid = 0
              for k in range(size):
                if square[i][k] == s: 
                  valid = 0
              for k in range(size):
                if square[k][j] == s:
                  valid = 0
              if valid:
                count += 1
    return count

n = int(input())

while n < 2 or n > 3:
    print("Select a number between 2 and 3")
    n = int(input())

size = n*n
square = []
symbols = []

for i in range(size):
    line = input().split()
    square.append(line)

for i in range(size):
    for j in range(size):
      if square[i][j] not in symbols and square[i][j] != '0':
        symbols.append(square[i][j])

solved = 0
while not solved:
  solved = 1
  for i in range(size):
      for j in range(size):
        if square[i][j] == '0':
          solved = 0

  for s in symbols:
    for i in range(size):
        for j in range(size):
            if square[i][j] == '0':
              valid = 1

              for k in range(n*(i//n), n + n*(i//n)): 
                  for l in range(n*(j//n), n + n*(j//n)):
                    if square[k][l] == s:
                      valid = 0

              for k in range(size):
                if square[i][k] == s: 
                  valid = 0

              for k in range(size):
                if square[k][j] == s: 
                  valid = 0

              if valid and checkBox(n*(i//n), n*(j//n), n + n*(i//n), n + n*(j//n)) == 1:
                square[i][j] = s


print("Result:")
for i in range(size):
    for j in range(size):
        print(square[i][j],end=" ")
    print()
