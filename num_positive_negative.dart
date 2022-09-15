import 'dart:io';

void main(){
  print('Enter a value: ');
  int? num =int.parse(stdin.readLineSync()!);

  if(num >=0 ){
    if(num == 0){
      print('You enter 0.');
    }
    else{
      print('Number is Positive!');
    }
  }
  else{
    print('Number is Negtive!');
  }
}