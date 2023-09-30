import 'package:flutter/material.dart';
import 'package:letterdude/pages/home_page.dart';
import 'package:letterdude/utils/constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      cardTheme: const CardTheme(elevation: 0),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo),
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
        ),
      ),
      title: Constants.appName,
      routes: {
        HomePage.route: (context) => const HomePage(),
      },
    );
  }
}
