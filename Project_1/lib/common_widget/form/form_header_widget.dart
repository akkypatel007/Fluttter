import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.imageHeight = 0.2,
    this.heightBetween,
    this.imageColor,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textAlign,
  }) : super(key: key);

  final double? imageHeight;
  final double? heightBetween;
  final Color? imageColor;
  final CrossAxisAlignment crossAxisAlignment;
  final String image, title, subtitle;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Image(
            image: AssetImage(image),
            color: imageColor,
            height: size.height * imageHeight!), //height: 135
        SizedBox(height: heightBetween),
        Text(title, style: Theme.of(context).textTheme.headline6),
        Text(subtitle,
            textAlign: textAlign, style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
