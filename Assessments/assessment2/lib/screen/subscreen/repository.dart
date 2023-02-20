import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rto_app/model/rto_offices_model.dart';

final String url = "https://akkypatel007.000webhostapp.com/rtos.json";

List<RTOofficeModel> parseUser(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var users = list.map((e) => RTOofficeModel.fromJson(e)).toList();
  print("---------------------------------$users");
  return users;
}

Future<List<RTOofficeModel>> fetchUsers() async {
  final http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return compute(parseUser, response.body);
  } else {
    throw Exception(response.statusCode);
  }
}
