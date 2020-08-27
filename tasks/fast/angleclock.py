timeInput = input().split(":")
hour = int(timeInput[0])
minute = int(timeInput[1])

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
