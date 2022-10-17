class Student {
  int id = 0;
  String name = "";

  Student(int id, String name) {
    //this -refrence keyword

    this.id = id;
    this.name = name;
  }

  void display() {
    print("$id and $name");
  }
}

class denger {
  int num = 0;
  String eman = "";

  denger(int num, String eman) {
    this.num = num;
    this.eman = eman;
  }
  void play() {
    print("$eman is your name..");
    print("$num number You achive");
  }
}
