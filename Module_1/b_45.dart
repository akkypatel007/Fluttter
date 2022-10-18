abstract class Marks {
  double getPercentage();
}

class A extends Marks {
  var a, b, c;
  A(int a, int b, int c) {
    this.a = a;
    this.b = b;
    this.c = c;
  }
  @override
  double getPercentage() {
    var a1 = (a + b + c) / 3;
    return a1;
  }
}

class B extends Marks {
  var a, b, c, d;
  B(int a, int b, int c, int d) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
  }
  @override
  double getPercentage() {
    var a1 = (a + b + c + d) / 4;
    return a1;
  }
}
