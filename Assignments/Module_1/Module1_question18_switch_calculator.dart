class SwitchCalculator
{
  void sc()
  {
    var a = 45;
    var b = 65;
    var c = 5;

    var opretor = '+';

    switch(opretor)
    {
      case '+' : print(a+b);
      break;
      case '-' : print(a-b);
      break;
      case '*' : print(a*b);
      break;
      case '/' : print(a/c);
      break;
      default: print("invalide opretor!");
      break;
    }


  }
}
