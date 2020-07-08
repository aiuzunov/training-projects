from PIL import Image, ImageDraw, ImageFont

inputdata = input("").split(" ")

n = int(inputdata[0])
a = int(inputdata[1])
b = int(inputdata[2])
c = int(inputdata[3])

while n > 100000 or n < 1:
    print("Invalid Input For n")
    print("Enter new value for n: ")
    n = int(input())
while a > 100000 or a < 1:
    print("Invalid Input For a")
    print("Enter new value for a: ")
    a = int(input())

while b > 100000 or b < 1:
    print("Invalid Input For b")
    print("Enter new value for b: ")
    b = int(input())

while c > 100000 or c < 1:
    print("Invalid Input For c")
    print("Enter new value for c: ")
    c = int(input())

colored = []
i = 0
points_Georgi = []
while (i <= n):
    points_Georgi.append(i)
    i += a

j = n
points_Gergana = []
while (j >= 0):
    points_Gergana.append(j)
    j -= b

col_len = 0
for dot1 in points_Georgi:
    for dot2 in points_Gergana:
        tempdot1 = max(dot1, dot2)
        tempdot2 = min(dot1, dot2)
        if tempdot1 - tempdot2 == c:
            if tempdot1 not in colored:
                colored.append(tempdot1)
            if tempdot2 not in colored:
                colored.append(tempdot2)
            col_len = col_len + c
if a == b == c:
    col_len = int(col_len / 2)
result = abs(n - col_len)
colored.sort()
print(result)


def drawImage(colored, result, n, c, a, b):
    maxwidth = 50;
    while n * maxwidth > 1000:
        maxwidth = maxwidth - 1
    W = n * maxwidth
    H = 150
    startx = 0
    starty = 50
    image = Image.new('RGB', (W, H), (241, 238, 209))
    drawing = ImageDraw.Draw(image)
    drawing.text((startx + 20, startx + 20),
                 "N =  {:d}, A = {:d}, B = {:d}, C = {:d}, Uncolored line length = {:d}".format(n, a, b, c, result),
                 fill=(0, 0, 0, 0))

    i = 0
    while i < len(colored) - 1:
        if colored[i + 1] - colored[i] == c:
            drawing.rectangle(
                xy=[colored[i] * maxwidth - maxwidth, starty, colored[i + 1] * maxwidth - maxwidth, starty + 100],
                fill=(255, 0, 0), outline=None)

        i = i + 1
    drawing.line((0, 48, W, 48), fill=0, width=2)
    drawing.line((0, H - 2, W, H - 2), fill=0, width=2)
    drawing.line((0, 48, 0, H), fill=0, width=2)
    drawing.line((W - 2, 48, W - 2, H - 2), fill=0, width=2)
    image.save("segments.png")


drawImage(colored, result, n, c, a, b)
