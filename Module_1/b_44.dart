abstract class Bank {
  void getBalance();
}

class BankA extends Bank {
  @override
  void getBalance() {
    print("100");
  }
}

class BankB extends Bank {
  @override
  void getBalance() {
    print("200");
  }
}

class BankC extends Bank {
  @override
  void getBalance() {
    print("300");
  }
}
