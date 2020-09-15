from collections import Counter
def main():
    with open("testfile.txt", 'r') as f:
        words = [word for line in f for word in line.split()]
        print("The total word count is:", len(words))
        c = Counter(words)
        for word, count in c.most_common():
           print(word, count)
main()
