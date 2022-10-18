import 'dart:io';

import 'a1.dart';
import 'b_44.dart';
import 'b_45.dart';
import 'l1.dart';
import 'l2.dart';
import 'l3.dart';

void main() {
  // var B1=BankA();
  // B1.getBalance();
  // var B2=BankC();
  // B2.getBalance();
  // var B3=BankB();
  // B3.getBalance();

  // var m1=A(65, 95, 73);
  // print(m1.getPercentage());
  //
  // var m2=B(32, 68, 85, 46);
  // print(m2.getPercentage());

  // var f12=Factorial();
  // print(f12.facto(5));

  // var r1=Rectangle();
  // r1.circle(3);
  // r1.rectabgle(6, 8);
  // r1.square(9);

  // var m=Mark();
  // print("enter your marks:=");
  // m.marks=int.parse(stdin.readLineSync()!);
  // m.grades();

  var r1 = Sbi();
  print("enter your bank account:=");
  r1.amount = int.parse(stdin.readLineSync()!);
  r1.account();
}
