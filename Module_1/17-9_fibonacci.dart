class Fibonacci {
  void fibonacci() {
    int fibn1 = 0, fibn2 = 1, i, fib = 6;
    var fibn3;
    for (i = 2; i <= fib; i++) {
      fibn3 = fibn1 + fibn2;
      fibn1 = fibn2;
      fibn2 = fibn3;
    }
    print(fibn3);
  }
}
