import 'package:flutter/material.dart';

import '../../../../constants/image_strings.dart';
import '../../../../constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.center,
          child: Image(image: AssetImage(tLoginScreenImage), height: 135),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          tLoginTitle,
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          tLoginSubTitle,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
