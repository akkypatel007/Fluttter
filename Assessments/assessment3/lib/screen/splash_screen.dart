import 'dart:async';

import 'package:cash_counter/screen/update_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:share/share.dart';

import '../constants/colors_size_constants.dart';
import '../models/note_model.dart';

class SavedHistory extends StatefulWidget {
  const SavedHistory({Key? key}) : super(key: key);

  @override
  State<SavedHistory> createState() => _SavedHistoryState();
}

class _SavedHistoryState extends State<SavedHistory> {
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
      formattedTime = DateFormat.jms().format(currentTime);
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
    formattedTime = DateFormat.jms().format(currentTime);
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _updateClock());
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
    timer.cancel();
  }

  Future<void> _update(
      [DocumentSnapshot? documentSnapshot, String? docId]) async {
    if (documentSnapshot != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateScreen(docID: docId!),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tAccentColor,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Saved history'),
      ),
      body: StreamBuilder(
        stream: _cash.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              // shrinkWrap: true,
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Dismissible(
                  key: Key(documentSnapshot.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onDismissed: (direction) async {
                    await _cash.doc(documentSnapshot.id).delete();
                  },
                  child: InkWell(
                    child: Card(
                      color: Colors.transparent,
                      margin: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                documentSnapshot.get('description') ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "Rs. ${documentSnapshot.get('TotalsAmount').toString()}" ??
                                  "",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 16),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    documentSnapshot.get('Created Date') ?? ""),
                                Text(
                                    documentSnapshot.get('Created Time') ?? ""),
                              ],
                            ),
                            SizedBox(width: 16),
                            IconButton(
                              onPressed: () {
                                _update(documentSnapshot, documentSnapshot.id);
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () async {
                      final snapshot =
                          await _cash.doc(documentSnapshot.id).get();

                      final quantities =
                          (snapshot.get('Quantities') as List<dynamic>)
                              .map((quantity) => quantity as int)
                              .toList();
                      final denominations =
                          (snapshot.get('Denominations') as List<dynamic>)
                              .map((denomination) => denomination as int)
                              .toList();
                      final totals = List<int>.generate(quantities.length,
                          (i) => denominations[i] * quantities[i]);
                      final totalAmount =
                          totals.fold<int>(0, (sum, total) => sum + total);
                      final sum =
                          quantities.fold(0, (prev, curr) => prev + curr);
                      final date = snapshot.get('Created Date') as String;
                      final time = snapshot.get('Created Time') as String;

                      showDialog(
                        context: context,
                        builder: (context) => RecordDetailsDialog(
                          description: snapshot.get('description') ?? '',
                          totalAmount: totalAmount,
                          quantities: quantities,
                          denominations: denominations,
                          totals: totals,
                          notesCount: sum,
                          createdData: date,
                          createdTime: time,
                          documentId: snapshot.id,
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class RecordDetailsDialog extends StatelessWidget {
  final String description;
  final int totalAmount;
  final List<int> quantities;
  final List<int> denominations;
  final List<int> totals;
  final int notesCount;
  final String createdData;
  final String createdTime;
  final String documentId;

  const RecordDetailsDialog({
    Key? key,
    required this.description,
    required this.totalAmount,
    required this.quantities,
    required this.denominations,
    required this.totals,
    required this.notesCount,
    required this.createdData,
    required this.createdTime,
    required this.documentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _cash =
        FirebaseFirestore.instance.collection("cash");
    final numberFormat = NumberFormat('#,###');

    return AlertDialog(
      title: Center(child: const Text("Record Details")),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Description:',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    description,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Total Rs.:',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 8),
                Text(
                  numberFormat.format(totalAmount),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'In Word:',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    NumberToWord().convert('en-in', totalAmount),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quantities:',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: quantities.length,
                    itemBuilder: (_, index) {
                      if (quantities[index] > 0) {
                        return Row(
                          children: [
                            Text(
                              '${denominations[index]} x ${quantities[index]}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 8),
                            // Text(
                            //   numberFormat.format(totals[index]),
                            //   style: const TextStyle(fontSize: 15),
                            // ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  'Notes Count',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 8),
                Text(
                  notesCount.toString(),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Created Date',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    '${createdData}, ${createdTime}',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 60,
              height: 65,
              child: IconButton(
                icon: Column(
                  children: [
                    Icon(Icons.share),
                    Text('share'),
                  ],
                ),
                onPressed: () {
                  final String text = "Description: $description\n"
                      "Total Rs.: ${numberFormat.format(totalAmount)}\n"
                      "In Word: ${NumberToWord().convert('en-in', totalAmount)}\n"
                      "Quantities: \n${getQuantitiesText()}\n"
                      "Notes Count: $notesCount\n"
                      "Created Date: $createdData, $createdTime";
                  Share.share(text);
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              width: 60,
              height: 65,
              child: IconButton(
                icon: Column(
                  children: [
                    Icon(Icons.edit),
                    Text('edit'),
                  ],
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(
              width: 60,
              height: 65,
              child: IconButton(
                  icon: Column(
                    children: [
                      Icon(Icons.delete),
                      Text('delete'),
                    ],
                  ),
                  onPressed: () async {
                    await _cash.doc(documentId).delete();
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ],
    );
  }

  String getQuantitiesText() {
    final List<String> texts = [];
    for (int i = 0; i < denominations.length; i++) {
      if (quantities[i] > 0) {
        texts.add('${denominations[i]} x ${quantities[i]}');
      }
    }
    return texts.join(", ");
  }
}
