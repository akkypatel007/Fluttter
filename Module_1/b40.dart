class Rectangle {
  var length;
  var breath;
  Rectangle(int length, int breath) {
    this.length = length;
    this.breath = breath;
  }
  void area() {
    var b = length * breath;
    print("area is:=$b");
  }

  void perimeter() {
    var a = 2 * (length + breath);
    print("perimeter is:=$a");
  }
}

class Square extends Rectangle {
  var square;

  Square(super.length, super.breath, int square) {
    this.square = square;
    var s = square * square;
    print("square is:=$s");
  }
}
