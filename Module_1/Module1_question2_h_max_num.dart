// import 'dart:convert';

class MaxNumber {
  void maxnumberEx() {
    int num = 4657;
    int large = 0;
    int rem = 0;
    while (num > 0) {
      rem = num % 10;

      if (rem > large) {
        large = rem;
      }
      num = (num / 10).floor();
    }
    print(num);
  }

  // void maxnum(){
  //   var max =0;
  //   var a = new List.filled(5, null, growable: false);
  //   print("enter the number");
  //   for(var i=0;i<5;i++){
  //     int? num = int.parse(stdin.readLineSync()!);
  //   }
  //   for(var i=0;i<5;i++){
  //     if(a[i]>max){
  //       max=a[i];
  //     }
  //     }
  //   print(max);
  // }

}
