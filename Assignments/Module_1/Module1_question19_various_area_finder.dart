class Areafind
{
  void af()
  {
    var height = 10;
    var base = 8;
    var length =12;
    var width =17;
    var radius =7;

    var area = 2;

    switch(area)
    {
      case 1: print("area of triangle");
      var a = (height*base)/2;
      print(a);
      break;
      case 2: print("area of circle");
      var a = 3.14*radius*radius;
      print(a);
      break;
      case 3: print("area of teiangle");
      var a = length*width;
      print(a);
      break;
      default: print("invalide opretor!");
      break;


    }



  }
}
