abstract class Rbi {
  var amount;
  var si = 4;
  void account() {}
}

class Sbi extends Rbi {
  @override
  void account() {
    if (super.amount >= 10000) {
      print("you have sufficient balance");
    } else {
      print("you don't have sufficient balance");
    }
  }
}

class Icici extends Rbi {
  @override
  void account() {
    if (super.amount >= 4000) {
      print("you have sufficient balance");
    } else {
      print("you don't have sufficient balance");
    }
  }
}

class Pnb extends Rbi {
  @override
  void account() {
    if (super.amount >= 5000) {
      print("you have sufficient balance");
    } else {
      print("you don't have sufficient balance");
    }
  }
}

class Customer {}

class Account {}
