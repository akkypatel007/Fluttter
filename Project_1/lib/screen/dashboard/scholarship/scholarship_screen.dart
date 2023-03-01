import 'package:career360/constants/colors.dart';
import 'package:flutter/material.dart';

class AfterTenScreen extends StatefulWidget {
  const AfterTenScreen({Key? key}) : super(key: key);

  @override
  State<AfterTenScreen> createState() => _CareerScreenState();
}

class _CareerScreenState extends State<AfterTenScreen> {
  final List _image = [
    'assets/after10th/after 10_page-0004.jpg',
    'assets/after10th/after 10_page-0007.jpg',
    'assets/after10th/after 10_page-0009.jpg',
    'assets/after10th/after 10_page-0010.jpg',
    'assets/after10th/after 10_page-0012.jpg',
    'assets/after10th/after 10_page-0013.jpg',
    'assets/after10th/after 10_page-0014.jpg',
    'assets/after10th/after 10_page-0015.jpg',
    'assets/after10th/after 10_page-0016.jpg',
    'assets/after10th/after 10_page-0018.jpg',
    'assets/after10th/after 10_page-0019.jpg',
    'assets/after10th/after 10_page-0020.jpg',
    'assets/after10th/after 10_page-0022.jpg',
    'assets/after10th/after 10_page-0023.jpg',
    'assets/after10th/after 10_page-0024.jpg',
    'assets/after10th/after 10_page-0025.jpg',
    'assets/after10th/after 10_page-0026.jpg',
    'assets/after10th/after 10_page-0028.jpg',
    'assets/after10th/after 10_page-0029.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: tDarkColor,
            )),
        title: Text(
          'After 10\u1d57\u02b0 & 12\u1d57\u02b0',
          style: TextStyle(color: tDarkColor),
        ),
      ),
      body: Column(
        children: [
          Container(),
          Expanded(
              child: ListView.builder(
            itemCount: _image.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image(
                      image: AssetImage(_image[index]),
                      height: 600,
                      width: 400,
                    ),
                  ),
                  Divider(
                    color: tDarkColor,
                  ),
                ],
              );
            },
          )),
        ],
      ),
    );
  }
}
