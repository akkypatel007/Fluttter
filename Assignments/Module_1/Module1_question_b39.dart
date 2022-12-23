class Member {
  void printSalary() {
    var salary1 = 52333;
    print("Salary of Employee:= $salary1");
  }
}

class Employee extends Member {
  void detail(
      var name, var age, var phone, var add, var salary, var specialization) {
    print(name);
    print(age);
    print(phone);
    print(add);
    print(salary);
    print(specialization);
  }
}

class Manager extends Member {
  void detail1(var department) {
    print(department);
  }
}
