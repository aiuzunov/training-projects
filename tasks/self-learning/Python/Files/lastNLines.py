n = int(input("Select N (lines from LAST LINE as LL to LL-N from the file will be read)"))
with open("testfile.txt") as myfile:
       for line in (myfile.readlines() [-n:]):
            print(line, end ='')
