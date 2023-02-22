import 'package:flutter/cupertino.dart';

class Note {
  int denomination;
  int quantity;
  TextEditingController controller;

  Note(
      {required this.denomination,
      required this.quantity,
      required this.controller});
}
