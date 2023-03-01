// To parse this JSON data, do
//
//     final allStateJobsAlert = allStateJobsAlertFromJson(jsonString);

import 'dart:convert';

List<AllStateJobsAlert> allStateJobsAlertFromJson(String str) =>
    List<AllStateJobsAlert>.from(
        json.decode(str).map((x) => AllStateJobsAlert.fromJson(x)));

String allStateJobsAlertToJson(List<AllStateJobsAlert> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllStateJobsAlert {
  AllStateJobsAlert({
    required this.code,
    required this.name,
    required this.link,
  });

  String code;
  String name;
  String link;

  factory AllStateJobsAlert.fromJson(Map<String, dynamic> json) =>
      AllStateJobsAlert(
        code: json["code"],
        name: json["name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "link": link,
      };
}
