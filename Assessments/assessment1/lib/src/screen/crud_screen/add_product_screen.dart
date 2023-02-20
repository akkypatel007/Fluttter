//@dart=2.9

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imfaa/src/model/note_demo.dart';
import 'package:imfaa/src/utils/databse_helper_demo.dart';
import 'package:intl/intl.dart';

class InsertScreen extends StatefulWidget {
  final String appBarTitle;
  // final Notes note;

  const InsertScreen({this.appBarTitle
      /* this.note*/
      });

  @override
  State<InsertScreen> createState() => _InsertScreenState(this.appBarTitle);
}

class _InsertScreenState extends State<InsertScreen> {
  _InsertScreenState(this.appBarTitle);

  // final controller = Get.put(GetControllar());

  final _formKey = GlobalKey<FormState>();
  final double _minimumPadding = 5.0;
  DataBaseHelper helper = DataBaseHelper();
  String appBarTitle;
  Notes note = Notes('', '', null, null, null, '');

  // final TextEditingController productController = TextEditingController();
  // final TextEditingController categoryController = TextEditingController();
  // final TextEditingController priceController = TextEditingController();
  // final TextEditingController quantityController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   helper.getTotalPrice().then((price) {
  //     setState(() {
  //       totalprice = price;
  //     });
  //   });
  // }

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  var totalprice;
  String _product;
  String _category;
  int _price;
  int _quantity;
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // productController.text = note.product;
    // categoryController.text = note.category;
    // priceController.text = note.price as String;
    // quantityController.text = note.quantity as String;
    // note.price = int.parse(priceController.text);
    // note.quantity = int.parse(quantityController.text);

    return WillPopScope(
        onWillPop: () {
          // Write some code to control things, when user press Back navigation button in device navigationBar
          moveToLastScreen();
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back)),
              title: Text(appBarTitle),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                height: 693,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Color(0xf22324e0),
                      Color(0xff0021d2),
                    ],
                    tileMode: TileMode.mirror,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Product',
                        style: GoogleFonts.allura(
                            textStyle: TextStyle(
                                fontSize: 58,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = linearGradient)),
                      ),
                    ),
                    Text(
                      'Details',
                      style: GoogleFonts.allura(
                          textStyle: TextStyle(
                              fontSize: 58,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linearGradient)),
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                          padding: EdgeInsets.all(_minimumPadding * 2),
                          child: Column(children: [
                            // Item name
                            Row(
                              children: [
                                Text(
                                  'product',
                                  style: GoogleFonts.allura(
                                      textStyle: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          foreground: Paint()
                                            ..shader = linearGradient)),
                                ),
                                const SizedBox(width: 27),
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints.tightFor(width: 200),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a category';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        _product = value;
                                      });
                                    },
                                    // controller: productController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      // labelText: "Item name",
                                      hintText: "product",
                                      // labelStyle: TextStyle(color: Colors.white),
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    // onChanged: (value) {
                                    //   debugPrint(
                                    //       'Something changed in product Text Field');
                                    //   updateProduct();
                                    // },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'category',
                                  style: GoogleFonts.allura(
                                      textStyle: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          foreground: Paint()
                                            ..shader = linearGradient)),
                                ),
                                const SizedBox(width: 15),
                                ConstrainedBox(
                                    constraints: const BoxConstraints.tightFor(
                                        width: 200),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter a category';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          _category = value;
                                        });
                                      },
                                      // controller: categoryController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        // labelText: "Item name",
                                        hintText: "Category",
                                        // labelStyle: TextStyle(color: Colors.white),
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                      ),
                                      // onChanged: (value) {
                                      //   debugPrint(
                                      //       'Something changed in Category Text Field');
                                      //   updateCategory();
                                      // },
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Price \$',
                                  style: GoogleFonts.allura(
                                      textStyle: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          foreground: Paint()
                                            ..shader = linearGradient)),
                                ),
                                const SizedBox(width: 30),
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints.tightFor(width: 200),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a price';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        _price = int.parse(value);
                                      });
                                    },
                                    // controller: priceController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      // labelText: "Item name",
                                      hintText: "\$00.00",
                                      // labelStyle: TextStyle(color: Colors.white),
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    // onChanged: (value) {
                                    //   debugPrint(
                                    //       'Something changed in price Text Field');
                                    //   updatePrice();
                                    // },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'quantity',
                                  style: GoogleFonts.allura(
                                      textStyle: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          foreground: Paint()
                                            ..shader = linearGradient)),
                                ),
                                const SizedBox(width: 16),
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints.tightFor(width: 200),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a quantity';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        _quantity = int.parse(value);
                                      });
                                    },
                                    // controller: quantityController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      // labelText: "Item name",
                                      hintText: "number's",
                                      // labelStyle: TextStyle(color: Colors.white),
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    // onChanged: (value) {
                                    //   debugPrint(
                                    //       'Something changed in quantity Text Field');
                                    //   updateQuantity();
                                    // },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    // var totalprice = _price * _quantity;

                                    await helper.insertNote(Notes(
                                      _product,
                                      _category,
                                      _price,
                                      _quantity,
                                      totalprice,
                                      DateFormat.yMMMd().format(_date),
                                    ));
                                    moveToLastScreen();
                                    int result;
                                    /* if (note.id != null) {
                                      // Case 1: Update operation

                                      result = await helper.updateNote(note);
                                    } else {
                                      // Case 2: Insert Operation
                                      result = await helper.insertNote(note);
                                    }*/
                                    if (result != 0) {
                                      // Success
                                      _showAlertDialog(
                                          'Status', 'Note Saved Successfully');
                                    } else {
                                      // Failure
                                      _showAlertDialog(
                                          'Status', 'Problem Saving Note');
                                    }
                                    // _save(
                                    //     _product, _category, _price, _quantity);
                                  }
                                },
                                child: Text('Add Item'))
                          ])),
                    )
                  ],
                ),
              ),
            )));
  }

  void moveToLastScreen() {
    Navigator.of(context).pop();
  }

  void addOrUpdateNote() {}

/*  void updateProduct() {
    note.product = _product;

  }

  void updateQuantity() {
    note.quantity = _quantity;
  }

  void updatePrice() {
    note.price = _price;
  }

  void updateCategory() {
    note.category = _category;
  }

  void totalPrice() {
    var pric = _price;
    var quan = _quantity;
    totalprice = pric * quan;
    print(totalprice);
    note.total = totalprice;
  }*/

/*
  void _save(String product, String category, int price, int quantity) async {
    totalPrice() {
      var pric = price;
      var quan = quantity;
      totalprice = pric * quan;
      print(totalprice);
      note.total = totalprice;
    }

    moveToLastScreen();
    note.product = product;
    note.category = category;
    note.price = price;
    note.quantity = quantity;
    debugPrint("hey price is here :-${note.total}");
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      // Case 1: Update operation
      result = await helper.updateNote(note);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertNote(note);
    }
    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }
*/

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
