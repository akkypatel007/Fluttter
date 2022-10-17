class Percentage
{
  void pr()
  {
    var maths=91;
    var hindi=79;
    var sanskrit=80;
    var scienc=75;
    var english=82;

    var total=maths+hindi+sanskrit+scienc+english;
    var percentage= total/5;
    print(percentage);

    if(percentage >= 75){
      print("Distinction");
    }
    else if(percentage >= 60){
      print("First class");
    }
    else if(percentage >= 50){
      print("Second class");
    }
    else if(percentage >= 35){
      print("Pass class");
    }
    else{
      print("You are Fail");
    }
  }
}