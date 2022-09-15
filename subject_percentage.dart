import 'dart:io';

void main(){
  print('Enter Your Maths Subject marks');
  int? Maths=int.parse(stdin.readLineSync()!);//how to get multiple input?
  print('Enter Your Science Subject marks');
  int? Science=int.parse(stdin.readLineSync()!);
  print('Enter Your Finance Subject marks');
  int? Finance=int.parse(stdin.readLineSync()!);
  print('Enter Your Sanskrit Subject marks');
  int? Sanskrit=int.parse(stdin.readLineSync()!);
  print('Enter Your English Subject marks');
  int? English=int.parse(stdin.readLineSync()!);
  print(Maths);
  print(Science);
  print(Finance);
  print(Sanskrit);
  print(English);
  
  var sum_of_subject = Maths+Science+Finance+Sanskrit+English;
  print(sum_of_subject);

  var percentage = (sum_of_subject/500)*100;

  print('Your Percentage is ;$percentage');

}