class Factorial {
  void fact() {
    int i;
    int num = 6;
    int fac = 1;

    for (i = 1; i <= num; i++) {
      fac = fac * i;
    }
    print(fac);
//2 way
    var a = 6;
    for (var i = 5; i >= 1; i--) {
      a *= i;
    }
    print(a);
  }
}
