// To parse this JSON data, do
//
//     final jobsAlert = jobsAlertFromJson(jsonString);
//GET http://localhost:3000/freejobalert/
import 'dart:convert';

List<JobsAlert> jobsAlertFromJson(String str) =>
    List<JobsAlert>.from(json.decode(str).map((x) => JobsAlert.fromJson(x)));

String jobsAlertToJson(List<JobsAlert> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobsAlert {
  JobsAlert({
    required this.title,
    this.link,
  });

  String title;
  String? link;

  factory JobsAlert.fromJson(Map<String, dynamic> json) => JobsAlert(
        title: json["title"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
      };
}
