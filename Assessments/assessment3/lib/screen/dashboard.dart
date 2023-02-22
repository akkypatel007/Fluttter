import 'dart:async';

import 'package:cash_counter/screen/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_to_words/number_to_words.dart';

import '../constants/colors_size_constants.dart';
import '../models/note_model.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _CashCalculatorState();
}

class _CashCalculatorState extends State<DashBoardScreen> {
  final CollectionReference _cash =
      FirebaseFirestore.instance.collection("cash");
  double cash = 0.0;
  double rate = 0.0;
  double result = 0.0;
  double total = 0.0;
  // DateTime now = DateTime.now();
  late Timer timer;
  late DateTime currentTime;
  String formattedTime = '';

  void _updateClock() {
    setState(() {
      currentTime = DateTime.now();
      formattedTime = DateFormat.jm().format(currentTime);
    });
  }

  String formattedDate = DateFormat.yMMMd().format(DateTime.now());
  List<Note> notes = [
    Note(denomination: 2000, quantity: 0, controller: TextEditingController()),
    Note(denomination: 500, quantity: 0, controller: TextEditingController()),
    Note(denomination: 200, quantity: 0, controller: TextEditingController()),
    Note(denomination: 100, quantity: 0, controller: TextEditingController()),
    Note(denomination: 50, quantity: 0, controller: TextEditingController()),
    Note(denomination: 20, quantity: 0, controller: TextEditingController()),
    Note(denomination: 10, quantity: 0, controller: TextEditingController()),
    Note(denomination: 5, quantity: 0, controller: TextEditingController()),
    Note(denomination: 2, quantity: 0, controller: TextEditingController()),
    Note(denomination: 1, quantity: 0, controller: TextEditingController()),
  ];
  List<Note> notesBreakdown = [];

  void calculate() {
    setState(() {
      result = cash * rate;
      total = 0.0;
      notesBreakdown.clear();
      for (var note in notes) {
        total += note.denomination * note.quantity;
      }
      for (var note in notes) {
        if (note.quantity > 0) {
          notesBreakdown.add(note);
        }
      }
    });
  }

  clearNotes() {
    setState(() {
      for (var note in notes) {
        note.quantity = 0;
        note.controller.clear();
      }
      total = 0;
    });
  }

  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text =
        'Cash On ${DateFormat('yyyy-MM-dd').format(DateTime.now())}';
    currentTime = DateTime.now();
    formattedTime = DateFormat.jm().format(currentTime);
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _updateClock());
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Cash Calculator'),
        actions: [Text(formattedTime)],
      ),
      backgroundColor: tAccentColor,
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) {
                var note = notes[index];
                return ListTile(
                  leading: Text(
                    '${note.denomination}',
                    // textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        ' x ',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 80,
                        child: TextField(
                          controller: note.controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Quantity',
                          ),
                          onChanged: (value) {
                            setState(() {
                              note.quantity =
                                  value.isEmpty ? 0 : int.parse(value);
                            });
                          },
                        ),
                      ),
                      Text(
                        ' = ',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: Text(
                    '${note.denomination * note.quantity}',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Total Rs.'),
                    SizedBox(height: 10),
                    Text(
                      '${notes.fold<int>(0, (sum, note) => sum + note.denomination * note.quantity)}',
                      style: TextStyle(fontSize: 25),
                    )
                  ],
                ),
                Text(
                    "${NumberToWord().convert('en-in', notes.fold<int>(0, (sum, note) => sum + note.denomination * note.quantity))}"),
                // add this after the ListView.builder
                Text(
                  'Total: ${notes.fold<int>(0, (sum, note) => sum + note.quantity)}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                      height: 35,
                      width: 80,
                      color: Colors.green,
                      child: IconButton(
                        icon: Icon(Icons.clear, color: Colors.white),
                        onPressed: clearNotes,
                      )),
                  const SizedBox(height: 5),
                  const Text('clear'),
                ],
              ),
              Column(
                children: [
                  Container(
                      height: 35,
                      width: 80,
                      color: Colors.green,
                      child: IconButton(
                          icon: Icon(Icons.save, color: Colors.white),
                          onPressed: () {
                            DateTime? _selectedDate;

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                int sum = notes.fold<int>(
                                    0,
                                    (sum, note) =>
                                        sum +
                                        note.denomination * note.quantity);
                                NumberFormat numberFormat =
                                    NumberFormat('#,###');

                                String formattedSum = numberFormat.format(sum);
                                return AlertDialog(
                                  title: const Text('Enter Description / Note'),
                                  content: Wrap(
                                    children: [
                                      TextFormField(
                                        controller: _dateController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter a date',
                                          suffixIcon: IconButton(
                                            icon: const Icon(
                                                Icons.calendar_today),
                                            onPressed: () async {
                                              final DateTime? picked =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(2100),
                                              );
                                              if (picked != null) {
                                                _dateController.text =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(picked);
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Total Rs.${formattedSum ?? 0}',
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: notes.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var note = notes[index];
                                          if (note.quantity > 0) {
                                            return Row(
                                              children: [
                                                Text(
                                                  '${note.denomination}',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const Text(
                                                  ' x ',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  '${note.quantity}',
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Container(); // Return an empty container if note quantity is 0
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () async {
                                        String enteredDate =
                                            _selectedDate?.toString() ??
                                                _dateController.text.toString();

                                        List<int> quantities = [];
                                        List<int> denominations = [];
                                        List<int> totals = [];
                                        print("totals before fold: $totals");

                                        for (var note in notes) {
                                          if (note.quantity > 0) {
                                            int denomination =
                                                note.denomination;
                                            int quantity = note.quantity;
                                            int total = denomination * quantity;
                                            quantities.add(note.quantity);
                                            denominations
                                                .add(note.denomination);
                                            totals.add(total);
                                          }
                                        }
                                        int totalAmount = 0;
                                        if (totals.isNotEmpty) {
                                          totalAmount = totals.fold<int>(0,
                                              (prev, amount) => prev + amount);
                                          print(
                                              "totalAmount after fold: $totalAmount");
                                        }
                                        await _cash.add({
                                          "description": enteredDate.toString(),
                                          "Created Date":
                                              formattedDate.toString(),
                                          "Created Time":
                                              formattedTime.toString(),
                                          "Quantities": quantities,
                                          "Denominations": denominations,
                                          "Totals": totals,
                                          "TotalsAmount": totalAmount,
                                        });

                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          })),
                  const SizedBox(height: 5),
                  const Text('save'),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 35,
                    width: 80,
                    color: Colors.green,
                    child: IconButton(
                      icon:
                          Icon(Icons.format_list_bulleted, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SavedHistory()));
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text('saved records'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
//Created Date
//Created Time
//Notes Count
//Quantity
//Total Rs
//name
