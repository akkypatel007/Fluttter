import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rto_app/const/colors.dart';
import 'package:rto_app/provider/countdown_provider.dart';
import 'package:rto_app/screen/dashboard.dart';

main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: blue));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CountDown(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const DashboardScreen(),
          theme: ThemeData(
            fontFamily: "quick",
          ),
          title: "Demo",
        ));
  }
}
