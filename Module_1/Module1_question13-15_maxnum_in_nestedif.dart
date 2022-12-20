class MaxNumber {
  void maxnum() {
    var num1 = 55;
    var num2 = 65;
    var num3 = 95;

    if (num1 > num2) {
      if (num1 > num3){
        print("$num1 is a Max Number");
      }
    }
    else{
      if(num2>num3){
        print("$num2 is a Max Number");
      }
      else{
        print("$num3 is a Max Number");
      }
    }
  }
}

