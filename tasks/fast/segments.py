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
print(colored)
print(result)
print(points_Gergana)
print(points_Georgi)

def drawImage(colored, result, n, c, a, b,points_Gergana,points_Georgi):
    maxwidth = 50
    while n * maxwidth > 1000:
        maxwidth = maxwidth - 1
    fontsize = 15
    if n > 20:
        fontsize = fontsize - int(n/10)
    W = n * maxwidth
    Wimg = n*30
    if n<30:
        Wimg = n*maxwidth
    H = 250
    startx = maxwidth
    starty = 150
    pairend = 145
    georgiend = 125
    gerganaend = 130
    image = Image.new('RGB', (Wimg + (2*maxwidth) + 200, H), (246, 237, 223))
    drawing = ImageDraw.Draw(image)
    textfont=ImageFont.truetype('arial.ttf', size=fontsize)
    drawing.text((10, 10),
                 "n =  {:d} м. , a = {:d} м. , b = {:d} м., c = {:d} м., неоцветена част на правата = {:d} м.".format(n, a, b, c, result),
                 fill=(0, 0, 0, 0), font=textfont)

    i = 0
    drawing.text((10, 70),
                 "Дължини за оцветяване:",
                 fill=0, font=textfont)
    while i < len(colored) - 1:
        if colored[i + 1] - colored[i] == c:
            if colored[i+1] > 9 and colored[i] >9:
                if colored[i-1] > 9:
                    pairend = pairend + 55
                else:
                    pairend = pairend + 47
            else:
                pairend = pairend + 40
            drawing.text((pairend, 70),
                 "({:d}-{:d}) ".format(colored[i],colored[i+1]),
                 fill=(0, 0, 0, 0), font=textfont)
            drawing.rectangle(
                xy=[colored[i] * maxwidth +startx, starty, colored[i + 1] * maxwidth+startx, starty + 100],
                fill=(255, 0, 0), outline=None)

        i = i + 1
    i=0
    drawing.text((10, 30),
                 "Toчки на Георги:",
                 fill=0, font=textfont)
    while i <  len(points_Georgi):
         drawing.text((georgiend, 30),
                 " {:d}  ".format(points_Georgi[i]),
                 fill=(0, 0, 0, 0), font=textfont)
         if points_Georgi[i] > 9:
           georgiend = georgiend + 22
         else:
           georgiend = georgiend + 15
         i = i+1
    i=0
    drawing.text((10, 50),
                 "Toчки на Гергана:",
                 fill=0, font=textfont)
    while i <  len(points_Gergana):
         drawing.text((gerganaend, 50),
                 " {:d}  ".format(points_Gergana[i]),
                 fill=(0, 0, 0, 0), font=textfont)
         
         if points_Gergana[i] > 9:
           gerganaend = gerganaend + 22
         else:
           gerganaend = gerganaend + 15
         i = i+1
    drawing.rectangle(xy=[580, 10, 600 ,30],
                fill=(255, 0, 0), outline=None)
    drawing.text((600, 10),
                 " - Оцветена част на правата ",
                 fill=0, font=textfont)
    i = 0
    while i < n+1:
        if n<=30:
            drawing.text((maxwidth*i+startx-10,starty-22),"{:d} м.".format(i),fill=0,font=textfont)
            drawing.line((maxwidth*i+startx,starty-5,maxwidth*i+startx,starty+5),fill=0,width=2)
            i = i + 1
        else:
            drawing.text((maxwidth*i+startx-10,starty-22),"{:d}".format(i),fill=0,font=textfont)
            drawing.line((maxwidth*i+startx,starty-5,maxwidth*i+startx,starty+5),fill=0,width=2)
            i = i + 1
    drawing.line((startx, starty-2, W+maxwidth, starty-2), fill=0, width=2)
    drawing.line((startx,starty+98, maxwidth*(n+1), starty+98), fill=0, width=2)
    drawing.line((startx, starty-2, startx, starty+98), fill=0, width=2)
    drawing.line((maxwidth*(n+1), starty-2,  maxwidth*(n+1), starty+98), fill=0, width=2)
    drawing.text((startx-20, 195), "A", fill=(0, 0, 0, 0), font=textfont, size=25)
    drawing.text((maxwidth*(n+1)+10, 195), "Y", fill=(0, 0, 0, 0), font=textfont, size=25)

    image.save("segments.png")


drawImage(colored, result, n, c, a, b,points_Gergana,points_Georgi)