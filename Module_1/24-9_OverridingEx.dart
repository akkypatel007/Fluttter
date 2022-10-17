class Bank1 {
  int rate() {
    return 0;
  }
}

class Sbi extends Bank1 {
  int rate() {
    return 7;
  }
}

class Icici extends Bank1 {
  int rate() {
    return 8;
  }
}

class Axis extends Bank1 {
  int rate() {
    return 9;
  }
}

class Mybank {
  int rate() {
    return 0;
  }
}

class BOI extends Mybank {
  int rate() {
    return 10;
  }
}

class HDFC extends Mybank {
  int rate() {
    return 12;
  }
}

class RDCB extends Mybank {
  int rate() {
    return 11;
  }
}
