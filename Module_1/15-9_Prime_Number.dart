class PrimeNumber {
  void primenum() {
    var num = 17;
    var factor = 0;

    for(int i=1; i<= num; i++){
      if(num % i ==0){
        factor++;
      }
    }
    if(factor > 2){
      print("$num is not a Prime number!!");
    }
    else{
      print("It's Prime number");
    }
  }
}




