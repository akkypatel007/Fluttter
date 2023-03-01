/*
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<College> welcomeFromJson(String str) =>
    List<College>.from(json.decode(str).map((x) => College.fromJson(x)));

String welcomeToJson(List<College> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class College {
  College({
    required this.university,
    required this.college,
    required this.collegeType,
    required this.state,
    required this.district,
  });

  String university;
  String college;
  String collegeType;
  String state;
  String district;

  factory College.fromJson(Map<String, dynamic> json) => College(
        university: json["university"],
        college: json["college"],
        collegeType: json["college_type"],
        state: json["state"],
        district: json["district"],
      );

  Map<String, dynamic> toJson() => {
        "university": university,
        "college": college,
        "college_type": collegeType,
        "state": state,
        "district": district,
      };
}
*/
