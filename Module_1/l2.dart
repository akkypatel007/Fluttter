abstract class Shape {
  rectabgle(var l, var b);
  square(var side);
  circle(var r);
}

class Rectangle extends Shape {
  @override
  circle(r) {
    print(3.14 * r * r);
  }

  @override
  rectabgle(l, b) {
    print(l * b);
  }

  @override
  square(side) {
    print(side * side * side);
  }
}
