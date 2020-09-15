class Circle:
  def __init__(self, radius):
    self.radius = radius
  def calcArea(self):
      return 3.141592653589793*(self.radius**2)
  def calcPerim(self):
      return 3.141592653589793*self.radius*2

print(Circle(36).calcArea(),Circle(36).calcPerim())
