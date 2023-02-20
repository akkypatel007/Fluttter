//@dart=2.9
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextForm extends StatelessWidget {
  const TextForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required double minimumPadding,
    @required this.linearGradient,
    this.onChangedProduct,
  })  : _formKey = formKey,
        _minimumPadding = minimumPadding,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final double _minimumPadding;
  final Shader linearGradient;
  final ValueChanged<String> onChangedProduct;

  @override
  Widget build(BuildContext context) {
    var productis;
    return Form(
      key: _formKey,
      child: Padding(
          padding: EdgeInsets.all(_minimumPadding * 2),
          child: Column(children: [
            // Item name
            My_field(
              linearGradient: linearGradient,
              title: 'Product',
              hintText: 'product name',
              validtorName: productis,
              onChangedValuesName: onChangedProduct,
            ),
            Row(
              children: [
                Text(
                  'category',
                  style: GoogleFonts.allura(
                      textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = linearGradient)),
                ),
                const SizedBox(width: 15),
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 200),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      // labelText: "Item name",
                      hintText: "Category",
                      // labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    /*onChanged: (value) {
                      debugPrint(
                          'Something changed in Category Text Field');
                      updateCategory();
                    },*/
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Price',
                  style: GoogleFonts.allura(
                      textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = linearGradient)),
                ),
                const SizedBox(width: 48),
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 200),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      // labelText: "Item name",
                      hintText: "\$00.00",
                      // labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    /*onChanged: (value) {
                      debugPrint(
                          'Something changed in price Text Field');
                      updatePrice();
                    },*/
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
                          foreground: Paint()..shader = linearGradient)),
                ),
                const SizedBox(width: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 200),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      // labelText: "Item name",
                      hintText: "number's",
                      // labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    /* onChanged: (value) {
                      debugPrint(
                          'Something changed in quantity Text Field');
                      updateQuantity();
                    },*/
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  // _save();
                },
                child: Text('Add Item'))
          ])),
    );
  }
}

class My_field extends StatelessWidget {
  const My_field({
    Key key,
    @required this.linearGradient,
    this.title,
    this.hintText,
    this.validtorName,
    this.onChangedValuesName,
    this.initialvalue,
  }) : super(key: key);

  final Shader linearGradient;
  final String title;
  final String hintText;
  final String validtorName;
  final ValueChanged<String> onChangedValuesName;
  final String initialvalue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.allura(
              textStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = linearGradient)),
        ),
        const SizedBox(width: 28),
        ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 200),
          child: TextFormField(
            initialValue: initialvalue,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              // labelText: "Item name",
              hintText: hintText,
              // labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            validator: (validtorName) =>
                validtorName != null && validtorName.isEmpty
                    ? 'The $validtorName cannot be empty'
                    : null,
            onChanged: onChangedValuesName,
          ),
        ),
      ],
    );
  }
}
