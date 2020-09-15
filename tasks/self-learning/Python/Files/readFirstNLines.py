n = int(input("Select N (lines 1 to N from the file will be read)"))
with open("testfile.txt") as myfile:
    for line in (myfile.readlines() [:n]):
            print(line, end ='')
