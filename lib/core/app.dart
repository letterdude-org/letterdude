import 'package:flutter/material.dart';
import 'package:letterdude/pages/home_page.dart';
import 'package:letterdude/utils/constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: ThemeData(fontFamily: 'gg sans'),
      routes: {
        HomePage.route: (context) => const HomePage(),
      },
    );
  }
}
