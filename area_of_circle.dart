import 'dart:io';

main(){
  print('Enter Radius : ');
  int radius =int.parse(stdin.readLineSync()!);
  print(3.14 * radius * radius);
}