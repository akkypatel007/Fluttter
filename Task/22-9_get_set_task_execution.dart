import 'get_set_encapsuling.dart';

void main() {
  var s = Student();
  s.setdetail(400);
  print(s.getdetail());

  var s2 = Student();
  s2.setdetail(438);
  print(s2.getdetail());

  var s3 = Student();
  s3.setdetail(458);
  print(s3.getdetail());
}
