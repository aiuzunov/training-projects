inputArray = input().split(" ")

z = int(inputArray[0])
m = int(inputArray[1])
n = int(inputArray[2])
drobi = []
chislitel = 1
znamenatel = 1

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

while chislitel<z:
    while znamenatel<=z:
        if chislitel<znamenatel and findDivisor(chislitel,znamenatel)==1:
                drobi.append(str(chislitel)+' '+str(znamenatel))
                znamenatel+=1
        else:
            znamenatel+=1
    chislitel+=1
    znamenatel=1


print(drobi[drobi.index(str(m)+" "+str(n))+1])
