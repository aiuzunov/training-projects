import math
from PIL import Image, ImageDraw, ImageFont

couples = []
longestline = [0,0]
lengths = []
longestSegment = 0

A = int(input())
while A < 1 or A > 20000:
	print("Please insert a value between 0 and 20000")
	A = int(input())


for y in range(1,A+1):
    for x in range(y+1,A+1): 
        temp = math.floor(math.sqrt(x*x + y*y))
        if temp*temp == (x*x + y*y):
            couples.append(x)
            couples.append(y)
            lengths.append(temp)
            if longestSegment < temp:
                longestSegment = temp
                longestline[0] = x
                longestline[1] = y

lengths = set(lengths)
print(longestSegment,len(lengths))

def drawImage():
    image = Image.new('RGB',(900,900),(246, 237, 223))
    drawing = ImageDraw.Draw(image)
    velkoz = 600/A
    textfont=ImageFont.truetype('arial.ttf', size=22)
    textfont2=ImageFont.truetype('arial.ttf', size=18)

    drawing.text((90, 20),
                 "Входни данни :",
                 fill=(0, 0, 0, 0), font=textfont2)
    drawing.text((90, 50),
                 "А = {:d} ".format(A),
                 fill=(0, 0, 0, 0), font=textfont2)
    drawing.text((90, 80),
                 "Изходни данни:",
                 fill=(0, 0, 0, 0), font=textfont2)
    drawing.text((90, 110),
                 "Дължина на най-дългата отсечка = {:d}      Брой дължини отговарящи на условията = {:d}".format(longestSegment,len(lengths)),
                 fill=(0, 0, 0, 0), font=textfont2)
    drawing.text((90,445), "A={:d}".format(A), fill=(0,0,0,0), font=textfont)
    drawing.text((450,770), "A={:d}".format(A), fill=(0,0,0,0), font=textfont)
    drawing.rectangle(xy=[440, 20, 460 ,40],
                fill=(0, 0, 255), outline=None)
    drawing.text((460, 20),
                 " - Най-дълга отсечка ",
                 fill=0, font=textfont2)
    drawing.rectangle(xy=[440, 60, 460 ,80],
                fill=(255, 0, 0), outline=None)
    drawing.text((460, 60),
                 " - Други отсечки отговарящи на условията",
                 fill=0, font=textfont2)
    
    drawing.rectangle(xy=[150,150,750,750], fill=(255,255,255), outline=(0,0,0))
    if (len(lengths)>0):
        drawing.ellipse((147,147,153,153), fill = (0,0,255), outline =(0,0,255))
        drawing.ellipse(((150+longestline[0]*velkoz)-3, (150+longestline[1]*velkoz)-3, (150+longestline[0]*velkoz)+3,  (150+longestline[1]*velkoz)+3), fill = (0,0,255), outline =(0,0,255))
        drawing.ellipse((147,747,153,753), fill = (0,0,255), outline =(0,0,255))
        drawing.ellipse(((150+longestline[0]*velkoz)-3, (750-longestline[1]*velkoz)-3, (150+longestline[0]*velkoz)+3,  (750-longestline[1]*velkoz)+3), fill = (0,0,255), outline =(0,0,255))
        drawing.ellipse((747,147,753,153), fill = (0,0,255), outline =(0,0,255))
        drawing.ellipse(((750-longestline[0]*velkoz)-3, (150+longestline[1]*velkoz)-3, (750-longestline[0]*velkoz)+3,  (150+longestline[1]*velkoz)+3), fill = (0,0,255), outline =(0,0,255))
        drawing.ellipse((747,747,753,753), fill = (0,0,255), outline =(0,0,255))
        drawing.ellipse(((750-longestline[0]*velkoz)-3, (750-longestline[1]*velkoz)-3, (750-longestline[0]*velkoz)+3,  (750-longestline[1]*velkoz)+3), fill = (0,0,255), outline =(0,0,255))
    else:
        drawing.text((250,450),"Няма отсечки отговарящи на условията",fill=0,font=textfont)
    for i in range(0,len(couples)-1):
        drawing.line((150,150,150+couples[i]*velkoz,150+couples[i+1]*velkoz),fill=(255,0,0),width=2)
        drawing.line((150,750,150+couples[i]*velkoz,750-couples[i+1]*velkoz),fill=(255,0,0),width=2)
        drawing.line((750,150,750-couples[i]*velkoz,150+couples[i+1]*velkoz),fill=(255,0,0),width=2)
        drawing.line((750,750,750-couples[i]*velkoz,750-couples[i+1]*velkoz),fill=(255,0,0),width=2)

        i=i+2
    drawing.line((150,150,150+longestline[0]*velkoz,150+longestline[1]*velkoz),fill=(0,0,255),width=2)
    drawing.line((150,750,150+longestline[0]*velkoz,750-longestline[1]*velkoz),fill=(0,0,255),width=2)
    drawing.line((750,150,750-longestline[0]*velkoz,150+longestline[1]*velkoz),fill=(0,0,255),width=2)
    drawing.line((750,750,750-longestline[0]*velkoz,750-longestline[1]*velkoz),fill=(0,0,255),width=2)



    image.save("square.png")	 


drawImage()