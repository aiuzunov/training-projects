import turtle
from turtle import Turtle, Screen
import datetime
import tkinter


timeInput = input().split(":")
hour = int(timeInput[0])
minute = int(timeInput[1])
second = 0

def find_angle():
    minAngle = 360*(minute/60)
    hourAngle = 360*(hour/12)+(360/12)*(minute/60)
    if(minAngle > hourAngle):
        if((minAngle-hourAngle)>180):
            return 360-(minAngle - hourAngle)
        else:
            return minAngle - hourAngle
    else:
        if((hourAngle-minAngle)>180):
            return 360-(hourAngle - minAngle)
        else:
            return hourAngle - minAngle

print("{:.3f}".format(find_angle()))


wn = Screen()
wn.title("Clock")
wn.bgcolor("saddlebrown")
wn.setup(width=1900, height=1000)

currentHour = hour
if currentHour > 12:
    currentHour = currentHour - 12
currentMinute = minute
if currentMinute < 10:
    print("Начално време - " + str(currentHour) + ":0" + str(currentMinute))
else:
    print("Начално време - " + str(currentHour) + ":" + str(currentMinute))

currentHourText = Turtle()

circle = Turtle()
circle.penup()
circle.pencolor("black")
circle.speed(0)
circle.hideturtle()
circle.goto(0, -370)
circle.pendown()
circle.fillcolor("gold")
circle.begin_fill()
circle.circle(380)
circle.end_fill()

circle = Turtle()
circle.penup()
circle.pencolor("black")
circle.speed(0)
circle.pensize(35)
circle.hideturtle()
circle.goto(0, -390)
circle.pendown()
circle.fillcolor("gold")
circle.begin_fill()
circle.circle(400)
circle.end_fill()

hourHand = Turtle()
hourHand.shape("arrow")
hourHand.color("black")
hourHand.speed(10)
hourHand.shapesize(stretch_wid=0.4, stretch_len=18)

minuteHand = Turtle()
minuteHand.shape("arrow")
minuteHand.color("black")
minuteHand.speed(10)
minuteHand.shapesize(stretch_wid=0.4, stretch_len=26)

insideCircle = Turtle()
insideCircle.shape("circle")
insideCircle.color("black")
insideCircle.shapesize(stretch_wid=1.5, stretch_len=1.5)

def writeText():
    currentHourText.clear()
    currentHourText.penup()
    currentHourText.goto(-600, 200)
    currentHourText.pendown()
    if minute>9 and hour>9:
        currentHourText.write("Час: "+str(hour)+":"+str(minute), font=("Arial", 16, "normal"))
    elif hour>9 and minute<=9:
        currentHourText.write("Час: "+str(hour)+":"+"0"+str(minute), font=("Arial", 16, "normal"))
    elif hour<9 and minute>9:
        currentHourText.write("Час: "+"0"+str(hour)+":"+str(minute), font=("Arial", 16, "normal"))
    else:
        currentHourText.write("Час: "+"0"+str(hour)+":"+"0"+str(minute), font=("Arial", 16, "normal"))
    currentHourText.penup()
    currentHourText.goto(-600, 180)
    currentHourText.write("Ъгъл: "+"{:.3f}".format(find_angle()), font=("Arial", 16, "normal"))
    currentHourText.pendown()
    currentHourText.penup()


pen = Turtle()
pen.speed(0)
pen.color("black")
pen.penup()
pen.hideturtle()
pen.goto(0, 300)
pen.write("12", align="center", font=("Courier", 50, "normal"))
pen.penup()
pen.hideturtle()
pen.goto(340, -30)
pen.write("3", align="center", font=("Courier", 50, "normal"))
pen.penup()
pen.hideturtle()
pen.goto(0, -370)
pen.write("6", align="center", font=("Courier", 50, "normal"))
pen.penup()
pen.hideturtle()
pen.goto(-340, -30)
pen.write("9", align="center", font=("Courier", 50, "normal"))
pen.penup()
pen.hideturtle()
pen.goto(170, 260)
pen.write("1", align="center", font=("Courier", 50, "normal"))
pen.penup()
pen.hideturtle()
pen.goto(-160, 260)
pen.write("11", align="center", font=("Courier", 50, "normal"))
pen.penup()
pen.hideturtle()
pen.goto(300, 140)
pen.write("2", align="center", font=("Courier", 50, "normal"))
pen.penup()
pen.hideturtle()
pen.goto(-280, 140)
pen.write("10", align="center", font=("Courier", 50, "normal"))
pen.penup()
pen.hideturtle()
pen.goto(300, -200)
pen.write("4", align="center", font=("Courier", 50, "normal"))
pen.penup()
pen.hideturtle()
pen.goto(-300, -200)
pen.write("8", align="center", font=("Courier", 50, "normal"))
pen.penup()
pen.hideturtle()
pen.goto(170, -325)
pen.write("5", align="center", font=("Courier", 50, "normal"))
pen.penup()
pen.hideturtle()
pen.goto(-170, -325)
pen.write("7", align="center", font=("Courier", 50, "normal"))

def moveHourHand():
   currentHourInternal = hour
   degree = (currentHourInternal - 15) * -30
   currentMinuteInternal = minute
   degree = degree + -0.5 * currentMinuteInternal
   hourHand.setheading(degree)
   writeText()
   wn.ontimer(moveHourHand, 2000)


def moveMinuteHand():
    currentMinuteInternal = minute
    degree = (currentMinuteInternal - 15) * -6
    currentSecondInternal = second
    degree = degree + (-currentSecondInternal * 0.1)
    minuteHand.setheading(degree)
    writeText()
    wn.ontimer(moveMinuteHand, 2000)



def setMinute():
    global minute
    global hour
    if minute==59:
        if hour==12:
            hour = 1
        else:
            hour+=1
        minute=0
    else:
        minute += 1
    wn.ontimer(setMinute, 2000)

for i in range(-35, 105, 70):
    turtle.up()
    turtle.goto(i, 35)
    turtle.setheading(0)
    turtle.down()
    turtle.begin_fill()
    turtle.circle(10)
    turtle.end_fill()

turtle.up()
turtle.goto(-67, -40)
turtle.setheading(-60)
turtle.width(5)
turtle.down()
turtle.circle(80, 120)



wn.ontimer(setMinute, 2000)
wn.ontimer(moveHourHand, 1)
wn.ontimer(moveMinuteHand, 1)

wn.exitonclick()
