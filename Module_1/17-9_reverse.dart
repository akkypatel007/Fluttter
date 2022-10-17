class Reverser {
  void r1() {
    var a = 54223;
    var c, d, e;
    while (a != 0) {
      c = a % 10;
      d *= 10 + c;
    }
    print(d);
  }
}
