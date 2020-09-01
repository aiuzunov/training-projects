inputArray = input().split(" ")

z = int(inputArray[0])
m = int(inputArray[1])
n = int(inputArray[2])
lower_p = 0
lower_q = 0
upper_p = 0
upper_q = 0


def findDivisor(a,b):
    GCD=0
    if a>b:
        big = a
        small = b
    else:
        big = b
        small = a
    while(small!=0):
        GCD = small
        small = big % small
        big = GCD
    return GCD


def findLower():
    global lower_p
    global lower_q
    chislitel = m
    znamenatel = n-1
    while chislitel<z:
        while znamenatel>chislitel:
            if chislitel<znamenatel and findDivisor(chislitel,znamenatel)==1:
                lower_p = chislitel
                lower_q = znamenatel
                return chislitel/znamenatel
            else:
                znamenatel-=1
        chislitel-=1
        znamenatel=z

def findUpper():
    global upper_p
    global upper_q
    chislitel = m+1
    znamenatel = 1
    while chislitel<z:
        while znamenatel<=z:
            if chislitel<znamenatel and findDivisor(chislitel,znamenatel)==1:
                upper_p = chislitel
                upper_q = znamenatel
                return chislitel/znamenatel
            else:
                znamenatel+=1
        chislitel+=1
        znamenatel=1

findLower()
findUpper()

if lower_p/lower_q<upper_p/upper_q:
    if lower_p/lower_q>m/n:
        print(str(lower_p)+" "+str(lower_q))
    else:
        print(str(upper_p)+" "+str(upper_q))
