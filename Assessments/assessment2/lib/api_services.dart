import 'dart:convert';

import 'package:http/http.dart' as http;

// var link = "https://opentdb.com/api.php?amount=20";
var link = "https://akkypatel007.000webhostapp.com/rto/question.json";

getQuiz() async {
  var res = await http.get(Uri.parse(link));
  if (res.statusCode == 200) {
    var data = jsonDecode(res.body.toString());
    print("data is loaded____________${data}");
    return data;
  }
}
