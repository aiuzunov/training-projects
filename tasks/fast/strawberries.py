#Strawberries - Александър Узунов
from PIL import Image,ImageDraw,ImageFont
healthystraws = 0
decayed = []
counter = 1
counter2 = 0
counter3 = 0
inputdata = input("Въведете редове, колони и дни\n").split(",")
rows = int(inputdata[0])
columns = int(inputdata[1])
days = int(inputdata[2])
strawberry1 = [0, 0]
strawberry2 = [0, 0]
strawberry1 = input("Въведете местоположението на първата ягодка -> ред колона\n").split(",")
strawberry2 = input("Въведете местоположението на втората ягодка -> ред колона\n").split(",")

row1 = int(strawberry1[0])-1
col1 = int(strawberry1[1])-1
row2 = int(strawberry2[0])-1
col2 = int(strawberry2[1])-1

map = [['o' for x in range(columns)] for y in range(rows)]
map[row1][col1] = 'z'
map[row2][col2] = 'z'

def decay(x, y,counter):
	if x < rows-1:
		if map[x+1][y] == 'o':
			map[x+1][y] = counter
	if x > 0:
		if map[x-1][y] == 'o':
			map[x-1][y] = counter
	if y < columns-1:
		if map[x][y+1] == 'o':
			map[x][y+1] = counter
	if y > 0:
		if map[x][y-1] == 'o':
			map[x][y-1] = counter
while counter <= days:
	for row in range(rows):
		for column in range(columns):
			if map[row][column] != 'o':
				decayed.append(row)
				decayed.append(column)
	while counter2 < len(decayed)/2:
		decay(decayed[counter3], decayed[counter3+1],counter)
		counter2 += 1
		counter3 += 2
	
	counter += 1
	
for row in range(rows):
	for column in range(columns):
		if map[row][column] == 'o':
			healthystraws += 1

#for row in reversed(range(rows)):
#	print(map[row])
#print("Where: ")
#print("x - Decayed Strawberries")
#print("o - Healthy Strawberries")
print("{:d}".format(healthystraws))

def drawImage(map,rows,columns):
	white = (255, 255, 255)
	dimgray = (77, 73, 73)
	gray = (128,128,128)
	darkgray = (169, 169, 169)
	silver = (192,192,192)
	lightgray = (211,211,211)
	startx=0
	starty=0
	movex=200
	movey=200
	while(movex*columns>900):
		movex=movex-1	
	movey = movex
	W=columns*movex+1
	H=rows*movey+1
	image = Image.new('RGB', (W, H),(241, 238, 209))
	drawing = ImageDraw.Draw(image)
	dynamicfont=movex/3
	textfont=ImageFont.truetype('DejaVuSansMono.ttf', size=int(dynamicfont))
	for row in reversed(range(rows)):
		for point in map[row]:
			if point=='o':
				drawing.rectangle(xy=[startx,starty,startx+movex,starty+movey], fill=white, outline=(0,0,0))
				#drawing.text((startx+(movex/2), starty+(movey/2)), str(point),font=textfont, fill=(0,0,0,0))
				startx=startx+movex
			else:
				if point=='z':
					drawing.rectangle(xy=[startx,starty,startx+movex,starty+movey], fill=dimgray, outline=(0,0,0))
					#drawing.text((startx+(movex/2), starty+(movey/2)), str(point),font=textfont, fill=(0,0,0,0))
					startx=startx+movex
				elif point==1:
					drawing.rectangle(xy=[startx,starty,startx+movex,starty+movey], fill=gray, outline=(0,0,0))
					#drawing.text((startx+(movex/2), starty+(movey/2)), str(point),font=textfont, fill=(0,0,0,0))
					startx=startx+movex
				elif point==2:
					drawing.rectangle(xy=[startx,starty,startx+movex,starty+movey], fill=darkgray, outline=(0,0,0))
					#drawing.text((startx+(movex/2), starty+(movey/2)), str(point),font=textfont, fill=(0,0,0,0))
					startx=startx+movex
				elif point==3:
					drawing.rectangle(xy=[startx,starty,startx+movex,starty+movey], fill=silver, outline=(0,0,0))
					#drawing.text((startx+(movex/2), starty+(movey/2)), str(point),font=textfont, fill=(0,0,0,0))
					startx=startx+movex
				elif point>3:
					drawing.rectangle(xy=[startx,starty,startx+movex,starty+movey], fill=lightgray, outline=(0,0,0))
					#drawing.text((startx+(movex/2), starty+(movey/2)), str(point),font=textfont, fill=(0,0,0,0))
					startx=startx+movex

		startx=0
		starty=starty+movey
	image.save("strawberries2.png")	 
drawImage(map,rows,columns)
