//@dart=2.9
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteFormWidget extends StatelessWidget {
  final int price;
  final int quantity;
  final String product;
  final String category;
  final ValueChanged<int> onChangedPrice;
  final ValueChanged<int> onChangedQuantity;
  final ValueChanged<String> onChangedProduct;
  final ValueChanged<String> onChangedCategory;

  NoteFormWidget({
    Key key,
    this.price = 0,
    this.quantity = 0,
    this.product = '',
    this.category = '',
    this.onChangedPrice,
    this.onChangedQuantity,
    this.onChangedProduct,
    this.onChangedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: Container(
            constraints: BoxConstraints.tightForFinite(height: 691),
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
              mainAxisSize: MainAxisSize.min,
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
                buildProduct(),
                SizedBox(height: 8),
                buildCategory(),
                SizedBox(height: 16),
                buildPrice(),
                SizedBox(height: 16),
                buildQuantity(),
                SizedBox(height: 16),
                buildButton(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );

  Widget buildProduct() => Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'product',
              style: GoogleFonts.allura(
                  textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..shader = linearGradient)),
            ),
          ),
          const SizedBox(width: 26),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 200),
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                // labelText: "Item name",
                hintText: "Product name",
                // labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              validator: (product) => product != null && product.isEmpty
                  ? 'The product cannot be empty'
                  : null,
              onChanged: onChangedProduct,
            ),
          ),
        ],
      );

  Widget buildCategory() => Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'category',
              style: GoogleFonts.allura(
                  textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..shader = linearGradient)),
            ),
          ),
          const SizedBox(width: 15),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 200),
            child: TextFormField(
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
              validator: (category) => category != null && category.isEmpty
                  ? 'The category cannot be empty'
                  : null,
              onChanged: onChangedCategory,
            ),
          ),
        ],
      );

  Widget buildPrice() => Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Price',
              style: GoogleFonts.allura(
                  textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..shader = linearGradient)),
            ),
          ),
          const SizedBox(width: 48),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 200),
            child: TextFormField(
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
              validator: (price) => price != null && price.isEmpty
                  ? 'The price cannot be empty'
                  : null,
              onChanged: (price) => {onChangedPrice.toString()},
            ),
          ),
        ],
      );

  Widget buildQuantity() => Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'quantity',
              style: GoogleFonts.allura(
                  textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..shader = linearGradient)),
            ),
          ),
          const SizedBox(width: 16),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 200),
            child: TextFormField(
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
              validator: (quantity) => quantity != null && quantity.isEmpty
                  ? 'The quantity cannot be empty'
                  : null,
              onChanged: (quantity) => {onChangedQuantity.toString()},
            ),
          ),
        ],
      );
}

Widget buildButton() =>
    ElevatedButton(onPressed: () {}, child: Text('Add Item'));

final Shader linearGradient = const LinearGradient(
  colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

/*
  Widget buildProduct() =>
      TextFormField(
        maxLines: 1,
        initialValue: product,
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText: 'Name',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (product) =>
        product != null && product.isEmpty
            ? 'The product cannot be empty'
            : null,
        onChanged: onChangedProduct,
      );
*/

/*
  Widget buildCategory() =>
      TextFormField(
        maxLines: 5,
        initialValue: category,
        style: TextStyle(color: Colors.white60, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type category',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (category) =>
        category != null && category.isEmpty
            ? 'The category cannot be empty'
            : null,
        onChanged: onChangedCategory,
      );
*/

/*
  Widget buildPrice() =>
      TextFormField(
        maxLines: 5,
        initialValue: price.toString(),
        style: TextStyle(color: Colors.white60, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'price',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (price) =>
        price != null && price.isEmpty ? 'The price cannot be empty' : null,
        onChanged: (price) => widget.onChangedPrice(price.compareTo(price)),
      );
*/

/*
  Widget buildQuantity() =>
      TextFormField(
        maxLines: 5,
        initialValue: quantity.toString(),
        style: TextStyle(color: Colors.white60, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'quantity',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (quantity) =>
        quantity != null && quantity.isEmpty
            ? 'The quantity cannot be empty'
            : null,
        onChanged: (quantity) =>
            widget.onChangedQuantity(quantity.compareTo(quantity)),
      );
*/
