import 'object_and_class.dart';

void main() {
  //objects
  var s1 = Student();
  var s2 = Student();

  String name = "a";
  //value assign
  s1.id = 101;
  s1.name = "Hamir";

  s2.id = 102;
  s2.name = "Akshay";

  s1.di = 14;
  s1.eman = "Akky";

  s2.di = 555;
  s2.eman = "Aayu";

  print(
      "Detail of student 1 is \n id is : ${s1.id} and  \n name is : ${s1.name}");
  print("\n");
  print(
      "Detail of student 2 is \n id is : ${s2.id} and  \n name is : ${s2.name}");
  print("\n");
  s1.a();
  print("\n");
  s2.b();
  print("\n");

  s1.x();
  print("\n");

  s2.y();

  print("${s1.eman} bapu is now learning");
}
