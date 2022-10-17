// Write a Program to check the given year is leap year or not.

class LeapYear {
  void leapy() {
    var year = 1600;
    if (year % 400 == 0) {
      print("Leap Year!");
    } else if (year % 100 == 0) {
      print("Leap Year!");
    } else if (year % 4 == 0) {
      print("Leap Year!");
    } else {
      print("It's Not Leap Year!");
    }
  }
}
