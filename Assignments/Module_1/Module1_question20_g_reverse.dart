//Write a program to print the number in reverse order.
void main() {
  var rev = Reverse();
  rev.reverse();
}

class Reverse{
  int reverse = 0;
  int reminder;
  int r=1234;

  while (r != 0) {
    reminder = r % 10;
  
    reverse = reverse * 10 + reminder;
    r ~/= 10;
        }

}
