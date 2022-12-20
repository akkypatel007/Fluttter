import 'dart:io';
main(){
  print('Enter base:');
  int? b=int.parse(stdin.readLineSync()!);
  print('Enter height:');
  int? h=int.parse(stdin.readLineSync()!);

  var area = (b*h)/2;

  print('Area of Triangle is: $area');

}
