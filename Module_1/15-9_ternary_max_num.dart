class Ternary {
  void tmn() {
    var a = 23;
    var b = 45;
    var c = 66;

    var maxNumber = (a>b)?(a>c ? a:c):(b>c ? b:c);

    print("$maxNumber is Max number !!");
  }

}