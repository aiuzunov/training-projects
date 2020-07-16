import math
from PIL import Image, ImageDraw, ImageFont

couples = []
longestline = [0, 0]
lengths = []
longestSegment = 0

A = int(input())
while A < 0 or A > 20000:
    print("Please insert a value between 0 and 20000")
    A = int(input())

for y in range(1, A + 1):
    for x in range(y + 1, A + 1):
        temp = math.floor(math.sqrt(x * x + y * y))
        if temp * temp == (x * x + y * y):
            couples.append(x)
            couples.append(y)
            lengths.append(temp)
            if longestSegment < temp:
                longestSegment = temp
                longestline[0] = x;
                longestline[1] = y;

lengths = set(lengths)
print(longestSegment, len(lengths))


def drawImage(A, couples, longestline):
    image = Image.new('RGB', (901, 901), (241, 238, 209))
    drawing = ImageDraw.Draw(image)
    velkoz = 600 / A;
    drawing.rectangle(xy=[150, 150, 750, 750], fill=(255, 255, 255), outline=(0, 0, 0))
    drawing.ellipse((147, 147, 153, 153), fill=(0, 0, 255), outline=(0, 0, 255))
    for i in range(0, len(couples) - 1):
        drawing.line((150, 150, 150 + couples[i] * velkoz, 150 + couples[i + 1] * velkoz), fill=(255, 0, 0), width=2)
        i = i + 2;
    drawing.ellipse(((150 + longestline[0] * velkoz) - 3, (150 + longestline[1] * velkoz) - 3,
                     (150 + longestline[0] * velkoz) + 3, (150 + longestline[1] * velkoz) + 3), fill=(0, 0, 255),
                    outline=(0, 0, 255))
    drawing.line((150, 150, 150 + longestline[0] * velkoz, 150 + longestline[1] * velkoz), fill=(0, 0, 255), width=2)

    image.save("square.png")


drawImage(A, couples, longestline)