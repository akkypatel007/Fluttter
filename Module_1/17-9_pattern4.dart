import 'dart:io';

void main() {
  for (var i = 1; i <= 5; i++) {
    for (var j = 5; j > i; j--) {
      stdout.write(' ');
    }
    for (var k = i; k >= 1; k--) {
      stdout.write(k);
    }
    print('');
  }
}
