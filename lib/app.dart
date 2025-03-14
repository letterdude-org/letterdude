import 'package:flutter/material.dart';
import 'package:letterdude/app/screens/home_page.dart';
import 'package:letterdude/core/utils/constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      cardTheme: const CardTheme(elevation: 0),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 244, 244, 245),
        brightness: Brightness.dark,
        surface: Colors.grey.shade900,
      ),
      fontFamily: 'gg sans',
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        appBarTheme: AppBarTheme(
          elevation: 0,
          titleSpacing: 10,
          titleTextStyle: theme.textTheme.titleMedium
              ?.copyWith(color: theme.colorScheme.onPrimary),
          toolbarHeight: 40,
          color: theme.colorScheme.primary,
        ),
      ),
      title: Constants.appName,
      routes: {
        HomePage.route: (context) => HomePage(),
      },
    );
  }
}
