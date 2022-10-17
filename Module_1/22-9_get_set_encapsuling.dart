class Student {
  String name = "";
  double percent = 0.00;

  void setdetail(double marks) => percent = (marks / 500) * 100;

  double getdetail() => percent;
}
