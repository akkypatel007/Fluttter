import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.description,
    required this.occupations,
  });

  String description;
  List<String> occupations;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        description: json["description"],
        occupations: List<String>.from(json["occupations"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "occupations": List<dynamic>.from(occupations.map((x) => x)),
      };
}
