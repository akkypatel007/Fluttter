abstract class Parent {
  void message() {
    print("hello this is father");
  }
}

class Child extends Parent {
  void message() {
    print("this is first subclass");
  }
}

class Subchild extends Parent {
  void message() {
    print("this is second subclass");
  }
}
