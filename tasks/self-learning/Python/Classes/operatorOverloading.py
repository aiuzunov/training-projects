class Name:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __str__(self):
        return "({0},{1})".format(self.x, self.y)

    def __add__(self, other):
        x = self.x + other.x
        y = self.y + other.y
        return Name(x, y)
    def __mul__(self,other):
        x = self.x * other.x
        y = self.y * other.y
        return Name(x, y)
    def __mul__(self,other):
        x = self.x * other.x
        y = self.y * other.y
        return Name(x, y)
    def __eq__(self,other):
        x = self.x == other.x
        y = self.y == other.y
        return Name(x and y,x and y)

Name1 = Name(1, 2)
Name2 = Name(2, 1)

print(Name1+Name2)
print(Name1*Name2)
print(Name1==Name2)
