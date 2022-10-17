import 'dart:io';
void main(){
  print('Enter side:- ');
  int side =int.parse(stdin.readLineSync()!);
  var square = side*side;
  var cube = side*side*side;
  print('The value of square is:- $square');
  print('The value of square is: $side * $side * $side = $cube');

}
