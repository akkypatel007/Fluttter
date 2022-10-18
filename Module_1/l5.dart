class Shape1 {
  void shape() {
    print("this is shape");
  }
}

class Recta extends Shape1 {
  void rect() {
    print("this is rectangle shape");
  }
}

class Circ extends Shape1 {
  void circle() {
    print("this is circle");
  }
}

class Squa extends Recta {
  void square() {
    print("this is square");
  }
}
