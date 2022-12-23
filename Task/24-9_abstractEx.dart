abstract class Shape {
  void draw();

  int x = 0;
  int y = 0;

  void myNormalFunction() {
    print("Normal Function");
  }
}

class Circle extends Shape {
  @override
  void draw() {
    print("Drawing Circle.....");
  }
}

class Rectangle extends Shape {
  @override
  void draw() {
    print("Drawing Rectangle.....");
  }
}
